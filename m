From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: virtio-vsock live migration
Date: Tue, 15 Mar 2016 15:10:37 +0000
Message-ID: <20160315151037.GA26263@stefanha-x1.localdomain>
References: <20160303153737.GA19780@stefanha-x1.localdomain>
	<20160311014147-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3443300674119373885=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160311014147-mutt-send-email-mst@redhat.com>
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


--===============3443300674119373885==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 11, 2016 at 01:56:05AM +0200, Michael S. Tsirkin wrote:
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
> >=20
> > 1. Requirements
> >=20
> > Virtio-vsock is a new AF_VSOCK transport.  As such, it should provide at
> > least the same guarantees as the existing AF_VSOCK VMCI transport.  This
> > is for consistency and to allow code reuse across any AF_VSOCK
> > transport.
> >=20
> > Virtio-vsock aims to replace virtio-serial by providing the same
> > guest/host communication ability but with sockets API semantics that are
> > more popular and convenient for application developers.  Therefore
> > virtio-vsock migration should provide at least the same level of
> > migration functionality as virtio-serial.
> >=20
> > Ideally it should be possible to migrate applications using AF_VSOCK
> > together with the virtual machine so that guest<->host communication is
> > interrupted.  Neither AF_VSOCK VMCI nor virtio-serial support this
> > today.
>=20
> I'm not sure why do you say this about virtio serial.
> It appears that if host pre-connected to destination
> qemu before migration, backend reconnects transparently
> on destination.

You are right, virtio-serial supports keeping active ports open across
migration (as well as closing active ports across migration).  In
virtio-vsock the equivalent would be setsockopt() CRIU-style socket
migration which is not implemented today.

> > 2. Basic disruptive migration flow
> >=20
> > When the virtual machine migrates from the source host to the
> > destination host, the guest's CID may change.  The CID namespace is
> > host-wide
>=20
>=20
> BTW, I think CIDs would have to become per network namespace.

Yes, I agree.

> > so other hosts may have CID collisions and allocate a new CID
> > for incoming migration VMs.
>=20
> I guess all this is so that guest can retrieve its CID and
> send it to host using some side-channel?

Yes.

> > The device notifies the guest that the CID has changed.  Guest sockets
> > are affected as follows:
> >=20
> >  * Established connections are reset (ECONNRESET) and the guest
> >    application will have to reconnect.
> >=20
> >  * Listen sockets remain open.  The only thing to note is that
> >    connections from the host are now made to the new CID.  This means
> >    the local address of the listen socket is automatically updated to
> >    the new CID.
> >=20
> >  * Sockets in other states are unchanged.
> >=20
> > Applications must handle disruptive migration by reconnecting if
> > necessary after ECONNRESET.
> >=20
> > 3. Checkpoint/restore for seamless migration
> >=20
> > Applications that wish to communicate across live migration can do so
> > but this requires extra application-specific checkpoint/restore code.
> >=20
> > This is similar to the approach taken by the CRIU project where
> > getsockopt()/setsockopt() is used to migrate socket state.  The
> > difference is that the application process is not automatically migrated
> > from the source host to the destination host.  Therefore, the
> > application needs to migrate its own state somehow.
> >=20
> > The flow is as follows:
> >=20
> > The application on the source host must quiesce (stop sending/receiving)
> > and use getsockopt() to extract socket state information from the host
> > kernel.
> >=20
> > A new instance of the application is started on the destination host and
> > given the state so it can restore the connection.  The setsockopt()
> > syscall is used to restore socket state information.
> >=20
> > The guest is given a list of <host_old_cid, host_new_cid, host_port,
> > guest_port> tuples for established connections that must not be reset
> > when the guest CID update notification is received.  These connections
> > will carry on as if nothing changed.
> >=20
> > Note that the connection's remote address is updated from host_old_cid
> > to host_new_cid.  This allows remapping of CIDs (if necessary).
> > Typically this will be unused because the host always has well-known CID
> > 2.  In a guest<->guest scenario it may be used to remap CIDs.
> >=20
> >=20
> > For the time being I am focussing on the basic disruptive migration flow
> > only.  Checkpoint/restore can be added with a feature bit in the future.
> > It is a lot more complex and I'm not sure whether there will be any
> > users yet.
> >=20
> > Stefan
>=20
> This makes some things harder. For example, imagine a guest
> reboot mixed with migration. We don't know why did the connection
> die, so we'll retry connections until - when?
>=20
> Could you please describe some user of vsock and show how
> it recovers from destructive migration?

qemu-guest-agent runs inside the guest with an AF_VSOCK listen socket.

libvirt arbitrates the qemu-guest-agent connection and provides an API
for applications to send commands.

When an application sends a command, libvirt checks if the connection to
qemu-guest-agent is established.  If there is no connection libvirt will
attempt to connect.

The command is sent to qemu-guest-agent and the response is handed back
to the guest application.  libvirt arbitrates access so commands from
multiple applications are serialized.

Live migration resets the established connection between
qemu-guest-agent and the source host's libvirt daemon.  When an
application issues the next qemu-guest-agent command the libvirt daemon
on the destination host notices there is no established connection yet
and starts a new one.

Libvirt refuses to send qemu-guest-agent commands while live migration
is in progress.

Stefan

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJW6CXtAAoJEJykq7OBq3PI99wIALdHrU0MJhYptbkFhyGSoB4X
6NOiA9cfWaDQ9xZEdzuMko0+E6eLwudTSkjHfFLVSwtFEC1ywE5KZgOa4vu3mJ2S
RjQzKZTvnx2ArTjoLwTatlVkW9YKEkng8Gb8F2A3FFflCGq2rmPSY08jJNXMc+Jm
Vllu9sBDEvmEvSUTRKPDLqJSMqOnWcJDlA0j4iYYg6YMHuRogG8eAewHGWFzXPRD
cuvzA1C0Pt5ezXXMyV67WM8cfFXX7AryxNgltTU72Ibvpc5FGLtMCRruIZBCCLv3
EZEqrK+zE2kS3Di++5fBI6HmUcOJckF5rH6gV8FjF5/mI7Top/oVdmpsQym6IMg=
=/xE+
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--

--===============3443300674119373885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3443300674119373885==--
