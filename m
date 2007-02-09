From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 6/10] lguest code: the little linux hypervisor.
Date: Fri, 09 Feb 2007 14:29:12 -0800 (PST)
Message-ID: <20070209.142912.38710040.davem@davemloft.net>
References: <1171018812.2718.66.camel@localhost.localdomain>
	<45CC5771.1070309@vmware.com>
	<200702091250.06482.ak@muc.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1423343AbXBIW3P@vger.kernel.org>
In-Reply-To: <200702091250.06482.ak@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
To: ak@muc.de
Cc: virtualization@lists.osdl.org, zach@vmware.com, rusty@rustcorp.com.au, paulus@samba.org, sfr@canb.auug.org.au, akpm@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

From: Andi Kleen <ak@muc.de>
Date: Fri, 9 Feb 2007 12:50:06 +0100

> 
> > Yes, it is a bit, umm, innovative.  If it is going to be kept, even if 
> > just for devel logging, you should disable interrupts around it.  
> > Changing segments is not a normal thing to do.
> 
> Actually that wouldn't be needed because interrupts are not allowed to do any 
> user accesses. And contrary to the name it doesn't actually change
> the segment registers, only state used by *_user.

That's right and we use this construct all throughout the
syscall compatibility layer for 64-bit platforms.
