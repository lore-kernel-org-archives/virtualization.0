From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 0/2] virtio-gpu: hardware specification
Date: Thu, 11 Sep 2014 17:09:31 +0200
Message-ID: <1410448173-12960-1-git-send-email-kraxel@redhat.com>
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
To: qemu-devel@nongnu.org
Cc: Dave Airlie <airlied@redhat.com>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
List-Id: virtualization@lists.linuxfoundation.org

  Hi folks,

Lets kick off the virtio-gpu review process, starting with the virtio
protocol.

This is a tiny patch series for qemu.  Patch #1 carries the header file
describing the virtual hardware: config space, command structs being
sent over the rings, defines etc.  Patch #2 adds a text file describing
virtio-gpu to docs/specs/.  It covers 2D support only for now.

For anybody who wants to dig a bit deeper:  Here are the branches for
qemu and the linux kernel:

  https://www.kraxel.org/cgit/qemu/log/?h=rebase/vga-wip
  https://www.kraxel.org/cgit/linux/log/?h=virtio-gpu-rebase

The qemu patches are in a reasonable state.  The linux kernel patches
are not cleaned up yet, you probably want to look at the final tree
only.

Work has been done by Dave Airlie <airlied@redhat.com> and me.  The
authorship info in git got lost in the qemu patch cleanup process
though.  Suggestions how to handle that best?  Simply add both mine
and Dave's signed-off-by to all virtio-gpu qemu patches?  Is that fine
with you Dave?  Anyone has better ideas?

please review,
  Gerd Hoffmann

Gerd Hoffmann (2):
  virtio-gpu/2d: add hardware spec include file
  virtio-gpu/2d: add docs/specs/virtio-gpu.txt

 docs/specs/virtio-gpu.txt      | 165 +++++++++++++++++++++++++++++++++++++++++
 include/hw/virtio/virtgpu_hw.h | 158 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 323 insertions(+)
 create mode 100644 docs/specs/virtio-gpu.txt
 create mode 100644 include/hw/virtio/virtgpu_hw.h

-- 
1.8.3.1
