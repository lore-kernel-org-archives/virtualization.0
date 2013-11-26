From: Richard Yao <ryao@gentoo.org>
Subject: Re: QEMU dies on any attempt to load a Linux kernel module when using
	a 9P rootfs
Date: Tue, 26 Nov 2013 10:47:32 -0500
Message-ID: <5294C294.9000004@gentoo.org>
References: <5293718E.4090508@gentoo.org> <5293C622.4070304@gentoo.org>
	<5294BB66.3060608@codeaurora.org> <5294C05C.20802@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7534543625875800920=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5294C05C.20802@gentoo.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christopher Covington <cov@codeaurora.org>
Cc: kernel@gentoo.org, v9fs-developer@lists.sourceforge.net, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============7534543625875800920==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="guc7rDUWb7H7rJjP8alCIwearDG9QDgeE"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--guc7rDUWb7H7rJjP8alCIwearDG9QDgeE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I have this bad habit of not reviewing emails until after I send them.
Anyway, Chris, thanks for your offer of help, but I can handle this on
my own. The previous email was mostly to give you an early version of
the patch and let you know what I plan to do to improve upon it before I
propose some version of this patch to the appropriate subsystem
maintainer(s).

On 11/26/2013 10:38 AM, Richard Yao wrote:
> Christopher,
>=20
> It sounds like you disabled zero-copy entirely, which is not necessary.=

> As far as I recall, loading kernel modules is the only case in which
> valloc() allocated buffers are used. In the worst case, we only need to=

> disable zero-copy on such buffers. I have been using a small patch to d=
o
> precisely that since yesterday. I have attached it to this email since
> it sounds like the first version might be helpful to others while I tak=
e
> the time to explore a few loose ends.
>=20
> That being said, I would like to investigate a couple of things before =
I
> send either this patch or some variant of it to the appropriate
> subsystem maintainer. First, I need to review the valloc() routines to
> ensure that range checking against [VMALLOC_START, VMALLOC_END) is the
> correct way to identify valloc() generated buffers. Second, I want to
> explore the feasibility of a suggestion by Alexander Graf to instead
> rework the zero-copy to properly handle valloc() allocated buffers.
> Yours truly,
> Richard Yao
>=20
> On 11/26/2013 10:16 AM, Christopher Covington wrote:
>> Hi Richard,
>>
>> On 11/25/2013 04:50 PM, Richard Yao wrote:
>>> I figured out the problem. There is zerocopy IO is being done via DMA=
 to
>>> a buffer allocated with valloc(). Right now, I am running a hack-fix
>>> locally so I can get some other stuff done first. I will propose a
>>> proper fix to the list in a few days.
>>
>> I've also encountered this issue on a non-QEMU simulator and have been=

>> carrying a disable-zero-copy hack for a few months. Let me know if the=
re's
>> anything I can help with.
>>
>> Christopher
>>



--guc7rDUWb7H7rJjP8alCIwearDG9QDgeE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSlMKcAAoJECDuEZm+6ExkQEcP/ibqeJWsDZMJu9UskWr7nao9
eaIod74l/8wqcMlzTB36PWmbO6Or6Y9g7vm8gTIOOdbCvRBCl71y4MBlFsDZqtw0
O4OiLqLPZsmvIrXt4qiX2jjjWs+aMbZMB3qqeoV6e9OnKuxbhIQ6u9SoHPwz2BHo
AhDhPaqZUij8s+86t7De/MRmfSL8DLT+EmW8L+B0ob8aieJlNX2WeCr7XnGKZFjH
P1zfMxkzIn9iVMVKu3sm0DgPRtzLW8tpDJUNW3domEHevS1yhu2hzULUbDWgdaFH
o5JpIGQHEtoDu6VR5NN7+WjPxNBb3gMqiT8Ewybo5oSpTi4IOohEGOgKKAbbo1UB
d/F730ueDF10w/1KVzRZA6JYFkGJ3TzpNgKOcU1iYi/SGx9BVRmptgMH/PDEpN8W
MOxTgxdx5WNJzweFrCKNNdUpoa7OF3uE7aL0cj4ck52Um6qcngyzdkPBKL2A6Ipd
emDlwD5kS1rpuwBIXVBPMzCGgXfN0QCxAvejNstAkuQs3mTY1AXuDWmTDAxk18uT
QIdKcpIEmqfYDlR8O0UMA9bl17F+mq2Efnevm4gtMXL1S5qc3GQJ9eh/A4feE9NV
wMUU6gUkxDEDfIF2vjcT/IYUGlWnTbK6fz176J2RbyHQtoY9R1tuqUEaMUH7W5Uf
MRCvocnMeUH52IC0wzR3
=/p2s
-----END PGP SIGNATURE-----

--guc7rDUWb7H7rJjP8alCIwearDG9QDgeE--

--===============7534543625875800920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7534543625875800920==--
