From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: upstream boot error: KASAN: slab-out-of-bounds Write in
 virtio_gpu_object_create
Date: Mon, 6 Apr 2020 10:06:12 +0200
Message-ID: <20200406080612.v5ubxvyliuso6v5h@sirius.home.kraxel.org>
References: <00000000000091056b05a2999f1e@google.com>
 <CACT4Y+b4RcgG_GrcpaghmqhX47zUVsAcGGd6vb6MYJT=6gf89g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACT4Y+b4RcgG_GrcpaghmqhX47zUVsAcGGd6vb6MYJT=6gf89g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+d3a7951ed361037407db@syzkaller.appspotmail.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, DRI <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 06, 2020 at 09:07:44AM +0200, Dmitry Vyukov wrote:
> On Mon, Apr 6, 2020 at 8:46 AM syzbot
> <syzbot+d3a7951ed361037407db@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    ffc1c20c Merge tag 'for-5.7/dm-changes' of git://git.kerne..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1690471fe00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=d6a1e2f9a9986236
> > dashboard link: https://syzkaller.appspot.com/bug?extid=d3a7951ed361037407db
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+d3a7951ed361037407db@syzkaller.appspotmail.com
> 
> 
> +drivers/gpu/drm/virtio/virtgpu_object.c maintainers
> Now we have both mainline and linux-next boot broken (linux-next is
> broken for the past 40 days).
> No testing of new code happens.
> 
> >  virtio_gpu_object_shmem_init drivers/gpu/drm/virtio/virtgpu_object.c:151 [inline]
> >  virtio_gpu_object_create+0x9f3/0xaa0 drivers/gpu/drm/virtio/virtgpu_object.c:230

Ah, that one.

broken patch: f651c8b05542 ("drm/virtio: factor out the sg_table from virtio_gpu_object")
fixed by: 0666a8d7f6a4 ("drm/virtio: fix OOB in virtio_gpu_object_create")

Both are in drm-misc-next.  I suspect the fix was added after
drm-misc-next was closed for the 5.7 merge window and thus should
have been submitted to drm-misc-next-fixes instead.

So, what to do now?  Should I cherry-pick 0666a8d7f6a4 into
drm-misc-next-fixes?  Or should it go into drm-misc-fixes instead?

thanks,
  Gerd
