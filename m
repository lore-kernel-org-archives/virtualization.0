From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH 00/23] drm: Eliminate plane->fb/crtc usage for atomic
	drivers
Date: Thu, 22 Mar 2018 20:49:12 +0200
Message-ID: <20180322184912.GM5453__39584.0698773556$1521744445$gmane$org@intel.com>
References: <20180322152313.6561-1-ville.syrjala@linux.intel.com>
	<b92fe986-295c-fecb-dca1-82cb9bf7b7b1@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <b92fe986-295c-fecb-dca1-82cb9bf7b7b1@tronnes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Thomas Hellstrom <thellstrom@vmware.com>, amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx@lists.freedesktop.org, Seung-Woo Kim <sw0312.kim@samsung.com>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Kyungmin Park <kyungmin.park@samsung.com>, VMware Graphics <linux-graphics-maintainer@vmware.com>, linux-arm-msm@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>, Shawn Guo <shawnguo@kernel.org>, freedreno@lists.freedesktop.org, Vincent Abriou <vincent.abriou@st.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 22, 2018 at 05:51:35PM +0100, Noralf Tr=F8nnes wrote:
> tinydrm is also using plane->fb:
> =

> $ grep -r "plane\.fb" drivers/gpu/drm/tinydrm/
> drivers/gpu/drm/tinydrm/repaper.c:=A0=A0=A0=A0=A0 if (tdev->pipe.plane.fb=
 !=3D fb)
> drivers/gpu/drm/tinydrm/mipi-dbi.c:=A0=A0=A0=A0 if (tdev->pipe.plane.fb !=
=3D fb)
> drivers/gpu/drm/tinydrm/mipi-dbi.c:=A0=A0=A0=A0 struct drm_framebuffer *f=
b =3D =

> mipi->tinydrm.pipe.plane.fb;

Oh dear, and naturally it's the most annoying one of the bunch. So we
want to take the plane lock in the fb.dirty() hook to look at the fb,
but mipi-dbi.c calls that directly from the bowels of its
.atomic_enable() hook. So that would deadlock pretty neatly if the
commit happens while already holding the lock.

So we'd either need to plumb an acquire context into fb.dirty(),
or maybe have tinydrm provide a lower level lockless dirty() hook
that gets called by both (there are just too many layers in this
particular cake to immediately see where such a hook would be best
placed). Or maybe there's some other solution I didn't think of.

Looking at this I'm also left wondering how this is supposed
handle fb.dirty() getting called concurrently with a modeset.
The dirty_mutex only seems to offer any protection for
fb.dirty() against another fb.dirty()...

-- =

Ville Syrj=E4l=E4
Intel OTC
