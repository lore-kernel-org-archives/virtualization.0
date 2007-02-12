From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [q] kbuild for private asm-offsets (Re: [PATCH 6/10] lguest code: the little linux hypervisor.)
Date: Mon, 12 Feb 2007 22:41:28 +0100
Message-ID: <20070212214128.GA11955@uranus.ravnborg.org>
References: <1171012296.2718.26.camel@localhost.localdomain> <1171012761.2718.40.camel@localhost.localdomain> <1171012827.2718.42.camel@localhost.localdomain> <200702091109.20061.ak@muc.de> <1171024771.2718.129.camel@localhost.localdomain> <20070209141728.GA26749@uranus.ravnborg.org> <1171034599.2718.190.camel@localhost.localdomain> <E1HGbJz-0003Lc-6h@flower>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965424AbXBLVlk@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E1HGbJz-0003Lc-6h@flower>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleg Verych <olecom@flower.upol.cz>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andi Kleen <ak@muc.de>, virtualization@lists.osdl.org, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

> 
> If you will have time for newbie, to explain in a few words, what is it need
> for (whole idea, or key detail), and, maybe, why it is generated so ... interestingly:
> 
>             asm-offsets.c -> *.s -> *.h
>  (but this looks like interconnecting C and assembler, obviously)

Correct - asm-offsets is used to transfer constants for .c to assembler,
which us especially convinient for constant that differ when a stuct
is changed.

> 
> I will glad to help providing solution maybe somewhat earlier (well, i'm
> trying to understand whole building process, if that matters).

Basically what is requested is to move the generic parts of asm-offsets
generation from top-level Kbuild file to a generic file somewhere.

Since this is not generic Kbuild functionality but more specific to the
kernel it should not be part of Kbuild generic files.
include/asm-generic/asm-offsets seems to be a fair place for it.

It would contain the sed-y parts as well as cmd_offsets definition.

I would be glad if you could give that a spin.

	Sam
