From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH untested] virtio: allocate extra memory before the ring (
	was Re: [RFC PATCH] virtio_console: link vq to port with a
	private) pointer in struct virtqueue
Date: Tue, 08 May 2012 07:06:04 -0400 (EDT)
Message-ID: <7dee31a0-7b89-418c-a69b-436729ba55b0@zmail13.collab.prod.int.phx2.redhat.com>
References: <20120508105654.GB15598@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120508105654.GB15598@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Amit Shah <amit.shah@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

> And it's not a problem if virtqueue is exactly at start of
> vring_virtqueue: we just need to allocate a bit more at start, and
> offset when we free.  Here's how I would do this: first apply patch
> below that adds the offset parameter, then update all transports, one
> patch at a time to not use priv pointer, finally you can repurpose
> priv pointer to let devices use it.

I like it, though I prefer to have the new arguments as sizeof()
rather than offsets.

I'll pick up this and test it.

> As a bonus we get small incremental patches.

FWIW, that's possible with the patch I posted too.

Paolo
