From: =?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>
Subject: Re: [patch 34/54] Staging: hv: remove STRUCT_PACKED and STRUCT_ALIGNED defines
Date: Sat, 25 Jul 2009 01:06:20 +0200
Message-ID: <20090724230619.GB13702@logfs.org>
References: <20090717180850.873962925@mini.kroah.org> <20090717180921.448023599@mini.kroah.org> <200907210146.41399.arnd@arndb.de> <20090724213218.GA13702@logfs.org> <20090724145025.12da5a6e@nehalam>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755176AbZGXXGh@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090724145025.12da5a6e@nehalam>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, virtualization@lists.osdl.org, Sam Ramji <sramji@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 24 July 2009 14:50:25 -0700, Stephen Hemminger wrote:
> On Fri, 24 Jul 2009 23:32:19 +0200
> J=C3=B6rn Engel <joern@logfs.org> wrote:
>=20
> > On Tue, 21 July 2009 01:46:41 +0200, Arnd Bergmann wrote:
> > >=20
> > > The data structure is actually packed already, the attribute does=
 not make it better
> > > and could be removed. We also have __packed as a shortcut for __a=
ttribute__((packed)).
> >=20
> > Honestly, I don't know how useful __packed really is.  In a shared
> > kernel/userspace header, it is only defined for the kernel.
>=20
> As I remember, gcc generates worse code for packed structures on many=
 architectures
> since it may have to do byte fetchs/recombining to avoid unaligned
> accesses.

I was talking about "__packed" vs. "__attribute__((packed))".  But yes,
avoiding packed structures where possible is a good idea.

J=C3=B6rn

--=20
"[One] doesn't need to know [...] how to cause a headache in order
to take an aspirin."
-- Scott Culp, Manager of the Microsoft Security Response Center, 2001
