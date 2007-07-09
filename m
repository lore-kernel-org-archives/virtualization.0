From: Avi Kivity <avi@qumranet.com>
Subject: Re: [RFC 1/4] New virtio bus driver
Date: Mon, 09 Jul 2007 15:09:35 +0300
Message-ID: <4692257F.4070909@qumranet.com>
References: <20070706124200.988637662@arndb.de>
	<200707091318.48261.arnd@arndb.de> <46921EDF.7080602@qumranet.com>
	<200707091338.20288.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200707091338.20288.arnd@arndb.de>
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
>>> The problem with hotplugging devices on PCI is that there is not a good
>>> standard for this yet. The best option we have is probably PCI express
>>> hotplug, but I'm not sure how many legacy operating systems already support
>>> this.
>>>       
>> This is indeed a problem.  Perhaps we should have a virtqueue for 
>> reconfiguration (with a couple of read messages always queued for 
>> host-side changes, and a write message sent when the guest reconfigures).
>>     
>
> Yes, that would be my preferred solution as well. For devices that need
> reconfiguration capability, one virtqueue for all out-of-band information
> should be enough, with device specific messages.
>
> Why do you think we want to have multiple outstanding read messages?
> I would guess that a single message is enough, you can always requeue
> it after one event gets processed.
>   

Suppose there is one message queued.  The host reconfigures and sends 
the message. A new reconfiguration event now cannot be propagated.

If there are two messages queued, the host can post the updates in the 
second message.  The guest would then post two new messages (since it 
can't tell whether any reconfiguration events occured after the second 
message), the host would fill one, and everyone is happy.

Rusty, If you agree with this, I think it needs to be added to the core 
protocol.

[btw, virtbus could be implemented atop virtqueue as well]

-- 
error compiling committee.c: too many arguments to function
