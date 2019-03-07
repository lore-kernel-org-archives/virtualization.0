From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2] vsock/virtio: fix kernel panic from
	virtio_transport_reset_no_sock
Date: Thu, 7 Mar 2019 16:37:09 +0000
Message-ID: <20190307163709.GL2843__34327.4914239132$1551976643$gmane$org@stefanha-x1.localdomain>
References: <20190306101353.9938-1-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0647609197602853058=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190306101353.9938-1-alazar@bitdefender.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Adalbert =?utf-8?B?TGF6xINy?= <alazar@bitdefender.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Alexandru Herghelegiu <aherghelegiu@bitdefender.com>, "David S . Miller" <davem@davemloft.net>, Stefano Garzarella <sgarzare@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============0647609197602853058==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DN8g+DOX2TxGxleI"
Content-Disposition: inline


--DN8g+DOX2TxGxleI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2019 at 12:13:53PM +0200, Adalbert Laz=C4=83r wrote:
> Previous to commit 22b5c0b63f32 ("vsock/virtio: fix kernel panic
> after device hot-unplug"), vsock_core_init() was called from
> virtio_vsock_probe(). Now, virtio_transport_reset_no_sock() can be called
> before vsock_core_init() has the chance to run.
>=20
> [Wed Feb 27 14:17:09 2019] BUG: unable to handle kernel NULL pointer dere=
ference at 0000000000000110
> [Wed Feb 27 14:17:09 2019] #PF error: [normal kernel read fault]
> [Wed Feb 27 14:17:09 2019] PGD 0 P4D 0
> [Wed Feb 27 14:17:09 2019] Oops: 0000 [#1] SMP PTI
> [Wed Feb 27 14:17:09 2019] CPU: 3 PID: 59 Comm: kworker/3:1 Not tainted 5=
=2E0.0-rc7-390-generic-hvi #390
> [Wed Feb 27 14:17:09 2019] Hardware name: QEMU Standard PC (i440FX + PIIX=
, 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
> [Wed Feb 27 14:17:09 2019] Workqueue: virtio_vsock virtio_transport_rx_wo=
rk [vmw_vsock_virtio_transport]
> [Wed Feb 27 14:17:09 2019] RIP: 0010:virtio_transport_reset_no_sock+0x8c/=
0xc0 [vmw_vsock_virtio_transport_common]
> [Wed Feb 27 14:17:09 2019] Code: 35 8b 4f 14 48 8b 57 08 31 f6 44 8b 4f 1=
0 44 8b 07 48 8d 7d c8 e8 84 f8 ff ff 48 85 c0 48 89 c3 74 2a e8 f7 31 03 0=
0 48 89 df <48> 8b 80 10 01 00 00 e8 68 fb 69 ed 48 8b 75 f0 65 48 33 34 25=
 28
> [Wed Feb 27 14:17:09 2019] RSP: 0018:ffffb42701ab7d40 EFLAGS: 00010282
> [Wed Feb 27 14:17:09 2019] RAX: 0000000000000000 RBX: ffff9d79637ee080 RC=
X: 0000000000000003
> [Wed Feb 27 14:17:09 2019] RDX: 0000000000000001 RSI: 0000000000000002 RD=
I: ffff9d79637ee080
> [Wed Feb 27 14:17:09 2019] RBP: ffffb42701ab7d78 R08: ffff9d796fae70e0 R0=
9: ffff9d796f403500
> [Wed Feb 27 14:17:09 2019] R10: ffffb42701ab7d90 R11: 0000000000000000 R1=
2: ffff9d7969d09240
> [Wed Feb 27 14:17:09 2019] R13: ffff9d79624e6840 R14: ffff9d7969d09318 R1=
5: ffff9d796d48ff80
> [Wed Feb 27 14:17:09 2019] FS:  0000000000000000(0000) GS:ffff9d796fac000=
0(0000) knlGS:0000000000000000
> [Wed Feb 27 14:17:09 2019] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050=
033
> [Wed Feb 27 14:17:09 2019] CR2: 0000000000000110 CR3: 0000000427f22000 CR=
4: 00000000000006e0
> [Wed Feb 27 14:17:09 2019] DR0: 0000000000000000 DR1: 0000000000000000 DR=
2: 0000000000000000
> [Wed Feb 27 14:17:09 2019] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR=
7: 0000000000000400
> [Wed Feb 27 14:17:09 2019] Call Trace:
> [Wed Feb 27 14:17:09 2019]  virtio_transport_recv_pkt+0x63/0x820 [vmw_vso=
ck_virtio_transport_common]
> [Wed Feb 27 14:17:09 2019]  ? kfree+0x17e/0x190
> [Wed Feb 27 14:17:09 2019]  ? detach_buf_split+0x145/0x160
> [Wed Feb 27 14:17:09 2019]  ? __switch_to_asm+0x40/0x70
> [Wed Feb 27 14:17:09 2019]  virtio_transport_rx_work+0xa0/0x106 [vmw_vsoc=
k_virtio_transport]
> [Wed Feb 27 14:17:09 2019] NET: Registered protocol family 40
> [Wed Feb 27 14:17:09 2019]  process_one_work+0x167/0x410
> [Wed Feb 27 14:17:09 2019]  worker_thread+0x4d/0x460
> [Wed Feb 27 14:17:09 2019]  kthread+0x105/0x140
> [Wed Feb 27 14:17:09 2019]  ? rescuer_thread+0x360/0x360
> [Wed Feb 27 14:17:09 2019]  ? kthread_destroy_worker+0x50/0x50
> [Wed Feb 27 14:17:09 2019]  ret_from_fork+0x35/0x40
> [Wed Feb 27 14:17:09 2019] Modules linked in: vmw_vsock_virtio_transport =
vmw_vsock_virtio_transport_common input_leds vsock serio_raw i2c_piix4 mac_=
hid qemu_fw_cfg autofs4 cirrus ttm drm_kms_helper syscopyarea sysfillrect s=
ysimgblt fb_sys_fops virtio_net psmouse drm net_failover pata_acpi virtio_b=
lk failover floppy
>=20
> Fixes: 22b5c0b63f32 ("vsock/virtio: fix kernel panic after device hot-unp=
lug")
> Reported-by: Alexandru Herghelegiu <aherghelegiu@bitdefender.com>
> Signed-off-by: Adalbert Laz=C4=83r <alazar@bitdefender.com>
> Co-developed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)

Excellent, thanks!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--DN8g+DOX2TxGxleI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcgUi1AAoJEJykq7OBq3PILVYIAJoiNUivvTKNqO0dpFJa8n6f
VVRxbzPNNsRtzv+2h4yn+Tpq3FR9zV1nOb0eLZGPzOas0Pck1ssnu3PrVHQf8ddo
VAoquSEPSN6bgisJkfQJzKLlp7423n3cNuFRPJnu2J55upFMNMCfgIVKd2jjunBR
IAOOHVV/1YZsJgTn6gZf8YKGXoO8s8ElOUl+i7te0L6clMpBfq3yZ2fB7LSjfB25
RfiIJJiez5wtOne+JaqPTz+4fvl7NClsxF1euNMC4LXaWhtOH0Y26WL29XegYzti
9Lsmn2ZubPpVD/46BYYargDpWH6C+3u7S81uEa2BGl0Sa5d87BZKp75voDWF9dA=
=kFyN
-----END PGP SIGNATURE-----

--DN8g+DOX2TxGxleI--

--===============0647609197602853058==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0647609197602853058==--
