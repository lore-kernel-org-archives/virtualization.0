From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 0/2] Add BO reservation to GEM VRAM
	pin/unpin/push_to_system
Date: Fri, 17 May 2019 13:17:03 +0200
Message-ID: <20190517111703.j3qtk74awnnebupe@sirius.home.kraxel.org>
References: <20190516162746.11636-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190516162746.11636-1-tzimmermann@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: noralf@tronnes.org, airlied@linux.ie, puck.chen@hisilicon.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, z.liuxinliang@hisilicon.com, hdegoede@redhat.com, kong.kongxinwei@hisilicon.com, ray.huang@amd.com, daniel@ffwll.ch, zourongrong@gmail.com, sam@ravnborg.org, christian.koenig@amd.com
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> It turns out that the bochs and vbox drivers automatically reserved and
> unreserved the BO from within their pin and unpin functions. The other
> drivers; ast, hibmc and mgag200; performed reservation explicitly. With the
> GEM VRAM conversion, automatic BO reservation within pin and unpin functions
> accidentally got lost. So for bochs and vbox, ttm_bo_validate() worked on
> unlocked BOs.
> 
> This patch set fixes the problem by adding automatic reservation to the
> implementation of drm_gem_vram_{pin,unpin,push_to_system}() to fix bochs
> and vbox. It removes explicit BO reservation around the pin, unpin and
> push-to-system calls in the ast, hibmc and mgag200 drivers.
> 
> The only exception is the cursor handling of mgag200. In this case, the
> mgag200 driver now calls drm_gem_vram_{pin,unpin}_reserved(), which works
> with reserved BOs. The respective code should be refactored in a future
> patch to work with the regular pin and unpin functions.

Looks good, pushed to drm-misc-next.

thanks,
  Gerd
