From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [virtio-dev] virtio-vsock live migration
Date: Wed, 16 Mar 2016 14:32:00 +0000
Message-ID: <20160316143200.GA689@stefanha-x1.localdomain>
References: <20160303153737.GA19780@stefanha-x1.localdomain>
	<20160314130150-mutt-send-email-mst@redhat.com>
	<20160315151529.GB26263@stefanha-x1.localdomain>
	<20160315180916-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8015115501117306484=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160315180916-mutt-send-email-mst@redhat.com>
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


--===============8015115501117306484==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 15, 2016 at 06:12:55PM +0200, Michael S. Tsirkin wrote:
> On Tue, Mar 15, 2016 at 03:15:29PM +0000, Stefan Hajnoczi wrote:
> > On Mon, Mar 14, 2016 at 01:13:24PM +0200, Michael S. Tsirkin wrote:
> > > On Thu, Mar 03, 2016 at 03:37:37PM +0000, Stefan Hajnoczi wrote:
> > > > Michael pointed out that the virtio-vsock draft specification does =
not
> > > > address live migration and in fact currently precludes migration.
> > > >=20
> > > > Migration is fundamental so the device specification at least mustn=
't
> > > > preclude it.  Having brainstormed migration with Matthew Benjamin a=
nd
> > > > Michael Tsirkin, I am now summarizing the approach that I want to
> > > > include in the next draft specification.
> > > >=20
> > > > Feedback and comments welcome!  In the meantime I will implement th=
is in
> > > > code and update the draft specification.
> > >=20
> > > Most of the issue seems to be a consequence of using a 4 byte CID.
> > >=20
> > > I think the right thing to do is just to teach guests
> > > about 64 bit CIDs.
> > >=20
> > > For now, can we drop guest CID from guest to host communication compl=
etely,
> > > making CID only host-visible? Maybe leave the space
> > > in the packet so we can add CID there later.
> > > It seems that in theory this will allow changing CID
> > > during migration, transparently to the guest.
> > >=20
> > > Guest visible CID is required for guest to guest communication -
> > > but IIUC that is not currently supported.
> > > Maybe that can be made conditional on 64 bit addressing.
> > > Alternatively, it seems much easier to accept that these channels get=
 broken
> > > across migration.
> >=20
> > I reached the conclusion that channels break across migration because:
> >=20
> > 1. 32-bit CIDs are in sockaddr_vm and we'd break AF_VSOCK ABI by
> >    changing it to 64-bit.  Application code would be specific
> >    virtio-vsock and wouldn't work with other AF_VSOCK transports that
> >    use the 32-bit sockaddr_vm struct.
>=20
> You don't have to repeat the IPv6 mistake.  Make all 32 bit CIDs
> 64 bit CIDs by padding with 0s, then 64 bit apps can use
> any CID.
>=20
> Old 32 bit CID applications will not be able to use the extended
> addresses, but hardcoding bugs
> does not seem sane.

A mixed 32-bit and 64-bit CID world is complex.  The host doesn't know
in advance whether all applications (especially inside the guest) will
support 64-bit CIDs or not.  32-bit CID applications won't work if a
64-bit CID has been assigned.

It also opens up the question how unique CIDs are allocated across
hosts.

Given that AF_VSOCK in Linux already exists in the 32-bit CID version,
I'd prefer to make virtio-vsock compatible with that for the time being.
Extensions can be added in the future but just implementing existing
AF_VSOCK semantics will already allow the applications to run.

> > 2. Dropping guest CIDs from the protocol breaks network protocols that
> >    send addresses.
>=20
> Stick it in config space if you really have to.
> But why do you need it on each packet?

If packets are implicitly guest<->host then adding guest<->guest
communication requires a virtio spec change.  If packets contain
source/destination CIDs then allowing/forbidding guest<->host or
guest<->guest communication is purely a host policy decision.  I think
it's worth keeping that in from the start.

> >  NFS and netperf are the first two protocols I looked
> >    at and both transmit address information across the connection...
>=20
>=20
> Does netperf really attempt to get local IP
> and then send that inline within the connection?

Yes, netperf has separate control and data sockets.  I think part of the
reason for this split is that the control connection can communicate the
address details for the data connection over a different protocol (TCP +
RDMA?), but I'm not sure.

Stefan

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJW6W5gAAoJEJykq7OBq3PItjMH/2xvEQ8ka+0ORunyR5J8kynJ
7Y18Y8bPUFzxaVC/g+cZGd8v/Af/fKR+pjVdBXSJjJb2erLc1F9COknoKqyZYoeP
0zO/BeKSTy03mMhPKSlp4Wy6820JNFytXUcR1grjyL7/w2CCuFlFUBOlzZilEo+U
7n2HxZZ5TFuCSIfNQYR29AaXKxgt+zgQTG9xiAHF/cHo+2enzbCVrL+CXi1Hin/H
tnYtYACHo5h+jA1mxmy0G/ua3PAYdqYqiC1cRHUkbSgyJZuZnXbazxLXEdxruly0
rCB/B/w24ggtE74o+HeDxfj6a1ckFRJ5xdjLEggPen2/Lhl9IbYAdjdDlfFEBHY=
=1J3F
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--

--===============8015115501117306484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8015115501117306484==--
