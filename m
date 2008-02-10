From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [kvm-devel] [PATCH] virtio_ring: make structure defines packed
Date: Sun, 10 Feb 2008 03:18:06 +0100
Message-ID: <200802100318.07877.arnd__30018.7557390474$1202613611$gmane$org@arndb.de>
References: <200802081401.21194.borntraeger@de.ibm.com>
	<47AE4A82.3030504@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47AE4A82.3030504@codemonkey.ws>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sunday 10 February 2008, you wrote:
> Christian Borntraeger wrote:
> > =A0struct vring_used
> > =A0{
> > =A0=A0=A0=A0=A0=A0__u16 flags;
> > =A0=A0=A0=A0=A0=A0__u16 idx;
> > +=A0=A0=A0=A0=A0__u32 padding;
> > =A0=A0=A0=A0=A0=A0struct vring_used_elem ring[];
> > -};
> > +} __attribute__ ((packed));
> > =A0=20
>=20
> This padding that you've put in is not something that would normally=20
> occur on x86. =A0I've checked with GCC on 32-bit and 64-bit and neither=
=20
> would include that padding. =A0Is that padding included on s390?

No, it is not included on any architecture that is supported by Linux.
The only tricky case to watch out is if vring_used_elem contained
a __u64 member. In that case, the alignment would be 32 bits on x86 and
64 bits on s390, powerpc, mips and parisc.

	Arnd <><
