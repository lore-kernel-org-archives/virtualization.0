From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [virtio-dev] virtio-vsock live migration
Date: Wed, 6 Apr 2016 13:55:50 +0100
Message-ID: <20160406125550.GB17538__8191.25825441933$1459947366$gmane$org@stefanha-x1.localdomain>
References: <20160303153737.GA19780@stefanha-x1.localdomain>
	<20160314130150-mutt-send-email-mst@redhat.com>
	<20160315151529.GB26263@stefanha-x1.localdomain>
	<20160315180916-mutt-send-email-mst@redhat.com>
	<20160316143200.GA689@stefanha-x1.localdomain>
	<20160316163344-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8378040835710585699=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160316163344-mutt-send-email-mst@redhat.com>
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


--===============8378040835710585699==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Content-Disposition: inline


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 16, 2016 at 05:05:19PM +0200, Michael S. Tsirkin wrote:
> > > >  NFS and netperf are the first two protocols I looked
> > > >    at and both transmit address information across the connection...
> > >=20
> > >=20
> > > Does netperf really attempt to get local IP
> > > and then send that inline within the connection?
> >=20
> > Yes, netperf has separate control and data sockets.  I think part of the
> > reason for this split is that the control connection can communicate the
> > address details for the data connection over a different protocol (TCP +
> > RDMA?), but I'm not sure.
> >=20
> > Stefan
>=20
> Thinking about it, netperf does not survive disconnects.
> So the current protocol would be useless for it.
> I am not sure about NFS but from (long past) experience it did not
> attempt to re-resolve the name to address, so changing an
> address would break it as well.
>=20
> So I think these applications would have to use a 64 bit CID.
>=20
> Why, then, do we care about one aspect of these applications
> (creating connections) and not another (not breaking them)?

I care about mapping the semantics of AF_VSOCK to virtio-vsock.
AF_VSOCK was implemented with the ability to plug in additional
transports (like virtio).  This allows guest agents and other
applications to compile once and run on any transport.

If we change virtio-vsock to rely on unique addresses across migration
then we lose zero-configuration.  AF_VSOCK applications use the
VMADDR_CID_HOST (2) constant to communicate with the host.  After live
migration this well-known CID refers to the new host.  Applications
would need to know a unique host CID in order to work correctly across
live migration.

Although I appreciate your drive to make the device as flexible as
possible, if we want to do this we are totally beyond AF_VSOCK semantics
and would be better served by a separate effort that avoids confusion
between class AF_VSOCK semantics and virtio socket semantics.

Can we please treat AF_VSOCK semantics as the requirements we're trying
to implement?  It supports qemu-guest-agent and as I described in a
previous mail could also support transparent connection migration a la
CRIU sockets.

Stefan

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJXBQdWAAoJEJykq7OBq3PI/XMH/j5GkuGK8lvvRwur5xDhTBkw
1P5d1LQZpRhLc9mg/kjnRuU1avRhQWbZAttMEIXQLO7yDyvSKxblwfxheFOQhmKi
YfNvnItvNrt7/31gIOQuiz4VXKFF+AAFt+lZzGY9krljITq7yz/uZyXg4CKhDH8H
icSw8MCk3LKB5RWOgCHPJoB3E/51T9ato86m4yg5yz0nE7a4Ql3eKDF4cPP11PKS
HOcCsVt8sQRlOonYrp36C8yLXXAE/Zmu6iaqUNvfylCevy6FydI991jdipsu9shp
Ur9mcjJ4PK7iKkp1AYW9PwAmtnYPsSdVeTmiZ+ymefQeN9RMOgSRDzdkW90f+7c=
=+RPt
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--

--===============8378040835710585699==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8378040835710585699==--
