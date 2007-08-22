From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH] Add I/O hypercalls for i386 paravirt
Date: Wed, 22 Aug 2007 08:34:23 +0300
Message-ID: <46CBCADF.2070400@qumranet.com>
References: <46CBC842.4070100@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756121AbXHVFei@vger.kernel.org>
In-Reply-To: <46CBC842.4070100@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Jeremy Fitzhardinge <jeremy@goop.org>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> In general, I/O in a virtual guest is subject to performance
> problems.  The I/O can not be completed physically, but must be
> virtualized.  This means trapping and decoding port I/O instructions
> from the guest OS.  Not only is the trap for a #GP heavyweight, both
> in the processor and the hypervisor (which usually has a complex #GP
> path), but this forces the hypervisor to decode the individual
> instruction which has faulted.  Worse, even with hardware assist such
> as VT, the exit reason alone is not sufficient to determine the true
> nature of the faulting instruction, requiring a complex and costly
> instruction decode and simulation.
>
> This patch provides hypercalls for the i386 port I/O instructions,
> which vastly helps guests which use native-style drivers.  For certain
> VMI workloads, this provides a performance boost of up to 30%.  We
> expect KVM and lguest to be able to achieve similar gains on I/O
> intensive workloads.
>


Won't these workloads be better off using paravirtualized drivers? 
i.e., do the native drivers with paravirt I/O instructions get anywhere
near the performance of paravirt drivers?


-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
