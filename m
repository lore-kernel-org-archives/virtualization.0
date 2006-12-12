From: Zachary Amsden <zach@vmware.com>
Subject: Re: Why disable vdso by default with CONFIG_PARAVIRT?
Date: Mon, 11 Dec 2006 17:46:43 -0800
Message-ID: <457E0A03.3020704@vmware.com>
References: <457E0460.4030107@goop.org> <457E08FE.6050600@vmware.com> <457E097C.5030208@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750856AbWLLBqp@vger.kernel.org>
In-Reply-To: <457E097C.5030208@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@suse.de>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Zachary Amsden wrote:
>   
>> Jeremy Fitzhardinge wrote:
>>     
>>> Hi Andi,
>>>
>>> What problem do they cause together?  There's certainly no problem with
>>> Xen+vdso (in fact, its actually very useful so that it picks up the
>>> right libc with Xen-friendly TLS).
>>>   
>>>       
>> Methinks the compat VDSO support got broken in the config?  Paravirt +
>> COMPAT_VDSO are incompatible. 
>>     
>
> Yes, that's true, but I'm looking at arch/i386/kernel/sysenter.c:
>
> #ifdef CONFIG_PARAVIRT
> unsigned int __read_mostly vdso_enabled = 0;
> #else
> unsigned int __read_mostly vdso_enabled = 1;
> #endif
>
> I can't think of any reason why that should be necessary.
>   

It's not for us or Xen.  Perhaps it came from lhype?  
