From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 5/6] drm/virtio: drop fencing in
	virtio_gpu_resource_create_ioctl
Date: Fri, 1 Feb 2019 08:23:41 +0100
Message-ID: <20190201072341.nujqrkxbq3fg7djd__7678.11353305063$1549068713$gmane$org@sirius.home.kraxel.org>
References: <20190130094338.14203-1-kraxel@redhat.com>
	<20190130094338.14203-6-kraxel@redhat.com>
	<CAAfnVB=z36CtTsCiEy1uVTNvE9DVuSDKLNdMVFO+tBJqiQ7s1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAAfnVB=z36CtTsCiEy1uVTNvE9DVuSDKLNdMVFO+tBJqiQ7s1A@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 31, 2019 at 11:04:31AM -0800, Gurchetan Singh wrote:
> On Wed, Jan 30, 2019 at 1:43 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > There is no need to wait for completion here.
> >
> > The host will process commands in submit order, so commands can
> > reference the new resource just fine even when queued up before
> > completion.
> 
> Does virtio_gpu_execbuffer_ioctl also wait for completion for a host response?

No.

But you pass in a list of objects (drm_virtgpu_execbuffer->bo_handles)
used.  They will all get reserved, so you can use DRM_IOCTL_VIRTGPU_WAIT
on any of these objects to wait for completion.

Recently the driver got support for returning a fence fd for the
execbuffer, which you can also use to wait for completion in case your
kernel is new enough.

> From the guest driver perspective, a fence is just implemented has a
> virtio 3D resource.
> 
> https://gitlab.freedesktop.org/mesa/mesa/blob/master/src/gallium/winsys/virgl/drm/virgl_drm_winsys.c#L787
> 
> The DRM_IOCTL_VIRTGPU_WAIT ioctl essentially waits for the reservation
> objects associated with that fence resource to become available.  So
> the flow is:
> 
> virtio_gpu_execbuffer_ioctl
> virtio_gpu_resource_create_ioctl with fence resource
> virtio_gpu_wait_ioctl with that fence resource --> associated with a
> GL wait on the host side

Oh.  /me looks surprised.
Wasn't aware that userspace is doing *that*.

> Does this change modify this sequence of events?

Yes.  DRM_IOCTL_VIRTGPU_WAIT will not wait any more.  Guess I have to
scratch the patch then ...

cheers,
  Gerd
