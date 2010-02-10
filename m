From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Paravirt compile failure with gcc33
Date: Wed, 10 Feb 2010 10:41:37 -0800
Message-ID: <4B72FDE1.8060609@zytor.com>
References: <alpine.LSU.2.01.1002101909560.29808@obet.zrqbmnf.qr> <4B72FD09.1020202@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4B72FD09.1020202@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Jan Engelhardt <jengelh@medozas.de>, Jeremy Fitzhardinge <jeremy@xensource.com>, virtualization@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 02/10/2010 10:38 AM, Jeremy Fitzhardinge wrote:
> On 02/10/2010 10:13 AM, Jan Engelhardt wrote:
>> As I was compile-testing 2.6.33-rc with gcc-3.3,
>> binutils-2.19.51-10.26.4.x86_64, I observed a failure when
>> CONFIG_PARAVIRT is turned on:
>>    
> 
> Yeah, there's a gcc bug of some kind there, and its very hard to see how 
> to work around it.  When we last discussed this, I think we were close 
> to deciding to obsolete gcc 3.3.
> 
> HPA, do you remember?
> 

I don't, and the macros are tangled enough that I'm not actually sure
what the failure really is.

	-hpa
