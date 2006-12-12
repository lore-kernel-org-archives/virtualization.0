From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Why disable vdso by default with CONFIG_PARAVIRT?
Date: Mon, 11 Dec 2006 17:22:40 -0800
Message-ID: <457E0460.4030107@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750822AbWLLBX0@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Andi,

What problem do they cause together?  There's certainly no problem with
Xen+vdso (in fact, its actually very useful so that it picks up the
right libc with Xen-friendly TLS).

    J
