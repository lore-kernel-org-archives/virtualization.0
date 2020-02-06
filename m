From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 4/4] drm/virtio: move virtio_gpu_mem_entry initialization
 to new function
Date: Thu, 6 Feb 2020 09:55:40 +0100
Message-ID: <20200206085540.pa6py4ieoi242gma@sirius.home.kraxel.org>
References: <20200205105955.28143-1-kraxel@redhat.com>
 <20200205105955.28143-5-kraxel@redhat.com>
 <CAPaKu7RxijC_oS4GPukS9wEe9gn8DPQgaGZKwG6g8M8xwTnsig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPaKu7RxijC_oS4GPukS9wEe9gn8DPQgaGZKwG6g8M8xwTnsig@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chia-I Wu <olvaffe@gmail.com>
Cc: ML dri-devel <dri-devel@lists.freedesktop.org>, Gurchetan Singh <gurchetansingh@chromium.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> >         virtio_gpu_cmd_resource_attach_backing(vgdev, obj->hw_res_handle,
> > -                                              ents, nents,
> > +                                              obj->ents, obj->nents,
> >                                                fence);
> > +       obj->ents = NULL;
> > +       obj->nents = 0;
> Hm, if the entries are temporary, can we allocate and initialize them
> in this function?

Well, the plan for CREATE_RESOURCE_BLOB is to use obj->ents too ...

cheers,
  Gerd
