From: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: Paravirt compile failure with gcc33
Date: Wed, 10 Feb 2010 20:20:26 +0100 (CET)
Message-ID: <alpine.LSU.2.01.1002102019430.6708@obet.zrqbmnf.qr>
References: <alpine.LSU.2.01.1002101909560.29808@obet.zrqbmnf.qr> <4B72FD09.1020202@goop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4B72FD09.1020202@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Jeremy Fitzhardinge <jeremy@xensource.com>, virtualization@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 2010-02-10 19:38, Jeremy Fitzhardinge wrote:

> On 02/10/2010 10:13 AM, Jan Engelhardt wrote:
>> As I was compile-testing 2.6.33-rc with gcc-3.3,
>> binutils-2.19.51-10.26.4.x86_64, I observed a failure when
>> CONFIG_PARAVIRT is turned on:
>>   
>
> Yeah, there's a gcc bug of some kind there, and its very hard to see how to
> work around it.  When we last discussed this, I think we were close to deciding
> to obsolete gcc 3.3.
>
> HPA, do you remember?

In fact, there's such a big bug in there that I'll get a runaway 
allocation later on when kvm.o is to be compiled. This is getting fun,
but I am absolutely fine with obsoleting 3.x  :)
