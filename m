From: "Akinobu Mita" <akinobu.mita@gmail.com>
Subject: Re: [PATCH 1 of 4] mm: add a ptep_modify_prot transaction abstraction
Date: Thu, 19 Jun 2008 21:20:47 +0900
Message-ID: <961aa3350806190520m28edf130x3bb40d1ced56a303@mail.gmail.com>
References: <b020e42384197b824320.1213615800@localhost>
	 <1213831403.8011.24.camel@pasglop> <4859A149.9090004@goop.org>
	 <4859A528.1010107@goop.org>
	 <alpine.LFD.1.10.0806181723400.2907@woody.linux-foundation.org>
	 <4859AA47.2020903@goop.org>
	 <alpine.LFD.1.10.0806181743390.2907@woody.linux-foundation.org>
	 <alpine.LFD.1.10.0806182050470.2907@woody.linux-foundation.org>
	 <20080619115832.GM15228@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758579AbYFSMU5@vger.kernel.org>
In-Reply-To: <20080619115832.GM15228@elte.hu>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jeremy Fitzhardinge <jeremy@goop.org>, benh@kernel.crashing.org, xen-devel <xen-devel@lists.xensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kvm-devel <kvm-devel@lists.sourceforge.net>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Hugh Dickins <hugh@veritas.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

> Below is the commit, it needed a small amount of massaging to apply the
> void * -> unsigned long * change in the x86/bitops topic.

So you need to change this line

> +#define CONST_MASK_ADDR BITOP_ADDR(addr + (nr>>3))

to be

#define CONST_MASK_ADDR BITOP_ADDR((void *)addr + (nr>>3))

or something like this. Otherwise it will get wrong address in set_bit

> -static inline void set_bit(int nr, volatile unsigned long *addr)
> +static inline void set_bit(unsigned int nr, volatile unsigned long *addr)
>  {
> -       asm volatile(LOCK_PREFIX "bts %1,%0" : ADDR : "Ir" (nr) : "memory");
> +       if (IS_IMMEDIATE(nr))
> +               asm volatile(LOCK_PREFIX "orb %1,%0" : CONST_MASK_ADDR : "i" (CONST_MASK) : "memory");
> +       else
> +               asm volatile(LOCK_PREFIX "bts %1,%0" : ADDR : "Ir" (nr) : "memory");
>  }
