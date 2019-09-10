From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 0/4] Merge VRAM MM and GEM VRAM source files
Date: Tue, 10 Sep 2019 13:06:03 +0200
Message-ID: <20190910110603.upjt34ycylscjpnf@sirius.home.kraxel.org>
References: <20190909130453.6718-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190909130453.6718-1-tzimmermann@suse.de>
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
Cc: yc_chen@aspeedtech.com, corbet@lwn.net, airlied@linux.ie, puck.chen@hisilicon.com, linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, z.liuxinliang@hisilicon.com, hdegoede@redhat.com, kong.kongxinwei@hisilicon.com, daniel@ffwll.ch, zourongrong@gmail.com, sam@ravnborg.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Sep 09, 2019 at 03:04:49PM +0200, Thomas Zimmermann wrote:
> VRAM MM and GEM VRAM are only used with each other. This patch set
> moves VRAM MM into GEM VRAM source files and cleans up the helper's
> public interface.
> 
> Thomas Zimmermann (4):
>   drm/vram: Move VRAM memory manager to GEM VRAM implementation
>   drm/vram: Have VRAM MM call GEM VRAM functions directly
>   drm/vram: Unexport internal functions of VRAM MM
>   drm/vram: Unconditonally set BO call-back functions

Looks all sane.

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

cheers,
  Gerd
