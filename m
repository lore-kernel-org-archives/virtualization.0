From: David Riley <davidriley@chromium.org>
Subject: [PATCH v4 0/2] drm/virtio: Use vmalloc for command buffer
	alllocations.
Date: Wed, 11 Sep 2019 11:14:01 -0700
Message-ID: <20190911181403.40909-1-davidriley__45310.8854986326$1568225660$gmane$org@chromium.org>
References: <20190829212417.257397-1-davidriley@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190829212417.257397-1-davidriley@chromium.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, Gurchetan Singh <gurchetansingh@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>
List-Id: virtualization@lists.linuxfoundation.org

Userspace requested command buffer allocations could be too large
to make as a contiguous allocation.  Use vmalloc if necessary to
satisfy those allocations.

v1: Initial version.
v2: Properly account for number of free descriptors required.
v3: Remove offset handling for vmalloc'd buffers.
v4: Rebase onto drm-misc-next.

David Riley (2):
  drm/virtio: Rewrite virtio_gpu_queue_ctrl_buffer using fenced version.
  drm/virtio: Use vmalloc for command buffer allocations.

 drivers/gpu/drm/virtio/virtgpu_ioctl.c |  4 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 98 ++++++++++++++++++++------
 2 files changed, 79 insertions(+), 23 deletions(-)

-- 
2.23.0.162.g0b9fbb3734-goog
