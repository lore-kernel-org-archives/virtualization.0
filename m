From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v4 00/19] Share TTM code among DRM framebuffer drivers
Date: Mon, 6 May 2019 17:23:20 +0200
Message-ID: <20190506152320.GJ17751__17580.3304927953$1557156269$gmane$org@phenom.ffwll.local>
References: <20190506082649.942-1-tzimmermann@suse.de>
	<20190506122233.76pya5kpdfgp4f25@sirius.home.kraxel.org>
	<fcb3efd9-64f2-ca35-e36e-83b7055f8055@suse.de>
	<20190506142034.kb3lfvw25xbkrkyq@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190506142034.kb3lfvw25xbkrkyq@sirius.home.kraxel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: noralf@tronnes.org, Thomas Zimmermann <tzimmermann@suse.de>, airlied@linux.ie, puck.chen@hisilicon.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, z.liuxinliang@hisilicon.com, hdegoede@redhat.com, kong.kongxinwei@hisilicon.com, ray.huang@amd.com, daniel@ffwll.ch, zourongrong@gmail.com, sam@ravnborg.org, christian.koenig@amd.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, May 06, 2019 at 04:20:34PM +0200, Gerd Hoffmann wrote:
> On Mon, May 06, 2019 at 03:09:20PM +0200, Thomas Zimmermann wrote:
> > Hi
> > =

> > Am 06.05.19 um 14:22 schrieb Gerd Hoffmann:
> > >> GEM VRAM could implement PRIME helpers, which would allow for using
> > >> the generic fbcon.
> > > =

> > > bochs_gem_prime_*() functions with this series applied look like you =
can
> > > just rename them & move over to vram helpers.
> > > =

> > > It's not a full prime implementation, specifically actual export/impo=
rt
> > > isn't there.  But pin+vmap (needed by generic fbcon) is implemented.
> > =

> > I did have a patch to do this, but then I read that prime requires DMA
> > for buffer sharing and bochs works only because it's emulated.
> =

> For actual buffer sharing with other drivers yes because dma-bufs
> typically are a bunch of pages (struct page**) and live in RAM.
> =

> Not sure whenever it is possible or useful to place the vram in
> ZONE_DEVICE to get page structs for it, then export buffers located
> in vram that way without copying them over to main memory.  I suspect
> most importers would fail to properly setup PCI-PCI dma in that case.

Christian K=F6nig is working on p2p dma-buf sharing. Not sure that's worth
it for virtual devices, but could be fun to wire up I guess.
-Daniel

> =

> > If bochs' implementation is complete enough to be useful for other
> > drivers, I'll add it to the patch set.
> =

> It's good enough for generic fbcon.
> =

> cheers,
>   Gerd
> =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
