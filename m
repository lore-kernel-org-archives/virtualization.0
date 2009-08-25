From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: vhost net: performance with ping benchmark
Date: Tue, 25 Aug 2009 16:43:32 +0300
Message-ID: <20090825134332.GC13949__11971.870941534$1251208000$gmane$org@redhat.com>
References: <20090824081240.GA3415@redhat.com>
	<20090824212137.GA9835@redhat.com>
	<4A934AF7.2090904@codemonkey.ws> <4A936525.5030300@redhat.com>
	<4A93E5F7.5010606@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A93E5F7.5010606@codemonkey.ws>
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
Cc: Mark McLoughlin <markmc@redhat.com>, Avi Kivity <avi@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 25, 2009 at 08:24:07AM -0500, Anthony Liguori wrote:
> Avi Kivity wrote:
>> My preference is ring proxying.  Not we'll need ring proxying (or at  
>> least event proxying) for non-MSI guests.
>
> Thinking about this more...
>
> How does the hand off work?  Assuming you normally don't proxy ring  
> entries and switch to proxying them when you want to migration, do you  
> have a set of ioctl()s that changes the semantics of the ring to be host  
> virtual addresses instead of guest physical?  If so, what do you do with  
> in flight requests?  Does qemu have to buffer new requests and wait for  
> old ones to complete?
>
> Unless you always do ring proxying.  If that's the case, we don't need  
> any of the slot management code in vhost.
>
> Regards,
>
> Anthony Liguori

Here's how it works. It relies on the fact that in virtio, guest can not
assume that descriptors have been used unless they appeared in used
buffers.

When migration starts, we do this:

1. stop kernel (disable socket)
2. call VHOST_SET_VRING_USED: note it gets virtual address, bot guest
   physical. We point it at buffer in qemu memory
3. call VHOST_SET_VRING_CALL, pass eventfd created by qemu
5. copy over existing used buffer
4. unstop kernel (reenable socket)

Now when migration is in progress, we do this:
A. poll eventfd in 3 above
B. When event is seen, look at used buffer that we gave to kernel
C. Parse descriptors and mark pages that kernel wrote to
   as dirty
D. update used buffer that guest looks at
E. signal eventfd for guest

-- 
MST
