From: Chia-I Wu <olvaffe@gmail.com>
Subject: Re: [PATCH v4 08/12] drm/virtio: rework virtio_gpu_execbuffer_ioctl
	fencing
Date: Sun, 30 Jun 2019 11:47:53 -0700
Message-ID: <CAPaKu7Qvxp1poDoKz5Rft1uG0-7ijtTJQ-sLibvtewdZyVjXug__34521.6020521306$1561920495$gmane$org@mail.gmail.com>
References: <20190620060726.926-1-kraxel@redhat.com>
	<20190620060726.926-9-kraxel@redhat.com>
	<CAPaKu7QjuKMJfhTVOzBsUb8cT9cGgesG_-skQeBO8hL8UqcAzw@mail.gmail.com>
	<20190628103412.f2n7ybp3qtxbhdk4@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190628103412.f2n7ybp3qtxbhdk4@sirius.home.kraxel.org>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 28, 2019 at 3:34 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> > > +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> > > @@ -120,9 +120,9 @@ struct virtio_gpu_vbuffer {
> > >
> > >         char *resp_buf;
> > >         int resp_size;
> > > -
> > >         virtio_gpu_resp_cb resp_cb;
> > >
> > > +       struct virtio_gpu_object_array *objs;
> > This can use a comment (e.g., objects referenced by the vbuffer)
>
> IMHO this is obvious ...
>
> > >  void virtio_gpu_cmd_submit(struct virtio_gpu_device *vgdev,
> > >                            void *data, uint32_t data_size,
> > > -                          uint32_t ctx_id, struct virtio_gpu_fence *fence);
> > > +                          uint32_t ctx_id, struct virtio_gpu_fence *fence,
> > > +                          struct virtio_gpu_object_array *objs);
> > Can we keep fence, which is updated, as the last parameter?
>
> Fixed.
>
> > > +       if (buflist) {
> > > +               for (i = 0; i < exbuf->num_bo_handles; i++)
> > > +                       reservation_object_add_excl_fence(buflist->objs[i]->resv,
> > > +                                                         &out_fence->f);
> > > +               drm_gem_unlock_reservations(buflist->objs, buflist->nents,
> > > +                                           &ticket);
> > > +       }
> > We used to unlock after virtio_gpu_cmd_submit.
> >
> > I guess, the fence is considered signaled (because its seqno is still
> > 0) until after virtio_gpu_cmd_submit.  We probably don't want other
> > processes to see the semi-initialized fence.
>
> Good point.  Fixed.
>
> > >  out_memdup:
> > >         kfree(buf);
> > >  out_unresv:
> > > -       ttm_eu_backoff_reservation(&ticket, &validate_list);
> > > -out_free:
> > > -       virtio_gpu_unref_list(&validate_list);
> > Keeping out_free to free buflist seems just fine.
>
> We don't need the separate label though ...
>
> > > +       drm_gem_unlock_reservations(buflist->objs, buflist->nents, &ticket);
> > >  out_unused_fd:
> > >         kvfree(bo_handles);
> > > -       kvfree(buflist);
> > > +       if (buflist)
> > > +               virtio_gpu_array_put_free(buflist);
>
> ... and the buflist is released here if needed.
>
> But we need if (buflist) for drm_gem_unlock_reservations too.  Fixed.
>
> > > -
> > > -               list_del(&entry->list);
> > > -               free_vbuf(vgdev, entry);
> > >         }
> > >         wake_up(&vgdev->ctrlq.ack_queue);
> > >
> > >         if (fence_id)
> > >                 virtio_gpu_fence_event_process(vgdev, fence_id);
> > > +
> > > +       list_for_each_entry_safe(entry, tmp, &reclaim_list, list) {
> > > +               if (entry->objs)
> > > +                       virtio_gpu_array_put_free(entry->objs);
> > > +               list_del(&entry->list);
> > We are clearing the list.  I guess list_del is not needed.
> > > +               free_vbuf(vgdev, entry);
>
> This just shuffles around the code.  Dropping list_del() is unrelated
> and should be a separate patch.
Fair point.  We now loop the list twice and I was just looking for
chances for micro-optimizations.
>
> Beside that I'm not sure it actually can be dropped.  free_vbuf() will
> not kfree() the vbuf but keep it cached in a freelist instead.
vbuf is created with kmem_cache_zalloc which always zeros the struct.

>
> cheers,
>   Gerd
>
