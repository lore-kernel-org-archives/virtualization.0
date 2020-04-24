From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH Resend] drm/qxl: Use correct notify port address when
 creating cursor ring
Date: Fri, 24 Apr 2020 11:58:43 +0200
Message-ID: <20200424095843.owgjzaxdfkzr5ahk@sirius.home.kraxel.org>
References: <1585635488-17507-1-git-send-email-chenhc@lemote.com>
 <20200331145325.f6j2jjczlz33xuyi@sirius.home.kraxel.org>
 <CAAhV-H6vpKk=MD3PX8r6ByT7u4fhwfUcBX6c8FGVA-D0yqm28g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAhV-H6vpKk=MD3PX8r6ByT7u4fhwfUcBX6c8FGVA-D0yqm28g@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Huacai Chen <chenhc@lemote.com>
Cc: Dave Airlie <airlied@redhat.com>, virtualization@lists.linux-foundation.org, spice-devel@lists.freedesktop.org, Fuxin Zhang <zhangfx@lemote.com>, stable <stable@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 24, 2020 at 05:57:37PM +0800, Huacai Chen wrote:
> Hi,  Gerd
> 
> On Tue, Mar 31, 2020 at 10:53 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > On Tue, Mar 31, 2020 at 02:18:08PM +0800, Huacai Chen wrote:
> > > The command ring and cursor ring use different notify port addresses
> > > definition: QXL_IO_NOTIFY_CMD and QXL_IO_NOTIFY_CURSOR. However, in
> > > qxl_device_init() we use QXL_IO_NOTIFY_CMD to create both command ring
> > > and cursor ring. This doesn't cause any problems now, because QEMU's
> > > behaviors on QXL_IO_NOTIFY_CMD and QXL_IO_NOTIFY_CURSOR are the same.
> > > However, QEMU's behavior may be change in future, so let's fix it.
> > >
> > > P.S.: In the X.org QXL driver, the notify port address of cursor ring
> > >       is correct.
> > >
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> >
> > Pushed to drm-misc-next.
> It seems that this patch hasn't appear in upstream.

Was probably to late for the 5.7 merge window, should land in 5.8

cheers,
  Gerd
