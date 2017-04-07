From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: DRM_FORMAT_* byte order (was: Re: [PATCH] drm: virtio: fix
	virtio_gpu_cursor_formats)
Date: Fri, 07 Apr 2017 10:29:00 +0200
Message-ID: <1491553740.26308.26.camel__5332.16282860867$1491553753$gmane$org@redhat.com>
References: <20170405080915.823-1-lvivier@redhat.com>
	<20170405171125.GT30290@intel.com>
	<1491467383.12607.37.camel@redhat.com>
	<20170406172747.GB30290@intel.com> <20170406173514.GC30290@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170406173514.GC30290@intel.com>
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

> Hmm. Maybe it's still possible to salvage something by redefining the
> BIG_ENDIAN format bit to mean the "the other endianness". Ugly but it
> might still result in something usable.

Also at least for the virtual machine use case this doesn't buy us much.
The drm drivers (at least the ones used on both big and little endian
guests) support only 32 bpp + depth 24 formats.  And for these we don't
need a "other endian" flag because we have fourcc codes for all sorts of
byte orders (i.e. DRM_FORMAT_XRGB8888 little endian ==
DRM_FORMAT_BGRX8888 big endian).

The DRM_FORMAT_BIG_ENDIAN flags also seems not be used anywhere in the
code base (except in some format printing debug code ...).

cheers,
  Gerd
