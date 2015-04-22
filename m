From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: Zerocopy VM-to-VM networking using virtio-net
Date: Wed, 22 Apr 2015 19:46:03 +0200
Message-ID: <20150422194603.1e650ec7.cornelia.huck__21446.3724675172$1429724792$gmane$org@de.ibm.com>
References: <20150422170138.GA8388@stefanha-thinkpad.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150422170138.GA8388@stefanha-thinkpad.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Andrew Jones <drjones@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Rik van Riel <riel@redhat.com>, virtualization@lists.linux-foundation.org, virtio-comment@lists.oasis-open.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 22 Apr 2015 18:01:38 +0100
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> [It may be necessary to remove virtio-dev@lists.oasis-open.org from CC
> if you are a non-TC member.]
> 
> Hi,
> Some modern networking applications bypass the kernel network stack so
> that rx/tx rings and DMA buffers can be directly mapped.  This is
> typical in DPDK applications where virtio-net currently is one of
> several NIC choices.
> 
> Existing virtio-net implementations are not optimized for VM-to-VM
> DPDK-style networking.  The following outline describes a zero-copy
> virtio-net solution for VM-to-VM networking.
> 
> Thanks to Paolo Bonzini for the Shared Buffers BAR idea.
> 
> Use case
> --------
> Two VMs on the same host need to communicate in the most efficient
> manner possible (e.g. the sole purpose of the VMs is to do network I/O).
> 
> Applications running inside the VMs implement virtio-net in userspace so
> they have full control over rx/tx rings and data buffer placement.

Wouldn't that also benefit applications that use a kernel
implementation? You still need to get the data to/from kernel space,
but you'd get the benefit of being able to get the data to the peer
immediately.

> 
> Performance requirements are higher priority than security or isolation.
> If this bothers you, stick to classic virtio-net.
> 
> virtio-net VM-to-VM extensions
> ------------------------------
> A few extensions to virtio-net are necessary to support zero-copy
> VM-to-VM communication.  The extensions are covered informally
> throughout the text, this is not a VIRTIO specification change proposal.
> 
> The VM-to-VM capable virtio-net PCI adapter has an additional MMIO BAR
> called the Shared Buffers BAR.  The Shared Buffers BAR is a shared
> memory region on the host so that the virtio-net devices in VM1 and VM2
> both access the same region of memory.
> 
> The vring is still allocated in guest RAM as usual but data buffers must
> be located in the Shared Buffers BAR in order to take advantage of
> zero-copy.
> 
> When VM1 places a packet into the tx queue and the buffers are located
> in the Shared Buffers BAR, the host finds the VM2's rx queue descriptor
> with the same buffer address and completes it without copying any data
> buffers.

The shared buffers BAR looks PCI-specific, but what about other
mechanisms to provide a shared space between two VMs with some kind of
lightweight notifications? This should make it possible to implement a
similar mode of operation for other transports if it is factored out
correctly. (The actual implementation of this shared space is probably
the difficult part :)

> 
> Shared buffer allocation
> ------------------------
> A simple scheme for two cooperating VMs to manage the Shared Buffers BAR
> is as follows:
> 
>   VM1         VM2
>        +---+
>    rx->| 1 |<-tx
>        +---+
>    tx->| 2 |<-rx
>        +---+
>    Shared Buffers
> 
> This is a trivial example where the Shared Buffers BAR has only two
> packet buffers.
> 
> VM1 starts by putting buffer 1 in its rx queue.  VM2 starts by putting
> buffer 2 in its rx queue.  The VMs know which buffers to choose based on
> a new uint8_t virtio_net_config.shared_buffers_offset field (0 for VM1
> and 1 for VM2).
> 
> VM1 can transmit to VM2 by filling buffer 2 and placing it on its tx
> queue.  VM2 can transmit by filling buffer 1 and placing it on its tx
> queue.
> 
> As soon as a buffer is placed on a tx queue, the VM passes ownership of
> the buffer to the other VM.  In other words, the buffer must not be
> touched even after virtio-net tx completion because it now belongs to
> the other VM.
> 
> This scheme of bouncing ownership back-and-forth between the two VMs
> only works if both VMs transmit an equal number of buffers over time.
> In reality the traffic pattern may be unbalanced so VM1 is always
> transmitting and VM2 is always receiving.  This problem can be overcome
> if the VMs cooperate and return buffers if they accumulate too many.
> 
> For example, after VM1 transmits buffer 2 it has run out of tx buffers:
> 
>   VM1         VM2
>        +---+
>    rx->| 1 |<-tx
>        +---+
>     X->| 2 |<-rx
>        +---+
> 
> VM2 notices that it now holds all buffers.  It can donate a buffer back
> to VM1 by putting it on the tx queue with the new virtio_net_hdr.flags
> VIRTIO_NET_HDR_F_GIFT_BUFFER flag.  This flag indicates that this is not
> a packet but rather an empty gifted buffer.  VM1 checks the flags field
> to detect that it has been gifted buffers.
> 
> Also note that zero-copy networking is not mutually exclusive with
> classic virtio-net.  If the descriptor has buffer addresses outside the
> Shared Buffers BAR, then classic non-zero-copy virtio-net behavior
> occurs.

Is simply writing the values in the header enough to trigger the other
side? You don't need some kind of notification? (I'm obviously coming
from a non-PCI view, and for my kind-of-nebulous idea I'd need a
lightweight interrupt so that the other side knows it should check the
header.)

> 
> Host-side implementation
> ------------------------
> The host facilitates zero-copy VM-to-VM communication by taking
> descriptors off tx queues and filling in rx descriptors of the paired
> VM.  In the Linux vhost_net implementation this could work as follows:
> 
> 1. VM1 places buffer 2 on the tx queue and kicks the host.  Ownership of
>    the buffer no longer belongs to VM1.
> 2. vhost_net pops the buffer from VM1's tx queue and verifies that the
>    buffer address is within the Shared Buffers BAR.
> 3. vhost_net finds the VM2 rx queue descriptor whose buffer address
>    matches, completes that descriptor, and kicks VM2.
> 4. VM2 pops buffer 2 from the rx queue.  It can now reuse this buffer
>    for transmitting to VM1.
> 
> The vhost_net.ko kernel module needs a new ioctl for pairing vhost_net
> instances.  This ioctl is used to establish the VM-to-VM connection
> between VM1's virtio-net and VM2's virtio-net.
> 
> Discussion
> ----------
> The result is that applications in separate VMs can communicate in true
> zero-copy fashion.
> 
> I think this approach could be fruitful in bringing virtio-net to
> VM-to-VM networking use cases.  Unless virtio-net is extended for this
> use case, I'm afraid DPDK and OpenDataPlane communities might steer
> clear of VIRTIO.
> 
> This is an idea I want to share but I'm not working on a prototype.
> Feel free to flesh it out further and try it!

Definetly interesting. It seems you get much of the needed
infrastructure by simply leveraging what PCI gives you anyway? If we
want something like in other environments (say, via ccw on s390), we'd
have to come up with a mechanism that can give us the same (which is
probably the hard part).

> 
> Open issues:
>  * Multiple VMs?
>  * Multiqueue?
>  * Choice of shared buffer allocation algorithm?
>  * etc
> 
> Stefan
