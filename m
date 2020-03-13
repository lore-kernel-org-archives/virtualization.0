From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3] drm/bochs: downgrade pci_request_region failure from
 error to warning
Date: Fri, 13 Mar 2020 15:35:30 +0100
Message-ID: <20200313143530.6aoagldak3kpe3xv@sirius.home.kraxel.org>
References: <20200313084152.2734-1-kraxel@redhat.com>
 <20200313090338.GA31815@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200313090338.GA31815@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, marmarek@invisiblethingslab.com, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> > +	if (pci_request_region(pdev, 0, "bochs-drm") != 0)
> > +		DRM_WARN("Cannot request framebuffer, boot fb still active?\n");
> So you could use drm_WARN() which is what is preferred these days.

Nope, this isn't yet in -fixes.

cheers,
  Gerd
