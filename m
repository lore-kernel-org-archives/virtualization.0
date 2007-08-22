From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Add I/O hypercalls for i386 paravirt
Date: Wed, 22 Aug 2007 22:25:28 +0100
Message-ID: <20070822222528.7c58f1e9@the-village.bc.nu>
References: <46CBC842.4070100@vmware.com>
	<20070822102217.GE2642@bingen.suse.de>
	<46CC68D9.5060200@vmware.com>
	<20070822175918.GB8058@bingen.suse.de>
	<46CC6D63.2010204@vmware.com>
	<20070822194632.GD8058@bingen.suse.de>
	<46CC9FF2.3040406@vmware.com>
	<20070822220451.GJ8058@bingen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933959AbXHVVSs@vger.kernel.org>
In-Reply-To: <20070822220451.GJ8058@bingen.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Zachary Amsden <zach@vmware.com>, Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Avi Kivity <avi@qumranet.com>, Jeremy Fitzhardinge <jeremy@goop.org>
List-Id: virtualization@lists.linuxfoundation.org

> I still think it's preferable to change some drivers than everybody.
> 
> AFAIK BusLogic as real hardware is pretty much dead anyways,
> so you're probably the only primary user of it anyways.
> Go wild on it!

I don't believe anyone is materially maintaining the buslogic driver and
in time its going to break completely.

> Well that might be. I just think it would be a mistake
> to design paravirt_ops based on someone's short term release engineering
> considerations.

Agreed, especially as an interface where each in or out traps into the
hypervisor is broken even for the model of virtualising hardware. 

> I thought we had that already?  But can't find it now :/

pci_iomap() and friends. 

Alan
