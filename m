From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH net-next 1/3] vsock: add network namespace support
Date: Tue, 21 Jan 2020 15:44:12 +0000
Message-ID: <20200121154412.GC641751@stefanha-x1.localdomain>
References: <20200120.100610.546818167633238909.davem@davemloft.net>
 <20200120101735.uyh4o64gb4njakw5@steredhat>
 <20200120060601-mutt-send-email-mst@kernel.org>
 <CAGxU2F6VH8Eb5UH_9KjN6MONbZEo1D7EHAiocVVus6jW55BJDg@mail.gmail.com>
 <20200120110319-mutt-send-email-mst@kernel.org>
 <CAGxU2F5=DQJ56sH4BUqp_7rvaXSF9bFHp4QkpLApJQK0bmd4MA@mail.gmail.com>
 <20200120170120-mutt-send-email-mst@kernel.org>
 <CAGxU2F4uW7FNe5xC0sb3Xxr_GABSXuu1Z9n5M=Ntq==T7MaaVw@mail.gmail.com>
 <20200121135907.GA641751@stefanha-x1.localdomain>
 <20200121093104-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GZVR6ND4mMseVXL/"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200121093104-mutt-send-email-mst@kernel.org>
Content-Disposition: inline
Sender: kvm-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, David Miller <davem@davemloft.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>, Jason Wang <jasowang@redhat.com>, kvm <kvm@vger.kernel.org>, virtualization@lists.linux-foundation.org, linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

--GZVR6ND4mMseVXL/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2020 at 09:31:42AM -0500, Michael S. Tsirkin wrote:
> On Tue, Jan 21, 2020 at 01:59:07PM +0000, Stefan Hajnoczi wrote:
> > On Tue, Jan 21, 2020 at 10:07:06AM +0100, Stefano Garzarella wrote:
> > > On Mon, Jan 20, 2020 at 11:02 PM Michael S. Tsirkin <mst@redhat.com> =
wrote:
> > > > On Mon, Jan 20, 2020 at 05:53:39PM +0100, Stefano Garzarella wrote:
> > > > > On Mon, Jan 20, 2020 at 5:04 PM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> > > > > > On Mon, Jan 20, 2020 at 02:58:01PM +0100, Stefano Garzarella wr=
ote:
> > > > > > > On Mon, Jan 20, 2020 at 1:03 PM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > > > > > > On Mon, Jan 20, 2020 at 11:17:35AM +0100, Stefano Garzarell=
a wrote:
> > > > > > > > > On Mon, Jan 20, 2020 at 10:06:10AM +0100, David Miller wr=
ote:
> > > > > > > > > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > > > > > > > > Date: Thu, 16 Jan 2020 18:24:26 +0100
> > > > > > > > > >
> > > > > > > > > > > This patch adds 'netns' module param to enable this n=
ew feature
> > > > > > > > > > > (disabled by default), because it changes vsock's beh=
avior with
> > > > > > > > > > > network namespaces and could break existing applicati=
ons.
> > > > > > > > > >
> > > > > > > > > > Sorry, no.
> > > > > > > > > >
> > > > > > > > > > I wonder if you can even design a legitimate, reasonabl=
e, use case
> > > > > > > > > > where these netns changes could break things.
> > > > > > > > >
> > > > > > > > > I forgot to mention the use case.
> > > > > > > > > I tried the RFC with Kata containers and we found that Ka=
ta shim-v1
> > > > > > > > > doesn't work (Kata shim-v2 works as is) because there are=
 the following
> > > > > > > > > processes involved:
> > > > > > > > > - kata-runtime (runs in the init_netns) opens /dev/vhost-=
vsock and
> > > > > > > > >   passes it to qemu
> > > > > > > > > - kata-shim (runs in a container) wants to talk with the =
guest but the
> > > > > > > > >   vsock device is assigned to the init_netns and kata-shi=
m runs in a
> > > > > > > > >   different netns, so the communication is not allowed
> > > > > > > > > But, as you said, this could be a wrong design, indeed th=
ey already
> > > > > > > > > found a fix, but I was not sure if others could have the =
same issue.
> > > > > > > > >
> > > > > > > > > In this case, do you think it is acceptable to make this =
change in
> > > > > > > > > the vsock's behavior with netns and ask the user to chang=
e the design?
> > > > > > > >
> > > > > > > > David's question is what would be a usecase that's broken
> > > > > > > > (as opposed to fixed) by enabling this by default.
> > > > > > >
> > > > > > > Yes, I got that. Thanks for clarifying.
> > > > > > > I just reported a broken example that can be fixed with a dif=
ferent
> > > > > > > design (due to the fact that before this series, vsock device=
s were
> > > > > > > accessible to all netns).
> > > > > > >
> > > > > > > >
> > > > > > > > If it does exist, you need a way for userspace to opt-in,
> > > > > > > > module parameter isn't that.
> > > > > > >
> > > > > > > Okay, but I honestly can't find a case that can't be solved.
> > > > > > > So I don't know whether to add an option (ioctl, sysfs ?) or =
wait for
> > > > > > > a real case to come up.
> > > > > > >
> > > > > > > I'll try to see better if there's any particular case where w=
e need
> > > > > > > to disable netns in vsock.
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Stefano
> > > > > >
> > > > > > Me neither. so what did you have in mind when you wrote:
> > > > > > "could break existing applications"?
> > > > >
> > > > > I had in mind:
> > > > > 1. the Kata case. It is fixable (the fix is not merged on kata), =
but
> > > > >    older versions will not work with newer Linux.
> > > >
> > > > meaning they will keep not working, right?
> > >=20
> > > Right, I mean without this series they work, with this series they wo=
rk
> > > only if the netns support is disabled or with a patch proposed but no=
t
> > > merged in kata.
> > >=20
> > > >
> > > > > 2. a single process running on init_netns that wants to communica=
te with
> > > > >    VMs handled by VMMs running in different netns, but this case =
can be
> > > > >    solved opening the /dev/vhost-vsock in the same netns of the p=
rocess
> > > > >    that wants to communicate with the VMs (init_netns in this cas=
e), and
> > > > >    passig it to the VMM.
> > > >
> > > > again right now they just don't work, right?
> > >=20
> > > Right, as above.
> > >=20
> > > What do you recommend I do?
> >=20
> > Existing userspace applications must continue to work.
> >=20
> > Guests are fine because G2H transports are always in the initial networ=
k
> > namespace.
> >=20
> > On the host side we have a real case where Kata Containers and other
> > vsock users break.  Existing applications run in other network
> > namespaces and assume they can communicate over vsock (it's only
> > available in the initial network namespace by default).
> >=20
> > It seems we cannot isolate new network namespaces from the initial
> > network namespace by default because it will break existing
> > applications.  That's a bummer.
> >=20
> > There is one solution that maintains compatibility:
> >=20
> > Introduce a per-namespace vsock isolation flag that can only transition
> > from false to true.  Once it becomes true it cannot be reset to false
> > anymore (for security).
> >=20
> > When vsock isolation is false the initial network namespace is used for
> > <CID, port> addressing.
> >=20
> > When vsock isolation is true the current namespace is used for <CID,
> > port> addressing.
> >=20
> > I guess the vsock isolation flag would be set via a rtnetlink message,
> > but I haven't checked.
> >=20
> > The upshot is: existing software doesn't benefit from namespaces for
> > vsock isolation but it continues to work!  New software makes 1 special
> > call after creating the namespace to opt in to vsock isolation.
> >=20
> > This approach is secure because whoever sets up namespaces can
> > transition the flag from false to true and know that it can never be
> > reset to false anymore.
> >=20
> > Does this make sense to everyone?
> >=20
> > Stefan
>=20
> Anything wrong with a separate device? whoever opens it decides
> whether netns will work ...

Your idea is better.  I think a separate device is the way to go.

Stefan

--GZVR6ND4mMseVXL/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4nHEwACgkQnKSrs4Gr
c8gkWwf/WeCAFZA1kVaNgYa9wb5dO/ZohzbFkQbRphAk6cwcdO9bkkOoly99gEGb
zrr+mXxKZvzG+U4bsc3D9bLQr1UQ8GiD1YPBslgyTDZ72X1dWu2/11lPabgdTxhZ
SOFycWHK6sVsKUEA4Jiq7bwHqOzIez5cA+EOF3bmZCju1kcAFptyNpAnvopZt5AY
ZzEIqTDSm8p/GCVJmaJE4JzkzJM5mFzCSH73QeW0IGoUJ6C6ZbyvAOmXtEnFifwt
WxK4ok5OubA9Eadoo3x9tcr16to11ZV2aXVroS6Q96DCP8Vc3FHepAzEhgbjBw+O
bHtQCEDC6+JB3SWCmoWoX7qSts4OWg==
=HgEd
-----END PGP SIGNATURE-----

--GZVR6ND4mMseVXL/--
