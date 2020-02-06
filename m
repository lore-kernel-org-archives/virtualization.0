From: Chia-I Wu <olvaffe@gmail.com>
Subject: Re: [PATCH 2/4] drm/virtio: resource teardown tweaks
Date: Thu, 6 Feb 2020 10:32:38 -0800
Message-ID: <CAPaKu7S0E7Dm66UMkxb+3cwXuX3EXggFD0w66fv8exH4cQH==Q@mail.gmail.com>
References: <20200205105955.28143-1-kraxel@redhat.com> <20200205105955.28143-3-kraxel@redhat.com>
 <CAPaKu7SCk_3yeTtzFTTU_y-tyo8EDS7vR8i+mk829=0D-UjLQA@mail.gmail.com> <20200206064338.badm6ijgyo2p5mmc@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200206064338.badm6ijgyo2p5mmc@sirius.home.kraxel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: ML dri-devel <dri-devel@lists.freedesktop.org>, Gurchetan Singh <gurchetansingh@chromium.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 5, 2020 at 10:43 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> > > -
> > > -       drm_gem_shmem_free_object(obj);
> > > +       if (bo->created) {
> > > +               virtio_gpu_cmd_unref_resource(vgdev, bo);
> > > +               /* completion handler calls virtio_gpu_cleanup_object() */
> > nitpick: we don't need this comment when virtio_gpu_cmd_unref_cb is
> > defined by this file and passed to virtio_gpu_cmd_unref_resource.
>
> I want virtio_gpu_cmd_unref_cb + virtio_gpu_cmd_unref_resource being
> placed next to each other so it is easier to see how they work hand in
> hand.
>
> > I happen to be looking at our error handling paths.  I think we want
> > virtio_gpu_queue_fenced_ctrl_buffer to call vbuf->resp_cb on errors.
>
> /me was thinking about that too.  Yes, we will need either that,
> or a separate vbuf->error_cb callback.  That'll be another patch
> though.
Or the new virtio_gpu_queue_ctrl_sgs can return errors rather than
eating errors.

Yeah, that should be another patch.
>
> > > +       /*
> > > +        * We are in the release callback and do NOT want refcount
> > > +        * bo, so do NOT use virtio_gpu_array_add_obj().
> > > +        */
> > > +       vbuf->objs = virtio_gpu_array_alloc(1);
> > > +       vbuf->objs->objs[0] = &bo->base.base
> > This is an abuse of obj array.  Add "void *private_data;" to
> > virtio_gpu_vbuffer and use that maybe?
>
> I'd name that *cb_data, but yes, that makes sense.
Sounds great.
>
> cheers,
>   Gerd
>
