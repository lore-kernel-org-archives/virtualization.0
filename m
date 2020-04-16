From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 5/8] tools/virtio: Use __vring_new_virtqueue in
 virtio_test.c
Date: Thu, 16 Apr 2020 18:32:56 -0400
Message-ID: <20200416183244-mutt-send-email-mst@kernel.org>
References: <20200416075643.27330-1-eperezma@redhat.com>
 <20200416075643.27330-6-eperezma@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200416075643.27330-6-eperezma@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, kvm list <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Linux Next Mailing List <linux-next@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 16, 2020 at 09:56:40AM +0200, Eugenio P=C3=A9rez wrote:
> As updated in ("2a2d1382fe9d virtio: Add improved queue allocation API")
> =

> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Pls add motivation for these changes.

> ---
>  tools/virtio/virtio_test.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> =

> diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
> index 1d5144590df6..d9827b640c21 100644
> --- a/tools/virtio/virtio_test.c
> +++ b/tools/virtio/virtio_test.c
> @@ -106,10 +106,9 @@ static void vq_info_add(struct vdev_info *dev, int n=
um)
>  	assert(r >=3D 0);
>  	memset(info->ring, 0, vring_legacy_size(num, 4096));
>  	vring_legacy_init(&info->vring, num, info->ring, 4096);
> -	info->vq =3D vring_new_virtqueue(info->idx,
> -				       info->vring.num, 4096, &dev->vdev,
> -				       true, false, info->ring,
> -				       vq_notify, vq_callback, "test");
> +	info->vq =3D
> +		__vring_new_virtqueue(info->idx, info->vring, &dev->vdev, true,
> +				      false, vq_notify, vq_callback, "test");
>  	assert(info->vq);
>  	info->vq->priv =3D info;
>  	vhost_vq_setup(dev, info);
> -- =

> 2.18.1
