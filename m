From: "Kraska, Joe A \(US SSA\)" <joe.kraska@baesystems.com>
Subject: RE: Virtualization + CPU w/crypto acceleration
	instructions
Date: Mon, 12 Mar 2007 12:50:52 -0700
Message-ID: <09D59AEF0405D740BDCA2FAC0E0EA97601B3D360@blums0008.sd.gd.com>
References: <62b0912f0703121235l2001eaadra87e9022a8a8c0db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <xen-users-bounces@lists.xensource.com>
content-class: urn:content-classes:message
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-users>,
	<mailto:xen-users-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-users@lists.xensource.com>
List-Help: <mailto:xen-users-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-users>,
	<mailto:xen-users-request@lists.xensource.com?subject=subscribe>
Sender: xen-users-bounces@lists.xensource.com
Errors-To: xen-users-bounces@lists.xensource.com
To: Molle Bestefich <molle.bestefich@gmail.com>, xen-users@lists.xensource.com, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org


This seems more like a developer question. You might try the xen-devel
list. Anyway, I believe that all hardware instructions on any x86 cpu
are supposed to be executable by arbitrary assembly. Those that cannot
be properly kernel trapped may experience performance loss, but I
think that's SUPPOSED to be the only limitation.

Would be nice if someone with exact knowledge chipped in, of course.

Joe.

> -----Original Message-----
> From: xen-users-bounces@lists.xensource.com [mailto:xen-users-
> bounces@lists.xensource.com] On Behalf Of Molle Bestefich
> Sent: Monday, March 12, 2007 12:36 PM
> To: xen-users@lists.xensource.com; virtualization@lists.osdl.org
> Subject: [Xen-users] Virtualization + CPU w/crypto acceleration
instructions
>=20
> In a virtualized environment running Xen or VMware, can the guest
> operating systems utilize hardware crypto acceleration such as the
> "PadLock" AES acceleration built into VIA CPUs?
>=20
> (Wasn't able to find this info in any of ~400 Google hits, so I'm
> shooting it out a bit to let as many as possible benefit from the
> answer.)
>=20
> _______________________________________________
> Xen-users mailing list
> Xen-users@lists.xensource.com
> http://lists.xensource.com/xen-users
