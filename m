From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: DRM_FORMAT_* byte order (was: Re: [PATCH] drm: virtio: fix
	virtio_gpu_cursor_formats)
Date: Fri, 07 Apr 2017 10:13:09 +0200
Message-ID: <1491552789.26308.15.camel__46313.4149941199$1491552799$gmane$org@redhat.com>
References: <20170405080915.823-1-lvivier@redhat.com>
	<20170405171125.GT30290@intel.com>
	<1491467383.12607.37.camel@redhat.com>
	<20170406172747.GB30290@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>, David Airlie <airlied@redhat.com>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> > So, bigendian guests assume that DRM_FORMAT_XRGB8888 is big endian not
> > little endian.  And given that the fourcc codes are used in the
> > userspace/kernel API too (see DRM_IOCTL_MODE_ADDFB2) I think we can't
> > change that any more ...
> 
> Sigh. That makes mixed endian systems pretty much hopeless :(

At least you can't use the DRM_FORMAT_* (alone) to specify the format.
Still manageable, we have to do that to handle ppc64 and ppc64le ;)

> It's also doubly disappointing because eg. the more standardized YUV
> formats are definitely little endian as far the official fourccs are
> concerned. So if we now make everything follow the host endianness
> these things become a huge mess for anyone wanting to do video
> playback etc.

That one is up for discussion.  Guess I should brew a initial patch to
kickstart it.  At least in bigendian virtual machines (bochs and virtio
drivers) the YUV formats are not supported at all.  Dunno how things
look elsewhere.

> Oh well, at least I tried to make it sane from the start. I'll just
> go back to my blissful little endian world now.

ppc64le springing into live pretty much proves that little endian is
pretty close to reach world domination.  So maybe all our endian
troubles will be solved that way some day.

cheers,
  Gerd
