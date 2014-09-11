From: Eric Blake <eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] virtio-gpu/2d: add
	docs/specs/virtio-gpu.txt
Date: Thu, 11 Sep 2014 09:30:01 -0600
Message-ID: <5411BFF9.9030102__17632.9219867059$1410450847$gmane$org@redhat.com>
References: <1410448173-12960-1-git-send-email-kraxel@redhat.com>
	<1410448173-12960-3-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9055635558133522845=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1410448173-12960-3-git-send-email-kraxel@redhat.com>
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
--===============9055635558133522845==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QKFlxGEC3dSAwVedQsrCfLbQqAfGxtUtG"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QKFlxGEC3dSAwVedQsrCfLbQqAfGxtUtG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/11/2014 09:09 AM, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  docs/specs/virtio-gpu.txt | 165 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 165 insertions(+)
>  create mode 100644 docs/specs/virtio-gpu.txt
>=20
> diff --git a/docs/specs/virtio-gpu.txt b/docs/specs/virtio-gpu.txt
> new file mode 100644
> index 0000000..9455383
> --- /dev/null
> +++ b/docs/specs/virtio-gpu.txt
> @@ -0,0 +1,165 @@
> +virtio-gpu specification

I know you are just following existing bad practice in this directory,
but it would be nice to declare copyright and license on this file.


> +
> +The two members events_read and events_clear are used to signal events=

> +to the driver.  Currently one event is defined for a display
> +change. When a config space interrupt is received the driver should
> +read the events_read field.  The events processed should be written to=

> +the events_clear field.  The device will clear the bits in events_read=

> +then, mimicing write-to-clear behavior.

s/mimicing/mimicking/ (stupid English rule that any verb ending in 'ic'
becomes 'ick' when adding 'ed' or 'ing')

> +Both queues have the same format.  Each request and each response have=

> +a fixed header (struct virtgpu_ctrl_hdr), followed by command specific=

> +data fieds.  The separate cursor queue is the "fast track" for

s/fieds/fields/

> +The virtio-gpu is based around the concept of resources private to the=

> +host, the guest must DMA transfer into these resources. This is a
> +design requirement in order to interface with future 3D rendering. In
> +the unaccelerated there is no support for DMA transfers from

s/unaccelerated/unaccelerated mode/

> +  This creates a 2D resource on the host with the specified width,
> +  height and format. Only a small subset of formats are support. The

s/support/supported/
and can you delineate that subset?


> +  This sets the scanout parameters for a single scanout. The
> +  resource_id is the resource to be scanned out from, along with a
> +  rectangle specified by x, y, width and height.

Is it worth a mention here or generically up front where 0,0 is in
relation to the screen, and in which direction positive numbers move?
I'm assuming 0,0 is top left, and larger x moves right, larger y moves do=
wn.

Are there restrictions against rectangles that overlap beyond screen
boundaries?


> +  This assign an array of guest pages (struct virtgpu_mem_entry) as

s/assign/assigns/

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--QKFlxGEC3dSAwVedQsrCfLbQqAfGxtUtG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg

iQEcBAEBCAAGBQJUEb/5AAoJEKeha0olJ0NqLY8H/ihYDRlQb8BRGfJBFsYDlUzf
uNVZFw5BW+o+OSqbjuAmi7fxbMjweVoBkvFBTeTqDVwy3r+fMr9n1aSqacImq8n0
KyQD2v9TTyjS+neP1IeycI6yQtzQUeZ1LAcYZq2GXleowUHeCB2bsu2bDSXWzuAH
aoyanm9lcc10T3eBtwfLsMze1y43gAuvMZOQyQhJ6BwgyArXufWdKkJ3TxqIxzMt
91Ht3JJgRtD/EgSdqWBZ0Mv7Yr9rN1NJilFrnALr16AbnuZ9m9Ko0dW1P5GBq1ev
5ezQq3U+BJ7xpKR0GbHay70b2QxFJ/OEERzqRdLdffBJf6BV2lrDuKUGi8z4ll0=
=Hal3
-----END PGP SIGNATURE-----

--QKFlxGEC3dSAwVedQsrCfLbQqAfGxtUtG--

--===============9055635558133522845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============9055635558133522845==--
