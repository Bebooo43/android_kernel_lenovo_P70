/*
 * include/linux/sweep2wake.h
 *
 * Copyright (c) 2012, Dennis Rassmann <showp1984@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

#ifndef _LINUX_SWEEP2WAKE_H
#define _LINUX_SWEEP2WAKE_H

#include <linux/input.h>
#include <linux/earlysuspend.h>
#include <linux/hrtimer.h>

#define TOUCHSCREEN_SWEEP2WAKE
#define S2W_HEIGHT_ADJUST 1280
#define SWEEP2WAKE 2

/* Sweep2wake function */
extern bool scr_suspended;
extern int sweep2wake;
extern int tripon;
extern int tripoff;
extern unsigned long triptime;

/* Sweep2wake & Doubletap2wake main function */
extern void detect_sweep2wake(int, int, unsigned long, int);

/* PowerKey setter */
extern void sweep2wake_setdev(struct input_dev *);

#endif	/* _LINUX_SWEEP2WAKE_H */
