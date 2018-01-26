From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v3 0/2] drm/virtio: Add window server support
Date: Fri, 26 Jan 2018 14:58:00 +0100
Message-ID: <20180126135803.29781-1-tomeu.vizoso@collabora.com>
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
To: linux-kernel@vger.kernel.org
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Zach Reizner <zachr@google.com>, kernel@collabora.com
List-Id: virtualization@lists.linuxfoundation.org

Hi,

this work is based on the virtio_wl driver in the ChromeOS kernel by
Zach Reizner, currently at:

https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.4/drivers/virtio/virtio_wl.c

There's one feature missing currently, which is letting clients write
directly to the host part of a resource, so the extra copy in
TRANSFER_TO_HOST isn't needed.

Have pushed the QEMU counterpart to this branch, though it isn't as
polished atm:

https://gitlab.collabora.com/tomeu/qemu/commits/winsrv-wip

Thanks,

Tomeu


Tomeu Vizoso (2):
  drm/virtio: Add window server support
  drm/virtio: Handle buffers from the compositor

 drivers/gpu/drm/virtio/virtgpu_drv.c   |   1 +
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  39 ++++-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 219 +++++++++++++++++++++++++
 drivers/gpu/drm/virtio/virtgpu_kms.c   |  66 ++++++--
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 285 ++++++++++++++++++++++++++++++++-
 include/uapi/drm/virtgpu_drm.h         |  29 ++++
 include/uapi/linux/virtio_gpu.h        |  43 +++++
 7 files changed, 667 insertions(+), 15 deletions(-)

-- 
2.14.3
