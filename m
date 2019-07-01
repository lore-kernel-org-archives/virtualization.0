From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v2 1/3] vsock/virtio: use RCU to avoid use-after-free on
	the_virtio_vsock
Date: Mon, 1 Jul 2019 15:54:12 +0100
Message-ID: <20190701145412.GA11900__30050.0440805749$1561992867$gmane$org@stefanha-x1.localdomain>
References: <20190628123659.139576-1-sgarzare@redhat.com>
	<20190628123659.139576-2-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4216647553637226525=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190628123659.139576-2-sgarzare@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org


--===============4216647553637226525==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2019 at 02:36:57PM +0200, Stefano Garzarella wrote:
> Some callbacks used by the upper layers can run while we are in the
> .remove(). A potential use-after-free can happen, because we free
> the_virtio_vsock without knowing if the callbacks are over or not.
>=20
> To solve this issue we move the assignment of the_virtio_vsock at the
> end of .probe(), when we finished all the initialization, and at the
> beginning of .remove(), before to release resources.
> For the same reason, we do the same also for the vdev->priv.
>=20
> We use RCU to be sure that all callbacks that use the_virtio_vsock
> ended before freeing it. This is not required for callbacks that
> use vdev->priv, because after the vdev->config->del_vqs() we are sure
> that they are ended and will no longer be invoked.

->del_vqs() is only called at the very end, did you forget to move it
earlier?

In particular, the virtqueue handler callbacks schedule a workqueue.
The work functions use container_of() to get vsock.  We need to be sure
that the work item isn't freed along with vsock while the work item is
still pending.

How do we know that the virtqueue handler is never called in such a way
that it sees vsock !=3D NULL (there is no explicit memory barrier on the
read side) and then schedules a work item after flush_work() has run?

Stefan

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0aHpQACgkQnKSrs4Gr
c8h3iggAyuubhQSWc2lhNVpR8Iy+q+vzwq6cn2HkKAJfd12b4HEHPiQthM2torlj
Bv8w164J+O/rOon9ZrilyvFEgF2NuQbHiyd7REvtp4tKyZow9wVqj4VT2s0CIxAM
5w3ijDBYRXnC2YmnnjJLJb/xhmkrjboxZcX7BuPjNbsNtkxcVer9KlOZOp9tjL7N
OYm4hhy/aHydI1SwBIbVYNvyWGvjhpZqYixHr2uOB/Xd/kisVztQoJE77oRPD6IS
3kScisIJxoNurY1izyyJfSI0OJ+chyeGNLeR/NzvMGiPRUeEIZCC/Z2jGGBGD7WU
re2dtf93pyrxquVVa7nd39azFSXO3w==
=NQ6E
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--

--===============4216647553637226525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4216647553637226525==--
