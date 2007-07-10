From: Avi Kivity <avi@qumranet.com>
Subject: Re: [RFC 1/4] New virtio bus driver
Date: Tue, 10 Jul 2007 10:56:46 +0300
Message-ID: <46933BBE.3030908@qumranet.com>
References: <20070706124200.988637662@arndb.de>	
	<200707091318.48261.arnd@arndb.de> <46921EDF.7080602@qumranet.com>	
	<200707091338.20288.arnd@arndb.de> <4692257F.4070909@qumranet.com>
	<1184032419.6005.430.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1184032419.6005.430.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Mon, 2007-07-09 at 15:09 +0300, Avi Kivity wrote:
>   
>> Arnd Bergmann wrote:
>>     
>>> Why do you think we want to have multiple outstanding read messages?
>>> I would guess that a single message is enough, you can always requeue
>>> it after one event gets processed.
>>>       
>> Suppose there is one message queued.  The host reconfigures and sends 
>> the message. A new reconfiguration event now cannot be propagated.
>>
>> If there are two messages queued, the host can post the updates in the 
>> second message.  The guest would then post two new messages (since it 
>> can't tell whether any reconfiguration events occured after the second 
>> message), the host would fill one, and everyone is happy.
>>     
>
> But there can always be another reconfig about to happen after whatever
> the guest is processing now.  Is there any point in the guest doing
> anything other than one at a time, in order?
>
>   

I thought that would help prevent races, but there's a much simpler way: 
the host sets an internal flag if an event happened since the last 
message was posted, etc.  So one message should suffice.


>> Rusty, If you agree with this, I think it needs to be added to the core 
>> protocol.
>>     
>
> Well, using an "events" virtqueue in the core means existing virtual I/O
> mechanisms need to fake one up on the guest.  Using a function-call
> interface is more natural (and doesn't stop a virtio layer from using an
> events virtqueue and demuxing).
>
> Also, are we sure about the assumption that events won't have ordering
> constraints wrt other queues?  For example, a media change event might;
> I don't know the semantics required there...

Yeah.  Maybe just allow configuration messages on the regular virtqueues 
(they can cause a callback to be called, which parses  the message and 
passes it to the function-call interface.

-- 
error compiling committee.c: too many arguments to function
