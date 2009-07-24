From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [patch 34/54] Staging: hv: remove STRUCT_PACKED and
 STRUCT_ALIGNED defines
Date: Fri, 24 Jul 2009 14:50:25 -0700
Message-ID: <20090724145025.12da5a6e@nehalam>
References: <20090717180850.873962925@mini.kroah.org>
	<20090717180921.448023599@mini.kroah.org>
	<200907210146.41399.arnd@arndb.de>
	<20090724213218.GA13702@logfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754751AbZGXVwA@vger.kernel.org>
In-Reply-To: <20090724213218.GA13702@logfs.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?SsO2cm4=?= Engel <joern@logfs.org>
Cc: Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, virtualization@lists.osdl.org, Sam Ramji <sramji@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 24 Jul 2009 23:32:19 +0200
J=C3=B6rn Engel <joern@logfs.org> wrote:

> On Tue, 21 July 2009 01:46:41 +0200, Arnd Bergmann wrote:
> > On Friday 17 July 2009, Greg Kroah-Hartman wrote:
> > > @@ -43,7 +43,7 @@ typedef struct _RING_BUFFER {
> > >         // volatile u32 InterruptMask;
> > >         // Ring data starts here + RingDataStartOffset !!! DO NOT=
 place any fields below this !!!
> > >      u8         Buffer[0];
> > > -} STRUCT_PACKED RING_BUFFER;
> > > +} __attribute__((packed)) RING_BUFFER;
> > > =20
> >=20
> > The data structure is actually packed already, the attribute does n=
ot make it better
> > and could be removed. We also have __packed as a shortcut for __att=
ribute__((packed)).
>=20
> Honestly, I don't know how useful __packed really is.  In a shared
> kernel/userspace header, it is only defined for the kernel.
>=20

As I remember, gcc generates worse code for packed structures on many a=
rchitectures
since it may have to do byte fetchs/recombining to avoid unaligned
accesses.

--=20
