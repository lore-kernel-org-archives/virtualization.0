From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/4] Merge VRAM MM and GEM VRAM source files
Date: Mon,  9 Sep 2019 15:04:49 +0200
Message-ID: <20190909130453.6718-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: daniel@ffwll.ch, kraxel@redhat.com, airlied@linux.ie, corbet@lwn.net, z.liuxinliang@hisilicon.com, zourongrong@gmail.com, kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com, hdegoede@redhat.com, sam@ravnborg.org, yc_chen@aspeedtech.com
Cc: virtualization@lists.linux-foundation.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

VRAM MM and GEM VRAM are only used with each other. This patch set
moves VRAM MM into GEM VRAM source files and cleans up the helper's
public interface.

Thomas Zimmermann (4):
  drm/vram: Move VRAM memory manager to GEM VRAM implementation
  drm/vram: Have VRAM MM call GEM VRAM functions directly
  drm/vram: Unexport internal functions of VRAM MM
  drm/vram: Unconditonally set BO call-back functions

 Documentation/gpu/drm-mm.rst                  |  12 -
 drivers/gpu/drm/Makefile                      |   3 +-
 drivers/gpu/drm/ast/ast_drv.c                 |   1 -
 drivers/gpu/drm/ast/ast_main.c                |   1 -
 drivers/gpu/drm/ast/ast_ttm.c                 |   3 +-
 drivers/gpu/drm/bochs/bochs.h                 |   1 -
 drivers/gpu/drm/bochs/bochs_mm.c              |   3 +-
 drivers/gpu/drm/drm_gem_vram_helper.c         | 361 ++++++++++++++----
 drivers/gpu/drm/drm_vram_helper_common.c      |   8 +-
 drivers/gpu/drm/drm_vram_mm_helper.c          | 309 ---------------
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |   1 -
 drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c   |   3 +-
 drivers/gpu/drm/mgag200/mgag200_drv.h         |   1 -
 drivers/gpu/drm/mgag200/mgag200_ttm.c         |   3 +-
 drivers/gpu/drm/vboxvideo/vbox_drv.h          |   2 -
 drivers/gpu/drm/vboxvideo/vbox_ttm.c          |   3 +-
 include/drm/drm_gem_vram_helper.h             |  90 ++++-
 include/drm/drm_vram_mm_helper.h              | 108 ------
 18 files changed, 375 insertions(+), 538 deletions(-)
 delete mode 100644 drivers/gpu/drm/drm_vram_mm_helper.c
 delete mode 100644 include/drm/drm_vram_mm_helper.h

--
2.23.0
