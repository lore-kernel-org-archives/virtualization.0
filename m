From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Xen paravirt frontend block hang
Date: Tue, 18 Mar 2008 09:02:55 -0700
Message-ID: <47DFE7AF.7090402@goop.org>
References: <4772AC8E.7010007@theshore.net> <47758352.5040504@goop.org>	
	<479E71B7.7060207@theshore.net> <479E75E3.6030601@goop.org>	
	<479E7BA4.5050306@theshore.net>	
	<519a8b110802060437k70c099b7y7faefe63dd82039@mail.gmail.com>	
	<47AA845E.8020708@goop.org>
	<519a8b110802070612j2a1717f3s6aa25eeea8b7d18a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <519a8b110802070612j2a1717f3s6aa25eeea8b7d18a@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: xming <xmingske@gmail.com>
Cc: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

xming wrote:
> On Feb 7, 2008 5:09 AM, Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>   
>> xming wrote:
>>     
>>> But I do have one problem after I upgraded to xen 3.2, the 2.6.23.x domU do
>>> not boot any more and 2.6.24 does boot but will hang after cpufreq changes
>>> the frequency.
>>>
>>>       
>> Interesting.  Do you mean dom0 cpufreq frequency changes will cause the
>> domU to hang?
>>
>>     J
>>
>>     
>
> Yes, when Dom0 changes freq while domU is doing something will trigger this.
> When using "on demand" will trigger this very eassily.
>
> This is from xm top when a domU hangs:
>
>     test32 ------       4018   98.8     131072    6.4     131072
> 6.4     1    1     4516    50087    1        0   433908   300403
> 3084907223
>
> So it appers to be running (eating CPU) sometimes the state is "r"
> sometimes "-",
> but both console and network are dead.
>   

Which version of Xen did you try this on?  Some versions of xen-unstable 
had horribly broken cpufreq support, in which it was failing to keep 
track of cpu speed changes.  Current versions should be OK.

    J
