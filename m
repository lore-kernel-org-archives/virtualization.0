From: akong@redhat.com
Subject: [QEMU PATCH v4 0/3] virtio-net: fix of ctrl commands
Date: Sat, 19 Jan 2013 09:54:25 +0800
Message-ID: <1358560468-10865-1-git-send-email-akong@redhat.com>
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
To: mst@redhat.com
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, stefanha@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Amos Kong <akong@redhat.com>

Currently virtio-net code relys on the layout of descriptor,
this patchset removed the assumptions and introduced a control
command to set mac address. Last patch is a trivial renaming.

V2: check guest's iov_len
V3: fix of migration compatibility
    make mac field in config space read-only when new feature is acked
V4: add fix of descriptor layout assumptions, trivial rename

Amos Kong (2):
  virtio-net: introduce a new macaddr control
  virtio-net: rename ctrl rx commands

Michael S. Tsirkin (1):
  virtio-net: remove layout assumptions for ctrl vq

 hw/pc_piix.c    |   4 ++
 hw/virtio-net.c | 143 ++++++++++++++++++++++++++++++++++----------------------
 hw/virtio-net.h |  26 +++++++----
 3 files changed, 109 insertions(+), 64 deletions(-)

-- 
1.7.11.7
