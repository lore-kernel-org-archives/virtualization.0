From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Add I/O hypercalls for i386 paravirt
Date: Wed, 22 Aug 2007 18:34:31 +0100
Message-ID: <20070822183431.133f056c@the-village.bc.nu>
References: <46CBC842.4070100@vmware.com>
	<20070822102217.GE2642@bingen.suse.de>
	<46CC68D9.5060200@vmware.com>
	<20070822175918.GB8058@bingen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934477AbXHVR1z@vger.kernel.org>
In-Reply-To: <20070822175918.GB8058@bingen.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Zachary Amsden <zach@vmware.com>, Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Avi Kivity <avi@qumranet.com>, Jeremy Fitzhardinge <jeremy@goop.org>
List-Id: virtualization@lists.linuxfoundation.org

> out is usually a single byte. Shouldn't be very expensive
> to decode. In fact it should be roughly equivalent to your
> hypercall multiplex.

Why is a performance critical path on a paravirt kernel even using I/O
instructions and not paravirtual device drivers ?

It clearly makes sense to virtualise I/O operations if you are doing that
(so you can do posting, triggers and predicted reply handling guest side
to keep the trap rate sane) but I don't see why this situation occurs in
the first place for paravirt.
