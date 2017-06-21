From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC] virtio-mem: paravirtualized memory
Date: Wed, 21 Jun 2017 12:08:17 +0100
Message-ID: <20170621110817.GF16183__2749.25313792682$1498043304$gmane$org@stefanha-x1.localdomain>
References: <547865a9-d6c2-7140-47e2-5af01e7d761d@redhat.com>
	<20170619100813.GB17304@stefanha-x1.localdomain>
	<4cec825b-d92e-832e-3a76-103767032528@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5262756952581844332=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4cec825b-d92e-832e-3a76-103767032528@redhat.com>
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


--===============5262756952581844332==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Il7n/DHsA0sMLmDu"
Content-Disposition: inline


--Il7n/DHsA0sMLmDu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 19, 2017 at 12:26:52PM +0200, David Hildenbrand wrote:
> On 19.06.2017 12:08, Stefan Hajnoczi wrote:
> > On Fri, Jun 16, 2017 at 04:20:02PM +0200, David Hildenbrand wrote:
> >> Important restrictions of this concept:
> >> - Guests without a virtio-mem guest driver can't see that memory.
> >> - We will always require some boot memory that cannot get unplugged.
> >>   Also, virtio-mem memory (as all other hotplugged memory) cannot beco=
me
> >>   DMA memory under Linux. So the boot memory also defines the amount of
> >>   DMA memory.
> >=20
> > I didn't know that hotplug memory cannot become DMA memory.
> >=20
> > Ouch.  Zero-copy disk I/O with O_DIRECT and network I/O with virtio-net
> > won't be possible.
> >=20
> > When running an application that uses O_DIRECT file I/O this probably
> > means we now have 2 copies of pages in memory: 1. in the application and
> > 2. in the kernel page cache.
> >=20
> > So this increases pressure on the page cache and reduces performance :(.
> >=20
> > Stefan
> >=20
>=20
> arch/x86/mm/init_64.c:
>=20
> /*
>  * Memory is added always to NORMAL zone. This means you will never get
>  * additional DMA/DMA32 memory.
>  */
> int arch_add_memory(int nid, u64 start, u64 size, bool for_device)
> {
>=20
> The is for sure something to work on in the future. Until then, base
> memory of 3.X GB should be sufficient, right?

I'm not sure that helps because applications typically don't control
where their buffers are located?

Stefan

--Il7n/DHsA0sMLmDu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZSlOhAAoJEJykq7OBq3PIvj8IAIYB7fWhiMFR7qGpHgnD6tM3
6RMqMgAoTe7NBIeh3tFbsGjp/XjzeCT7iiEhbrO7MtFrP7IxXylQFRmzBMNb6WlU
EyhwQ4Ajyj3TP8Rey+xApJe8ZQkieWHq8ovTI/ozXXMJ+9k/XwiwVaXzPkThy1v2
Ne6vfF/nONpRi55kOst8zGw6MzmAHK3hnoIR9KAqWXfm6jrw71m3NyL/1K9n/QH9
YnUi6WC98xgk9CJlCnuUR6am2sr5Xly+lN9jrKQ8DJZn3KjjcvwTJTNEYrJpK2gh
CZ+UGkmWbdWftyIB0uHnJAtyO+eDobaldJ6gD89T7ysDpuh8CdpPGpKEyzxP40w=
=SMQf
-----END PGP SIGNATURE-----

--Il7n/DHsA0sMLmDu--

--===============5262756952581844332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5262756952581844332==--
