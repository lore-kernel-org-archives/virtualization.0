From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3] drm/bochs: downgrade pci_request_region failure from
 error to warning
Date: Wed, 18 Mar 2020 07:42:11 +0100
Message-ID: <20200318064211.rg5s4sgrnqhht3f4@sirius.home.kraxel.org>
References: <20200313084152.2734-1-kraxel@redhat.com>
 <20200317164941.GP2363188@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200317164941.GP2363188@phenom.ffwll.local>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, marmarek@invisiblethingslab.com, David Airlie <airlied@linux.ie>, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 17, 2020 at 05:49:41PM +0100, Daniel Vetter wrote:
> On Fri, Mar 13, 2020 at 09:41:52AM +0100, Gerd Hoffmann wrote:
> > Shutdown of firmware framebuffer has a bunch of problems.  Because
> > of this the framebuffer region might still be reserved even after
> > drm_fb_helper_remove_conflicting_pci_framebuffers() returned.
> 
> Is that still the fbdev lifetime fun where the cleanup might be delayed if
> the char device node is still open?

Yes.

cheers,
  Gerd
