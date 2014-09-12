From: Eric Blake <eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] virtio-gpu/2d: add hardware spec include
	file
Date: Fri, 12 Sep 2014 06:48:09 -0600
Message-ID: <5412EB89.1080405@redhat.com>
References: <1410448173-12960-1-git-send-email-kraxel@redhat.com>	
	<1410448173-12960-2-git-send-email-kraxel@redhat.com>	
	<5411BD74.80608@redhat.com>
	<1410518696.30411.9.camel@nilsson.home.kraxel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5779782859871037852=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1410518696.30411.9.camel@nilsson.home.kraxel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Dave Airlie <airlied@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============5779782859871037852==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="51im3AxrIrngDKNjhqT7IrdHQHja5orqi"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--51im3AxrIrngDKNjhqT7IrdHQHja5orqi
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/12/2014 04:44 AM, Gerd Hoffmann wrote:

>>> +enum virtgpu_ctrl_type {
>>> +        VIRTGPU_UNDEFINED =3D 0,
>>> +
>>> +        /* 2d commands */
>>> +        VIRTGPU_CMD_GET_DISPLAY_INFO =3D 0x0100,
>>
>> Please consider also adding:
>>
>> #define VIRTGPU_CMD_GET_DISPLAY_INFO VIRTGPU_CMD_GET_DISPLAY_INFO
>>
>> and friends.  It makes it MUCH nicer for application software to probe=

>> for later extensions if every member of the enum is also associated wi=
th
>> a preprocessor macro.
>=20
> I don't think this will ever be shipped as library header for external
> users ...

Fair enough. I wasn't sure, so it didn't hurt to ask.

>=20
>>> +struct virtgpu_ctrl_hdr {
>>> +        uint32_t type;
>>> +        uint32_t flags;
>>> +        uint64_t fence_id;
>>> +        uint32_t ctx_id;
>>> +        uint32_t padding;
>>> +};
>>> +
>>
>> Is the padding to ensure that this is aligned regardless of 32-bit or
>> 64-bit hosts?
>=20
> Yes.
>=20
>> Is it worth adding a compile-time assertion about the
>> size of the struct to ensure the compiler doesn't add any additional
>> padding?
>=20
> Makes sense.  What is the usual trick to do that?

Among others,

struct dummy {
  int size_check : (sizeof(virtgpu_ctrl_hdr) =3D=3D 24 ? 1 : -1);
};

Since bitfields cannot have a negative size, the compiler will
forcefully fail compilation if the struct size ever changes.  Similar
tricks include setting up array bounds that would be negative on
failure, or (inside a function body) declaring a switch that has
colliding case statements on failure.  But depending on the set of
compiler warning options in effect, declaring an otherwise unused struct
may be too noisy.  So if you need more ideas and a good read, check out
the comments in how gnulib does it (the link mentions GPLv3+, but that
file is also shipped as LGPLv2+ so it is compatible with qemu):

git.savannah.gnu.org/cgit/gnulib.git/tree/lib/verify.h

with an end result that a user just writes:

verify(sizeof(virtgpu_ctrl_hdr) =3D=3D 24);

and calls it a day.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--51im3AxrIrngDKNjhqT7IrdHQHja5orqi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg

iQEcBAEBCAAGBQJUEuuJAAoJEKeha0olJ0NqWEYIAIJc8TNESBnzr/PDoZOU9MMT
4KsW0/dJIy1Dcfv6HdGISvwDOoUDg4rp+tDKqliaKsp9NNdjFBQAQdBdPud9nsBr
YPVuBdXOrwHedOvWwdYfTyRPa1vW+nU7h/wqEL8RuC7v3p7Ghn5Eh5iH4zqxKfzZ
8/ht7OMAPUhFKm+Lo/JYGSFvSb1VqZdS5q/gQKCLV1Xt48Z3UBzE3Q3EhHPv71yL
LIQ243vUaYIrXN9+OFmoUevllX+zNb6Bl4bdpBRCebdX4B1SNz3bAq8N6AMVlJv7
L9gLoaJGdlpdlmqcoQnktn7oKB9xJbrLwionr5RpR9BmgKlzTs7Khdvo2tI0WeU=
=Hs6p
-----END PGP SIGNATURE-----

--51im3AxrIrngDKNjhqT7IrdHQHja5orqi--

--===============5779782859871037852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5779782859871037852==--
