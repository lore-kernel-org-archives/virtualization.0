From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/7] paravirtualization: header and stubs
	for	paravirtualizing critical operations
Date: Sun, 05 Nov 2006 15:43:35 +1100
Message-ID: <1162701815.29777.6.camel@localhost.localdomain>
References: <20061029024504.760769000@sous-sol.org>
	 <200611030356.54074.ak@suse.de> <454BA7F7.8030205@vmware.com>
	 <200611032209.40235.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030190AbWKEEnk@vger.kernel.org>
In-Reply-To: <200611032209.40235.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, akpm@osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2006-11-03 at 22:09 +0100, Andi Kleen wrote:
> > 
> > Sounds like desc.h got reordered.  Somewhere, there was a broken patch 
> > once that did this, I thought we fixed that.
> 
> I think I got Rusty's latest patches that I found in my mailbox.
> 
> I haven't looked at desc.h, but at least processor.h ordering was totally
> b0rken (e.g. #define __cpuid native_cpuid was after several uses). I fixed
> that to make at least the CONFIG_PARAVIRT not set case compile.
> 
> I can't see how this ever worked either.
> 
> Haven't attempted the CONFIG_PARAVIRT case which apparently needs more work
> (it is currently marked CONFIG_BROKEN) 
> 
> Can someone double check this is the correct patchkit?
> 
> ftp://ftp.frstfloor.org/pub/ak/x86_64/quilt/patches/paravirt*

Andi, the patches work against Andrew's tree, and he's merged them in
rc4-mm2.  There are a few warnings to clean up, but it seems basically
sound.

At this point I our think time is better spent on beating those patches
up, rather than going back and figuring out why they don't work in your
tree.

Sorry,
Rusty.
