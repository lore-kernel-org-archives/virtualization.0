From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v6 15/18] drm/virtio: rework
	virtio_gpu_transfer_to_host_ioctl fencing
Date: Thu, 4 Jul 2019 13:51:38 +0200
Message-ID: <20190704115138.ou77sb3rlrex67tj__33510.1153281116$1562241114$gmane$org@sirius.home.kraxel.org>
References: <20190702141903.1131-1-kraxel@redhat.com>
	<20190702141903.1131-16-kraxel@redhat.com>
	<CAPaKu7S0n=E7g0o2e6fEk1YjP+u=tsoV8upw7J=noSx88PgP+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAPaKu7S0n=E7g0o2e6fEk1YjP+u=tsoV8upw7J=noSx88PgP+A@mail.gmail.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, Gurchetan Singh <gurchetansingh@chromium.org>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> >         convert_to_hw_box(&box, &args->box);
> >         if (!vgdev->has_virgl_3d) {
> >                 virtio_gpu_cmd_transfer_to_host_2d
> > -                       (vgdev, qobj, offset,
> > +                       (vgdev, gem_to_virtio_gpu_obj(objs->objs[0]), offset,
> >                          box.w, box.h, box.x, box.y, NULL);
> > +               virtio_gpu_array_put_free(objs);
> Don't we need this in non-3D case as well?

No, ...

> >                 virtio_gpu_cmd_transfer_to_host_3d
> > -                       (vgdev, qobj,
> > +                       (vgdev,
> >                          vfpriv ? vfpriv->ctx_id : 0, offset,
> > -                        args->level, &box, fence);
> > -               reservation_object_add_excl_fence(qobj->base.base.resv,
> > -                                                 &fence->f);
> > +                        args->level, &box, objs, fence);

... 3d case passes the objs list to virtio_gpu_cmd_transfer_to_host_3d,
so it gets added to the vbuf and released when the command is finished.

cheers,
  Gerd
