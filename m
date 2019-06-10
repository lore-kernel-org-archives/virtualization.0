From: davidriley@chromium.org
Subject: [PATCH v2 0/4] drm/virtio: Ensure cached capset entries are valid
	before copying.
Date: Mon, 10 Jun 2019 14:18:06 -0700
Message-ID: <20190610211810.253227-1-davidriley__46783.0966155574$1560201508$gmane$org@chromium.org>
References: <20190605234423.11348-1-davidriley@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190605234423.11348-1-davidriley@chromium.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>
List-Id: virtualization@lists.linuxfoundation.org

From: David Riley <davidriley@chromium.org>


v2: Updated barriers.

David Riley (4):
  drm/virtio: Ensure cached capset entries are valid before copying.
  drm/virtio: Wake up all waiters when capset response comes in.
  drm/virtio: Fix cache entry creation race.
  drm/virtio: Add memory barriers for capset cache.

 drivers/gpu/drm/virtio/virtgpu_ioctl.c |  6 ++++--
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 26 ++++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 4 deletions(-)

-- 
2.22.0.rc2.383.gf4fbbf30c2-goog
