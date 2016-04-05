From: Jeff Mahoney <jeffm@suse.com>
Subject: =?UTF-8?Q?Re:_[PATCH]_virtio:_fix_=22warning:_=e2=80=98queue?=
	=?UTF-8?Q?=e2=80=99_may_be_used_uninitialized=22?=
Date: Tue, 5 Apr 2016 09:34:24 -0400
Message-ID: <5703BEE0.5020206@suse.com>
References: <5702AEFB.5090701@suse.com>
	<20160405110113-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2249687371614954184=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160405110113-mutt-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============2249687371614954184==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="EEgkIeMVh2QJDpgS4jFsQWlDWecxXPths"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EEgkIeMVh2QJDpgS4jFsQWlDWecxXPths
Content-Type: multipart/mixed; boundary="AR2fcOjQ4PRxv0umXoQc0XFV5B3CevSrD"
From: Jeff Mahoney <jeffm@suse.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Message-ID: <5703BEE0.5020206@suse.com>
Subject: =?UTF-8?Q?Re:_[PATCH]_virtio:_fix_=22warning:_=e2=80=98queue?=
 =?UTF-8?Q?=e2=80=99_may_be_used_uninitialized=22?=
References: <5702AEFB.5090701@suse.com>
 <20160405110113-mutt-send-email-mst@redhat.com>
In-Reply-To: <20160405110113-mutt-send-email-mst@redhat.com>

--AR2fcOjQ4PRxv0umXoQc0XFV5B3CevSrD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/5/16 4:04 AM, Michael S. Tsirkin wrote:
> On Mon, Apr 04, 2016 at 02:14:19PM -0400, Jeff Mahoney wrote:
>> This fixes the following warning:
>> drivers/virtio/virtio_ring.c:1032:5: warning: =E2=80=98queue=E2=80=99 =
may be used
>> uninitialized in this function
>>
>> The conditions that govern when queue is set aren't apparent to gcc.
>>
>> Setting queue =3D NULL clears the warning.
>>
>> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
>=20
> Which gcc version produces this warning?
> I do not seem to see it with gcc 5.3.1.

gcc version 4.8.5 (SUSE Linux)

> Also - use uninitialized_var then?

If it were a fast path, sure, but otherwise the use of uninitialized_var
just makes similar issues harder to debug if the code changes.

-Jeff

>> ---
>>
>>  drivers/virtio/virtio_ring.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> --- a/drivers/virtio/virtio_ring.c
>> +++ b/drivers/virtio/virtio_ring.c
>> @@ -1006,7 +1006,7 @@ struct virtqueue *vring_create_virtqueue
>>  	const char *name)
>>  {
>>  	struct virtqueue *vq;
>> -	void *queue;
>> +	void *queue =3D NULL;
>>  	dma_addr_t dma_addr;
>>  	size_t queue_size_in_bytes;
>>  	struct vring vring;
>>
>> --=20
>> Jeff Mahoney
>> SUSE Labs
>=20


--=20
Jeff Mahoney
SUSE Labs


--AR2fcOjQ4PRxv0umXoQc0XFV5B3CevSrD--

--EEgkIeMVh2QJDpgS4jFsQWlDWecxXPths
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.19 (Darwin)
Comment: GPGTools - http://gpgtools.org

iQIcBAEBAgAGBQJXA77gAAoJEB57S2MheeWynsIP/1AICmRAA14Hc8WQ5T68+Fy0
4TJyYVNwcC04Fjcb/CvjQfVFTCNkNcaJehZcERL+UAsHb4TJ3H0HqsgpTodZ3y92
vRMxsKoclEi004qWYV/pZIciLxIJDmZMIvWbo9ZZhrMEE+n/psWVofEVT1VSqtbN
ZY1oiJRx5vdR10yWgV60CTimfOfRDWKnaooCsDnyv4owNbG18HOR4JfNE2uX5S3j
5u/2dwkdWFDPNDkGGSKXiGWj/rAsu4zfx3IX+9kaP6a6c1rzTocLqk3ryFcs0q2v
8t7xgyj5LT7VQmrsEbl/An7o8I6bAk30custu7RxAhtLREe/Ne2LdyYJphErMUbz
9bi22MOAnN9UodXwKYhO/U/itk5xwXfT4GbAcf9/p3u5ug7Z2CbREnfLkJ1Qyw3K
ZBmhHkcVrv0cO5IqlCCHktdZqQASNHiBUkN5oKZ6cA5eydwInm7KPsxDuQTVNJWD
WmI8TteNT018Ygz7W7mNMS/V727n4k9TUkLaeJ2lv1m5+zSJwuOxbvouvDsA8hr1
8wqbtAfK/5vME2D60tgaFVYS29Zp1HB43P2cjDIhfvOWxqwCVdHc/5BnV8jhhVB+
1XgMBML/Zto10CJBsBDxgp0Y78cOvgV6ISoy0gdb9ZAOch2zPIOKJ/9ytEWq9ZOk
QP8WPIz+Q53DNFQ4NozW
=lYG5
-----END PGP SIGNATURE-----

--EEgkIeMVh2QJDpgS4jFsQWlDWecxXPths--

--===============2249687371614954184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2249687371614954184==--
