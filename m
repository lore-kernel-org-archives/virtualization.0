From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Define EFLAGS_IF
Date: Thu, 22 Mar 2007 14:24:34 +1100
Message-ID: <1174533874.2713.105.camel@localhost.localdomain>
References: <1174533374.2713.104.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965632AbXCVDYx@vger.kernel.org>
In-Reply-To: <1174533374.2713.104.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.osdl.org>, Andi Kleen <andi@firstfloor.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-03-22 at 14:16 +1100, Rusty Russell wrote:
> There is now more than one place where we use the fact that bit 9 of
> eflags is the interrupt-enabled flag, so define EFLAGS_IF.  We make it
> 512 so it can be used in asm, too.

Belay this: there's a X86_EFLAGS_IF in asm/processor.h which we should
use.  Will send patch.

Thanks to Jeremy Fitzhardinge for the clue.

Rusty.
