From: Zachary Amsden <zach@vmware.com>
Subject: Re: Re: [patch 14/21] Xen-paravirt: Add XEN config	options
	and disableunsupported config options.
Date: Fri, 16 Feb 2007 13:51:21 -0800
Message-ID: <45D62759.7080006@vmware.com>
References: <C1FBAFD7.99AB%keir@xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <C1FBAFD7.99AB%keir@xensource.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Keir Fraser <keir@xensource.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, Christian Limpach <Christian.Limpach@xensource.com>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Steven Hand <steven.hand@cl.cam.ac.uk>, Ian Pratt <Ian.Pratt@xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

Keir Fraser wrote:
> On 16/2/07 17:46, "Jeremy Fitzhardinge" <jeremy@goop.org> wrote:
>
>   
>> Keir Fraser wrote:
>>     
>>> This initial patchset does not include save/restore support anyway, so in
>>> fact it would be consistent to have CONFIG_PREEMPT configurable. I'm sure
>>> that we are going to have some nasty bugs to fix up as a result, but we
>>> can't fix them until we find them! Then we can convert our save/restore code
>>> to use the freezer before submitting it for inclusion.
>>>       
>> OK.  So that makes the only config restriction the 100Hz ticks.
>>     
>
> We can extend the Xen timer interface quite easily and get rid of this one
> too. In fact it doesn't *much* matter if the CONFIG_HZ differs from the Xen
> ticker rate -- we modified the Linux timer ISR to handle timer interrupts at
> arbitrary times already. The only drawback is that jiffies updates in burts
> if CONFIG_HZ is higher than the actual tick rate, and this can affect some
> calibration constants and cause Linux to print out some weird values at
> start-of-day.
>   

That's why we'd very much like to get a get_cpu_speed paravirt-op 
implemented.  I think this would be useful to work around these problems 
for Xen as well.

Zach
