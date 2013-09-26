From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCHv2] tracing/events: Add bounce tracing to swiotbl
Date: Thu, 26 Sep 2013 14:03:25 -0400
Message-ID: <ce4d1787-5f83-4710-9f88-9349620eda28@email.android.com>
References: <1378325465-10384-1-git-send-email-zoltan.kiss@citrix.com>
	<5239CF01.1010001@citrix.com>
	<20130925175649.GC7253@phenom.dumpdata.com>
	<524467CC.7040908@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <524467CC.7040908@citrix.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zoltan Kiss <zoltan.kiss@citrix.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Zoltan Kiss <zoltan.kiss@citrix.com> wrote:
>On 25/09/13 18:56, Konrad Rzeszutek Wilk wrote:
>> On Wed, Sep 18, 2013 at 05:04:17PM +0100, Zoltan Kiss wrote:
>>> Hi,
>>>
>>> I haven't got a reply in the past 2 weeks, so I would like to bump
>>> the patch, just to make sure it haven't fell off the radar.
>>
>> Hey,
>>
>> I have this in my queue to put on 3.13 as it is past the merge
>window.
>> .. with that in mind:
>>
>>
>> .. snip..
>>>> +	TP_printk("dev_name: %s dma_mask=%llx dev_addr=%llx "
>>>> +		"size=%zu swiotlb_force=%x",
>>>> +		__get_str(dev_name),
>>>> +		__entry->dma_mask,
>>>> +		(unsigned long long)__entry->dev_addr,
>>>> +		__entry->size,
>>>> +		__entry->swiotlb_force)
>>
>> Would it make sense to do something like this:
>>
>> 		__entry->swiotlb_force ? "swiotlb_force" : "")
>>
>
>I would then rather do:
>
>+	TP_printk("dev_name: %s dma_mask=%llx dev_addr=%llx "
>+		"size=%zu swiotlb_force=",
>+               __entry->swiotlb_force ? " yes" : "no",
>+		__get_str(dev_name),
>
>Or do you mean?:
>
>+	TP_printk("dev_name: %s dma_mask=%llx dev_addr=%llx "
>+		"size=%zu",
>+               __entry->swiotlb_force ? " swiotlb_force" : "",
>+		__get_str(dev_name),
>
>This one doesn't tell you explicitly if swiotlb_force is NOT set, maybe
>
>that's not so good? And adds a bit of complexity to your grep regexp?
>Either way is fine with me, but I think "swiotlb_force=0|1" is also 
>pretty straightforward to understand, and I guess it makes printk 
>slightly faster (I assume the conditional operator gives a little bit
>of 
>overhead)
>
>Regards,
>
>Zoli

I was thinking it would be good to print the swiotlb-force only when it is enabled. So your second one would be it. 
