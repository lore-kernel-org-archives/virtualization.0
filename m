From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH for-2.6.35] virtio-pci: disable msi at startup
Date: Wed, 23 Jun 2010 18:43:11 +0300
Message-ID: <20100623154311.GD30526__11823.4107424088$1277308219$gmane$org@redhat.com>
References: <20100610152252.GA3510@redhat.com> <4C22132F.4060307@redhat.com>
	<20100623135946.GA30526@redhat.com> <4C221871.6020509@redhat.com>
	<20100623144307.GB30526@redhat.com> <4C222508.2060804@redhat.com>
	<20100623152633.GC30526@redhat.com> <4C2229DB.6060706@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4C2229DB.6060706@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, linux-pci@vger.kernel.org, Matt Carlson <mcarlson@broadcom.com>, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, virtualization@lists.linux-foundation.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Tejun Heo <tj@kernel.org>, "David S. Miller" <davem@davemloft.net>, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 23, 2010 at 06:35:55PM +0300, Avi Kivity wrote:
> On 06/23/2010 06:26 PM, Michael S. Tsirkin wrote:
>>
>>
>>>>
>>>>        
>>>>>>> Shouldn't a reset be equivalent to power cycling?
>>>>>>>
>>>>>>>
>>>>>>>              
>>>>>> If we did this, driver would need to restore registers
>>>>>> such as BAR etc.
>>>>>>
>>>>>>
>>>>>>            
>>>>> We could save/restore the registers we care about.
>>>>>
>>>>>          
>>>> It seems easier to clear registers we care about.
>>>>        
>>> We know the registers we care about, we don't know the ones we don't.
>>>      
>> If/when we use more registers, we can update driver to clear them on start.
>>    
>
> The kdump kernel may not load drivers for those extra devices.

Then we don't care about clearing them?

>>> I'm talking about FLRing all cards, not just those you want to use.
>>>      
>> reset using FLR/PM is complex because of the need to save/restore
>> config space. Doing this on a crashing kernel sounds scary.
>>    
>
> Well, you only need to save/restore for the devices you use.  The rest  
> you reset and forget.
>
> I don't really see why copying some config space is crazy.

Maybe not crazy, but complex.  Look at pci_restore_state.
Anyway, if kdump wants to do this, it's a question of
calling pci_reset_function.

>>>>     It's also too late
>>>> now: changing behaviour will break old drivers.
>>>>
>>>>        
>>> Why?  the FLR is triggered by the guest kernel, so all drivers will be
>>> aware it was FLRed.
>>>      
>> Not for FLR. Too late to reset on PA write.
>>
>>    
>
> What's PA write?

thats how we reset virtio today: write 0 to PA register.

> -- 
> error compiling committee.c: too many arguments to function
