From: Amos Kong <akong@redhat.com>
Subject: [QEMU PATCH v5 0/3] virtio-net: fix of ctrl commands
Date: Tue, 22 Jan 2013 23:44:43 +0800
Message-ID: <1358869486-22777-1-git-send-email-akong@redhat.com>
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
To: mst@redhat.com, qemu-devel@nongnu.org, aliguori@us.ibm.com
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Currently virtio-net code relys on the layout of descriptor,
this patchset removed the assumptions and introduced a control
command to set mac address. Last patch is a trivial renaming.

V2: check guest's iov_len
V3: fix of migration compatibility
    make mac field in config space read-only when new feature is acked
V4: add fix of descriptor layout assumptions, trivial rename
V5: fix endianness after iov_to_buf copy

Amos Kong (2):
  virtio-net: introduce a new macaddr control
  virtio-net: rename ctrl rx commands

Michael S. Tsirkin (1):
  virtio-net: remove layout assumptions for ctrl vq

 hw/pc_piix.c    |    4 ++
 hw/virtio-net.c |  142 +++++++++++++++++++++++++++++++++---------------------
 hw/virtio-net.h |   26 +++++++----
 3 files changed, 108 insertions(+), 64 deletions(-)
