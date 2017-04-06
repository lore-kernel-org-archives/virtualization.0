From: Gerd Hoffmann <kraxel@redhat.com>
Subject: DRM_FORMAT_* byte order (was: Re: [PATCH] drm: virtio: fix
	virtio_gpu_cursor_formats)
Date: Thu, 06 Apr 2017 10:29:43 +0200
Message-ID: <1491467383.12607.37.camel@redhat.com>
References: <20170405080915.823-1-lvivier@redhat.com>
	<20170405171125.GT30290@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170405171125.GT30290@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>, David Airlie <airlied@redhat.com>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> >  static const uint32_t virtio_gpu_cursor_formats[] = {
> > +#ifdef __BIG_ENDIAN
> > +	DRM_FORMAT_BGRA8888,
> > +#else
> >  	DRM_FORMAT_ARGB8888,
> > +#endif
> 
> DRM formats are supposed to be little endian, so this isn't really
> correct.

Well, maybe they where *intended* to be little endian at some point in
the past.  The actual code appears to interpret them as native endian
though.

Lets take a simple example, the bochs driver (qemu sdvga).  It supports
32 bpp with depth 24 (DRM_FORMAT_XRGB8888) as the one and only
framebuffer format (see bochs_user_framebuffer_create).  We still had to
add a special register to the virtual hardware so the guest can signal
to the host whenever the framebuffer is big endian or little endian (see
bochs_hw_init), so both ppc64 and ppc64le guests work properly with the
qemu stdvga.

So, bigendian guests assume that DRM_FORMAT_XRGB8888 is big endian not
little endian.  And given that the fourcc codes are used in the
userspace/kernel API too (see DRM_IOCTL_MODE_ADDFB2) I think we can't
change that any more ...

cheers,
  Gerd
