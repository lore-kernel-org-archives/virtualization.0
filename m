From: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] paravirt.h
Date: Tue, 22 Aug 2006 15:44:26 +0200
Message-ID: <200608221544.26989.ak@muc.de>
References: <1155202505.18420.5.camel@localhost.localdomain> <44DB7596.6010503@goop.org> <1156254965.27114.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932247AbWHVNok@vger.kernel.org>
In-Reply-To: <1156254965.27114.17.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: virtualization@lists.osdl.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org


I don't see why paravirt ops is that much more sensitive
than most other kernel code. 

> It would be a lot safer if we could have the struct paravirt_ops in
> protected read-only const memory space, set it up in the core kernel
> early on in boot when we play "guess todays hypervisor" and then make
> sure it stays in read only (even to kernel) space.

By default we don't make anything read only because that would
mess up the 2MB kernel mapping.

In general i don't think making select code in the kernel
read only is a good idea, because as long as you don't
protect everything including stacks etc. there will be always
attack points where supposedly protected code relies 
on unprotected state. If someone can write to kernel
memory you already lost.

And it adds TLB pressure.

-Andi
