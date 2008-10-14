From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [PATCH][RFC] vmchannel a data channel between host and guest.
Date: Tue, 14 Oct 2008 13:16:19 -0500
Message-ID: <48F4E1F3.3050606__46145.8738813691$1224008444$gmane$org@codemonkey.ws>
References: <20081012124534.GK11435@redhat.com>
	<48F39443.4070203@codemonkey.ws>
	<20081014090540.GB13153@redhat.com> <48F4A3B8.8050603@us.ibm.com>
	<20081014175900.GA18344@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081014175900.GA18344@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gleb Natapov <gleb@redhat.com>
Cc: Anupam Chanda <anupamc@vmware.com>, Andrew Biggadike <biggadike@vmware.com>, kvm@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Gleb Natapov wrote:
> On Tue, Oct 14, 2008 at 08:50:48AM -0500, Anthony Liguori wrote:
>   
>> Gleb Natapov wrote:
>>     
>>> On Mon, Oct 13, 2008 at 01:32:35PM -0500, Anthony Liguori wrote:
>>>   
>>>       
>>> netlink was designed to be interface to userspace and is used like this
>>> by different subsystems (not just network). What full blown socket (and
>>> by that I presume you mean new address family) will give you over netlink?
>>> File system? We need a simple stream semantics is this justify another
>>> virtual file system? The choice was between char device and netlink.
>>> Nelink was simpler and gives broadcast as a bonus.
>>>   
>>>       
>> The problem that you aren't solving, that IMHO is critical to solve, is  
>> the namespace issue.  How do you determine who gets to use what channel  
>> in userspace and in the host?
>>     
> Management software determines this. You have an image that is managed
> by particular software and management daemons on the guest knows what
> channels to use to communicate with their counterparts on the host.
> Is there a need to provide more then that?
>   

No, I don't think this is enough.  I think we need to support multiple 
independent management agents using these interfaces so we can't rely on 
a single management too orchestrating who uses what channel.

For instance, we'll have something that's open that does copy/paste and 
DnD, but then CIM people may want to have monitor agents that use the 
interface for monitoring.

>>                                 It's not a problem when you just have one
>> tool, but if you expect people to start using this interface,  
>> arbitrating it quickly becomes a problem.
>>     
> I expect that software on the host and on the guest will belong to the
> same management solution.
>   

There won't always be one set of tools that use this functionality.

>> sockets have a concept of addressing and a vfs has a natural namespace.   
>> That's what I was suggesting those interfaces.
>>
>>     
> What address should look like if we will choose to use new address family?
> An example will help me understand what problem you are trying to point out
> easily.
>   

One thing that's been discussed is to use something that looked much 
like struct sockaddr_un.  As long as the strings were unique, they could 
be in whatever format people wanted.

Of course, you should also take a look at VMware's VMCI.  If we're going 
to have a socket interface, if we can have a compatible userspace 
interface, that would probably be a good thing.

>>>   
>>>       
>>>> Having a limit of only 4 links seems like a problem to me too.
>>>>
>>>>     
>>>>         
>>> This can be easily extended.
>>>   
>>>       
>> There shouldn't be an inherent limit in the userspace interface.
>>
>>     
> Well, qemu has those limits for all other interfaces (like number of
> nics, serial ports, parallel ports), but if vmchannels are somehow
> different in this regards there is no problem to dynamically grow their
> number.
>   

Having a limit in QEMU is fine, we just don't want the limit to be in 
the guest driver.  It's relatively easy to increase the limit or make it 
dynamic in QEMU but if it requires guest-visible changes, that's much 
more difficult to fix.

Regards,

Anthony Liguori

>   


> --
> 			Gleb.
>   
