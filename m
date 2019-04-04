From: David Airlie <airlied@redhat.com>
Subject: Re: [PATCH] drm/cirrus: rewrite and modernize driver.
Date: Thu, 4 Apr 2019 12:58:09 +1000
Message-ID: <CAMwc25o=DZSVE5Qf5mow6es06Gk3=+6+8offXPY-JPgUkG_Shw__8000.96431500919$1555717752$gmane$org@mail.gmail.com>
References: <20190403072318.31507-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190403072318.31507-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 3, 2019 at 5:23 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Time to kill some bad sample code people are copying from ;)
>
> This is a complete rewrite of the cirrus driver.  The cirrus_mode_set()
> function is pretty much the only function which is carried over largely
> unmodified.  Everything else is upside down.
>
> It is a single monster patch.  But given that it does some pretty
> fundamental changes to the drivers workflow and also reduces the code
> size by roughly 70% I think it'll still be alot easier to review than a
> longish baby-step patch series.
>
> Changes summary:
>  - Given the small amout of video memory (4 MB) the cirrus device has
>    the rewritten driver doesn't try to manage buffers there.  Instead
>    it will blit (memcpy) the active framebuffer to video memory.

Does it get any slower, with TTM I just wrote it to migrate just the
frontbuffer in/out of VRAM on modeset, won't we end up with more
copies now?

>  - All gem objects are stored in main memory and are manged using the
>    new shmem helpers.  ttm is out.
>  - Only DRM_FORMAT_RGB565 (depth 16) is supported.  The old driver does
>    that too by default.  There was a module parameter which enables 24/32
>    bpp support and disables higher resolutions (due to cirrus hardware
>    constrains).  That parameter wasn't reimplemented.
This might be the big sticking point, this is a userspace regression
for a feature that was explicitly added a few years ago, can we really
get away without it?

The rest looks good though!
Dave.

>  - The simple display pipeline is used.
>  - The generic fbdev emulation is used.
>  - It's a atomic driver now.
>
