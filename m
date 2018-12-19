From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/bochs: add edid present check
Date: Wed, 19 Dec 2018 16:21:29 +0100
Message-ID: <20181219152129.k7v4ttpsazguswke__26799.3088499226$1545232771$gmane$org@sirius.home.kraxel.org>
References: <20181218073339.12160-1-kraxel@redhat.com>
	<93d72578-9567-9694-dbc7-62618b217f8f@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <93d72578-9567-9694-dbc7-62618b217f8f@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> You could probably have a comment here explaining the magic below
> (just like in the commit message to ease the task of understanding
> while reading the code why 2 of 8 bytes of the EDID header is checked
> and why it is all needed). Of course one can use git blame... Up to you

Makes sense.

> > +	if (readb(bochs->mmio + 0) !=3D 0x00 ||
> > +	    readb(bochs->mmio + 1) !=3D 0xff)
> =

> bochs->mmio is defined as "void __iomem=A0=A0 *mmio;". Can we please avoid
> void pointer arithmetic here?

Why is that a problem?  gcc uses bytes when doing pointer arithmetic
with void pointers (even though it is undefined in the C standard),
and as far I know the linux kernel depends on that behavior anyway.

Also the driver already does it everywhere.

cheers,
  Gerd
