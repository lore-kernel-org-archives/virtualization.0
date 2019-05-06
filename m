From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v4 00/19] Share TTM code among DRM framebuffer drivers
Date: Mon, 6 May 2019 14:43:44 +0200
Message-ID: <20190506124344.hltulw6e3kkcg4w3__11535.7171440095$1557146714$gmane$org@sirius.home.kraxel.org>
References: <20190506082649.942-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190506082649.942-1-tzimmermann@suse.de>
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

On Mon, May 06, 2019 at 10:26:30AM +0200, Thomas Zimmermann wrote:
> Several simple framebuffer drivers copy most of the TTM code from each
> other. The implementation is always the same; except for the name of
> some data structures.
> 
> As recently discussed, this patch set provides generic memory-management
> code for simple framebuffers with dedicated video memory. It further
> converts the respective drivers to the generic code. The shared code
> is basically the same implementation as the one copied among individual
> drivers.
> 
> The patch set contains two major changes: first, it introduces
> |struct drm_gem_vram_object| and helpers (GEM VRAM). It's a GEM object
> that is backed by VRAM. The type's purpose is somewhat similar to
> |struct drm_gem_{cma, shmem}_object|: it provides an commom implementation
> that handles all the basic cases. Second, the patch set introduces
> |struct drm_vram_mm| and helpers (VRAM MM). It's an implementation of a
> basic memory manager for VRAM.
> 
> Both, GEM VRAM and VRAM MM, support buffer placement in VRAM and system
> memory. Both can be used independedly from each other if desired by the
> DRM driver.

Looks good to me overall, some small nits in replies to patches.

> Currently ast, bochs, mgag200, vboxvideo and hisilicon/hibmc can use
> these helpers.

I've tested bochs on qemu, works fine.
What is the testing status of the other drivers?

cheers,
  Gerd
