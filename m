From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/2] virtio_ring: Use DMA API if memory is encrypted
Date: Mon, 21 Oct 2019 19:36:50 +1100
Message-ID: <20191021083650.GG6439__10197.5754879945$1571647040$gmane$org@umbus.fritz.box>
References: <1570843519-8696-1-git-send-email-linuxram@us.ibm.com>
	<1570843519-8696-2-git-send-email-linuxram@us.ibm.com>
	<1570843519-8696-3-git-send-email-linuxram@us.ibm.com>
	<20191015073501.GA32345@lst.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5505045536764271647=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191015073501.GA32345@lst.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@lst.de>
Cc: andmike@us.ibm.com, sukadev@linux.vnet.ibm.com, b.zolnierkie@samsung.com, benh@kernel.crashing.org, aik@linux.ibm.com, Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, paulus@ozlabs.org, iommu@lists.linux-foundation.org, paul.burton@mips.com, mpe@ellerman.id.au, m.szyprowski@samsung.com, linuxppc-dev@lists.ozlabs.org, robin.murphy@arm.com
List-Id: virtualization@lists.linuxfoundation.org


--===============5505045536764271647==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Sw7tCqrGA+HQ0/zt"
Content-Disposition: inline


--Sw7tCqrGA+HQ0/zt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2019 at 09:35:01AM +0200, Christoph Hellwig wrote:
> On Fri, Oct 11, 2019 at 06:25:19PM -0700, Ram Pai wrote:
> > From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> >=20
> > Normally, virtio enables DMA API with VIRTIO_F_IOMMU_PLATFORM, which mu=
st
> > be set by both device and guest driver. However, as a hack, when DMA API
> > returns physical addresses, guest driver can use the DMA API; even thou=
gh
> > device does not set VIRTIO_F_IOMMU_PLATFORM and just uses physical
> > addresses.
>=20
> Sorry, but this is a complete bullshit hack.  Driver must always use
> the DMA API if they do DMA, and if virtio devices use physical addresses
> that needs to be returned through the platform firmware interfaces for
> the dma setup.  If you don't do that yet (which based on previous
> informations you don't), you need to fix it, and we can then quirk
> old implementations that already are out in the field.
>=20
> In other words: we finally need to fix that virtio mess and not pile
> hacks on top of hacks.

Christoph, if I understand correctly, your objection isn't so much to
the proposed change here of itself, except insofar as it entrenches
virtio's existing code allowing it to either use the DMA api or bypass
it and use physical addresses directly.  Is that right, or have I
missed something?

Where do you envisage the decision to bypass the IOMMU being made?
The virtio spec more or less states that virtio devices use hypervisor
magic to access physical addresses directly, rather than using normal
DMA channels.  The F_IOMMU_PLATFORM flag then overrides that, since it
obviously won't work for hardware devices.

The platform code isn't really in a position to know that virtio
devices are (usually) magic.  So were you envisaging the virtio driver
explicitly telling the platform to use bypassing DMA operations?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Sw7tCqrGA+HQ0/zt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2tbhcACgkQbDjKyiDZ
s5JyXg//T3Ppsd9Nw4UJ0S7vuihqdegF9xf5Id+ggjipfZl02lYq6KHjlrkDkMXH
HVHUoVYy0626P9inLv/Yt9cqA70zVNKVt5gItWX+FUETTio5hv1vcz5pB28nGln/
uauetB6MmSZnnRcMkzguJjRO53cJJIR2ft+qKz6BhVksdhE+JufUYuWgCM92znTp
e+ku518x0fc5t4mqCBjIf/EZ0S0F3GqXH61q38USXZhfaJDJiaR/krUYvB+Opm6y
k505kcbvfLybLlZyb6EOQyjQGskvQsBbSXbzJRImbUPA8hrFQY0JMozfxcUKz56G
PGvl9KKWz/Wr+NwwCcPi6/oM1t+iisn6UGsW9j4888nFzMDVlQgWMBP2oPD5vNiS
JvmxsmveiRl+0YZ6mPPG6GLg0msmW8TPM5lYVBpG+yJs24C/AY0yUkgjzSX9wjdd
6zuO5ZJumgblftxiYZ5SoMX/RZ1tlTn9o35B5wOA8rbvBEGbdVEPlrhxzpxKUA41
M+63HFoZOZ4zRtV/qBP4Z3lhqzsatDsDPq3FIH5GOtJAVs9yiaJPjF4449plpzMS
mSoJgCD9g0M0aQJXYb1gv/1BrAuO2kQSoounFzDWP0hmTPdGd3QQifF8n3x4j4h6
xuGMCq/7AXeE6xZsBnw7+bqX0NLIRgIb7a6d3nyJeVzfgJWvq/M=
=ybRR
-----END PGP SIGNATURE-----

--Sw7tCqrGA+HQ0/zt--

--===============5505045536764271647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5505045536764271647==--
