From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] scsi: virtio_scsi: unplug LUNs when events missed
Date: Mon, 9 Sep 2019 18:55:48 +0200
Message-ID: <45d4fc47-cfc2-b7ae-e147-fb993a77e9e5__29291.7992732086$1568048209$gmane$org@redhat.com>
References: <20190905181903.29756-1-mlupfer@ddn.com>
	<20190906085409.GC5900@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0137876054551001053=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190906085409.GC5900@stefanha-x1.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@redhat.com>, Matt Lupfer <mlupfer@ddn.com>
Cc: "martin.petersen@oracle.com" <martin.petersen@oracle.com>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "jejb@linux.ibm.com" <jejb@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0137876054551001053==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pxnQuVbtWYEwmX3SJy3OhOXnAXOYEWRNZ"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pxnQuVbtWYEwmX3SJy3OhOXnAXOYEWRNZ
Content-Type: multipart/mixed; boundary="KlMsZ2txnG2HaPm51dmD2esB01PSzQkME";
 protected-headers="v1"
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Matt Lupfer <mlupfer@ddn.com>
Cc: "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <45d4fc47-cfc2-b7ae-e147-fb993a77e9e5@redhat.com>
Subject: Re: [PATCH v2] scsi: virtio_scsi: unplug LUNs when events missed
References: <20190905181903.29756-1-mlupfer@ddn.com>
 <20190906085409.GC5900@stefanha-x1.localdomain>
In-Reply-To: <20190906085409.GC5900@stefanha-x1.localdomain>

--KlMsZ2txnG2HaPm51dmD2esB01PSzQkME
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06/09/19 10:54, Stefan Hajnoczi wrote:
> On Thu, Sep 05, 2019 at 06:19:28PM +0000, Matt Lupfer wrote:
>> The event handler calls scsi_scan_host() when events are missed, which=

>> will hotplug new LUNs.  However, this function won't remove any
>> unplugged LUNs.  The result is that hotunplug doesn't work properly wh=
en
>> the number of unplugged LUNs exceeds the event queue size (currently 8=
).
>>
>> Scan existing LUNs when events are missed to check if they are still
>> present.  If not, remove them.
>>
>> Signed-off-by: Matt Lupfer <mlupfer@ddn.com>
>> ---
>>  drivers/scsi/virtio_scsi.c | 33 +++++++++++++++++++++++++++++++++
>>  1 file changed, 33 insertions(+)
>=20
> Please include a changelog in future patch revisions.  For example:
>=20
>   Signed-off-by: ...
>   ---
>   v2:
>     * Replaced magic constants with sd.h constants [Michael]
>=20
> Just C and virtio code review, no SCSI specifics:
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20

Acked-by: Paolo Bonzini <pbonzini@redhat.com>


--KlMsZ2txnG2HaPm51dmD2esB01PSzQkME--

--pxnQuVbtWYEwmX3SJy3OhOXnAXOYEWRNZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl12hBQACgkQv/vSX3jH
roNf/QgAmxUxJG1dOWyJiM9cOE05ZHpVBvjYtllR4MHb7M3HkgznPc7bAe3ojMCh
MjjpnhamcSKKTKtx9cgDK1bh8uj8viucaOZ43r0/P+npJO8XsdwwAlzfx5WMQ/Al
qEaNVoX1KUxdWZAEYS1y52JmEvOf+0SlmaeJZMYQOWSJHepaM3d7l2vslFhZMIdt
y054MXFZiJxyEB/AE8R/Xy7LPe9/CHliHqxDBMVjLYRFuUeqtkgAXjKUVsThUsGt
EIKONYmN0aQ+Nl8bphUlxHhVVUgCTZ+YP/OCQqAOWtGKpINsFKBcvipeJeAVj3id
Z7Jdh+v01Bs92VJ3BdQHgIbvvRulCA==
=O1le
-----END PGP SIGNATURE-----

--pxnQuVbtWYEwmX3SJy3OhOXnAXOYEWRNZ--

--===============0137876054551001053==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0137876054551001053==--
