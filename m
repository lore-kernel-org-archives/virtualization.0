From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH 1/3] virtio: Basic implementation of virtio pstore driver
Date: Thu, 22 Sep 2016 12:57:44 +0100
Message-ID: <20160922115744.GA8221__38306.6119197339$1474545494$gmane$org@stefanha-x1.localdomain>
References: <20160904143900.14850-1-namhyung@kernel.org>
	<20160904143900.14850-2-namhyung@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2280657147849284507=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160904143900.14850-2-namhyung@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Namhyung Kim <namhyung@kernel.org>
Cc: virtio-dev@lists.oasis-open.org, Tony Luck <tony.luck@intel.com>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Anton Vorontsov <anton@enomsg.org>, Will Deacon <will.deacon@arm.com>, qemu-devel@nongnu.org, Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, Minchan Kim <minchan@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Anthony Liguori <aliguori@amazon.com>, Colin Cross <ccross@android.com>, Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org


--===============2280657147849284507==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 04, 2016 at 11:38:58PM +0900, Namhyung Kim wrote:
> The virtio pstore driver provides interface to the pstore subsystem so
> that the guest kernel's log/dump message can be saved on the host
> machine.  Users can access the log file directly on the host, or on the
> guest at the next boot using pstore filesystem.  It currently deals with
> kernel log (printk) buffer only, but we can extend it to have other
> information (like ftrace dump) later.
>=20
> It supports legacy PCI device using a 16K buffer by default and it's
> configurable.  It uses two virtqueues - one for (sync) read and another
> for (async) write.  Since it cannot wait for write finished, it supports
> up to 128 concurrent IO.

Please document the locks that this code relies on.  It is generally not
safe to call virtqueue_*() from multiple threads.  I also wonder about
locking for virtio_pstore->req_id and other fields.  Are locks missing
or is something in pstore ensuring safety?

> +static int virt_pstore_open(struct pstore_info *psi)
> +{
> +	struct virtio_pstore *vps =3D psi->data;
> +	struct virtio_pstore_req *req;
> +	struct virtio_pstore_res *res;
> +	struct scatterlist sgo[1], sgi[1];
> +	struct scatterlist *sgs[2] =3D { sgo, sgi };
> +	unsigned int len;
> +
> +	virt_pstore_get_reqs(vps, &req, &res);
> +
> +	req->cmd =3D cpu_to_le16(VIRTIO_PSTORE_CMD_OPEN);
> +
> +	sg_init_one(sgo, req, sizeof(*req));
> +	sg_init_one(sgi, res, sizeof(*res));
> +	virtqueue_add_sgs(vps->vq[0], sgs, 1, 1, vps, GFP_KERNEL);
> +	virtqueue_kick(vps->vq[0]);
> +
> +	wait_event(vps->acked, virtqueue_get_buf(vps->vq[0], &len));
> +	return le32_to_cpu(res->ret);

This assumes the device puts compatible Linux errno values in res->ret.
The function doesn't need to return -errno if I'm reading fs/pstore/
code correctly.  You could return -1 on error to avoid making this
assumption.  The same applies to other res->ret usage below.

> +}
> +
> +static int virt_pstore_close(struct pstore_info *psi)
> +{
> +	struct virtio_pstore *vps =3D psi->data;
> +	struct virtio_pstore_req *req =3D &vps->req[vps->req_id];
> +	struct virtio_pstore_res *res =3D &vps->res[vps->req_id];

Assigning &vps->req[vps->req_id]/&vps->res[vps->req_id] is unnecessary,
virt_pstore_get_reqs() handles that below.

> +	struct scatterlist sgo[1], sgi[1];
> +	struct scatterlist *sgs[2] =3D { sgo, sgi };
> +	unsigned int len;
> +
> +	virt_pstore_get_reqs(vps, &req, &res);
> +
> +	req->cmd =3D cpu_to_le16(VIRTIO_PSTORE_CMD_CLOSE);
> +
> +	sg_init_one(sgo, req, sizeof(*req));
> +	sg_init_one(sgi, res, sizeof(*res));
> +	virtqueue_add_sgs(vps->vq[0], sgs, 1, 1, vps, GFP_KERNEL);
> +	virtqueue_kick(vps->vq[0]);
> +
> +	wait_event(vps->acked, virtqueue_get_buf(vps->vq[0], &len));
> +	return le32_to_cpu(res->ret);
> +}
> +
> +static ssize_t virt_pstore_read(u64 *id, enum pstore_type_id *type,
> +				int *count, struct timespec *time,
> +				char **buf, bool *compressed,
> +				ssize_t *ecc_notice_size,
> +				struct pstore_info *psi)
> +{
> +	struct virtio_pstore *vps =3D psi->data;
> +	struct virtio_pstore_req *req;
> +	struct virtio_pstore_res *res;
> +	struct virtio_pstore_fileinfo info;
> +	struct scatterlist sgo[1], sgi[3];
> +	struct scatterlist *sgs[2] =3D { sgo, sgi };
> +	unsigned int len;
> +	unsigned int flags;
> +	int ret;
> +	void *bf;
> +
> +	virt_pstore_get_reqs(vps, &req, &res);
> +
> +	req->cmd =3D cpu_to_le16(VIRTIO_PSTORE_CMD_READ);
> +
> +	sg_init_one(sgo, req, sizeof(*req));
> +	sg_init_table(sgi, 3);
> +	sg_set_buf(&sgi[0], res, sizeof(*res));
> +	sg_set_buf(&sgi[1], &info, sizeof(info));
> +	sg_set_buf(&sgi[2], psi->buf, psi->bufsize);
> +	virtqueue_add_sgs(vps->vq[0], sgs, 1, 1, vps, GFP_KERNEL);
> +	virtqueue_kick(vps->vq[0]);
> +
> +	wait_event(vps->acked, virtqueue_get_buf(vps->vq[0], &len));
> +	if (len < sizeof(*res) + sizeof(info))
> +		return -1;
> +
> +	ret =3D le32_to_cpu(res->ret);
> +	if (ret < 0)
> +		return ret;
> +
> +	len =3D le32_to_cpu(info.len);

We trust the device but a length check would be nice here to be clear
that the memcpy() below is always safe:

if (len > psi->bufsize)
    return -1;

> +
> +	bf =3D kmalloc(len, GFP_KERNEL);
> +	if (bf =3D=3D NULL)
> +		return -ENOMEM;

There's no point in returning -ENOMEM if we return -1 and res->ret
above.  The caller has no way of knowing the true meaning of the return
value.  I would return -1 to be clear that there are no error constants.

> +
> +	*id    =3D le64_to_cpu(info.id);
> +	*type  =3D from_virtio_type(info.type);
> +	*count =3D le32_to_cpu(info.count);
> +
> +	flags =3D le32_to_cpu(info.flags);
> +	*compressed =3D flags & VIRTIO_PSTORE_FL_COMPRESSED;
> +
> +	time->tv_sec  =3D le64_to_cpu(info.time_sec);
> +	time->tv_nsec =3D le32_to_cpu(info.time_nsec);
> +
> +	memcpy(bf, psi->buf, len);
> +	*buf =3D bf;
> +
> +	return len;
> +}
> +
> +static int notrace virt_pstore_write(enum pstore_type_id type,
> +				     enum kmsg_dump_reason reason,
> +				     u64 *id, unsigned int part, int count,
> +				     bool compressed, size_t size,
> +				     struct pstore_info *psi)
> +{
> +	struct virtio_pstore *vps =3D psi->data;
> +	struct virtio_pstore_req *req;
> +	struct virtio_pstore_res *res;
> +	struct scatterlist sgo[2], sgi[1];
> +	struct scatterlist *sgs[2] =3D { sgo, sgi };
> +	unsigned int flags =3D compressed ? VIRTIO_PSTORE_FL_COMPRESSED : 0;
> +
> +	if (vps->failed)
> +		return -1;
> +
> +	*id =3D vps->req_id;
> +	virt_pstore_get_reqs(vps, &req, &res);

This function does not wait for a response from the device so you cannot
call virt_pstore_get_reqs() without risk of reusing an in-flight buffer.

> +
> +	req->cmd   =3D cpu_to_le16(VIRTIO_PSTORE_CMD_WRITE);
> +	req->type  =3D to_virtio_type(type);
> +	req->flags =3D cpu_to_le32(flags);
> +
> +	sg_init_table(sgo, 2);
> +	sg_set_buf(&sgo[0], req, sizeof(*req));
> +	sg_set_buf(&sgo[1], psi->buf, size);
> +	sg_init_one(sgi, res, sizeof(*res));
> +	virtqueue_add_sgs(vps->vq[1], sgs, 1, 1, vps, GFP_ATOMIC);

If we don't wait for request completion then virtqueue_add_sgs() could
fail here if the virtqueue is already full.

> +	virtqueue_kick(vps->vq[1]);
> +
> +	return 0;
> +}
> +
> +static int virt_pstore_erase(enum pstore_type_id type, u64 id, int count,
> +			     struct timespec time, struct pstore_info *psi)
> +{
> +	struct virtio_pstore *vps =3D psi->data;
> +	struct virtio_pstore_req *req;
> +	struct virtio_pstore_res *res;
> +	struct scatterlist sgo[1], sgi[1];
> +	struct scatterlist *sgs[2] =3D { sgo, sgi };
> +	unsigned int len;
> +
> +	virt_pstore_get_reqs(vps, &req, &res);
> +
> +	req->cmd   =3D cpu_to_le16(VIRTIO_PSTORE_CMD_ERASE);
> +	req->type  =3D to_virtio_type(type);
> +	req->id	   =3D cpu_to_le64(id);
> +	req->count =3D cpu_to_le32(count);
> +
> +	sg_init_one(sgo, req, sizeof(*req));
> +	sg_init_one(sgi, res, sizeof(*res));
> +	virtqueue_add_sgs(vps->vq[0], sgs, 1, 1, vps, GFP_KERNEL);
> +	virtqueue_kick(vps->vq[0]);

Erase commands are sent on the "read" virtqueue, not the "write"
virtqueue?

> +
> +	wait_event(vps->acked, virtqueue_get_buf(vps->vq[0], &len));
> +	return le32_to_cpu(res->ret);
> +}
> +
> +static int virt_pstore_init(struct virtio_pstore *vps)
> +{
> +	struct pstore_info *psinfo =3D &vps->pstore;
> +	int err;
> +
> +	if (!psinfo->bufsize)
> +		psinfo->bufsize =3D VIRT_PSTORE_BUFSIZE;
> +
> +	psinfo->buf =3D alloc_pages_exact(psinfo->bufsize, GFP_KERNEL);
> +	if (!psinfo->buf) {
> +		pr_err("cannot allocate pstore buffer\n");
> +		return -ENOMEM;
> +	}
> +
> +	psinfo->owner =3D THIS_MODULE;
> +	psinfo->name  =3D "virtio";
> +	psinfo->open  =3D virt_pstore_open;
> +	psinfo->close =3D virt_pstore_close;
> +	psinfo->read  =3D virt_pstore_read;
> +	psinfo->erase =3D virt_pstore_erase;
> +	psinfo->write =3D virt_pstore_write;
> +	psinfo->flags =3D PSTORE_FLAGS_FRAGILE;
> +
> +	psinfo->data  =3D vps;
> +	spin_lock_init(&psinfo->buf_lock);
> +
> +	err =3D pstore_register(psinfo);
> +	if (err)
> +		kfree(psinfo->buf);

Should this be free_pages_exact() instead of kfree()?

Is it safe to call pstore_register() before the remaining initialization
steps?

My understanding is that if pstore is already mounted then requests will
immediately be sent.  In order to support this we'd need to initialize
everything else first before calling pstore_register().

> +
> +	return err;
> +}
> +
> +static int virt_pstore_exit(struct virtio_pstore *vps)
> +{
> +	struct pstore_info *psinfo =3D &vps->pstore;
> +
> +	pstore_unregister(psinfo);
> +
> +	free_pages_exact(psinfo->buf, psinfo->bufsize);
> +	psinfo->buf =3D NULL;
> +	psinfo->bufsize =3D 0;
> +
> +	return 0;
> +}
> +
> +static int virtpstore_init_vqs(struct virtio_pstore *vps)
> +{
> +	vq_callback_t *callbacks[] =3D { virtpstore_ack, virtpstore_check };
> +	const char *names[] =3D { "pstore_read", "pstore_write" };
> +
> +	return vps->vdev->config->find_vqs(vps->vdev, 2, vps->vq,
> +					   callbacks, names);
> +}
> +
> +static void virtpstore_init_config(struct virtio_pstore *vps)
> +{
> +	u32 bufsize;
> +
> +	virtio_cread(vps->vdev, struct virtio_pstore_config, bufsize, &bufsize);
> +
> +	vps->pstore.bufsize =3D PAGE_ALIGN(bufsize);
> +}
> +
> +static void virtpstore_confirm_config(struct virtio_pstore *vps)
> +{
> +	u32 bufsize =3D vps->pstore.bufsize;
> +
> +	virtio_cwrite(vps->vdev, struct virtio_pstore_config, bufsize,
> +		     &bufsize);
> +}
> +
> +static int virtpstore_probe(struct virtio_device *vdev)
> +{
> +	struct virtio_pstore *vps;
> +	int err;
> +
> +	if (!vdev->config->get) {
> +		dev_err(&vdev->dev, "driver init: config access disabled\n");
> +		return -EINVAL;
> +	}
> +
> +	vdev->priv =3D vps =3D kzalloc(sizeof(*vps), GFP_KERNEL);
> +	if (!vps) {
> +		err =3D -ENOMEM;
> +		goto out;
> +	}
> +	vps->vdev =3D vdev;
> +
> +	err =3D virtpstore_init_vqs(vps);
> +	if (err < 0)
> +		goto out_free;
> +
> +	virtpstore_init_config(vps);
> +
> +	err =3D virt_pstore_init(vps);
> +	if (err)
> +		goto out_del_vq;
> +
> +	virtpstore_confirm_config(vps);
> +
> +	init_waitqueue_head(&vps->acked);
> +
> +	virtio_device_ready(vdev);

This call is needed if the .probe() function uses virtqueues before
returning.  Right now it either doesn't use the virtqueues or it has
already used them in virt_pstore_init().  Please move this before
pstore_register().

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJX48c4AAoJEJykq7OBq3PI7kYH/AqkN5Uc0mGDZvGowVbqhmHP
eG95fWTU0F/sm2po6PGWTbM+hf+vPg0l7CuQcYHmjSu9xN7Elg5XS1C4DJffsYAv
Pmg6UCqS4NEq5DiFYM2y6XMY8Oh0gFN+Mw61XF4JmeWc4JBQEmLxcjxPsPCzM1WJ
YMse7mAEbJIGK0kNWxt0ENP2Wg1Rgq2MF8hQEsqSy8MTRMLd8GnQc04xRd60sa2x
h3x3tbfWrF8/LatfnzBeuRoylJl+sDl5zgJ8rj8w99r2pQDrHprLd5XFAflOIlB6
a1V5AGcXlFtgXiHS5oGPbLYAqT5x7UgxV/zXjOgbwTm22b9SnFfnxHY9R6841t0=
=ylUR
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--

--===============2280657147849284507==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2280657147849284507==--
