From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: DRM_FORMAT_* byte order (was: Re: [PATCH] drm: virtio: fix
	virtio_gpu_cursor_formats)
Date: Thu, 6 Apr 2017 20:35:14 +0300
Message-ID: <20170406173514.GC30290__44786.0740394846$1491500173$gmane$org@intel.com>
References: <20170405080915.823-1-lvivier@redhat.com>
	<20170405171125.GT30290@intel.com>
	<1491467383.12607.37.camel@redhat.com>
	<20170406172747.GB30290@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170406172747.GB30290@intel.com>
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
Cc: Laurent Vivier <lvivier@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>, David Airlie <airlied@redhat.com>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 06, 2017 at 08:27:47PM +0300, Ville Syrj=E4l=E4 wrote:
> On Thu, Apr 06, 2017 at 10:29:43AM +0200, Gerd Hoffmann wrote:
> >   Hi,
> > =

> > > >  static const uint32_t virtio_gpu_cursor_formats[] =3D {
> > > > +#ifdef __BIG_ENDIAN
> > > > +	DRM_FORMAT_BGRA8888,
> > > > +#else
> > > >  	DRM_FORMAT_ARGB8888,
> > > > +#endif
> > > =

> > > DRM formats are supposed to be little endian, so this isn't really
> > > correct.
> > =

> > Well, maybe they where *intended* to be little endian at some point in
> > the past.  The actual code appears to interpret them as native endian
> > though.
> > =

> > Lets take a simple example, the bochs driver (qemu sdvga).  It supports
> > 32 bpp with depth 24 (DRM_FORMAT_XRGB8888) as the one and only
> > framebuffer format (see bochs_user_framebuffer_create).  We still had to
> > add a special register to the virtual hardware so the guest can signal
> > to the host whenever the framebuffer is big endian or little endian (see
> > bochs_hw_init), so both ppc64 and ppc64le guests work properly with the
> > qemu stdvga.
> > =

> > So, bigendian guests assume that DRM_FORMAT_XRGB8888 is big endian not
> > little endian.  And given that the fourcc codes are used in the
> > userspace/kernel API too (see DRM_IOCTL_MODE_ADDFB2) I think we can't
> > change that any more ...
> =

> Sigh. That makes mixed endian systems pretty much hopeless :(

Hmm. Maybe it's still possible to salvage something by redefining the
BIG_ENDIAN format bit to mean the "the other endianness". Ugly but it
might still result in something usable.

-- =

Ville Syrj=E4l=E4
Intel OTC
