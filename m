From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH net] vhost: fix OOB in get_rx_bufs()
Date: Tue, 29 Jan 2019 14:30:08 +0800
Message-ID: <20190129063008.GJ3264__27994.0445254155$1548826273$gmane$org@stefanha-x1.localdomain>
References: <20190128070505.18335-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8231447120629914722=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190128070505.18335-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org


--===============8231447120629914722==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YPJ8CVbwFUtL7OFW"
Content-Disposition: inline


--YPJ8CVbwFUtL7OFW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2019 at 03:05:05PM +0800, Jason Wang wrote:
> After batched used ring updating was introduced in commit e2b3b35eb989
> ("vhost_net: batch used ring update in rx"). We tend to batch heads in
> vq->heads for more than one packet. But the quota passed to
> get_rx_bufs() was not correctly limited, which can result a OOB write
> in vq->heads.
>=20
>         headcount =3D get_rx_bufs(vq, vq->heads + nvq->done_idx,
>                     vhost_len, &in, vq_log, &log,
>                     likely(mergeable) ? UIO_MAXIOV : 1);
>=20
> UIO_MAXIOV was still used which is wrong since we could have batched
> used in vq->heads, this will cause OOB if the next buffer needs more
> than 960 (1024 (UIO_MAXIOV) - 64 (VHOST_NET_BATCH)) heads after we've
> batched 64 (VHOST_NET_BATCH) heads:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> BUG kmalloc-8k (Tainted: G    B            ): Redzone overwritten
> -------------------------------------------------------------------------=
----
>=20
> INFO: 0x00000000fd93b7a2-0x00000000f0713384. First byte 0xa9 instead of 0=
xcc
> INFO: Allocated in alloc_pd+0x22/0x60 age=3D3933677 cpu=3D2 pid=3D2674
>     kmem_cache_alloc_trace+0xbb/0x140
>     alloc_pd+0x22/0x60
>     gen8_ppgtt_create+0x11d/0x5f0
>     i915_ppgtt_create+0x16/0x80
>     i915_gem_create_context+0x248/0x390
>     i915_gem_context_create_ioctl+0x4b/0xe0
>     drm_ioctl_kernel+0xa5/0xf0
>     drm_ioctl+0x2ed/0x3a0
>     do_vfs_ioctl+0x9f/0x620
>     ksys_ioctl+0x6b/0x80
>     __x64_sys_ioctl+0x11/0x20
>     do_syscall_64+0x43/0xf0
>     entry_SYSCALL_64_after_hwframe+0x44/0xa9
> INFO: Slab 0x00000000d13e87af objects=3D3 used=3D3 fp=3D0x          (null=
) flags=3D0x200000000010201
> INFO: Object 0x0000000003278802 @offset=3D17064 fp=3D0x00000000e2e6652b
>=20
> Fixing this by allocating UIO_MAXIOV + VHOST_NET_BATCH iovs for
> vhost-net. This is done through set the limitation through
> vhost_dev_init(), then set_owner can allocate the number of iov in a
> per device manner.
>=20
> This fixes CVE-2018-16880.
>=20
> Fixes: e2b3b35eb989 ("vhost_net: batch used ring update in rx")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vhost/net.c   | 3 ++-
>  drivers/vhost/scsi.c  | 2 +-
>  drivers/vhost/vhost.c | 7 ++++---
>  drivers/vhost/vhost.h | 4 +++-
>  drivers/vhost/vsock.c | 2 +-
>  5 files changed, 11 insertions(+), 7 deletions(-)

No change in the scsi and vsock cases.  I haven't reviewed the net case.

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--YPJ8CVbwFUtL7OFW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcT/LwAAoJEJykq7OBq3PIxekH/05O7+mudnt5sHQYTE8fzAnD
qyX80qnYtoOkhdxJv+OJXC0wWNziXP+FKx+txGjW8YQbgyICgzPZdFx+MdJskyBj
ui74eegtEx60Jn0dxvRv9kuphlDTAk7csZ4tjJkjibkjkYDydqdconnO3l6eoklP
mHO15NKbm/R4zeNu8LzvIi0OBRQ7WSDyPuwCieVI8j6pkpPGnkf5qmhfdkLUIhfZ
yVXsX/zKFCwAktm2Q3W7nMnaJCwmmewxVj9wASOfwhI9fmUxY1TuAqAAaZW0oV5T
H9bjm/I73zR22jAUiMUKNBSs3hGc2DfJsSohkzRIscZuk/bGLVV+qtqokxWWVx8=
=3Jhy
-----END PGP SIGNATURE-----

--YPJ8CVbwFUtL7OFW--

--===============8231447120629914722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8231447120629914722==--
