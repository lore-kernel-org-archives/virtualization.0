From: Avi Kivity <avi@qumranet.com>
Subject: Re: [RFC 1/4] New virtio bus driver
Date: Sun, 08 Jul 2007 18:48:59 +0300
Message-ID: <4691076B.5050106@qumranet.com>
References: <20070706124200.988637662@arndb.de>
	<20070706125717.576683142@arndb.de> <4690B59C.10201@qumranet.com>
	<200707081729.58461.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200707081729.58461.arnd@arndb.de>
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
> On Sunday 08 July 2007, Avi Kivity wrote:
>   
>> arnd@arndb.de wrote:
>>     
>
>   
>>> +struct virtio_device_id {
>>> +	const char *device_type;
>>> +	unsigned long driver_data;
>>> +};
>>>   
>>>       
>> Carrying a string through a hypervisor interface can be unpleasant.  How 
>> about a constant instead?
>>     
>
> I chose a string because I found it to work rather well on
> open firmware and on the platform bus. It probably has
> to be a fixed length string which will be sent down from
> the hypervisor along with all the device specific data.
>
>   

Fixed length strings are okay, though unlovely.

>>> +struct virtio_config {
>>> +	const char host[128];
>>> +	const char driver[128];
>>> +};
>>>   
>>>       
>> There needs to be a way for the driver to tell the device that 
>> configuration has changed (promiscuous mode, MAC address) and vice versa 
>> (media detect).
>>
>> Maybe have a configuration virtqueue for that.
>>     
>
> I was hoping that we can live without dynamic configuration data
> in the common case. For a simple point-to-point ethernet device,
> that should work fine, 

Well, once you have _one_ dynamic config, you need a mechanism.  So 
consider a disk change notification for block device.

> and more complicated devices might need their
> own interface, e.g. by embedding a command number in every
> chunk of data that is sent down the one virtqueue, or by having
> a separate virtqueue for all out-of-band data.
>
> Alternatively, we could have a mechanism separate from the
> virtqueue concept, like a synchronous get_config_data/set_config_data
> callback into the host driver.
>   

You also need to allow the host to notify the guest about configuration 
changes.

>   
>> What I'm missing here is the lego approach, where you can mix and match:
>>
>>   virtnet.ko: basic net driver atop virtio, not linked to any implementation
>>   virtio-lguest.ko, virtio-kvm.ko, virtio-xen.ko:  virtio transports
>>   virtbus-pci.ko, virtbus-vio.ko, virtbus-xen.ko: virtual configuration 
>> space handlers; responsible for creating queues
>>
>>   vnet-kvm-pci.ko, vnet-kvm-virtbus.ko: stub drivers that glue the 
>> components together
>>
>> So we'd have one 10-line driver for every combination.
>>     
>
> The whole point of the bus abstraction is that the device driver (virtnet
> in this case) does not care about the underlying transport at all,
> while the host driver does not care about the device.
>
> So in your example, you get
>
> virtnet.ko (, virtblock.ko, hwrng-virtio.ko, ...): host-independent
>   device driver
> virtbus-lguest.ko, virtbus-kvm.ko, virtbus-pci.ko, virtbus-xen.ko:
>   device independent host drivers
>
> In cases where some of the code can be shared, e.g. virtbus-lguest
> and virtbus-kvm, you can have multiple host drivers sharing part
> of their code by using symbols from a library module, but my basic
> idea is that each host driver has a single module that handles
> the transport and the device probing.
>   

Is that module linked to both the pci libraries and the virtbus 
libraries?  Or does virtbus abstract pci in some way?


-- 
error compiling committee.c: too many arguments to function
