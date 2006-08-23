From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] paravirt.h
Date: Wed, 23 Aug 2006 11:06:26 +0200
Message-ID: <200608231106.26696.ak@suse.de>
References: <1155202505.18420.5.camel@localhost.localdomain> <200608231050.13272.ak@suse.de> <44EC194E.6080606@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751461AbWHWJGi@vger.kernel.org>
In-Reply-To: <44EC194E.6080606@vmware.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Arjan van de Ven <arjan@infradead.org>, virtualization@lists.osdl.org, Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 23 August 2006 11:01, Zachary Amsden wrote:
> Andi Kleen wrote:
> >> Yes, after discussion with Rusty, it appears that beefing up 
> >> stop_machine_run is the right way to go.  And it has benefits for 
> >> non-paravirt code as well, such as allowing plug-in kprobes or oprofile 
> >> extension modules to be loaded without having to deal with a debug 
> >> exception or NMI during module load/unload.
> >>     
> >
> > I'm still unclear where you think those debug exceptions will come from
> 
> kprobes set in the stop_machine code - which is probably a really bad 
> idea, but nothing today actively stops kprobes from doing that.

kprobes don't cause any debug exceptions. You mean int3?

Anyways this can be fixed by marking the stop machine code __kprobes

-Andi
