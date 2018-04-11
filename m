From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [virtio-dev] Re: [RFC] vhost: introduce mdev based hardware
	vhost backend
Date: Wed, 11 Apr 2018 10:01:50 +0800
Message-ID: <20180411020150.GE28698__47571.7907575474$1523412017$gmane$org@stefanha-x1.localdomain>
References: <20180402152330.4158-1-tiwei.bie@intel.com>
	<622f4bd7-1249-5545-dc5a-5a92b64f5c26@redhat.com>
	<20180410045723.rftsb7l4l3ip2ioi@debian>
	<7ee31a12-a370-fc43-82a6-2235f598e970@redhat.com>
	<D0158A423229094DA7ABF71CF2FA0DA34E9222F4@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7359400558970240325=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <D0158A423229094DA7ABF71CF2FA0DA34E9222F4@SHSMSX104.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Liang, Cunming" <cunming.liang@intel.com>
Cc: "Duyck, Alexander H" <alexander.h.duyck@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "Wang,
	Xiao W" <xiao.w.wang@intel.com>, "ddutile@redhat.com" <ddutile@redhat.com>, "Tan,
	Jianfeng" <jianfeng.tan@intel.com>, "Wang,
	Zhihong" <zhihong.wang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============7359400558970240325==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="so9zsI5B81VjUb/o"
Content-Disposition: inline


--so9zsI5B81VjUb/o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 10, 2018 at 09:23:53AM +0000, Liang, Cunming wrote:
> If QEMU is going to build a user space driver framework there, we're open mind on that, even leveraging DPDK as the underlay library. Looking forward to more others' comments from community.

There is already an NVMe VFIO driver in QEMU (see block/nvme.c).  So in
principle there's no reason against userspace drivers in QEMU.

Stefan

--so9zsI5B81VjUb/o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJazWyOAAoJEJykq7OBq3PIDxYH/3SjcypJKNjR0hMj21VW4REg
7F6RjwFFlXz5fjIdUTi3sW80T3eWF26MbWBttl1A6XwrWQPrx50iG9xhblCNwLtu
KY8vkQVK89LYwpM1vQn3LH7liEWexUIvq+dksxDts+7XE52qXxJ3hhzhb29ajTFf
aWh4HdJXZyh3243o8tyvUELsSQ/P5mxy6HHt2pggoPViO3ttfjYC/fnkd2Q11tZn
JxPIkqC4OkJW3EBva5V2/dCu0hWC8Gcj69Hda6eMrev4FzkHpFDROrb3CqtWKDEw
ngHk+06CpZF77C73b8OKf8/+yWUXwXc38OVjoX6B3FS/x7a+mW2DZNb/m8NRDXg=
=ueJP
-----END PGP SIGNATURE-----

--so9zsI5B81VjUb/o--

--===============7359400558970240325==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7359400558970240325==--
