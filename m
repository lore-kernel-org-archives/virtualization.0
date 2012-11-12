From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v11 5/7] virtio_balloon: introduce migration primitives to
	balloon pages
Date: Mon, 12 Nov 2012 18:19:23 +1030
Message-ID: <87lie71csc.fsf@rustcorp.com.au>
References: <cover.1352256081.git.aquini@redhat.com>
	<265aaff9a79f503672f0cdcdff204114b5b5ba5b.1352256088.git.aquini@redhat.com>
	<87625h3tl1.fsf@rustcorp.com.au>
	<20121108003403.GE10444@optiplex.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20121108003403.GE10444@optiplex.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rafael Aquini <aquini@redhat.com>
Cc: Rik van Riel <riel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Rafael Aquini <aquini@redhat.com> writes:

> On Thu, Nov 08, 2012 at 09:32:18AM +1030, Rusty Russell wrote:
>> The first one can be delayed, the second one can be delayed if the host
>> didn't ask for VIRTIO_BALLOON_F_MUST_TELL_HOST (qemu doesn't).
>> 
>> We could implement a proper request queue for these, and return -EAGAIN
>> if the queue fills.  Though in practice, it's not important (it might
>> help performance).
>
> I liked the idea. Give me the directions to accomplish it and I'll give it a try
> for sure.

OK, let's get this applied first, but here are some pointers:

Here's the current callback function when the host has processed the
buffers we put in the queue:

 static void balloon_ack(struct virtqueue *vq)
 {
	struct virtio_balloon *vb = vq->vdev->priv;

	wake_up(&vb->acked);
 }

It's almost a noop: here's how we use it to make our queues synchronous:

 static void tell_host(struct virtio_balloon *vb, struct virtqueue *vq)
 {
	struct scatterlist sg;
	unsigned int len;

	sg_init_one(&sg, vb->pfns, sizeof(vb->pfns[0]) * vb->num_pfns);

	/* We should always be able to add one buffer to an empty queue. */
	if (virtqueue_add_buf(vq, &sg, 1, 0, vb, GFP_KERNEL) < 0)
		BUG();
	virtqueue_kick(vq);

	/* When host has read buffer, this completes via balloon_ack */
	wait_event(vb->acked, virtqueue_get_buf(vq, &len));
 }

And we set up the callback when we create the virtqueue:

	vq_callback_t *callbacks[] = { balloon_ack, balloon_ack, stats_request };
...
	err = vb->vdev->config->find_vqs(vb->vdev, nvqs, vqs, callbacks, names);

So off the top of my head it should be as simple as changing tell_host()
to only wait if the virtqueue_add_buf() fails (ie. queue is full).

Hmm, though you will want to synchronize the inflate and deflate queues:
if we tell the host we're giving a page up we want it to have seen that
before we tell it we're using it again...

Cheers,
Rusty.
