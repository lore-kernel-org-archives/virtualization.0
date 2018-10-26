From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v8] virtio_blk: add discard and write zeroes support
Date: Fri, 26 Oct 2018 09:08:38 +0100
Message-ID: <20181026080838.GB4234@stefanha-x1.localdomain>
References: <1528258740-6581-1-git-send-email-changpeng.liu@intel.com>
	<20181012210628.226361-1-dverkamp@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4495166480373817270=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181012210628.226361-1-dverkamp@chromium.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Verkamp <dverkamp@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, Changpeng Liu <changpeng.liu@intel.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============4495166480373817270==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 12, 2018 at 02:06:28PM -0700, Daniel Verkamp wrote:
> +		range[n].flags =3D cpu_to_le32(flags);
> +		range[n].num_sectors =3D cpu_to_le32(num_sectors);
> +		range[n].sector =3D cpu_to_le64(sector);
=2E..
> +/* Discard/write zeroes range for each request. */
> +struct virtio_blk_discard_write_zeroes {
> +	/* discard/write zeroes start sector */
> +	__virtio64 sector;
> +	/* number of discard/write zeroes sectors */
> +	__virtio32 num_sectors;
> +	/* flags for this range */
> +	__virtio32 flags;

cpu_to_le32() is being used on __virtio32 fields instead of cpu_to_virtio32=
().

=46rom include/uapi/linux/virtio_types.h:

  /*
   * __virtio{16,32,64} have the following meaning:
   * - __u{16,32,64} for virtio devices in legacy mode, accessed in native =
endian
   * - __le{16,32,64} for standard-compliant virtio devices
   */

=46rom the VIRTIO specification:

  struct virtio_blk_discard_write_zeroes {
         le64 sector;
         le32 num_sectors;
         struct {
                 le32 unmap:1;
                 le32 reserved:31;
         } flags;
  };


Since the VIRTIO spec says these fields are little-endian, I think these
fields should be declared just __u32 and __u64 instead of __virtio32 and
__virtio64.

Stefan

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb0suGAAoJEJykq7OBq3PIovgH/RYjx3ilZdj/2DV4LRaU0j2g
r0I2C1zIJteXLa2aJF85UY8M0gJ119HiEW2BI7cdrCd4jkDV5dhm3KLbSxlS8IQe
GC7GfoYsv+w6v1hYd+FwExBaetDdLcLPxKGGpk7yq3LLb2jDAEpWAPE2qpd4raOr
jFqcCV1jrgDmt0UbAdo4+Vm4EHfAmw9s402zTt1GdNdg4CSyn4EtDV88BKImm56n
xNpneQtuRuWeMrwMNVFB9QelbF8nL4cKEupvayqFOw3q8ggBQA78UijTJAeAT/j+
1mS7hcNWiNxNsx0nIOtTgQQ+0Qz8S4yBJRJ1bx7gED5v/P6mcQpZx28qkNLV9+k=
=ZcGN
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--

--===============4495166480373817270==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4495166480373817270==--
