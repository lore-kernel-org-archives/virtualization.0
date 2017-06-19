From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC] virtio-mem: paravirtualized memory
Date: Mon, 19 Jun 2017 11:08:13 +0100
Message-ID: <20170619100813.GB17304__29695.1073142283$1497866901$gmane$org@stefanha-x1.localdomain>
References: <547865a9-d6c2-7140-47e2-5af01e7d761d@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4825570497037666074=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <547865a9-d6c2-7140-47e2-5af01e7d761d@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Hildenbrand <david@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, KVM <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
List-Id: virtualization@lists.linuxfoundation.org


--===============4825570497037666074==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 16, 2017 at 04:20:02PM +0200, David Hildenbrand wrote:
> Important restrictions of this concept:
> - Guests without a virtio-mem guest driver can't see that memory.
> - We will always require some boot memory that cannot get unplugged.
>   Also, virtio-mem memory (as all other hotplugged memory) cannot become
>   DMA memory under Linux. So the boot memory also defines the amount of
>   DMA memory.

I didn't know that hotplug memory cannot become DMA memory.

Ouch.  Zero-copy disk I/O with O_DIRECT and network I/O with virtio-net
won't be possible.

When running an application that uses O_DIRECT file I/O this probably
means we now have 2 copies of pages in memory: 1. in the application and
2. in the kernel page cache.

So this increases pressure on the page cache and reduces performance :(.

Stefan

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZR6KNAAoJEJykq7OBq3PIQqMH/0S2AZbkzrqnJOKdCz8yKg9X
qBbZG8McVs38XBZtkkzU4J4JKQMsS7b+boDjJ8N5LmjuHrNFfnJrwScVVc8aQ++E
muHRRed4s556aSBAcSvk/OT7CtxYdwrraFuvzp2O1Rt84m9RPrMv719xZxeWsbzo
69e7xRq3NIAgv2zLbPIWV/RiqXJIYWJatGP95n0PvKIeRwxl8jK68BUdEchWGjAQ
mcjgcM8gch/facSMSd0OcRR4IgCLKuEV3RqKXJ2WKy//xWIjQc95m0sQEFWdwBtB
Eri7GCsR0SDsOfGtoMmBvuQOePISkS1YiqNNLcSVKY2WJ5agzszR/rnFl6vvAF0=
=zROB
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--

--===============4825570497037666074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4825570497037666074==--
