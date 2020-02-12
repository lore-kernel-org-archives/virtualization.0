From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v4] drm/virtio: add drm_driver.release callback.
Date: Wed, 12 Feb 2020 10:35:43 +0100
Message-ID: <20200212093543.qg4j2nk5wxlii7wr@sirius.home.kraxel.org>
References: <20200211135805.24436-1-kraxel@redhat.com>
 <20200211142711.GE2363188@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200211142711.GE2363188@phenom.ffwll.local>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, olvaffe@gmail.com, gurchetansingh@chromium.org, David Airlie <airlied@linux.ie>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 11, 2020 at 03:27:11PM +0100, Daniel Vetter wrote:
> On Tue, Feb 11, 2020 at 02:58:04PM +0100, Gerd Hoffmann wrote:
> > Split virtio_gpu_deinit(), move the drm shutdown and release to
> > virtio_gpu_release().  Drop vqs_ready variable, instead use
> > drm_dev_{enter,exit,unplug} to avoid touching hardware after
> > device removal.  Tidy up here and there.
> > 
> > v4: add changelog.
> > v3: use drm_dev_*().
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> Looks reasonable I think.
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> I didn't review whether you need more drm_dev_enter/exit pairs, virtio is
> a bit more complex for that and I have no idea how exactly it works.

virtio uses two rings to send commands to the device, one to move the
cursor and one for everything else.  So pretty much everything ends up
calling either this ...

> > @@ -330,7 +330,14 @@ static void virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,

... or this ...

> > @@ -460,12 +460,13 @@ static void virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,

... to submit some request to the (virtual) hardware.  Therefore we
don't need many drm_dev_enter/exit pairs to cover everything ;)

cheers,
  Gerd
