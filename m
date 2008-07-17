From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH 2/4] KVM: Introduce a callback routine for IOAPIC ack
 handling
Date: Thu, 17 Jul 2008 20:16:04 +0300
Message-ID: <487F7E54.7030303@qumranet.com>
References: <1214571305-20701-1-git-send-email-amit.shah@qumranet.com>	 <1214571305-20701-2-git-send-email-amit.shah@qumranet.com>	 <1214571305-20701-3-git-send-email-amit.shah@qumranet.com>	 <4871EB36.5030003@qumranet.com>	 <1215513283.31546.133.camel@cluwyn.haifa.ibm.com>	 <48761558.3070703@qumranet.com> <1216313795.31546.342.camel@cluwyn.haifa.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1216313795.31546.342.camel@cluwyn.haifa.ibm.com>
Sender: kvm-owner@vger.kernel.org
To: Ben-Ami Yassour <benami@il.ibm.com>
Cc: Amit Shah <amit.shah@qumranet.com>, kvm@vger.kernel.org, Muli Ben-Yehuda <muli@il.ibm.com>, allen.m.kay@intel.com, chrisw@redhat.com, weidong.han@intel.com, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Ben-Ami Yassour wrote:
>>>   
>>>       
>> I did, and have something very similar queued.
>>     
>
> The notification list might help simplify the assigned device code.
> Are you planning to merge the patch you have queued, or should I use the
> one that I sent you?
>
>   

I'll dig mine up tomorrow and post it, so you can tell if it fits your 
needs.

-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.

