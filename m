From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Date: Wed, 14 Aug 2019 00:24:39 +1000
Message-ID: <20190813142439.GO3947__38048.4540875599$1565707681$gmane$org@umbus.fritz.box>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
	<20190810143038-mutt-send-email-mst@kernel.org>
	<20190810220702.GA5964@ram.ibm.com> <20190811055607.GA12488@lst.de>
	<20190812095156.GD3947@umbus.fritz.box>
	<20190813132617.GA6426@lst.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1660255041622460718=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190813132617.GA6426@lst.de>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Paul Mackerras <paulus@ozlabs.org>, iommu@lists.linux-foundation.org, linuxppc-devel@lists.ozlabs.org
List-Id: virtualization@lists.linuxfoundation.org


--===============1660255041622460718==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xexMVKTdXPhpRiVT"
Content-Disposition: inline


--xexMVKTdXPhpRiVT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2019 at 03:26:17PM +0200, Christoph Hellwig wrote:
> On Mon, Aug 12, 2019 at 07:51:56PM +1000, David Gibson wrote:
> > AFAICT we already kind of abuse this for the VIRTIO_F_IOMMU_PLATFORM,
> > because to handle for cases where it *is* a device limitation, we
> > assume that if the hypervisor presents VIRTIO_F_IOMMU_PLATFORM then
> > the guest *must* select it.
> >=20
> > What we actually need here is for the hypervisor to present
> > VIRTIO_F_IOMMU_PLATFORM as available, but not required.  Then we need
> > a way for the platform core code to communicate to the virtio driver
> > that *it* requires the IOMMU to be used, so that the driver can select
> > or not the feature bit on that basis.
>=20
> I agree with the above, but that just brings us back to the original
> issue - the whole bypass of the DMA OPS should be an option that the
> device can offer, not the other way around.  And we really need to
> fix that root cause instead of doctoring around it.

I'm not exactly sure what you mean by "device" in this context.  Do
you mean the hypervisor (qemu) side implementation?

You're right that this was the wrong way around to begin with, but as
well as being hard to change now, I don't see how it really addresses
the current problem.  The device could default to IOMMU and allow
bypass, but the driver would still need to get information from the
platform to know that it *can't* accept that option in the case of a
secure VM.  Reversed sense, but the same basic problem.

The hypervisor does not, and can not be aware of the secure VM
restrictions - only the guest side platform code knows that.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xexMVKTdXPhpRiVT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1SyCcACgkQbDjKyiDZ
s5I4bQ//S4EUhoZcI/LsW/VYsc9vUb4nR5PFUpsfHBRPpz5LSCyiE0zj6HPD0NEw
xx7wFiEoEoijTK2eUAql0bciMMkjU4bktaIRNxHL0gHTJ+bYC0JQK42DBFC6t/9L
2D5DD8K9CYwIwxjYOPlxaxCEJfVKLLCMwBXmO3n1wbp3DO4ejeOq6TcsFfzF079C
rj1ofD3aAdjKicydMAWXVOly4fcAimPwCI+CU/hEuAiT5OOsvl3RkOcPQ2psC0kr
AhWUtFFDmdTosz+3HvByFrQoIsWS833CETD/+h7QPRfcgdDnoctb5QY9oyqSCxvH
phO1O07WExt8rXrRAWJvP81K0n+b4cTuw8aUKp8qchHopQUrSiUfwM0vLFgbHmPj
qG+x3Z1XfdMRWJjnst0aF/EMnI3GXl+d2hzMJLbXicj0F4HLnn/F2mkQbXRkOcFw
8gilmJLNmOhUWo8viy7dc90YU2i0HOQd6h0j+5fyfhYKf+4fWvodL6thBGHWWiTk
g63CjmoEZByRc5iDwuGf3vRBsFU26hDHYXh3mk8+AEmfZ0zMfE+6NvgEdPOvU82A
bwQU186bnnTF1AjRiGfC69gX4Dfe077FiFjcDwS6ojR+21MojjdITMsVOKw4ZwfQ
wwnomYbPb7NjK2QJcSM8AqbQftwvqAIzBtjPEOsknnb4VyoVTXs=
=2Lh2
-----END PGP SIGNATURE-----

--xexMVKTdXPhpRiVT--

--===============1660255041622460718==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1660255041622460718==--
