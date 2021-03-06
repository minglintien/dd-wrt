/* src/vm/jit/powerpc/md-atomic.hpp - PowerPC atomic instructions

   Copyright (C) 1996-2013
   CACAOVM - Verein zur Foerderung der freien virtuellen Maschine CACAO

   This file is part of CACAO.

   This program is free software; you can redistribute it and/or
   modify it under the terms of the GNU General Public License as
   published by the Free Software Foundation; either version 2, or (at
   your option) any later version.

   This program is distributed in the hope that it will be useful, but
   WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
   02110-1301, USA.

*/


#ifndef MD_ATOMIC_HPP_
#define MD_ATOMIC_HPP_ 1

#include "config.h"

#include <stdint.h>

#include "threads/atomic.hpp"

namespace Atomic_md {

/**
 * An atomic compare and swap for 32-bit integer values.
 *
 * @param p      Pointer to memory address.
 * @param oldval Old value to be expected.
 * @param newval New value to be stored.
 *
 * @return value of the memory location before the store
 */
inline uint32_t compare_and_swap(volatile uint32_t *p, uint32_t oldval, uint32_t newval)
{
	uint32_t temp;
	uint32_t result;

	__asm__ __volatile__ (
		"1:                   \n"
		"    lwarx  %0,0,%4   \n"
		"    subf.  %1,%0,%2  \n"
		"    bne-   2f        \n"
		"    or     %1,%3,%3  \n"
		"    stwcx. %1,0,%4   \n"
		"    bne-   1b        \n"
		"2:                   \n"
		: "=&r" (result), "=&r" (temp)
		: "r" (oldval), "r" (newval), "r" (p)
		: "cr0", "memory");

	return result;
}


/**
 * An atomic compare and swap for 64-bit integer values.
 *
 * @param p      Pointer to memory address.
 * @param oldval Old value to be expected.
 * @param newval New value to be stored.
 *
 * @return value of the memory location before the store
 */
inline uint64_t compare_and_swap(volatile uint64_t *p, uint64_t oldval, uint64_t newval)
{
	return Atomic::generic_compare_and_swap(p, oldval, newval);
}


/**
 * A memory barrier.
 */
inline void memory_barrier(void)
{
	__asm__ __volatile__ ("sync" : : : "memory");
}


/**
 * A write memory barrier.
 */
inline void write_memory_barrier(void)
{
	__asm__ __volatile__ ("" : : : "memory");
}

/**
 * An instruction barrier.
 */
inline void instruction_barrier(void)
{
	__asm__ __volatile__ ("isync" : : : "memory");
}

}

#endif // MD_ATOMIC_HPP_


/*
 * These are local overrides for various environment variables in Emacs.
 * Please do not remove this and leave it at the end of the file, where
 * Emacs will automagically detect them.
 * ---------------------------------------------------------------------
 * Local variables:
 * mode: c++
 * indent-tabs-mode: t
 * c-basic-offset: 4
 * tab-width: 4
 * End:
 * vim:noexpandtab:sw=4:ts=4:
 */
