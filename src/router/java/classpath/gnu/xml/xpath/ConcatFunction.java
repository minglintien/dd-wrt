/* ConcatFunction.java --
   Copyright (C) 2004 Free Software Foundation, Inc.

This file is part of GNU Classpath.

GNU Classpath is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2, or (at your option)
any later version.

GNU Classpath is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with GNU Classpath; see the file COPYING.  If not, write to the
Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
02110-1301 USA.

Linking this library statically or dynamically with other modules is
making a combined work based on this library.  Thus, the terms and
conditions of the GNU General Public License cover the whole
combination.

As a special exception, the copyright holders of this library give you
permission to link this library with independent modules to produce an
executable, regardless of the license terms of these independent
modules, and to copy and distribute the resulting executable under
terms of your choice, provided that you also meet, for each linked
independent module, the terms and conditions of the license of that
module.  An independent module is a module which is not derived from
or based on this library.  If you modify this library, you may extend
this exception to your version of the library, but you are not
obligated to do so.  If you do not wish to do so, delete this
exception statement from your version. */

package gnu.xml.xpath;

import gnu.java.lang.CPStringBuilder;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import javax.xml.namespace.QName;
import org.w3c.dom.Node;

/**
 * The <code>concat</code> function returns the concatenation of its arguments.
 *
 * @author <a href='mailto:dog@gnu.org'>Chris Burdess</a>
 */
final class ConcatFunction
  extends Expr
{

  final List<Expr> args;

  ConcatFunction(List<Expr> args)
  {
    this.args = args;
  }

  @Override
  public Object evaluate(Node context, int pos, int len)
  {
    CPStringBuilder buf = new CPStringBuilder();
    for (Expr arg : args)
      {
        Object val = arg.evaluate(context, pos, len);
        buf.append(_string(context, val));
      }
    return buf.toString();
  }

  public Expr clone(Object context)
  {
    int len = args.size();
    List<Expr> args2 = new ArrayList<Expr>(len);
    for (int i = 0; i < len; i++)
      {
        args2.add(args.get(i).clone(context));
      }
    return new ConcatFunction(args2);
  }

  public boolean references(QName var)
  {
    for (Iterator<Expr> i = args.iterator(); i.hasNext(); )
      {
        if (i.next().references(var))
          {
            return true;
          }
      }
    return false;
  }

  public String toString()
  {
    CPStringBuilder buf = new CPStringBuilder("concat(");
    int len = args.size();
    for (int i = 0; i < len; i++)
      {
        if (i > 0)
          {
            buf.append(',');
          }
        buf.append(args.get(i));
      }
    buf.append(')');
    return buf.toString();
  }

}
