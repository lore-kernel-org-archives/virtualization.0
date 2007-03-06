From: Zachary Amsden <zach@vmware.com>
Subject: Re: [patch] paravirt: VDSO page is essential
Date: Mon, 05 Mar 2007 23:42:28 -0800
Message-ID: <45ED1B64.9040104@vmware.com>
References: <20070305120631.GA14105@elte.hu> <1173101297.26165.39.camel@localhost.localdomain> <1173142644.4644.6.camel@localhost.localdomain> <45ECBDDC.8080708@vmware.com> <45ECC076.9050209@goop.org> <20070306073511.GA3938@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933024AbXCFHma@vger.kernel.org>
In-Reply-To: <20070306073511.GA3938@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, virtualization <virtualization@lists.osdl.org>, Andrew Morton <akpm@linux-foundation.org>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
> * Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>
>   
>>> I had just sent this out for internal review...
>>>       
>> I think Jan's approach is better if it works (since there's no 
>> compromise), but this is better if you want to get something working 
>> in the near term.
>>     
>
> yeah. (plus my patches of course that remove the current papering-over 
> hackery and restores COMPAT_VDSO.)
>   

Yes, I don't have a problem with your patch, I just wish I had been cc'd 
on it.  Fixing this is rather tricky, but I believe no strange build 
magic is required, it can be done in kernel init code.  Still building 
my SUSE 9.0 guest to test.  SUSE 9.0 is one of those that requires 
COMPAT_VDSO, yes?

Thanks,

Zach
