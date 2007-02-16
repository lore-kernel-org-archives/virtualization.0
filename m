From: Dan Hecht <dhecht@vmware.com>
Subject: Re: [Xen-devel] Re: [patch 14/21] Xen-paravirt: Add XEN config	options
 and disableunsupported config options.
Date: Fri, 16 Feb 2007 14:38:13 -0800
Message-ID: <45D63255.2070801@vmware.com>
References: <C1FBAFD7.99AB%keir@xensource.com> <45D62759.7080006@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751517AbXBPWlM@vger.kernel.org>
In-Reply-To: <45D62759.7080006@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Keir Fraser <keir@xensource.com>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Christian Limpach <Christian.Limpach@xensource.com>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, Steven Hand <steven.hand@cl.cam.ac.uk>, linux-kernel@vger.kernel.org, Ian Pratt <Ian.Pratt@xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

On 02/16/2007 01:51 PM, Zachary Amsden wrote:
> Keir Fraser wrote:
>> On 16/2/07 17:46, "Jeremy Fitzhardinge" <jeremy@goop.org> wrote:
>>
>>   
>>> Keir Fraser wrote:
>>>     
>>>> This initial patchset does not include save/restore support anyway, so in
>>>> fact it would be consistent to have CONFIG_PREEMPT configurable. I'm sure
>>>> that we are going to have some nasty bugs to fix up as a result, but we
>>>> can't fix them until we find them! Then we can convert our save/restore code
>>>> to use the freezer before submitting it for inclusion.
>>>>       
>>> OK.  So that makes the only config restriction the 100Hz ticks.
>>>     
>> We can extend the Xen timer interface quite easily and get rid of this one
>> too. In fact it doesn't *much* matter if the CONFIG_HZ differs from the Xen
>> ticker rate -- we modified the Linux timer ISR to handle timer interrupts at
>> arbitrary times already. The only drawback is that jiffies updates in burts
>> if CONFIG_HZ is higher than the actual tick rate, and this can affect some
>> calibration constants and cause Linux to print out some weird values at
>> start-of-day.
>>   
> 
> That's why we'd very much like to get a get_cpu_speed paravirt-op 
> implemented.  I think this would be useful to work around these problems 
> for Xen as well.
> 
>

Yes, and regardless of whether you run your periodic timer slower than 
HZ, calibrating time in a VM is always difficult due to the fact the 
kernel is time sharing the physical cpu.  Why not just ask the 
underlying hypervisor?

Really, Time is one of those areas where paravirtualization makes a lot 
of sense, no matter how much virtualization hardware you have crammed 
into your cpu....
