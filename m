From: Chia-I Wu <olvaffe@gmail.com>
Subject: Re: [PATCH 4/4] drm/virtio: move virtio_gpu_mem_entry initialization
 to new function
Date: Thu, 6 Feb 2020 10:41:39 -0800
Message-ID: <CAPaKu7RDZYnpjFB-Vou0RwiDGCxrD4ak2vLEf89UupdYm59ZYw@mail.gmail.com>
References: <20200205105955.28143-1-kraxel@redhat.com> <20200205105955.28143-5-kraxel@redhat.com>
 <CAPaKu7RxijC_oS4GPukS9wEe9gn8DPQgaGZKwG6g8M8xwTnsig@mail.gmail.com> <20200206085540.pa6py4ieoi242gma@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200206085540.pa6py4ieoi242gma@sirius.home.kraxel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: ML dri-devel <dri-devel@lists.freedesktop.org>, Gurchetan Singh <gurchetansingh@chromium.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 6, 2020 at 12:55 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > >         virtio_gpu_cmd_resource_attach_backing(vgdev, obj->hw_res_handle,
> > > -                                              ents, nents,
> > > +                                              obj->ents, obj->nents,
> > >                                                fence);
> > > +       obj->ents = NULL;
> > > +       obj->nents = 0;
> > Hm, if the entries are temporary, can we allocate and initialize them
> > in this function?
>
> Well, the plan for CREATE_RESOURCE_BLOB is to use obj->ents too ...
Is obj->ents needed after CREATE_RESOURCE_BLOB?  If not, having yet
another helper

  ents = virtio_gpu_object_alloc_mem_entries(..., &count);

seems cleaner.  We would also be able to get rid of virtio_gpu_object_attach.

>
> cheers,
>   Gerd
>
