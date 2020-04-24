From: Huacai Chen <chenhc@lemote.com>
Subject: Re: [PATCH Resend] drm/qxl: Use correct notify port address when
 creating cursor ring
Date: Fri, 24 Apr 2020 17:57:37 +0800
Message-ID: <CAAhV-H6vpKk=MD3PX8r6ByT7u4fhwfUcBX6c8FGVA-D0yqm28g@mail.gmail.com>
References: <1585635488-17507-1-git-send-email-chenhc@lemote.com> <20200331145325.f6j2jjczlz33xuyi@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20200331145325.f6j2jjczlz33xuyi@sirius.home.kraxel.org>
Sender: stable-owner@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Dave Airlie <airlied@redhat.com>, virtualization@lists.linux-foundation.org, spice-devel@lists.freedesktop.org, Fuxin Zhang <zhangfx@lemote.com>, stable <stable@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi,  Gerd

On Tue, Mar 31, 2020 at 10:53 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Tue, Mar 31, 2020 at 02:18:08PM +0800, Huacai Chen wrote:
> > The command ring and cursor ring use different notify port addresses
> > definition: QXL_IO_NOTIFY_CMD and QXL_IO_NOTIFY_CURSOR. However, in
> > qxl_device_init() we use QXL_IO_NOTIFY_CMD to create both command ring
> > and cursor ring. This doesn't cause any problems now, because QEMU's
> > behaviors on QXL_IO_NOTIFY_CMD and QXL_IO_NOTIFY_CURSOR are the same.
> > However, QEMU's behavior may be change in future, so let's fix it.
> >
> > P.S.: In the X.org QXL driver, the notify port address of cursor ring
> >       is correct.
> >
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Huacai Chen <chenhc@lemote.com>
>
> Pushed to drm-misc-next.
It seems that this patch hasn't appear in upstream.

>
> thanks,
>   Gerd
>
Thanks,
Huacai
