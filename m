From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH] virtio: decrement dev_index when device is unregistered
Date: Tue, 5 Apr 2011 07:21:56 +0100
Message-ID: <BANLkTi=DGfKuapLhvt62UVG_h7fzsRRo3g__32829.8665503555$1301984576$gmane$org@mail.gmail.com>
References: <1457566934.641329.1301903526622.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
	<66015840.659833.1301978966706.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <66015840.659833.1301978966706.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Takuma Umeya <tumeya@redhat.com>
Cc: Stephen Hemminger <shemminger@vyatta.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 5, 2011 at 5:49 AM, Takuma Umeya <tumeya@redhat.com> wrote:
> When virtio device is removed, dev_index does not get decremented.
> The next device hotplug event results in consuming the next pci to
> the one that is suppose to be available.
>
> Signed-off-by: Takuma Umeya <tumeya@redhat.com>
>
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index efb35aa..67fe71d 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -216,6 +216,7 @@ EXPORT_SYMBOL_GPL(register_virtio_device);
> =A0void unregister_virtio_device(struct virtio_device *dev)
> =A0{
> =A0 =A0 =A0 =A0device_unregister(&dev->dev);
> + =A0 =A0 =A0 dev_index--;

I don't think there is any guarantee that virtio devices are
added/removed in first-in-last-out order.

That means I could add a virtio-net device (index 0) followed by a
virtio-blk device (index 1).  Now I remove the virtio-net device
(index 0) which causes me to decrement dev_index and hand index 1 out
again to the next device.  This leaves us with virtio-blk (index 1)
and the new device with index 1, which is not unique.

Perhaps I missed a constraint which prevents this from occurring?

Stefan
