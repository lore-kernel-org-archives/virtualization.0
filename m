From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: upstream boot error: KASAN: slab-out-of-bounds Write in
 virtio_gpu_object_create
Date: Mon, 6 Apr 2020 15:16:02 +0200
Message-ID: <20200406131602.ggugjwkm36r4zvkr@sirius.home.kraxel.org>
References: <00000000000091056b05a2999f1e@google.com>
 <CACT4Y+b4RcgG_GrcpaghmqhX47zUVsAcGGd6vb6MYJT=6gf89g@mail.gmail.com>
 <20200406080612.v5ubxvyliuso6v5h@sirius.home.kraxel.org>
 <CAKMK7uE9uQ_YCXfDOH9zQBu_ffoz546hqRd1R_r1+L-T072Lew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKMK7uE9uQ_YCXfDOH9zQBu_ffoz546hqRd1R_r1+L-T072Lew@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Dmitry Vyukov <dvyukov@google.com>, syzbot <syzbot+d3a7951ed361037407db@syzkaller.appspotmail.com>, David Airlie <airlied@linux.ie>, DRI <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE, NET..." <virtualization@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> > > +drivers/gpu/drm/virtio/virtgpu_object.c maintainers
> > > Now we have both mainline and linux-next boot broken (linux-next is
> > > broken for the past 40 days).
> > > No testing of new code happens.
> > >
> > > >  virtio_gpu_object_shmem_init drivers/gpu/drm/virtio/virtgpu_object.c:151 [inline]
> > > >  virtio_gpu_object_create+0x9f3/0xaa0 drivers/gpu/drm/virtio/virtgpu_object.c:230
> >
> > Ah, that one.
> >
> > broken patch: f651c8b05542 ("drm/virtio: factor out the sg_table from virtio_gpu_object")
> > fixed by: 0666a8d7f6a4 ("drm/virtio: fix OOB in virtio_gpu_object_create")
> >
> > Both are in drm-misc-next.  I suspect the fix was added after
> > drm-misc-next was closed for the 5.7 merge window and thus should
> > have been submitted to drm-misc-next-fixes instead.
> >
> > So, what to do now?  Should I cherry-pick 0666a8d7f6a4 into
> > drm-misc-next-fixes?  Or should it go into drm-misc-fixes instead?
> 
> Yup cherry-pick it over, with -x, to drm-misc-next-fixes.
> -Daniel

Done.  So the next linux-next build should be green again.  mainline
should get the fix with the next drm pull (may take a few days).

take care,
  Gerd
