From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Define EFLAGS_IF
Date: Fri, 06 Apr 2007 08:39:16 -0700
Message-ID: <461669A4.70405@zytor.com>
References: <1174533374.2713.104.camel@localhost.localdomain> <46159256.1040705@zytor.com> <461592AA.4060103@goop.org> <46159480.20108@zytor.com> <20070406004839.GA27668@one.firstfloor.org> <46159D08.9030400@zytor.com> <20070406103038.GA32440@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1767774AbXDFPkE@vger.kernel.org>
In-Reply-To: <20070406103038.GA32440@one.firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, virtualization <virtualization@lists.osdl.org>, Andrew Morton <akpm@linux-foundation.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
> On Thu, Apr 05, 2007 at 06:06:16PM -0700, H. Peter Anvin wrote:
>> Andi Kleen wrote:
>>> No processor.h is such a hodgepodge of unrelated stuff that any
>>> splitting up is a good thing.
>>>
>> Fair enough.  However, I'd still like to see the X86_CR* constants 
>> moved, too (and constants added for at least CR0 as well.)
> 
> Send patches then.

I will, unless Rusty does, first.  No desire to step on each other.

	-hpa
