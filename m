From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Xen & VMI?
Date: Tue, 6 Mar 2007 21:37:12 +0100
Message-ID: <20070306203712.GC21736@elte.hu>
References: <45ED82D9.6050204@codemonkey.ws> <8FFF7E42E93CC646B632AB40643802A80229779B@scsmsx412.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751072AbXCFUiF@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8FFF7E42E93CC646B632AB40643802A80229779B@scsmsx412.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Anthony Liguori <anthony@codemonkey.ws>, virtualization <virtualization@lists.osdl.org>, Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Jan Beulich <jbeulich@novell.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


* Nakajima, Jun <jun.nakajima@intel.com> wrote:

> I think a KVM Linux would benefit more from paravirt ops, rather than 
> VMI. The higher-level interface such as the one in Xen, espeically for 
> I/O, interrupt controllers, timer, SMP, etc. actually simplifies the 
> implementation of the VMM, and improve performance of the guest. Even 
> for MMU, direct page tables, for example, would work better for 
> hardware-based virtualization because the processor can use the native 
> page tables.

maybe we are talking past each other because i dont really disagree with 
that: i mentioned it right at beginning that higher-level APIs would 
have to be added to VMI. What i'd like to avoid is the ABI duplication 
for the lowlevel stuff /and/ for the highlevel stuff. Since VMI is 
mostly about lowlevel stuff right now it's obvious that it would have to 
grow more highlevel ops. Doing an IO driver via IO emulation is 
obviously pretty ... low-tech.

maybe i shouldnt call it 'VMI' but 'the paravirt ABI'. I dont mind if 
it's the Xen ABI or the VMWare ABI or a mesh of the two - everyone can 
map their own internals to that /one/ ABI.

	Ingo
