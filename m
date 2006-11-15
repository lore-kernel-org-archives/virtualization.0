From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.19-rc5-mm2: warnings in MODPOST and later
Date: Wed, 15 Nov 2006 08:42:05 +0100
Message-ID: <1163576525.31358.80.camel@laptopd505.fenrus.org>
References: <20061114014125.dd315fff.akpm@osdl.org>
	 <20061114225622.GO22565@stusta.de>  <20061114150902.f772c75c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965970AbWKOHmO@vger.kernel.org>
In-Reply-To: <20061114150902.f772c75c.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2006-11-14 at 15:09 -0800, Andrew Morton wrote:
> On Tue, 14 Nov 2006 23:56:22 +0100
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > Since people were recently complaining about too many warnings:
> > Here is a list of the warnings I'm getting in MODPOST and later.
> > 
> > Since the warnings by far exceed the 100kB limit of linux-kernel (sic), 
> > I had to attach them compressed.
> > 
> > With the exception of the "drivers/ide/pci/atiixp:FFFF05", none of these 
> > warnings is present in Linus' tree.
> 
> yes, lots of new section mismatch warnings.
> 
> A large number of them are due to the paravirt patches:
> 
> WARNING: vmlinux - Section mismatch: reference to .init.text: from .parainstructions between '__start_parainstructions' (at offset 0xc0458470) and '__stop_parainstructions'
> WARNING: vmlinux - Section mismatch: reference to .init.text: from .parainstructions between '__start_parainstructions' (at offset 0xc0458478) and '__stop_parainstructions'


ok this means that you shouldn't probably switch paravirtualizations
after boot, but that's ok ;) it's not like hypervisor support should be
a module anyway
