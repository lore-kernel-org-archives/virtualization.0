From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/cirrus: Use drm_framebuffer_put to avoid kernel oops
	in clean-up
Date: Fri, 10 Aug 2018 08:03:05 +0200
Message-ID: <20180810060305.q2wse7tdkx46pzyy__1136.89260692826$1533880864$gmane$org@sirius.home.kraxel.org>
References: <20180720112743.27159-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180720112743.27159-1-tzimmermann@suse.de>
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
Cc: airlied@redhat.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 20, 2018 at 01:27:43PM +0200, Thomas Zimmermann wrote:
> In the Cirrus driver, the regular clean-up code also performs the clean-up
> of a failed initialization. If the fbdev's framebuffer was not initialized,
> the clean-up will fail within drm_framebuffer_unregister_private. Booting
> with cirrus.bpp=16 triggers this bug.
> 
> The framebuffer is currently stored directly within struct cirrus_fbdev. To
> fix the bug, we turn it into a pointer that is only set for initialized
> framebuffers. The fbdev's clean-up code skips uninitialized framebuffers.
> 
> The memory for struct drm_framebuffer is allocated dynamically. This requires
> additional error handling within cirrusfb_create. The framebuffer clean-up is
> now performed by drm_framebuffer_put, which also frees the data strcuture's
> memory.

pushed to drm-misc-next (also the other ones, except the failing ttm_put
patches).

thanks,
  Gerd
