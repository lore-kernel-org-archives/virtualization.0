From: Eric Blake <eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] virtio-gpu/2d: add hardware spec include
	file
Date: Thu, 11 Sep 2014 09:19:16 -0600
Message-ID: <5411BD74.80608__32478.367110207$1410450844$gmane$org@redhat.com>
References: <1410448173-12960-1-git-send-email-kraxel@redhat.com>
	<1410448173-12960-2-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1354838407656242522=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1410448173-12960-2-git-send-email-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Dave Airlie <airlied@redhat.com>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1354838407656242522==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fEoCf1awPbSnoUcl5vj19WK7LNbCoMbf7"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fEoCf1awPbSnoUcl5vj19WK7LNbCoMbf7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/11/2014 09:09 AM, Gerd Hoffmann wrote:
> This patch adds the header file with structs and defines for
> the virtio based gpu device.  Covers 2d operations only.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/hw/virtio/virtgpu_hw.h | 158 +++++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 158 insertions(+)
>  create mode 100644 include/hw/virtio/virtgpu_hw.h
>=20
> diff --git a/include/hw/virtio/virtgpu_hw.h b/include/hw/virtio/virtgpu=
_hw.h
> new file mode 100644
> index 0000000..461f452
> --- /dev/null
> +++ b/include/hw/virtio/virtgpu_hw.h
> @@ -0,0 +1,158 @@
> +#ifndef VIRTGPU_HW_H
> +#define VIRTGPU_HW_H

Non-trivial file, deserves a copyright and license notice.

> +
> +enum virtgpu_ctrl_type {
> +        VIRTGPU_UNDEFINED =3D 0,
> +
> +        /* 2d commands */
> +        VIRTGPU_CMD_GET_DISPLAY_INFO =3D 0x0100,

Please consider also adding:

#define VIRTGPU_CMD_GET_DISPLAY_INFO VIRTGPU_CMD_GET_DISPLAY_INFO

and friends.  It makes it MUCH nicer for application software to probe
for later extensions if every member of the enum is also associated with
a preprocessor macro.


> +
> +struct virtgpu_ctrl_hdr {
> +        uint32_t type;
> +        uint32_t flags;
> +        uint64_t fence_id;
> +        uint32_t ctx_id;
> +        uint32_t padding;
> +};
> +

Is the padding to ensure that this is aligned regardless of 32-bit or
64-bit hosts?  Is it worth adding a compile-time assertion about the
size of the struct to ensure the compiler doesn't add any additional
padding?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--fEoCf1awPbSnoUcl5vj19WK7LNbCoMbf7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg

iQEcBAEBCAAGBQJUEb10AAoJEKeha0olJ0Nq/YEH/2LapO7FOnlYn2iuhka1udDK
h2YzFXgdlpqNhJL/lbIctob8XeBNdroz1pRdHXOEwWHEnkrGRBRZtwbsDH7xwOgG
hJpW2vr9NgHCPFeJmnaY30194/kiEU5o4QkPhX2YjWCVZLdd+T2kLv7jDPN4h6nl
nN3g29kiCjhy67BKTFgCoB8DkVsn7TaMBjjjb/8ib5Yd8nQ/rTLBdBgiIPtsJMKZ
gQ8BsizfHGmVTlwk0vecvl7k0TF32+DcIHg08NvdHjgDUnNtMoijYq7uMAODavG3
x0t9aONY3RNwumYwH2Ho0BDJ1vnxsMvK/NZzfM4ew9spAFoC3xgC4sxOgSywVAo=
=Zenb
-----END PGP SIGNATURE-----

--fEoCf1awPbSnoUcl5vj19WK7LNbCoMbf7--

--===============1354838407656242522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1354838407656242522==--
