From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 2/4] drm/virtio: resource teardown tweaks
Date: Thu, 6 Feb 2020 07:43:38 +0100
Message-ID: <20200206064338.badm6ijgyo2p5mmc@sirius.home.kraxel.org>
References: <20200205105955.28143-1-kraxel@redhat.com>
 <20200205105955.28143-3-kraxel@redhat.com>
 <CAPaKu7SCk_3yeTtzFTTU_y-tyo8EDS7vR8i+mk829=0D-UjLQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAPaKu7SCk_3yeTtzFTTU_y-tyo8EDS7vR8i+mk829=0D-UjLQA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, Gurchetan Singh <gurchetansingh@chromium.org>
List-Id: virtualization@lists.linuxfoundation.org

> > -
> > -       drm_gem_shmem_free_object(obj);
> > +       if (bo->created) {
> > +               virtio_gpu_cmd_unref_resource(vgdev, bo);
> > +               /* completion handler calls virtio_gpu_cleanup_object() */
> nitpick: we don't need this comment when virtio_gpu_cmd_unref_cb is
> defined by this file and passed to virtio_gpu_cmd_unref_resource.

I want virtio_gpu_cmd_unref_cb + virtio_gpu_cmd_unref_resource being
placed next to each other so it is easier to see how they work hand in
hand.

> I happen to be looking at our error handling paths.  I think we want
> virtio_gpu_queue_fenced_ctrl_buffer to call vbuf->resp_cb on errors.

/me was thinking about that too.  Yes, we will need either that,
or a separate vbuf->error_cb callback.  That'll be another patch
though.

> > +       /*
> > +        * We are in the release callback and do NOT want refcount
> > +        * bo, so do NOT use virtio_gpu_array_add_obj().
> > +        */
> > +       vbuf->objs = virtio_gpu_array_alloc(1);
> > +       vbuf->objs->objs[0] = &bo->base.base
> This is an abuse of obj array.  Add "void *private_data;" to
> virtio_gpu_vbuffer and use that maybe?

I'd name that *cb_data, but yes, that makes sense.

cheers,
  Gerd
