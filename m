From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 00/16] gpu/drm: remove -Iinclude/drm compiler flags from
	Makefile
Date: Thu, 18 May 2017 13:29:37 +0900
Message-ID: <1495081793-9707-1-git-send-email-yamada.masahiro__45277.4624842734$1495082630$gmane$org@socionext.com>
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
To: dri-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>
Cc: Archit Taneja <architt@codeaurora.org>, VMware Graphics <linux-graphics-maintainer@vmware.com>, Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, Thomas Hellstrom <thellstrom@vmware.com>, Sinclair Yeh <syeh@vmware.com>, linux-kernel@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>, Philippe Cornu <philippe.cornu@st.com>, Yannick Fertre <yannick.fertre@st.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Sean Paul <seanpaul@chromium.org>, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, Dave Airlie <airlied@redhat.com>, Zach Reizner <zachr@google.com>, Chris Wilson <chris@chris-wilson.co.uk>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


Many Makefiles needed to add -Iinclude/drm as an include path,
but the right thing to do is to include headers in the form
  #include <drm/.../*.h>

This series fixes the source files, then rip off -Iinclude/drm flags.

V3: rebased on commit bb2af9bda33 (drm-misc-next)


Masahiro Yamada (16):
  drm/vc4: fix include notation and remove -Iinclude/drm flag
  drm/virtio: fix include notation and remove -Iinclude/drm flag
  drm/vmwgfx: fix include notation and remove -Iinclude/drm flag
  drm/gma500: remove unneeded -Iinclude/drm compiler flag
  drm/i810: remove unneeded -Iinclude/drm compiler flag
  drm/i2c: remove unneeded -Iinclude/drm compiler flag
  drm/mga: remove unneeded -Iinclude/drm compiler flag
  drm/omap: remove unneeded -Iinclude/drm compiler flag
  drm/r128: remove unneeded -Iinclude/drm compiler flag
  drm/savage: remove unneeded -Iinclude/drm compiler flag
  drm/sis: remove unneeded -Iinclude/drm compiler flag
  drm/stm: remove unneeded -Iinclude/drm compiler flag
  drm/tdfx: remove unneeded -Iinclude/drm compiler flag
  drm/udl: remove unneeded -Iinclude/drm compiler flag
  drm/vgem: remove unneeded -Iinclude/drm compiler flag
  drm/via: remove unneeded -Iinclude/drm compiler flag

 drivers/gpu/drm/gma500/Makefile          |  1 -
 drivers/gpu/drm/i2c/Makefile             |  2 --
 drivers/gpu/drm/i810/Makefile            |  1 -
 drivers/gpu/drm/mga/Makefile             |  1 -
 drivers/gpu/drm/omapdrm/Makefile         |  1 -
 drivers/gpu/drm/r128/Makefile            |  1 -
 drivers/gpu/drm/savage/Makefile          |  1 -
 drivers/gpu/drm/sis/Makefile             |  1 -
 drivers/gpu/drm/stm/Makefile             |  2 --
 drivers/gpu/drm/tdfx/Makefile            |  1 -
 drivers/gpu/drm/udl/Makefile             |  3 ---
 drivers/gpu/drm/vc4/Makefile             |  2 --
 drivers/gpu/drm/vc4/vc4_crtc.c           | 14 +++++++-------
 drivers/gpu/drm/vc4/vc4_dpi.c            | 16 ++++++++--------
 drivers/gpu/drm/vc4/vc4_drv.c            |  2 +-
 drivers/gpu/drm/vc4/vc4_drv.h            |  6 ++----
 drivers/gpu/drm/vc4/vc4_dsi.c            | 28 ++++++++++++++--------------
 drivers/gpu/drm/vc4/vc4_hdmi.c           | 30 +++++++++++++++---------------
 drivers/gpu/drm/vc4/vc4_hvs.c            |  2 +-
 drivers/gpu/drm/vc4/vc4_kms.c            | 12 ++++++------
 drivers/gpu/drm/vc4/vc4_plane.c          |  9 +++++----
 drivers/gpu/drm/vc4/vc4_v3d.c            |  6 +++---
 drivers/gpu/drm/vgem/Makefile            |  1 -
 drivers/gpu/drm/via/Makefile             |  1 -
 drivers/gpu/drm/virtio/Makefile          |  2 --
 drivers/gpu/drm/virtio/virtgpu_debugfs.c |  2 +-
 drivers/gpu/drm/virtio/virtgpu_drv.c     |  4 ++--
 drivers/gpu/drm/virtio/virtgpu_drv.h     |  8 ++++----
 drivers/gpu/drm/virtio/virtgpu_ioctl.c   |  5 +++--
 drivers/gpu/drm/virtio/virtgpu_ttm.c     | 10 +++++-----
 drivers/gpu/drm/vmwgfx/Makefile          |  3 ---
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c   |  3 ++-
 drivers/gpu/drm/vmwgfx/vmwgfx_context.c  |  3 ++-
 drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c  |  3 ++-
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c      |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c   |  3 ++-
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c  |  3 ++-
 37 files changed, 88 insertions(+), 107 deletions(-)

-- 
2.7.4
