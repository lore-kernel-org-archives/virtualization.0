From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Add I/O hypercalls for i386 paravirt
Date: Wed, 22 Aug 2007 16:25:56 +1000
Message-ID: <1187763956.6174.48.camel@localhost.localdomain>
References: <46CBC842.4070100@vmware.com>  <46CBCADF.2070400@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757075AbXHVG0p@vger.kernel.org>
In-Reply-To: <46CBCADF.2070400@qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Avi Kivity <avi@qumranet.com>
Cc: Zachary Amsden <zach@vmware.com>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Chris Wright <chrisw@sous-sol.org>, Jeremy Fitzhardinge <jeremy@goop.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-08-22 at 08:34 +0300, Avi Kivity wrote:
> Zachary Amsden wrote:
> > This patch provides hypercalls for the i386 port I/O instructions,
> > which vastly helps guests which use native-style drivers.  For certain
> > VMI workloads, this provides a performance boost of up to 30%.  We
> > expect KVM and lguest to be able to achieve similar gains on I/O
> > intensive workloads.
> 
> Won't these workloads be better off using paravirtualized drivers? 
> i.e., do the native drivers with paravirt I/O instructions get anywhere
> near the performance of paravirt drivers?

This patch also means I can kill off the emulation code in
drivers/lguest/core.c, which is a real relief.

Cheers,
Rusty.
