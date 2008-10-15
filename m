From: Gleb Natapov <gleb@redhat.com>
Subject: Re: [PATCH][RFC] vmchannel a data channel between host and guest.
Date: Wed, 15 Oct 2008 14:58:37 +0200
Message-ID: <20081015125837.GQ11435__49787.1912819848$1224081974$gmane$org@redhat.com>
References: <20081012124534.GK11435@redhat.com>
	<48F39443.4070203@codemonkey.ws>
	<20081014090540.GB13153@redhat.com> <48F4A3B8.8050603@us.ibm.com>
	<20081014175900.GA18344@redhat.com>
	<48F4E1F3.3050606@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <48F4E1F3.3050606@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Anupam Chanda <anupamc@vmware.com>, Andrew Biggadike <biggadike@vmware.com>, kvm@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Oct 14, 2008 at 01:16:19PM -0500, Anthony Liguori wrote:
>>> sockets have a concept of addressing and a vfs has a natural 
>>> namespace.   That's what I was suggesting those interfaces.
>>>
>>>     
>> What address should look like if we will choose to use new address family?
>> An example will help me understand what problem you are trying to point out
>> easily.
>>   
>
> One thing that's been discussed is to use something that looked much  
Where is has been discussed? Was it on a public mailing list with online
archive?

> like struct sockaddr_un.  As long as the strings were unique, they could  
> be in whatever format people wanted.
>
So basically what you are saying is that you want to use string IDs instead of
numerical IDs in a hope that the chance of colliding IDs will be smaller? (in the
current implementation ID length is 32 bit, so the chances for two services to
pick the same ID is small).

But why pick constant ID for a service at all? Management software can
assign unique IDs for each service during image preparation. So one
management software will use channel 42 for DnD and 22 for CIM and another
will use 13 for DnD and 42 for CIM. All is need is to not hard code
channel IDs into agents. You will not be able to move such images from one
management software to another easily of cause, but this task is not so easy
today too.

> Of course, you should also take a look at VMware's VMCI.  If we're going  
> to have a socket interface, if we can have a compatible userspace  
> interface, that would probably be a good thing.
>
As good as VMware backdoor interface that we chose not to use because we
can't control it?

I looked at what I could find about VMCI (http://pubs.vmware.com/vmci-sdk/index.html).
Wow, it looks like somebody was assigned a task to design a cross
platform communication layer that should accommodate every past, present
and future requirement no matter how likely or weird it may be :)
But seriously if we drop all the cross platform craft from there and add
name resolution server to proposed vmchannel we will have something very
similar (sans shared memory of cause). If you like string IDs better
than numerical IDs and you are OK with "lookup by name" way of doing
things in VMCI I can easily add channel 0 (will be implemented by qemu
itself and thus always present) that will do name to ID mapping.
But why stop there. Lets run CORBA name service on channel 0 and run
CORBA objects on others (joke).


>>>>         
>>>>> Having a limit of only 4 links seems like a problem to me too.
>>>>>
>>>>>             
>>>> This can be easily extended.
>>>>         
>>> There shouldn't be an inherent limit in the userspace interface.
>>>
>>>     
>> Well, qemu has those limits for all other interfaces (like number of
>> nics, serial ports, parallel ports), but if vmchannels are somehow
>> different in this regards there is no problem to dynamically grow their
>> number.
>>   
>
> Having a limit in QEMU is fine, we just don't want the limit to be in  
> the guest driver.  It's relatively easy to increase the limit or make it  
> dynamic in QEMU but if it requires guest-visible changes, that's much  
> more difficult to fix.
>
That's OK then. There is no any compile time limits on a number of
channels in the current Linux driver. The number is only limited by PCI
configuration space as I pass available channel IDs there.

--
			Gleb.
