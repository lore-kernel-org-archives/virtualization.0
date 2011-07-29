From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [RFC PATCH 8/8] virtio: net: Add freeze, restore handlers to
	support S4
Date: Fri, 29 Jul 2011 09:58:02 +0530
Message-ID: <20110729042802.GD24868@amit-x200.redhat.com>
References: <cover.1311863438.git.amit.shah@redhat.com>
	<3d2fd91237cfb3ff1e05e464e305df2711b45885.1311863438.git.amit.shah@redhat.com>
	<20110729041335.GD31888@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110729041335.GD31888@redhat.com>
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
Cc: Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On (Fri) 29 Jul 2011 [07:13:35], Michael S. Tsirkin wrote:
> > +static int virtnet_restore(struct virtio_device *vdev)
> > +{
> > +	struct virtnet_info *vi = vdev->priv;
> > +	struct virtqueue *vqs[3];
> > +	vq_callback_t *callbacks[] = { skb_recv_done, skb_xmit_done, NULL};
> > +	const char *names[] = { "input", "output", "control" };
> > +	int nvqs, err;
> > +
> > +	/* We expect two virtqueues, receive then send,
> > +	 * and optionally control. */
> > +	nvqs = virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ) ? 3 : 2;
> > +
> > +	err = vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names);
> > +	if (err)
> > +		return err;
> > +
> > +	vi->rvq = vqs[0];
> > +	vi->svq = vqs[1];
> > +
> > +	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ)) {
> > +		vi->cvq = vqs[2];
> > +	}
> > +
> > +	/* Last of all, set up some receive buffers. */
> > +	try_fill_recv(vi, GFP_KERNEL);
> 
> should probably update carrier status too.

Will add that.

I think most of these restore routines are incomplete; I just pulled
in the most important things from the probe routines, but before the
final submission I'll do a thorough walk-through and ensure I get all
the bits necessary.

		Amit
