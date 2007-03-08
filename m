From: Andi Kleen <ak@suse.de>
Subject: Re: hardwired VMI crap
Date: Thu, 8 Mar 2007 22:43:31 +0100
Message-ID: <200703082243.31659.ak@suse.de>
References: <45EF175D.6030609@vmware.com> <45F07D07.5090003@goop.org> <20070308213458.GA24634@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030574AbXCHVnf@vger.kernel.org>
In-Reply-To: <20070308213458.GA24634@elte.hu>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Zachary Amsden <zach@vmware.com>, tglx@linutronix.de, john stultz <johnstul@us.ibm.com>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Pratap Subrahmanyam <pratap@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Daniel Hecht <dhecht@vmware.com>, Daniel Arai <arai@vmware.com>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org


> what we do _NOT_ want is some mixture of 'simplified' and 'hardwired' 
> native hardware access mixed with hypercalls that somehow ends up 
> creating a Frankenstein mixture of 'virtual silicon', is specified 
> nowhere else but in VMWare's proprietary hypervisor source code that we 
> have no way to fix and no way to even see!

Hmm, but we already drive the "vmware silicon" quite successfully with
fully virtualized kernels. And apparently the VMI version is the same,
just with some short cuts. Are you just worried about the ->apic_write()
hooks or about something else too?

-Andi
