From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [virtio-dev] Zerocopy VM-to-VM networking using virtio-net
Date: Fri, 24 Apr 2015 10:47:58 +0100
Message-ID: <CAJSP0QWtbzWwbvHYHVDJ2bccJ1wPZ0WA31bOH5UkGMhbkLF-Ng@mail.gmail.com>
References: <20150422170138.GA8388@stefanha-thinkpad.redhat.com>
	<CAA2XHbd_Wxs3O6ChSGouF3ZGH-SA0Lzw7OFVfvnuAXZmLAkZoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAA2XHbd_Wxs3O6ChSGouF3ZGH-SA0Lzw7OFVfvnuAXZmLAkZoA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Luke Gorrie <luke@snabb.co>
Cc: Andrew Jones <drjones@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Rik van Riel <riel@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-comment@lists.oasis-open.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 24, 2015 at 9:12 AM, Luke Gorrie <luke@snabb.co> wrote:
> - How fast would the new design likely be?

This proposal eliminates two things in the path:

1. Compared to vhost_net, it bypasses the host tun driver and network
stack, replacing it with direct vhost_net <-> vhost_net data transfer.
At this level it's compared to vhost-user, but it's not programmable
in userspace!

2. Data copies are eliminated because the Shared Buffers BAR gives
both VMs access to the packets.

My concern is the overhead of the vhost_net component copying
descriptors between NICs.  In a 100% shared memory model, each VM only
has a receive queue that the other VM places packets into.  There are
no tx queues.  The notification mechanism is an event fd that is
ioeventfd for VM1 and irqfd for VM2.  In other words, when VM1 kicks
the queue, VM2 receives an interrupt (of course polling the receive
queue is also possible).

It would be interesting to compare the two approaches.

> Our recent experience in Snabb Switch land is that networking on x86 is now
> more of a HPC problem than a system programming problem. The SIMD bandwidth
> per core keeps increasing that this erodes the value of traditional (and
> complex) system programming optimizations. I will be interested to compare
> notes with others on this, already on Haswell but more so when we have
> AVX512.
>
> Incidentally, we also did a pile of work last year on zero-copy NIC->VM
> transfers and discovered a lot of interesting problems and edge cases where
> Virtio-net spec and/or drivers are hard to match up with common NICs. Happy
> to explain a bit about our experience if that would be valuable.

That sounds interesting, can you describe the setup?

Stefan
