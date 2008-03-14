From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 0/6] Guest page hinting version 6.
Date: Fri, 14 Mar 2008 11:30:13 -0700
Message-ID: <47DAC435.1050105@goop.org>
References: <20080312132132.520833247@de.ibm.com>	 <Pine.LNX.4.64.0803131627450.17244@blonde.site> <47D9754B.1030509@goop.org>	 <Pine.LNX.4.64.0803131848080.800@blonde.site> <1205438038.14987.1.camel@bodhitayantram.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758334AbYCNSc1@vger.kernel.org>
In-Reply-To: <1205438038.14987.1.camel@bodhitayantram.eng.vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Hugh Dickins <hugh@veritas.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.osdl.org, akpm@linux-foundation.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rusty@rustcorp.com.au, andrea@qumranet.com, clameter@sgi.com, a.p.zijlstra@chello.nl, Keir Fraser <keir@xensource.com>, Ian Pratt <ian.pratt@xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> On Thu, 2008-03-13 at 18:55 +0000, Hugh Dickins wrote:
>   
>> On Thu, 13 Mar 2008, Jeremy Fitzhardinge wrote:
>>     
>>> My other concern is just correctness over time on the Linux side.  We already
>>> have enough trouble keeping things like the pte and page structure state in
>>> sync, with resulting rare data-loss bugs.  Adding another layer which only
>>> applies in specific environments raises the possibility for new bugs to be
>>> un-noticed for a long time.  How can we structure the VM changes to make sure
>>> that its robust in the face of maintenance?
>>>       
>> Yes, that's the main concern, as whenever lots of subtlety is added.
>> I wonder if there's any chance of a CONFIG_DEBUG mode, which could be
>> run on anybody's x86 machine, without involving any virtualization, but
>> in which the PAGE_STATEs become essential to the correct working of the mm.
>>     
>
> How about a fake hypervisor, which is really just a random page evictor,
> following the rules of CMM?
>   

Probably simpler to just have variants of the page_set_* functions which 
simulate the worst-possible host action immediately (ie, stealing pages, 
logically swapping them, etc).  That wouldn't give you full coverage, 
but it would go some way.  An async variant which schedules a change in 
a few milliseconds would help too.

I guess that's equivalent to having a special-purpose hypervisor built 
into the kernel (hm, sounds familiar...).

    J
