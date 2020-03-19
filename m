From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v3] drm/bochs: downgrade pci_request_region failure from
 error to warning
Date: Thu, 19 Mar 2020 09:39:52 +0100
Message-ID: <CAKMK7uE52i2_BhFoH0timOG_jUQP3OThA+wUWoMx6tfH9mMT6w@mail.gmail.com>
References: <20200313084152.2734-1-kraxel@redhat.com> <20200317164941.GP2363188@phenom.ffwll.local>
 <20200318064211.rg5s4sgrnqhht3f4@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200318064211.rg5s4sgrnqhht3f4@sirius.home.kraxel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, marmarek@invisiblethingslab.com, David Airlie <airlied@linux.ie>, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 18, 2020 at 7:49 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Tue, Mar 17, 2020 at 05:49:41PM +0100, Daniel Vetter wrote:
> > On Fri, Mar 13, 2020 at 09:41:52AM +0100, Gerd Hoffmann wrote:
> > > Shutdown of firmware framebuffer has a bunch of problems.  Because
> > > of this the framebuffer region might still be reserved even after
> > > drm_fb_helper_remove_conflicting_pci_framebuffers() returned.
> >
> > Is that still the fbdev lifetime fun where the cleanup might be delayed if
> > the char device node is still open?
>
> Yes.

In that case I think a FIXME comment that this should be upgraded
again to a full error once fbdev unloading is fixed should be added.
With that:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

I guess you might want a cc: stable on this too?
-Daniel

>
> cheers,
>   Gerd
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
