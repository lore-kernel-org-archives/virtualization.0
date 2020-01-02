From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v3 13/22] compat_ioctl: scsi: move ioctl handling into
 drivers
Date: Thu, 2 Jan 2020 16:33:21 +0000
Message-ID: <20200102163321.GA129642__40768.7243002997$1577982830$gmane$org@stefanha-x1.localdomain>
References: <20200102145552.1853992-1-arnd@arndb.de>
 <20200102145552.1853992-14-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2616568997154104561=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200102145552.1853992-14-arnd@arndb.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>, Ira Weiny <ira.weiny@intel.com>, Martin Wilck <mwilck@suse.com>, Hannes Reinecke <hare@suse.com>, Bart Van Assche <bvanassche@acm.org>, linux-scsi@vger.kernel.org, "Darrick J. Wong" <darrick.wong@oracle.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Doug Gilbert <dgilbert@interlog.com>, Iustin Pop <iustin@k1024.org>, "James E.J. Bottomley" <jejb@linux.ibm.com>, John Garry <john.garry@huawei.com>, linux-block@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, virtualization@lists.linux-foundation.org, Jens Axboe <axboe@kernel.dk>, Damien Le Moal <damien.lemoal@wdc.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

--===============2616568997154104561==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline

--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 02, 2020 at 03:55:31PM +0100, Arnd Bergmann wrote:
> Each driver calling scsi_ioctl() gets an equivalent compat_ioctl()
> handler that implements the same commands by calling scsi_compat_ioctl().
>=20
> The scsi_cmd_ioctl() and scsi_cmd_blk_ioctl() functions are compatible
> at this point, so any driver that calls those can do so for both native
> and compat mode, with the argument passed through compat_ptr().
>=20
> With this, we can remove the entries from fs/compat_ioctl.c.  The new
> code is larger, but should be easier to maintain and keep updated with
> newly added commands.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/block/virtio_blk.c |   3 +
>  drivers/scsi/ch.c          |   9 ++-
>  drivers/scsi/sd.c          |  50 ++++++--------
>  drivers/scsi/sg.c          |  44 ++++++++-----
>  drivers/scsi/sr.c          |  57 ++++++++++++++--
>  drivers/scsi/st.c          |  51 ++++++++------
>  fs/compat_ioctl.c          | 132 +------------------------------------
>  7 files changed, 142 insertions(+), 204 deletions(-)

virtio_blk.c changes:

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4OG1AACgkQnKSrs4Gr
c8gMMQf/cVfSKOJIWw9oQSb1Jtb5IIqXpqhGWNQXQPYbbsemSZJf8GuCcr81Y/O8
thKinuXXPDyxp2YiInq3zMfIn72igNBLu6R7+vlLftbmMGpcrz6NNeZHGqCrYYpH
tAbiYVKixufdkX3Z7zYKF17i1dNJNpfUojqhkjgV6v0/T/p6kaf1B7wzJa1Jxwol
Et0imw7jvfyzjcKb285/9aX+zWpzupOPtjuBwZdqxW/UU6RtNq4zw0aqT3HtxKRH
pU/1PuaHsZPWdag7TssEimmaRlgOkAlGr5zxjQXEeVV+Cx9rVJEr+Alnl/NB2qrY
AOe6O0GvhUnX+3rYXUwaVHnsPPkEPw==
=C/4U
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--


--===============2616568997154104561==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2616568997154104561==--
