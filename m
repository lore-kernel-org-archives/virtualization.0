From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 5/5] virtgpu: mark as a render gpu
Date: Thu, 10 Sep 2015 16:23:22 +0200
Message-ID: <1441895002.11233.6.camel@redhat.com>
References: <1441798946-26233-1-git-send-email-kraxel@redhat.com>
	<1441798946-26233-6-git-send-email-kraxel@redhat.com>
	<CACvgo53wYvAk_bVouPZ-F7wNm=Diyouue8m1AvO0=U+PvL61_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CACvgo53wYvAk_bVouPZ-F7wNm=Diyouue8m1AvO0=U+PvL61_Q@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: Dave Airlie <airlied@redhat.com>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open
	list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Do, 2015-09-10 at 09:59 +0100, Emil Velikov wrote:
> On 9 September 2015 at 12:42, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > From: Dave Airlie <airlied@redhat.com>
> >
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  drivers/gpu/drm/virtio/virtgpu_drv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> > index 1245d09..e00298e 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> > @@ -113,7 +113,7 @@ static const struct file_operations virtio_gpu_driver_fops = {
> >
> >
> >  static struct drm_driver driver = {
> > -       .driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_PRIME,
> > +       .driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_PRIME | DRIVER_RENDER,
> 
> I believe that this will only create the renderD# node. Shouldn't one
> also tag the relevant ioctls with DRM_RENDER_ALLOW ?

Dave?  Looking at the ioctls they are all fine for render nodes, there
isn't anything modesetting related in the device-specific ioctls.

Correct?

cheers,
  Gerd
