From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2] drm/bochs: downgrade pci_request_region failure from
 error to warning
Date: Fri, 7 Feb 2020 13:39:04 +0100
Message-ID: <20200207123904.vvueifnbcfzlb7gx@sirius.home.kraxel.org>
References: <20200207115744.4559-1-kraxel@redhat.com>
 <04783a3f-daae-47a3-d2a7-d42f192daf23@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <04783a3f-daae-47a3-d2a7-d42f192daf23@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, marmarek@invisiblethingslab.com, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 07, 2020 at 01:06:00PM +0100, Thomas Zimmermann wrote:
> Hi
> 
> Am 07.02.20 um 12:57 schrieb Gerd Hoffmann:
> > Shutdown of firmware framebuffer has a bunch of problems.  Because
> > of this the framebuffer region might still be reserved even after
> > drm_fb_helper_remove_conflicting_pci_framebuffers() returned.
> 
> Out of curiosity: what's going wrong here?

Very short version: userspace keeping /dev/fb0 open delays
firmware framebuffer deinit.

Long version by Daniel Vetter:
https://www.spinics.net/lists/linux-fbdev/msg28178.html

cheers,
  Gerd
