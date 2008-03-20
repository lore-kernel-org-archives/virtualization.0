From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [RFC PATCH 0/4] Inter-guest virtio I/O example with
	lguest
Date: Thu, 20 Mar 2008 16:27:45 +0200
Message-ID: <47E27461.4090404__46611.2345261083$1206023506$gmane$org@qumranet.com>
References: <200803201659.14344.rusty@rustcorp.com.au>
	<47E20A35.2000600@qumranet.com> <47E26CC1.8080900@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47E26CC1.8080900@codemonkey.ws>
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
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori wrote:
> Avi Kivity wrote:
>> Rusty Russell wrote:
>>  
>>> Hi all,
>>>
>>>    Just finished my prototype of inter-guest virtio, using 
>>> networking as an example.  Each guest mmaps the other's address 
>>> space and uses a FIFO for notifications.
>>>
>>>       
>>
>> Isn't that a security hole (hole? chasm)?  If the two guests can 
>> access each other's memory, they might as well be just one guest, and 
>> communicate internally.
>>   
>
> Each guest's host userspace mmaps the other guest's address space.  
> The userspace then does a copy on both the tx and rx paths.
>

Well, that's better security-wise (I'd still prefer to avoid it, so we 
can run each guest under a separate uid), but then we lose performance wise.

> Conceivably, this could be done as a read-only mapping so that each 
> guest userspace copies only the rx packets.  That's about as secure as 
> you're going to get with this approach I think.
>

Maybe we can terminate the virtio queue in the host kernel as a pipe, 
and splice pipes together.

That gives us guest-guest and guest-process communications, and if you 
use aio the kernel can use a dma engine for the copy.

-- 
error compiling committee.c: too many arguments to function
