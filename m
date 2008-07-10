From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH 2/4] KVM: Introduce a callback routine for IOAPIC ack
 handling
Date: Thu, 10 Jul 2008 16:57:44 +0300
Message-ID: <48761558.3070703@qumranet.com>
References: <1214571305-20701-1-git-send-email-amit.shah@qumranet.com>	 <1214571305-20701-2-git-send-email-amit.shah@qumranet.com>	 <1214571305-20701-3-git-send-email-amit.shah@qumranet.com>	 <4871EB36.5030003@qumranet.com> <1215513283.31546.133.camel@cluwyn.haifa.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1215513283.31546.133.camel@cluwyn.haifa.ibm.com>
Sender: kvm-owner@vger.kernel.org
To: Ben-Ami Yassour <benami@il.ibm.com>
Cc: Amit Shah <amit.shah@qumranet.com>, kvm@vger.kernel.org, Muli Ben-Yehuda <muli@il.ibm.com>, allen.m.kay@intel.com, chrisw@redhat.com, weidong.han@intel.com, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Ben-Ami Yassour wrote:
> On Mon, 2008-07-07 at 13:08 +0300, Avi Kivity wrote:
>   
>> Amit Shah wrote:
>>     
>>> This will be useful for acking irqs of assigned devices
>>>
>>>   
>>>       
>> And also for improving time drift tracking.
>>
>> Please make this more generic by having a list of callbacks.  There 
>> could also be just one list, rather than one for the ioapic and one for 
>> the pic as implemented now.
>>
>> It may also make sense to filter the irq number before calling the 
>> callback rather than relying on the callback to ignore uninteresting irqs.
>>
>>     
> Avi,
>
> Did you mean something like the patch below?
>   

I did, and have something very similar queued.

> How should we protect list accesses, should it be a new lock or an existing one?
>
>   

kvm->lock for now.

-- 
error compiling committee.c: too many arguments to function

