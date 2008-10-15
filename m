From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [PATCH][RFC] vmchannel a data channel between host and guest.
Date: Wed, 15 Oct 2008 09:02:30 -0500
Message-ID: <48F5F7F6.5010208__2371.05776691369$1224079749$gmane$org@codemonkey.ws>
References: <20081012124534.GK11435@redhat.com>
	<48F39443.4070203@codemonkey.ws>
	<20081014090540.GB13153@redhat.com> <48F4A3B8.8050603@us.ibm.com>
	<20081014175900.GA18344@redhat.com>
	<48F4E1F3.3050606@codemonkey.ws>
	<20081015125837.GQ11435@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081015125837.GQ11435@redhat.com>
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
> On Tue, Oct 14, 2008 at 01:16:19PM -0500, Anthony Liguori wrote:
>   
>> One thing that's been discussed is to use something that looked much  
>>     
> Where is has been discussed? Was it on a public mailing list with online
> archive?
>   

Probably?  This subject has been discussed to death in various places 
(including within the Xen community).

>> like struct sockaddr_un.  As long as the strings were unique, they could  
>> be in whatever format people wanted.
>>
>>     
> So basically what you are saying is that you want to use string IDs instead of
> numerical IDs in a hope that the chance of colliding IDs will be smaller? (in the
> current implementation ID length is 32 bit, so the chances for two services to
> pick the same ID is small).
>   

But people don't choose random 32-bit integers and since your 
implementation only supports channels 0..4 obviously, the intention 
isn't to choose random integers.  When using integers, it would be 
necessary to have some sort of authority that assigns out the integers 
to avoid conflict.  A protocol like this scales better if such an 
authority isn't necessary.

> But why pick constant ID for a service at all? Management software can
> assign unique IDs for each service during image preparation.

First, not everyone has "management software".  Even so, it's not the 
center of the world.  If I want to add a new feature to QEMU that makes 
use of one of these channels (say Unity/Coherence), does that mean I now 
have to tell every management tool (libvirt et al) about this interface 
so they can assign an ID to it?  How does the guest software know what 
channel to use?  You basically assume yet another host<=>guest 
communication mechanism to tell the guest software what channel to use.  
That seems to defeat the purpose.

>  So one
> management software will use channel 42 for DnD and 22 for CIM and another
> will use 13 for DnD and 42 for CIM. All is need is to not hard code
> channel IDs into agents. You will not be able to move such images from one
> management software to another easily of cause, but this task is not so easy
> today too.
>   

It's so much simpler to just use unique identifiers for each service.  
Be it UUID, a string in the form of a reverse fqdn or URL, or whatever.

>> Of course, you should also take a look at VMware's VMCI.  If we're going  
>> to have a socket interface, if we can have a compatible userspace  
>> interface, that would probably be a good thing.
>>
>>     
> As good as VMware backdoor interface that we chose not to use because we
> can't control it?
>   

I suggested you look at VMCI mainly to see the addressing mechanism.  
AF_IUCV is something else to look at although there's a lot of legacy 
there.  I'm not suggesting we be binary compatible with VMCI, but if 
their addressing mechanism is sufficiently general (like a string), then 
I see no reason not to use the same addressing mechanism or something 
similar to it.

>  If you like string IDs better
> than numerical IDs and you are OK with "lookup by name" way of doing
> things in VMCI I can easily add channel 0 (will be implemented by qemu
> itself and thus always present) that will do name to ID mapping.
>   

It's not a bad idea to have a bootstrap channel.  Do channel exist 
during the entirely life time of the guest?  Can disconnects/reconnects 
happen on a channel?  Can a guest listen on a channel?

Certainly, sockets are a pretty well established model so it makes a 
certain amount of sense to have these things behave like traditional 
sockets.

Regards,

Anthony Liguori
