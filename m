From: Avi Kivity <avi@qumranet.com>
Subject: Re: [RFC 1/4] New virtio bus driver
Date: Mon, 09 Jul 2007 14:41:19 +0300
Message-ID: <46921EDF.7080602@qumranet.com>
References: <20070706124200.988637662@arndb.de>
	<200707082229.00810.arnd@arndb.de> <4691DA69.4060204@qumranet.com>
	<200707091318.48261.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200707091318.48261.arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Arnd Bergmann wrote:
> On Monday 09 July 2007, Avi Kivity wrote:
>   
>>> That is much harder to do, it would require a separate interrupt if you
>>> want to have a device independent mechanism. Most real buses (like PCI)
>>> don't have this, so I'm not sure it's good to do this at the virtio
>>> layer. You already listed the media change notification, which can
>>> be handled without this by either removing and adding the complete
>>> virtio device, or by using a channel for out-of-band data like scsi.
>>>       
>> At the very least, we need an interrupt for device hotplug.  That same
>> interrupt can be used to notify the guest about configuration changes
>> within a device ("rescan the virtbus and all who sail in her").
>>     
>
> There is an important difference between device reconfiguration and bus
> reconfiguration (device hotplug). If we want device reconfiguration, that
> needs to be implemented within the virtio layer, because the device
> drivers need to know about it. For hotplugging devices, we need to have
> a bus specific mechanism, while the device drivers only care about
> 'new device found' and 'device is gone' events that are already supported
> by any linux bus_type.
>   

Sure.  I'm only suggesting to share the interrupt.

> The problem with hotplugging devices on PCI is that there is not a good
> standard for this yet. The best option we have is probably PCI express
> hotplug, but I'm not sure how many legacy operating systems already support
> this.
>   

This is indeed a problem.  Perhaps we should have a virtqueue for 
reconfiguration (with a couple of read messages always queued for 
host-side changes, and a write message sent when the guest reconfigures).

-- 
error compiling committee.c: too many arguments to function
