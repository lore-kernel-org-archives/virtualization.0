From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH 1/1] Add vhost_blk driver
Date: Tue, 6 Nov 2018 16:03:16 +0000
Message-ID: <20181106160316.GC31579__48149.8755318627$1541520081$gmane$org@stefanha-x1.localdomain>
References: <20181102182123.29420-1-v.mayatskih@gmail.com>
	<20181102182123.29420-2-v.mayatskih@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1318804652627889924=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181102182123.29420-2-v.mayatskih@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vitaly Mayatskikh <v.mayatskih@gmail.com>
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============1318804652627889924==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="adJ1OR3c6QgCpb/j"
Content-Disposition: inline


--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 02, 2018 at 06:21:23PM +0000, Vitaly Mayatskikh wrote:
> This driver accelerates host side of virtio-blk.

Did you look at vhost-user-blk?  It does things slightly differently:
more of the virtio-blk device model is handled by the vhost-user device
(e.g. config space).  That might be necessary to implement
virtio_blk_config.writeback properly.

> +#define VHOST_BLK_SET_BACKEND _IOW(VHOST_VIRTIO, 0x50, int)

Needs to be in the uapi header so userspace can use it.

> +
> +enum {
> +	VHOST_BLK_VQ_MAX = 16,
> +	VHOST_BLK_VQ_MAX_REQS = 128,
> +};

These limits seem arbitrary and probably too low.

> +
> +struct vhost_blk_req {
> +	struct llist_node list;
> +	int index;
> +	struct vhost_blk_queue *q;
> +	struct virtio_blk_outhdr hdr;
> +	struct iovec *out_iov;
> +	struct iovec *in_iov;
> +	u8 out_num;
> +	u8 in_num;
> +	long len;
> +	struct kiocb iocb;
> +	struct iov_iter i;
> +	int res;
> +	void __user *status;
> +};
> +
> +struct vhost_blk_queue {
> +	int index;
> +	struct vhost_blk *blk;
> +	struct vhost_virtqueue vq;
> +	struct vhost_work w;
> +	struct llist_head wl;

What is this?  Please use clear names and comments. :)

> +static int vhost_blk_req_handle(struct vhost_blk_req *req)
> +{
> +	struct vhost_blk *blk = req->q->blk;
> +	struct vhost_virtqueue *vq = &req->q->vq;
> +	int type = le32_to_cpu(req->hdr.type);
> +	int ret;
> +	u8 status;
> +
> +	if ((type == VIRTIO_BLK_T_IN) || (type == VIRTIO_BLK_T_OUT)) {
> +		bool write = (type == VIRTIO_BLK_T_OUT);
> +		int nr_seg = (write ? req->out_num : req->in_num) - 1;
> +		unsigned long sector = le64_to_cpu(req->hdr.sector);

Using little-endian instead of the virtio types means that only VIRTIO
1.0 modern devices are supported (older devices may not be
little-endian!).  In that case you'd need to put the VIRTIO_1 feature
bit into the features mask.

> +		req = &q->req[head];
> +		req->index = head;
> +		req->out_num = out;
> +		req->in_num = in;
> +		req->out_iov = &vq->iov[1];
> +		req->in_iov = &vq->iov[out];
> +		req->status = vq->iov[out + in - 1].iov_base;

The VIRTIO spec explicitly requires that devices support arbitrary
descriptor layouts, so you cannot assume a particular iov[] layout.

> +static long vhost_blk_ioctl(struct file *f, unsigned int ioctl,
> +			    unsigned long arg)
> +{
> +	struct vhost_blk *blk = f->private_data;
> +	void __user *argp = (void __user *)arg;
> +	int fd;
> +	u64 __user *featurep = argp;
> +	u64 features;
> +	long ret;
> +	struct vhost_vring_state s;
> +
> +	switch (ioctl) {
> +	case VHOST_SET_MEM_TABLE:
> +		vhost_blk_stop(blk);
> +		ret = vhost_blk_pass_ioctl(blk, ioctl, argp);
> +		break;

Why is this necessary?  Existing vhost devices pass the ioctl through
without an explicit case for it.

> +	case VHOST_SET_VRING_NUM:
> +		if (copy_from_user(&s, argp, sizeof(s)))
> +			return -EFAULT;
> +		ret = vhost_blk_pass_ioctl(blk, ioctl, argp);
> +		if (!ret)
> +			blk->num_queues = s.index + 1;

Where is this input checked against ARRAY_SIZE(blk->queue)?

--adJ1OR3c6QgCpb/j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb4btEAAoJEJykq7OBq3PI18kIAIWRNjdZlTZigFtAV0woY7NN
RQ9Kc0frAJv1XpbDemdbA41L7y2resmg4dcMIEFtd0qRbNjoXi8e8yRqF9RbBaqG
R9EUKz6cTYVlBURJp9zMYyEFbVR1tbo3J7Wid1Z1uRY9QAiB6FbmCu8cYWFVWL+S
8GA/rjcuqvoz19VnfVtH0IZbjD1/GH4boK0Y+fwH5WjC7jrnZSnjrXKSiFOeTm+9
3Mzgelzw/hKQePNvTO1B+W/C2+Se6q0Jfwb9i8pmtnyv4hl63IDkqnOqvDZ8L/qO
ypdaqmXAIGRZzUH5sn7yqZQX7mFNy8IdGk7RAazczZfsrKexHMD+YIS1OSfdmfY=
=eZZY
-----END PGP SIGNATURE-----

--adJ1OR3c6QgCpb/j--

--===============1318804652627889924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1318804652627889924==--
