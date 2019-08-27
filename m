From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2] drm/virtio: add plane check
Date: Tue, 27 Aug 2019 07:21:54 +0200
Message-ID: <20190827052154.etk4jbx45hsrl7z5__11138.2473188982$1566883328$gmane$org@sirius.home.kraxel.org>
References: <20190822094657.27483-1-kraxel@redhat.com>
	<CAPaKu7S_He9RYsxDi0Qco4u=Xnc3FjB5nvFT_Zh+o7pvFzCvRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAPaKu7S_He9RYsxDi0Qco4u=Xnc3FjB5nvFT_Zh+o7pvFzCvRQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chia-I Wu <olvaffe@gmail.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 26, 2019 at 03:34:56PM -0700, Chia-I Wu wrote:
> On Thu, Aug 22, 2019 at 2:47 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > Use drm_atomic_helper_check_plane_state()
> > to sanity check the plane state.
> >
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  drivers/gpu/drm/virtio/virtgpu_plane.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
> > index a492ac3f4a7e..fe5efb2de90d 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> > @@ -84,7 +84,22 @@ static const struct drm_plane_funcs virtio_gpu_plane_funcs = {
> >  static int virtio_gpu_plane_atomic_check(struct drm_plane *plane,
> >                                          struct drm_plane_state *state)
> >  {
> > -       return 0;
> > +       bool is_cursor = plane->type == DRM_PLANE_TYPE_CURSOR;
> > +       struct drm_crtc_state *crtc_state;
> > +       int ret;
> > +
> > +       if (!state->fb || !state->crtc)
> > +               return 0;
> > +
> > +       crtc_state = drm_atomic_get_crtc_state(state->state, state->crtc);
> > +       if (IS_ERR(crtc_state))
> > +                return PTR_ERR(crtc_state);
> Is drm_atomic_get_new_crtc_state better here?

We don't have to worry about old/new state here.  The drm_plane_state we
get passed is the state we should check in this callback (and I think
this always is the new state).

cheers,
  Gerd
