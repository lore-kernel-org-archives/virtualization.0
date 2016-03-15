From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [virtio-dev] virtio-vsock live migration
Date: Tue, 15 Mar 2016 15:15:29 +0000
Message-ID: <20160315151529.GB26263__43994.4844147705$1458057298$gmane$org@stefanha-x1.localdomain>
References: <20160303153737.GA19780@stefanha-x1.localdomain>
	<20160314130150-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7232141449177365250=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160314130150-mutt-send-email-mst@redhat.com>
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
Cc: virtio-dev@lists.oasis-open.org, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Matt Benjamin <mbenjamin@redhat.com>, virtualization@lists.linux-foundation.org, Christoffer Dall <christoffer.dall@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org


--===============7232141449177365250==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 14, 2016 at 01:13:24PM +0200, Michael S. Tsirkin wrote:
> On Thu, Mar 03, 2016 at 03:37:37PM +0000, Stefan Hajnoczi wrote:
> > Michael pointed out that the virtio-vsock draft specification does not
> > address live migration and in fact currently precludes migration.
> >=20
> > Migration is fundamental so the device specification at least mustn't
> > preclude it.  Having brainstormed migration with Matthew Benjamin and
> > Michael Tsirkin, I am now summarizing the approach that I want to
> > include in the next draft specification.
> >=20
> > Feedback and comments welcome!  In the meantime I will implement this in
> > code and update the draft specification.
>=20
> Most of the issue seems to be a consequence of using a 4 byte CID.
>=20
> I think the right thing to do is just to teach guests
> about 64 bit CIDs.
>=20
> For now, can we drop guest CID from guest to host communication completel=
y,
> making CID only host-visible? Maybe leave the space
> in the packet so we can add CID there later.
> It seems that in theory this will allow changing CID
> during migration, transparently to the guest.
>=20
> Guest visible CID is required for guest to guest communication -
> but IIUC that is not currently supported.
> Maybe that can be made conditional on 64 bit addressing.
> Alternatively, it seems much easier to accept that these channels get bro=
ken
> across migration.

I reached the conclusion that channels break across migration because:

1. 32-bit CIDs are in sockaddr_vm and we'd break AF_VSOCK ABI by
   changing it to 64-bit.  Application code would be specific
   virtio-vsock and wouldn't work with other AF_VSOCK transports that
   use the 32-bit sockaddr_vm struct.

2. Dropping guest CIDs from the protocol breaks network protocols that
   send addresses.  NFS and netperf are the first two protocols I looked
   at and both transmit address information across the connection...

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJW6CcRAAoJEJykq7OBq3PI5DwH/i5jb7qIf+pE0TgZtLiHooB3
mkcevwHgsni+nMp6LozW/UQGuPkMlPYjklnSwI2kvROg8YziV15xZGOzVQ1IffHe
4bg7Ns7QDW8DVbzQ8nIRUOPiUtVRNsV5pHr1G2o8W7CJj/C33bVrYX8oQf+2o0/H
hQ8W7VpFVvJ4ff5lFF64AKl0CaST+j8Yf4EOML0Az8ZRUwccGwSjcful7u8xkARK
WfbJwOR/AQZQbMpAUaSCuP8wdrJATG16JOSeADzRLCRGYC9DDUUjInFNFz17Jbcj
9qr041lFDgYv/L8G1AzIhjaOLzuhrx+YQB2t616SQJwo65EMAI5CYNSUnadaDnU=
=/41a
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--

--===============7232141449177365250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7232141449177365250==--
