From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [BUG] virtio-net linux driver fails to probe on MIPS Malta since
	'hw/virtio-pci: fix virtio behaviour'
Date: Mon, 27 Mar 2017 19:45:28 +0100
Message-ID: <20170327184528.GQ31606@jhogan-linux.le.imgtec.org>
References: <20170317215725.GJ996@jhogan-linux.le.imgtec.org>
	<6b3ec98b-55e2-ecc8-d962-dc9d13866319@redhat.com>
	<20170320174101-mutt-send-email-mst@kernel.org>
	<c92a77f3-7ddc-c0b8-7046-6d8f1c56aec7@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8306119807382506967=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <c92a77f3-7ddc-c0b8-7046-6d8f1c56aec7@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

--===============8306119807382506967==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qcTtWMBd/uZDG7+Y"
Content-Disposition: inline

--qcTtWMBd/uZDG7+Y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Tue, Mar 21, 2017 at 04:16:58PM +0200, Marcel Apfelbaum wrote:
> Can you please check if the below patch fixes the problem?
> Please note it is not a solution.
>=20
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index f9b7244..5b4d429 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1671,9 +1671,7 @@ static void virtio_pci_device_plugged(DeviceState *=
d, Error **errp)
>           }
>=20
>           pci_register_bar(&proxy->pci_dev, proxy->modern_mem_bar_idx,
> -                         PCI_BASE_ADDRESS_SPACE_MEMORY |
> -                         PCI_BASE_ADDRESS_MEM_PREFETCH |
> -                         PCI_BASE_ADDRESS_MEM_TYPE_64,
> +                         PCI_BASE_ADDRESS_SPACE_MEMORY,
>                            &proxy->modern_bar);
>=20
>           proxy->config_cap =3D virtio_pci_add_mem_cap(proxy, &cfg.cap);

Sorry for the delay trying this, I was away last week.

No, it doesn't seem to make any difference.

Thanks
James

--qcTtWMBd/uZDG7+Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJY2V3IAAoJEGwLaZPeOHZ6qz8QAKGWlc6KTI7rybtB7mjTGSnd
M8Rkp4d7AZtS+pJTdiyl5B5MmRl6Jsrq7hF546Lq4KL4jB7XIqsn9FyvDfO1wGpa
tIdi0q3wimxOuj/VRez+NgeqS0ThhhmxEJGCSUi2tpt6OyCO1jxdUtvox6VX1tzb
DArpXyuCcfa7CyCTniStAWt5umHRZdL9t6OsAhn7iMsyTHYc9yFq2fgd4me6D5nQ
q4KHNK/N7N25ADvvuk5/iiU1a4uoBAXjsanXhe6xQrr9sxfrWHSONu8cFMU9ToKR
FlVTt6qEq12Qoo4W/Ryt1lp0QYt/Xm2+RxNNekiEUVD5nOhprh38HIPaSBXDYz8d
eCl/QVfASOQfC0WB8oyLERHK9DCiDHxfvPyAc5Frsm9qZtoXDaxKyuMBvv7ZVVKZ
jYn69rJnogM1xOmZ0+DNoNoTQtmbG0anz3Bzh5b2hXZYrBrc54Ddb0fTEzcZ95Z7
6WTn/tlFp7CyHTpynxSPTmCWm6e+pshn1H+XJo/PgG+rC/O0jMOMC6aoY/7aI+m7
7xUaz4J+L3GMtWs0LWJHxHhQTyEuFqOtPDzSPuVQGDexgX1chWPRcje0EYW6gnbr
zKiozfA2/lcNiT2Rg8ETR2ptuhJd+lJk6Ex9kSntUdVVPo6Nm2v+q0NMcaM71xtk
+mD09HeTDntwWExYAVJp
=Hzmk
-----END PGP SIGNATURE-----

--qcTtWMBd/uZDG7+Y--

--===============8306119807382506967==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8306119807382506967==--
