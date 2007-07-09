From: Avi Kivity <avi@qumranet.com>
Subject: Re: [RFC 1/4] New virtio bus driver
Date: Mon, 09 Jul 2007 17:56:21 +0300
Message-ID: <46924C95.8010002@qumranet.com>
References: <20070706124200.988637662@arndb.de>
	<200707091338.20288.arnd@arndb.de> <4692257F.4070909@qumranet.com>
	<200707091624.57725.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200707091624.57725.arnd@arndb.de>
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
>> Suppose there is one message queued.  The host reconfigures and sends 
>> the message. A new reconfiguration event now cannot be propagated.
>>
>> If there are two messages queued, the host can post the updates in the 
>> second message.  The guest would then post two new messages (since it 
>> can't tell whether any reconfiguration events occured after the second 
>> message), the host would fill one, and everyone is happy.
>>     
>
> But you can always have one more event than you have space in the queue,
> so the host _still_ needs to do its own queuing of these events.
>
>   

It's probably enough to keep a flag that the guest is not up-to-date, 
and have a reconfiguration message include the entire configuration 
(e.g. don't send deltas).

>> Rusty, If you agree with this, I think it needs to be added to the core 
>> protocol.
>>     
>
> Why is it part of the core protocol? If a driver needs a feature like
> this, it needs to have an additional virtqueue, but the core does not
> need to care that this is about reconfiguration.
>
>   

I meant that drivers need that second (or third) virtqueue.  Actual 
configuration messages could be added later.  virtqueue itself is of 
course oblivious to this stuff happening behind (or rather on top) of 
its back.

> I would make a clear distinction between the stuff that is in the
> initial config space (read-only) and other things that can be reconfigured.
> If a device needs to read a property that can dynamically change,
> it probably makes sense for it to start by reading from the configuration
> virtqueue instead of the static config space.
>
>   

Agreed.

>> [btw, virtbus could be implemented atop virtqueue as well]
>>     
>
> You mean 'one virtbus'? Certainly, that sounds good. You can have
> a virtio device with a single read-only virtqueue that emits messages
> about other devices coming and going.
>   

Yes.  A message would contain the device type, identifier, interrupt 
number (when applicable), and location of the the device's configuration 
information (including its virtqueues).

> I think that is how Carsten's s390 virtual device bus works.
>
> For virtbus in general, I'd think that this model would only be one
> of several possible, where the others could be PCI and whatever Xen
> prefers for device enumeration (I haven't looked at that in detail).
>
> [interesting side effect: you can have a PCI device that actually
> is a virtbus bridge device, as the parent for other hcall based
> virtio devices, along with other PCI devices, some of which are
> a virtio device by themselves.]
>   

That still doesn't help with older Linuces and closed-source OSes, which 
are the main motivation for PCI.  Newer Linux should be pure virtbus IMO.

-- 
error compiling committee.c: too many arguments to function
