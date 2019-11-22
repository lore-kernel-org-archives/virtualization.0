From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH net-next 4/6] vsock: add vsock_loopback transport
Date: Fri, 22 Nov 2019 09:25:46 +0000
Message-ID: <20191122092546.GA464656__21007.7876852424$1574414768$gmane$org@stefanha-x1.localdomain>
References: <20191119110121.14480-1-sgarzare@redhat.com>
 <20191119110121.14480-5-sgarzare@redhat.com>
 <20191121093458.GB439743@stefanha-x1.localdomain>
 <20191121095948.bc7lc3ptsh6jxizw@steredhat>
 <20191121152517.zfedz6hg6ftcb2ks@steredhat>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7846284614583473819=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191121152517.zfedz6hg6ftcb2ks@steredhat>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: kvm@vger.kernel.org, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

--===============7846284614583473819==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline

--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2019 at 04:25:17PM +0100, Stefano Garzarella wrote:
> On Thu, Nov 21, 2019 at 10:59:48AM +0100, Stefano Garzarella wrote:
> > On Thu, Nov 21, 2019 at 09:34:58AM +0000, Stefan Hajnoczi wrote:
> > > On Tue, Nov 19, 2019 at 12:01:19PM +0100, Stefano Garzarella wrote:
> > > > +static struct workqueue_struct *vsock_loopback_workqueue;
> > > > +static struct vsock_loopback *the_vsock_loopback;
> > >=20
> > > the_vsock_loopback could be a static global variable (not a pointer) =
and
> > > vsock_loopback_workqueue could also be included in the struct.
> > >=20
> > > The RCU pointer is really a way to synchronize vsock_loopback_send_pk=
t()
> > > and vsock_loopback_cancel_pkt() with module exit.  There is no other
> > > reason for using a pointer.
> > >=20
> > > It's cleaner to implement the synchronization once in af_vsock.c (or
> > > virtio_transport_common.c) instead of making each transport do it.
> > > Maybe try_module_get() and related APIs provide the necessary semanti=
cs
> > > so that core vsock code can hold the transport module while it's bein=
g
> > > used to send/cancel a packet.
> >=20
> > Right, the module cannot be unloaded until open sockets, so here the
> > synchronization is not needed.
> >=20
> > The synchronization come from virtio-vsock device that can be
> > hot-unplugged while sockets are still open, but that can't happen here.
> >=20
> > I will remove the pointers and RCU in the v2.
> >=20
> > Can I keep your R-b or do you prefer to watch v2 first?

I'd like to review v2.

> > > > +MODULE_ALIAS_NETPROTO(PF_VSOCK);
> > >=20
> > > Why does this module define the alias for PF_VSOCK?  Doesn't another
> > > module already define this alias?
> >=20
> > It is a way to load this module when PF_VSOCK is starting to be used.
> > MODULE_ALIAS_NETPROTO(PF_VSOCK) is already defined in vmci_transport
> > and hyperv_transport. IIUC it is used for the same reason.
> >=20
> > In virtio_transport we don't need it because it will be loaded when
> > the PCI device is discovered.
> >=20
> > Do you think there's a better way?
> > Should I include the vsock_loopback transport directly in af_vsock
> > without creating a new module?
> >=20
>=20
> That last thing I said may not be possible:
> I remembered that I tried, but DEPMOD found a cyclic dependency because
> vsock_transport use virtio_transport_common that use vsock, so if I
> include vsock_transport in the vsock module, DEPMOD is not happy.
>=20
> Do you think it's okay in this case to keep MODULE_ALIAS_NETPROTO(PF_VSOC=
K)
> or is there a better way?

The reason I asked is because the semantics of duplicate module aliases
aren't clear to me.  Do all modules with the same alias get loaded?
Or just the first?  Or ...?

Stefan

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3XqZoACgkQnKSrs4Gr
c8g8zwgAgv0qn/NHDbIBcCRih2eGRkR+l2CqDKByM5A65GN5n5ZwQJvooj/0hZZa
maHWK3vTmOU1c5m5gwRHJcTNTvK3hL3xYgxMCzanpWkpK6xPFSbBReQ1KtN+2IJh
1bXN7mvpTAKFkIm10jnGIzK53Tv5y46c+dHQ+Q+Wx56zSCMWcMhPZUBXSAE8Tx61
VAeo0HFPzx/wgy785xR3+tw4xV0M8UlbcYqJG/jTToIES2z4JUNIVTAczg22QpSe
hp9KwKDgSMvJLmb6fzefYTgp/hTT3fQh448YbpeHAsly8RSoJjkJx/1w4qj/AVAT
rI4XWaP4Enu7IgGna2wLQSCP+fqRog==
=VfA7
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--


--===============7846284614583473819==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7846284614583473819==--
