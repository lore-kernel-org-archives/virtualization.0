From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH 2/5] drm/virtio: add uapi for in and out explicit fences
Date: Fri, 2 Nov 2018 13:34:07 +0000
Message-ID: <CACvgo50ARCHZckjxj-eoZbY6U4LA7O4iHQd6X4iQE-xu+Q5hRg__32649.164790246$1541165625$gmane$org@mail.gmail.com>
References: <20181025183739.9375-1-robert.foss@collabora.com>
	<20181025183739.9375-3-robert.foss@collabora.com>
	<CACvgo51LU3dAfO-jNcV02ZyYBOv8fKLhG_2QyRrB9XYfGJrzHQ@mail.gmail.com>
	<3a8a03d6-a544-b9f3-15a2-f6a2411bdb28@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <3a8a03d6-a544-b9f3-15a2-f6a2411bdb28@collabora.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Robert Foss <robert.foss@collabora.com>
Cc: Rob Herring <robh@kernel.org>, David Airlie <airlied@linux.ie>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Gustavo Padovan <gustavo.padovan@collabora.com>, Emil Velikov <emil.velikov@collabora.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 1 Nov 2018 at 12:56, Robert Foss <robert.foss@collabora.com> wrote:
> On 2018-10-31 10:38, Emil Velikov wrote:
> > Hi Rob,
> >
> > On Thu, 25 Oct 2018 at 19:38, Robert Foss <robert.foss@collabora.com> wrote:
> >>
> >> Add a new field called fence_fd that will be used by userspace to send
> >> in-fences to the kernel and receive out-fences created by the kernel.
> >>
> >> This uapi enables virtio to take advantage of explicit synchronization of
> >> dma-bufs.
> >>
> >> There are two new flags:
> >>
> >> * VIRTGPU_EXECBUF_FENCE_FD_IN to be used when passing an in-fence fd.
> >> * VIRTGPU_EXECBUF_FENCE_FD_OUT to be used when requesting an out-fence fd
> >>
> >> The execbuffer IOCTL is now read-write to allow the userspace to read the
> >> out-fence.
> >>
> >> On error -1 should be returned in the fence_fd field.
> >>
> >> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
> >> Signed-off-by: Robert Foss <robert.foss@collabora.com>
> >> ---
> >> Changes since v2:
> >>   - Since exbuf-flags is a new flag, check that unsupported
> >>     flags aren't set.
> >>
> >>   drivers/gpu/drm/virtio/virtgpu_ioctl.c |  5 +++++
> >>   include/uapi/drm/virtgpu_drm.h         | 13 ++++++++++---
> >>   2 files changed, 15 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> >> index d01a9ed100d1..1af289b28fc4 100644
> >> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> >> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> >> @@ -116,9 +116,14 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
> >>          struct ww_acquire_ctx ticket;
> >>          void *buf;
> >>
> >> +       exbuf->fence_fd = -1;
> >> +
> > Move this after the sanity checking.
>
> Agreed. Fixed in v4
>
> >
> >>          if (vgdev->has_virgl_3d == false)
> >>                  return -ENOSYS;
> >>
> >> +       if ((exbuf->flags & ~VIRTGPU_EXECBUF_FLAGS))
> >> +               return -EINVAL;
> >> +
> > I assume this did this trigger when using old userspace?
>
> No, not as far as I'm aware. This check is there to prevent userspace from
> polluting the bitspace of flag, so that all free bits can be used for new flags.
>
> As far as I understand this is pointed out by a drm driver development document
> written by danvet, which I unfortunately can't seem to find the link for at the
> moment.
>
Yes that is correct. What I was asking is:

Does a kernel with this patch, work with mesa lacking the corresponding updates?
I'd imagine things work just fine.

-Emil
