From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [PATCH] qemu/virtio: move features to an inline function
Date: Mon, 10 Aug 2009 14:37:20 -0500
Message-ID: <4A8076F0.5050700__23684.960199944$1249933418$gmane$org@codemonkey.ws>
References: <20090810192809.GA16800@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090810192809.GA16800@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Michael S. Tsirkin wrote:
> devices should have the final say over which virtio features they
> support. E.g. indirect entries may or may not make sense in the context
> of virtio-console.  Move the common bits from virtio-pci to an inline
> function and let each device call it.
>   

What drove this in vhost?

Normally, the common features are transport features and the devices 
should have absolutely no knowledge of transport feature (since they're 
transport dependent).

IOW, VIRTIO_RING_F_INDIRECT_DESC is meaningless to virtio-console 
because virtio-console has no idea what the ring implementation is that 
it sits on top of.

Regards,

Anthony Liguori
