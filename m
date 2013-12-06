From: Richard Yao <ryao@gentoo.org>
Subject: Re: [PATCH] 9p/trans_virtio.c: Fix broken zero-copy on vmalloc()
	buffers
Date: Fri, 06 Dec 2013 09:38:28 -0500
Message-ID: <52A1E164.20006@gentoo.org>
References: <1386189798-22157-1-git-send-email-ryao@gentoo.org>
	<20131206111422.GB16079@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0402047460152471690=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20131206111422.GB16079@mudshark.cambridge.arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Will Deacon <will.deacon@arm.com>
Cc: Eric Van Hensbergen <ericvh@gmail.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kernel@gentoo.org" <kernel@gentoo.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Ron Minnich <rminnich@sandia.gov>, "v9fs-developer@lists.sourceforge.net" <v9fs-developer@lists.sourceforge.net>, Brian Behlendorf <behlendorf1@llnl.gov>
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0402047460152471690==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="2SRCFbdLrL8Gd4hfRqUm7ArLvepdw3bok"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2SRCFbdLrL8Gd4hfRqUm7ArLvepdw3bok
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/06/2013 06:14 AM, Will Deacon wrote:
> On Wed, Dec 04, 2013 at 08:43:18PM +0000, Richard Yao wrote:
>> The 9p-virtio transport does zero copy on things larger than 1024 byte=
s
>> in size. It accomplishes this by returning the physical addresses of
>> pages to the virtio-pci device. At present, the translation is usually=
 a
>> bit shift.
>>
>> However, that approach produces an invalid page address when we
>> read/write to vmalloc buffers, such as those used for Linux kernle
>> modules. This causes QEMU to die printing:
>>
>> qemu-system-x86_64: virtio: trying to map MMIO memory
>>
>> This patch enables 9p-virtio to correctly handle this case. This not
>> only enables us to load Linux kernel modules off virtfs, but also
>> enables ZFS file-based vdevs on virtfs to be used without killing QEMU=
=2E
>>
>> Also, special thanks to both Avi Kivity and Alexander Graf for their
>> interpretation of QEMU backtraces. Without their guidence, tracking do=
wn
>> this bug would have taken much longer.
>>
>> Signed-off-by: Richard Yao <ryao@gentoo.org>
>> ---
>>  net/9p/trans_virtio.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
>> index 9c5a1aa..5d1d04b 100644
>> --- a/net/9p/trans_virtio.c
>> +++ b/net/9p/trans_virtio.c
>> @@ -340,7 +340,10 @@ static int p9_get_mapped_pages(struct virtio_chan=
 *chan,
>>  		int count =3D nr_pages;
>>  		while (nr_pages) {
>>  			s =3D rest_of_page(data);
>> -			pages[index++] =3D kmap_to_page(data);
>> +			if (is_vmalloc_or_module_addr(data))
>=20
> Can this really end up being a module address?

Yes. Here is the stacktrace to prove it:

[<ffffffff814878ce>] p9_virtio_zc_request+0x45e/0x510
[<ffffffff814814ed>] p9_client_zc_rpc.constprop.16+0xfd/0x4f0
[<ffffffff814839dd>] p9_client_read+0x15d/0x240
[<ffffffff811c8440>] v9fs_fid_readn+0x50/0xa0
[<ffffffff811c84a0>] v9fs_file_readn+0x10/0x20
[<ffffffff811c84e7>] v9fs_file_read+0x37/0x70
[<ffffffff8114e3fb>] vfs_read+0x9b/0x160
[<ffffffff81153571>] kernel_read+0x41/0x60
[<ffffffff810c83ab>] copy_module_from_fd.isra.34+0xfb/0x180
[<ffffffff810cc420>] SyS_finit_module+0x70/0xd0
[<ffffffff814a08fd>] system_call_fastpath+0x1a/0x1f
[<ffffffffffffffff>] 0xffffffffffffffff

This is easily reproducible by trying to load a module off virtfs. QEMU
will print the message that I cited in the commit message and then kill
itself.

P.S. I omitted the CC list the first time I sent this, so I am resending
with the correct CC list.


--2SRCFbdLrL8Gd4hfRqUm7ArLvepdw3bok
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSoeFmAAoJECDuEZm+6ExkcwEP/3jfbvTT+yRiQ6A0b4g0MjBo
8s/1f7UcUC2gBrrkZMXsazX/gpFJzumuIbDr5FyVWldwvzId1wbETJWqdMnfWRjw
tmZddKgK1PGf9KsQ0+mvVQjN0tCyEov+frpbdIADiTmHMk0/YeieFlj7JyYw4Vzn
oxrRfdwxiHclldyVRs1MeZuUJAV7Do8E7FKcV4dsIDoJY0e/kxOUFrdulrnPL0hm
PvArI5p4ihKzvxCqNMn6wSYZNn8AodVikmUxQQv0Ae+UbuSlW2f/W2iZnlhnSURo
HHsN9YpQD2oZ9VlSSG94EAWaBt4SNsFi1Wc9Fa/aZ6odd8zrwRxQIi3myQ+2wfdL
lHOP2Q6AJxbt3cOYml9FuHt95e9AOFVL7NrgRVD3e+us6rX/8Bsdhac2BLhbFfBX
gycay+Q95ddmFfpqjJnOH5l7BCkQ9MLuUpTjZzCKSITog0JUeuvFf+62UV0k8u/z
uOY99hILfLBe8FDCWj4tJe3YFIGLwqf3Ia400B56RT1rH0P8i5DLDEbqcaZmv0j0
VfSMOMOKjhv/cdnv2xk2xd2PPcpVeqG0dzb2Ugu+8c/rjmIjcr7xvUyDvOdfJb2F
hxQTKJhDlf/0vzU9ANwsTmVFbduGn2rUy9tws+8bFlHQkZDxz8ar/1YTy8icZINB
09Vz5YkgAz9twqk9TrRU
=DNKs
-----END PGP SIGNATURE-----

--2SRCFbdLrL8Gd4hfRqUm7ArLvepdw3bok--

--===============0402047460152471690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0402047460152471690==--
