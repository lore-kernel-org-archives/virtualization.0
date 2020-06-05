From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH RFC 11/13] vhost/scsi: switch to buf APIs
Date: Fri, 5 Jun 2020 09:36:16 +0100
Message-ID: <20200605083616.GB59410@stefanha-x1.localdomain>
References: <20200602130543.578420-1-mst@redhat.com>
 <20200602130543.578420-12-mst@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5919313954208170203=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200602130543.578420-12-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============5919313954208170203==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2020 at 09:06:20AM -0400, Michael S. Tsirkin wrote:
> Switch to buf APIs. Doing this exposes a spec violation in vhost scsi:
> all used bufs are marked with length 0.
> Fix that is left for another day.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/vhost/scsi.c | 73 ++++++++++++++++++++++++++------------------
>  1 file changed, 44 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index c39952243fd3..c426c4e899c7 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -71,8 +71,8 @@ struct vhost_scsi_inflight {
>  };
> =20
>  struct vhost_scsi_cmd {
> -	/* Descriptor from vhost_get_vq_desc() for virt_queue segment */
> -	int tvc_vq_desc;
> +	/* Descriptor from vhost_get_avail_buf() for virt_queue segment */
> +	struct vhost_buf tvc_vq_desc;
>  	/* virtio-scsi initiator task attribute */
>  	int tvc_task_attr;
>  	/* virtio-scsi response incoming iovecs */
> @@ -213,7 +213,7 @@ struct vhost_scsi {
>   * Context for processing request and control queue operations.
>   */
>  struct vhost_scsi_ctx {
> -	int head;
> +	struct vhost_buf buf;
>  	unsigned int out, in;
>  	size_t req_size, rsp_size;
>  	size_t out_size, in_size;
> @@ -443,6 +443,20 @@ static int vhost_scsi_check_stop_free(struct se_cmd =
*se_cmd)
>  	return target_put_sess_cmd(se_cmd);
>  }
> =20
> +/* Signal to guest that request finished with no input buffer. */
> +/* TODO calling this when writing into buffer and most likely a bug */
> +static void vhost_scsi_signal_noinput(struct vhost_dev *vdev,
> +				      struct vhost_virtqueue *vq,
> +				      struct vhost_buf *bufp)
> +{
> +	struct vhost_buf buf =3D *bufp;
> +
> +	buf.in_len =3D 0;
> +	vhost_put_used_buf(vq, &buf);

Yes, this behavior differs from the QEMU virtio-scsi device
implementation. I think it's just a quirk that is probably my fault (I
guess I thought the length information is already encoded in the payload
SCSI headers so we have no use for the used descriptor length field).

Whether it's worth changing now or is an interesting question. In theory
it would make vhost-scsi more spec compliant and guest drivers might be
happier (especially drivers for niche OSes that were only tested against
QEMU's virtio-scsi). On the other hand, it's a guest-visible change that
could break similar niche drivers that assume length is always 0.

I'd leave it as-is unless people hit issues that justify the risk of
changing it.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7aBAAACgkQnKSrs4Gr
c8hc2AgAhA2GdtNYe8p56IbAFfd8fkuwV0WVMyeBsCNkDsrJLQqfOtQ9EGUI3lir
8Xfy6Gr4Swoy+7HIeicp4dmOCrY6J+gJx3ORqS1UncMUJghROp1Iucm/MK3VZq81
bY9Xx07KuKFJHv6127fdnjw36uQdIJxRWMfYW1EeGLeLLWxzyYv6E1ajDo5USsrG
/nlX5NHWdz1CZbQc8HZnuZ9dwTsMuLJYYyhQFUtaHm3UYQ+39XHFtk12dJiHhDvD
2QdziP4TCejE+N4ICXV9M9uLRPAMFHbhAdMTbCGjwYpk01FxGIQ/hD87TtBMiyNB
gINncRUX153Pu1g/rx/FGzPJ+rBTRQ==
=9PYW
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--

--===============5919313954208170203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5919313954208170203==--
