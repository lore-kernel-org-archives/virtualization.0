From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next V2 0/3] basic in order support for vhost_net
Date: Wed,  9 Jan 2019 16:05:27 +0800
Message-ID: <20190109080530.18572-1-jasowang@redhat.com>
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
To: mst@redhat.com, jasowang@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi:

This series implement basic in order feature support for
vhost_net. This feature requires both driver and device to use
descriptors in order which can simplify the implementation and
optimizaton for both side. The series also implement a simple
optimization that avoid read available ring. Test shows 10%
performance improvement at most.

More optimizations could be done on top.

Changes from V1:
- no code changes
- add result of SMAP off

Jason Wang (3):
  virtio: introduce in order feature bit
  vhost_net: support in order feature
  vhost: don't touch avail ring if in_order is negotiated

 drivers/vhost/net.c                |  6 ++++--
 drivers/vhost/vhost.c              | 19 ++++++++++++-------
 include/uapi/linux/virtio_config.h |  6 ++++++
 3 files changed, 22 insertions(+), 9 deletions(-)

-- 
2.17.1
