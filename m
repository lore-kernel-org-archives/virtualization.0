From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: DRM_FORMAT_* byte order (was: Re: [PATCH] drm: virtio: fix
	virtio_gpu_cursor_formats)
Date: Fri, 7 Apr 2017 11:45:02 +0300
Message-ID: <20170407084502.GE30290@intel.com>
References: <20170405080915.823-1-lvivier@redhat.com>
	<20170405171125.GT30290@intel.com>
	<1491467383.12607.37.camel@redhat.com>
	<20170406172747.GB30290@intel.com>
	<20170406173514.GC30290@intel.com>
	<1491553740.26308.26.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1491553740.26308.26.camel@redhat.com>
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

On Fri, Apr 07, 2017 at 10:29:00AM +0200, Gerd Hoffmann wrote:
>   Hi,
> =

> > Hmm. Maybe it's still possible to salvage something by redefining the
> > BIG_ENDIAN format bit to mean the "the other endianness". Ugly but it
> > might still result in something usable.
> =

> Also at least for the virtual machine use case this doesn't buy us much.
> The drm drivers (at least the ones used on both big and little endian
> guests) support only 32 bpp + depth 24 formats.  And for these we don't
> need a "other endian" flag because we have fourcc codes for all sorts of
> byte orders (i.e. DRM_FORMAT_XRGB8888 little endian =3D=3D
> DRM_FORMAT_BGRX8888 big endian).

Yeah, those could be handled without the flag. But when mixed with any
other format the code would look a bit weird IMO. So my idea with the
flag was that if you display is big endian you always have the flag, and
then you don't have to think so much which way the bytes go for each
format. Less special casing is good IMO.

> =

> The DRM_FORMAT_BIG_ENDIAN flags also seems not be used anywhere in the
> code base (except in some format printing debug code ...).

That's because either no one has big endian display hardware or they
do but just didn't read the docs and cargo culted the format handling
from some driver for little endian display.

-- =

Ville Syrj=E4l=E4
Intel OTC
