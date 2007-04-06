From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Define EFLAGS_IF
Date: Thu, 05 Apr 2007 17:20:38 -0700
Message-ID: <46159256.1040705@zytor.com>
References: <1174533374.2713.104.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1767138AbXDFAUz@vger.kernel.org>
In-Reply-To: <1174533374.2713.104.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.osdl.org>, Andi Kleen <andi@firstfloor.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> There is now more than one place where we use the fact that bit 9 of
> eflags is the interrupt-enabled flag, so define EFLAGS_IF.  We make it
> 512 so it can be used in asm, too.

How about defining all the other EFLAGS in one place?

	-hpa
