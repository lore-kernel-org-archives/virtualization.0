From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 1/1] Shared memory uio_pci driver
Date: Thu, 25 Mar 2010 18:40:52 +0200
Message-ID: <20100325164052.GB16506__11229.0062279955$1269535695$gmane$org@redhat.com>
References: <1269497376-21903-1-git-send-email-cam@cs.ualberta.ca>
	<20100325091552.GB11153@redhat.com>
	<8286e4ee1003250918x659e87ai9e5ca7c68c23a7c3@mail.gmail.com>
	<4BAB8DE9.9080603@codemonkey.ws> <4BAB900F.5030104@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4BAB900F.5030104@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Anthony Liguori <anthony@codemonkey.ws>, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 25, 2010 at 06:32:15PM +0200, Avi Kivity wrote:
> On 03/25/2010 06:23 PM, Anthony Liguori wrote:
>>> There has been previous discussion of virtio, however while virtio is
>>> good for exporting guest memory, it's not ideal for importing memory
>>> into a guest.
>>
>> virtio is a DMA-based API which means that it doesn't assume cache  
>> coherent shared memory.  The PCI transport takes advantage of cache  
>> coherent shared memory but it's not strictly required.
>
> Aren't we violating this by not using dma_alloc_coherent() for the queues?

I don't see what changing this would buys us though, unless
a non-cache coherent architecture implements kvm.
TCG runs everything on a single processor so there are
no cache coherency issues.

> -- 
> error compiling committee.c: too many arguments to function
