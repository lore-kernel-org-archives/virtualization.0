From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH V3 6/7] virtio: introduce a mdev based transport
Date: Mon, 14 Oct 2019 18:39:42 +0100
Message-ID: <20191014173942.GB5359@stefanha-x1.localdomain>
References: <20191011081557.28302-1-jasowang@redhat.com>
	<20191011081557.28302-7-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1741906822813182094=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191011081557.28302-7-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: christophe.de.dinechin@gmail.com, kvm@vger.kernel.org, mst@redhat.com, airlied@linux.ie, joonas.lahtinen@linux.intel.com, heiko.carstens@de.ibm.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, kwankhede@nvidia.com, rob.miller@broadcom.com, linux-s390@vger.kernel.org, sebott@linux.ibm.com, lulu@redhat.com, eperezma@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, haotian.wang@sifive.com, zhi.a.wang@intel.com, farman@linux.ibm.com, idos@mellanox.com, gor@linux.ibm.com, intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com, xiao.w.wang@intel.com, freude@linux.ibm.com, zhenyuw@linux.intel.com, parav@mellanox.com, zhihong.wang@intel.com, rodrigo.vivi@intel.com, intel-gvt-dev@lists.freedesktop.org, akrowiak@linux.ibm.com, oberpar@linux.ibm.com, netdev@vger.kernel.org, cohuck@redhat.com, linux-kernel@vger.kernel.org, maxime.coque
List-Id: virtualization@lists.linuxfoundation.org


--===============1741906822813182094==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 11, 2019 at 04:15:56PM +0800, Jason Wang wrote:
> +struct virtio_mdev_device {
> +	struct virtio_device vdev;
> +	struct mdev_device *mdev;
> +	unsigned long version;
> +
> +	struct virtqueue **vqs;
> +	/* The lock to protect virtqueue list */
> +	spinlock_t lock;
> +	struct list_head virtqueues;

Is this a list of struct virtio_mdev_vq_info?  Please document the
actual type in a comment.

> +static int virtio_mdev_find_vqs(struct virtio_device *vdev, unsigned nvqs,
> +				struct virtqueue *vqs[],
> +				vq_callback_t *callbacks[],
> +				const char * const names[],
> +				const bool *ctx,
> +				struct irq_affinity *desc)
> +{
> +	struct virtio_mdev_device *vm_dev = to_virtio_mdev_device(vdev);
> +	struct mdev_device *mdev = vm_get_mdev(vdev);
> +	const struct virtio_mdev_device_ops *ops = mdev_get_dev_ops(mdev);
> +	struct virtio_mdev_callback cb;
> +	int i, err, queue_idx = 0;
> +
> +	vm_dev->vqs = kmalloc_array(queue_idx, sizeof(*vm_dev->vqs),
> +				    GFP_KERNEL);

kmalloc_array(0, ...)?  I would have expected nvqs instead of queue_idx
(0).

What is this the purpose of vm_dev->vqs and does anything ever access it?

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2kst4ACgkQnKSrs4Gr
c8hQqggAsLqAScuEZRHgMYUxIlc4Hpdh283rOQFgRgPfZqq3hQ/nzKTqbn1k7DnZ
MaXQk/GXc1/mFzEwjGVoMOJ+NiZKpj5xuVN9HqKEuDuBooykO5wKnbwkm6kAs/gG
/10A4I5fkyOUHB+xRkaM/3g9UJgo/yB/oI7yQonKFI3VNQc/Q0vcAWUkUbyoZyZA
WO5IJoOR9nF7g6kkYLT0ik26WZFVsBruKTsifLsCJTCQMWo8dJpvgJpGvo/k07YZ
kWYC8J+K/SRA9gpvDBCfkPRQGMgq7CiE0C+VfoGVo11TuFd6FlkjjYmBIPXYek98
rK1ONn6f4qY+67eRJ77oiNeFsj4eYw==
=7Qm5
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--

--===============1741906822813182094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1741906822813182094==--
