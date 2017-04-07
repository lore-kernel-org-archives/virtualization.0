From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: DRM_FORMAT_* byte order (was: Re: [PATCH] drm: virtio: fix
	virtio_gpu_cursor_formats)
Date: Fri, 7 Apr 2017 15:49:54 +0300
Message-ID: <20170407124954.GF30290__37751.6383691274$1491569427$gmane$org@intel.com>
References: <20170405080915.823-1-lvivier@redhat.com>
	<20170405171125.GT30290@intel.com>
	<1491467383.12607.37.camel@redhat.com>
	<20170406172747.GB30290@intel.com>
	<20170406173514.GC30290@intel.com>
	<1491553740.26308.26.camel@redhat.com>
	<20170407084502.GE30290@intel.com>
	<1491559586.26308.39.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1491559586.26308.39.camel@redhat.com>
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

On Fri, Apr 07, 2017 at 12:06:26PM +0200, Gerd Hoffmann wrote:
> On Fr, 2017-04-07 at 11:45 +0300, Ville Syrj=E4l=E4 wrote:
> > On Fri, Apr 07, 2017 at 10:29:00AM +0200, Gerd Hoffmann wrote:
> > >   Hi,
> > > =

> > > > Hmm. Maybe it's still possible to salvage something by redefining t=
he
> > > > BIG_ENDIAN format bit to mean the "the other endianness". Ugly but =
it
> > > > might still result in something usable.
> > > =

> > > Also at least for the virtual machine use case this doesn't buy us mu=
ch.
> > > The drm drivers (at least the ones used on both big and little endian
> > > guests) support only 32 bpp + depth 24 formats.  And for these we don=
't
> > > need a "other endian" flag because we have fourcc codes for all sorts=
 of
> > > byte orders (i.e. DRM_FORMAT_XRGB8888 little endian =3D=3D
> > > DRM_FORMAT_BGRX8888 big endian).
> > =

> > Yeah, those could be handled without the flag. But when mixed with any
> > other format the code would look a bit weird IMO.
> =

> Well, there is a reason only the 32bpp formats are supported.  With
> those you just adjust your color shifts and you are done.  No need to
> actually byte-swap.  In contrast handling 16bpp formats (5:6:5 or 5:5:5)
> with the non-native byte order is a PITA.

Yes, which is why I wanted to make the format endianness explicit from
the start so that you wouldn't have to guess whether you need to byte
swap or not.

> =

> The other reason of course is that this is the default format these
> days.
> =

> So, do any "other formats" exist where the byteswapped variant is used
> in practice?

I'm expecting people to move past 8bpc at some point. It's definitely
not enough for HDR stuff and whatnot. Even video content is already
moving to 10bpc.

So I think the question is better phrased as do mixed endian systems
exist? Or even if they do, does anyone care about them?

Also if someone goes and changes the DRM_FORMATs to follow host
endianness, they definitely have to figure out how to handle all
the YCbCr formats as well.

> Or can we just drop DRM_FORMAT_BIG_ENDIAN?
> =

> > So my idea with the
> > flag was that if you display is big endian you always have the flag, and
> > then you don't have to think so much which way the bytes go for each
> > format. Less special casing is good IMO.
> =

> Having two valid fourcc (DRM_FORMAT_XRGB8888 + (DRM_FORMAT_BGRX8888 |
> DRM_FORMAT_BIG_ENDIAN)) for the same format is confusing IMO.  And I
> doubt that it'll be properly implemented everywhere.

I think it would be if people actually handled any of the other formats.
It's a real shame these 8:8:8:8 formats were invented in the first place.
They allow people to be overly lazy and ignore endianness issues until
it's too late to fix things.

-- =

Ville Syrj=E4l=E4
Intel OTC
