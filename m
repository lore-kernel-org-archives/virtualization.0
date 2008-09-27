From: Javier Guerra Giraldez <javier@guerrag.com>
Subject: Re: [PATCH 0/6 v3] PCI: Linux kernel SR-IOV support
Date: Sat, 27 Sep 2008 13:07:57 -0500
Message-ID: <200809271308.03547.javier__3137.92258170924$1222701475$gmane$org@guerrag.com>
References: <D8078B8B3B09934AA9F8F2D5FB3F28CE088751B5EF@pdsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5948159367662291317=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <D8078B8B3B09934AA9F8F2D5FB3F28CE088751B5EF@pdsmsx502.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Zhao, Yu" <yu.zhao@intel.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Grant Grundler <grundler@parisc-linux.org>, Alex Chiang <achiang@hp.com>, Matthew Wilcox <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Roland Dreier <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Greg KH <greg@kroah.com>
List-Id: virtualization@lists.linuxfoundation.org

--===============5948159367662291317==
Content-Type: multipart/signed;
  boundary="nextPart407519406.Zl8rDPkWmg";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart407519406.Zl8rDPkWmg
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 27 September 2008, Zhao, Yu wrote:
> Greetings,
>
> Following patches are intended to support SR-IOV capability in the Linux
> kernel. With these patches, people can turn a PCI device with the
> capability into multiple ones from software perspective, which can benefit
> KVM and achieve other purposes such as QoS, security, etc.

sounds great, i think some Infiniband HBAs have this capability; they even=
=20
suggested using on Xen for faster (no hypervisor intervention) communicatio=
n=20
between DomU's on the same box. (and transparently to out of the box, of=20
course)

does it need an IOMMU (VT-d), or the whole magic is done by the PCI device?

=2D-=20
Javier

--nextPart407519406.Zl8rDPkWmg
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBI3naDsIoGnxsRK/ERAkVHAJ9tbeSSfMU0bH4M9t0HkpwypJD0wACdHDkx
gAPBfS5TDfIR3MWW5SNQ7RE=
=leKK
-----END PGP SIGNATURE-----

--nextPart407519406.Zl8rDPkWmg--

--===============5948159367662291317==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============5948159367662291317==--
