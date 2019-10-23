From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/virtio: print a single line with device features
Date: Wed, 23 Oct 2019 15:34:27 +0200
Message-ID: <CAKMK7uGm7gYQoEyoZDYYzGO6OBw6AdEwHRDOPDtvNOm-ijWJMQ__16961.8216854118$1571837693$gmane$org@mail.gmail.com>
References: <20191018113832.5460-1-kraxel@redhat.com>
	<20191022090533.GB11828@phenom.ffwll.local>
	<87mudreh2p.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87mudreh2p.fsf@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: David Airlie <airlied@linux.ie>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, dri-devel <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Oct 23, 2019 at 3:18 PM Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
> On Tue, 22 Oct 2019, Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Fri, Oct 18, 2019 at 01:38:32PM +0200, Gerd Hoffmann wrote:
> >> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> >> ---
> >>  drivers/gpu/drm/virtio/virtgpu_kms.c | 9 ++++-----
> >>  1 file changed, 4 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
> >> index 0b3cdb0d83b0..2f5773e43557 100644
> >> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> >> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> >> @@ -155,16 +155,15 @@ int virtio_gpu_init(struct drm_device *dev)
> >>  #ifdef __LITTLE_ENDIAN
> >>      if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_VIRGL))
> >>              vgdev->has_virgl_3d = true;
> >> -    DRM_INFO("virgl 3d acceleration %s\n",
> >> -             vgdev->has_virgl_3d ? "enabled" : "not supported by host");
> >> -#else
> >> -    DRM_INFO("virgl 3d acceleration not supported by guest\n");
> >>  #endif
> >>      if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_EDID)) {
> >>              vgdev->has_edid = true;
> >> -            DRM_INFO("EDID support available.\n");
> >>      }
> >>
> >> +    DRM_INFO("features: %cvirgl %cedid\n",
> >> +             vgdev->has_virgl_3d ? '+' : '-',
> >> +             vgdev->has_edid     ? '+' : '-');
> >
> > Maybe we should move the various yesno/onoff/enableddisabled helpers from
> > i915_utils.h to drm_utils.h and use them more widely?
>
> I'm trying to take it one step further by adding them to
> include/linux/string-choice.h [1]. Maybe, uh, fourth time's the charm?
>
> BR,
> Jani.
>
> [1] http://lore.kernel.org/r/20191023131308.9420-1-jani.nikula@intel.com

Oh nice, r-b: me on that.

I think the rule for new headers like this is "just do it" once you
have enough senior kernel maintainers' approval. Maybe ask Dave Airlie
for ack and with Greg's r-b then just stuff it into drm-misc-next or
so?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
