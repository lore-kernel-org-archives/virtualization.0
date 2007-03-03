From: Zachary Amsden <zach@vmware.com>
Subject: Re: system call time increase when turning on CONFIG_PARAVIRT
Date: Fri, 02 Mar 2007 23:00:59 -0800
Message-ID: <45E91D2B.9040004@vmware.com>
References: <1172866274.4898.14.camel@localhost.localdomain>	 <45E89CFB.4090905@goop.org> <1172877111.8383.4.camel@localhost.localdomain> <45E8BE79.40200@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965253AbXCCHBB@vger.kernel.org>
In-Reply-To: <45E8BE79.40200@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Tim Chen wrote:
>   
>> I also hope that the performance can be recovered as this option could
>> enabled in distributions' kernels in future.
>>     
>
> Yes, the intent is that running a CONFIG_PARAVIRT kernel on native
> hardware will have negligible performance hit compared to running a
> non-paravirt kernel.
>   

We can validate that claim entirely.  The way we are proceeding, the 
native code will be inlined or direct called as much as possible.  With 
the VMI-Linux code we had earlier, this mostly created <3% overhead for 
microbenchmarks (and in some cases, we actually won over the unmodified 
native code).  For macro-benchmarks, with real-world workloads, this 
reduced to immeasurable noise, never off by more than +/- 0.5% IIRC.

I believe all of this is totally achievable.  We have the technology.  
We can rebuild it.

Zach
