From: =?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>
Subject: Re: [patch 34/54] Staging: hv: remove STRUCT_PACKED and STRUCT_ALIGNED defines
Date: Fri, 24 Jul 2009 23:32:19 +0200
Message-ID: <20090724213218.GA13702@logfs.org>
References: <20090717180850.873962925@mini.kroah.org> <20090717180921.448023599@mini.kroah.org> <200907210146.41399.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754715AbZGXVcf@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200907210146.41399.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: virtualization@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, virtualization@lists.osdl.org, Sam Ramji <sramji@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>, shemminger@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 21 July 2009 01:46:41 +0200, Arnd Bergmann wrote:
> On Friday 17 July 2009, Greg Kroah-Hartman wrote:
> > @@ -43,7 +43,7 @@ typedef struct _RING_BUFFER {
> >         // volatile u32 InterruptMask;
> >         // Ring data starts here + RingDataStartOffset !!! DO NOT p=
lace any fields below this !!!
> >      u8         Buffer[0];
> > -} STRUCT_PACKED RING_BUFFER;
> > +} __attribute__((packed)) RING_BUFFER;
> > =20
>=20
> The data structure is actually packed already, the attribute does not=
 make it better
> and could be removed. We also have __packed as a shortcut for __attri=
bute__((packed)).

Honestly, I don't know how useful __packed really is.  In a shared
kernel/userspace header, it is only defined for the kernel.

J=C3=B6rn

--=20
Do not stop an army on its way home.
-- Sun Tzu
