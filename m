From: Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: [PATCH v3 0/7] vhost: support for cross endian guests
Date: Tue, 07 Apr 2015 14:09:29 +0200
Message-ID: <20150407120929.4213.8225.stgit__220.771719659929$1428408602$gmane$org@bahia.lab.toulouse-stg.fr.ibm.com>
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
To: Rusty Russell <rusty@rustcorp.com.au>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,

This patchset allows vhost to be used with legacy virtio when guest and host
have a different endianness.

Patches 1-6 remain the same as the previous post. Patch 7 was heavily changed
according to MST's comments.

---

Greg Kurz (7):
      virtio: introduce virtio_is_little_endian() helper
      tun: add tun_is_little_endian() helper
      macvtap: introduce macvtap_is_little_endian() helper
      vringh: introduce vringh_is_little_endian() helper
      vhost: introduce vhost_is_little_endian() helper
      virtio: add explicit big-endian support to memory accessors
      vhost: feature to set the vring endianness


 drivers/net/macvtap.c            |   11 ++++++--
 drivers/net/tun.c                |   11 ++++++--
 drivers/vhost/Kconfig            |   10 +++++++
 drivers/vhost/vhost.c            |   55 ++++++++++++++++++++++++++++++++++++++
 drivers/vhost/vhost.h            |   34 +++++++++++++++++++----
 include/linux/virtio_byteorder.h |   24 ++++++++++-------
 include/linux/virtio_config.h    |   19 +++++++++----
 include/linux/vringh.h           |   19 +++++++++----
 include/uapi/linux/vhost.h       |    5 +++
 9 files changed, 156 insertions(+), 32 deletions(-)

--
Greg
