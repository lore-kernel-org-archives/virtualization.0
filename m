From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 2/2] drm: virtio: fix virtio_gpu_mode_dumb_create
Date: Mon, 03 Apr 2017 11:02:15 +0200
Message-ID: <1491210135.17505.31.camel__3623.47346167571$1491210152$gmane$org@redhat.com>
References: <20170403070845.10793-1-kraxel@redhat.com>
	<20170403070845.10793-3-kraxel@redhat.com>
	<20170403075353.jqxrqshygfidn4f3@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170403075353.jqxrqshygfidn4f3@phenom.ffwll.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Vetter <daniel@ffwll.ch>
Cc: lvivier@redhat.com, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mo, 2017-04-03 at 09:53 +0200, Daniel Vetter wrote:
> On Mon, Apr 03, 2017 at 09:08:45AM +0200, Gerd Hoffmann wrote:
> > Lookup format using virtio_gpu_translate_format()
> > instead of hardcoding it.  Fixes xorg display on
> > bigendian guests (i.e. ppc64).
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> ow ... :(
> 
> With what kind of client have you tested this? fbdev? kms native?

text console (fbcon) is fine, xorg (modesetting driver) fails.

> Should we patch drm_fourcc.h and essentially state that _all_ drm_fourcc
> are in native endian, don't dare mixing things up?

Well, I don't think this needs clarification.  I never assumed that
fourcc is something else than native endian.  It really was just an
oversight in the virtio driver.

One code path (which creates the framebuffer for fbdev emulation) did
proper drm_fourcc -> virtio format mapping, including endianness
handling.  Patch 1/2 of this series factors this code out into a helper
function so we can easily reuse it.

The other code path (for creating dumb buffers) had the virtio format
hardcoded which happened to work correctly in the little endian case.

cheers,
  Gerd
