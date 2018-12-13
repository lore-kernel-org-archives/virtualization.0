From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 3/5] VSOCK: support receive mergeable rx buffer in guest
Date: Thu, 13 Dec 2018 16:20:39 +0000
Message-ID: <20181213162039.GO23318__42633.4394760945$1544717955$gmane$org@stefanha-x1.localdomain>
References: <5C10D57B.3070701@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0067787603986029446=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5C10D57B.3070701@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jiangyiwen <jiangyiwen@huawei.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============0067787603986029446==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kVcb4xucqmsYUpQy"
Content-Disposition: inline


--kVcb4xucqmsYUpQy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 12, 2018 at 05:31:39PM +0800, jiangyiwen wrote:
> +static struct virtio_vsock_pkt *receive_mergeable(struct virtqueue *vq,
> +		struct virtio_vsock *vsock, unsigned int *total_len)
> +{
> +	struct virtio_vsock_pkt *pkt;
> +	u16 num_buf;
> +	void *buf;
> +	unsigned int len;
> +	size_t vsock_hlen = sizeof(struct virtio_vsock_pkt);
> +
> +	buf = virtqueue_get_buf(vq, &len);
> +	if (!buf)
> +		return NULL;
> +
> +	*total_len = len;
> +	vsock->rx_buf_nr--;
> +
> +	if (unlikely(len < vsock_hlen)) {
> +		put_page(virt_to_head_page(buf));
> +		return NULL;
> +	}
> +
> +	pkt = buf;
> +	num_buf = le16_to_cpu(pkt->mrg_rxbuf_hdr.num_buffers);
> +	if (!num_buf || num_buf > VIRTIO_VSOCK_MAX_VEC_NUM) {
> +		put_page(virt_to_head_page(buf));
> +		return NULL;
> +	}
> +
> +	/* Initialize pkt residual structure */
> +	memset(&pkt->work, 0, vsock_hlen - sizeof(struct virtio_vsock_hdr) -
> +			sizeof(struct virtio_vsock_mrg_rxbuf_hdr));

struct virtio_vsock_pkt is an internal driver state structure.  It must
be able to change without breaking the host<->guest device interface.
Exposing struct virtio_vsock_pkt across the device interface makes this
impossible.

One way to solve this is by placing a header length field at the
beginning of the mergeable buffer.  That way the device knows at which
offset the payload should be placed and the driver can continue to use
the allocation scheme you've chosen (where a single page contains the
virtio_vsock_pkt and payload).

Another issue is that virtio requires exclusive read OR write
descriptors.  You cannot have a descriptor that is both read and write.
So there's not a huge advantage to combining the driver state struct and
payload, except maybe the driver can save a memory allocation.

--kVcb4xucqmsYUpQy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcEobXAAoJEJykq7OBq3PI660H/RJ9tmBPtcwl+HbLBQyjsPbD
s317Z9KyloXntFplY+l8JZDvLq0gI37OPQqY/pCB1azWx3Xq6pYPVAamzHBlA6By
mB5fve63gdI+Ap6x3uPGoHOBBOmLMg7tlXAwl9exAr7rY4LPqBpAPkKlwc16ISdM
oylxoFnyEPCoTu5QyExydzHbsS88SGBZghbXj5o3R1yPplAj9FINrtfTo/KvH28f
4R67qe0apklPW14bUq/U4B4xOQFM2MoD8wEMnpEXtLGzFYXNmBgnnyw4zKHaZwT2
6EY5NwIZdgXNFLZiu4221BEz0QtMDPsQdXo76wYMzcUBL+0zwaiaPEr/h39wNBk=
=xJVy
-----END PGP SIGNATURE-----

--kVcb4xucqmsYUpQy--

--===============0067787603986029446==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0067787603986029446==--
