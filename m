From: Keith Owens <kaos@ocs.com.au>
Subject: Re: [PATCH] Use X86_EFLAGS_IF in irqflags.h, lguest.
Date: Thu, 22 Mar 2007 15:03:19 +1100
Message-ID: <11208.1174536199@kao2.melbourne.sgi.com>
References: <1174535550.2713.108.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965647AbXCVEDZ@vger.kernel.org>
In-reply-to: Your message of "Thu, 22 Mar 2007 14:52:29 +1100."
             <1174535550.2713.108.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.osdl.org>, Andi Kleen <andi@firstfloor.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell (on Thu, 22 Mar 2007 14:52:29 +1100) wrote:
>On Thu, 2007-03-22 at 14:24 +1100, Rusty Russell wrote:
>> Belay this: there's a X86_EFLAGS_IF in asm/processor.h which we should
>> use.  Will send patch.
>
>How's this.  There may be other users, but they're not easy to grep for.

One less set of definitions for KDB to create - Thanks.
