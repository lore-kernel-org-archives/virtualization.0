From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v3] drm/bochs: downgrade pci_request_region failure from
 error to warning
Date: Fri, 13 Mar 2020 19:16:02 +0100
Message-ID: <20200313181602.GA16474@ravnborg.org>
References: <20200313084152.2734-1-kraxel@redhat.com>
 <20200313090338.GA31815@ravnborg.org>
 <20200313143530.6aoagldak3kpe3xv@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200313143530.6aoagldak3kpe3xv@sirius.home.kraxel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: dri-devel@lists.freedesktop.org, marmarek@invisiblethingslab.com, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 13, 2020 at 03:35:30PM +0100, Gerd Hoffmann wrote:
>   Hi,
> 
> > > +	if (pci_request_region(pdev, 0, "bochs-drm") != 0)
> > > +		DRM_WARN("Cannot request framebuffer, boot fb still active?\n");
> > So you could use drm_WARN() which is what is preferred these days.
> 
> Nope, this isn't yet in -fixes.
Ups, did not see this was for -fixes.
My ack stands without ths change then.

	Sam
