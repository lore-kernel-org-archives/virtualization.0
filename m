From: Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 0/4] Improve virtio ID allocation
Date: Wed, 26 Sep 2018 09:00:27 -0700
Message-ID: <20180926160031.15721-1-willy@infradead.org>
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
To: David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Matthew Wilcox <willy@infradead.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

I noticed you were using IDRs where you could be using the more efficient
IDAs, then while fixing that I noticed the lack of error handling,
and I decided to follow that up with an efficiency improvement.

There's probably a v2 of this to follow because I couldn't figure
out how to properly handle one of the error cases ... see the comment
embedded in one of the patches.

Matthew Wilcox (4):
  drm/virtio: Replace IDRs with IDAs
  drm/virtio: Handle context ID allocation errors
  drm/virtio: Handle object ID allocation errors
  drm/virtio: Use IDAs more efficiently

 drivers/gpu/drm/virtio/virtgpu_drv.h   |  9 ++---
 drivers/gpu/drm/virtio/virtgpu_fb.c    | 10 ++++--
 drivers/gpu/drm/virtio/virtgpu_gem.c   | 10 ++++--
 drivers/gpu/drm/virtio/virtgpu_ioctl.c |  5 ++-
 drivers/gpu/drm/virtio/virtgpu_kms.c   | 46 +++++++++-----------------
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 19 ++++-------
 6 files changed, 44 insertions(+), 55 deletions(-)

-- 
2.19.0
