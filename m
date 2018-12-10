From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net 0/4] Fix various issue of vhost
Date: Mon, 10 Dec 2018 17:44:50 +0800
Message-ID: <20181210094454.21144-1-jasowang@redhat.com>
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
To: mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Hi:

This series tries to fix various issues of vhost:

- Patch 1 adds a missing write barrier between used idx updating and
  logging.
- Patch 2-3 brings back the protection of device IOTLB through vq
  mutex, this fixes possible use after free in device IOTLB entries.
- Patch 4 fixes the diry page logging when device IOTLB is
  enabled. We should done through GPA instead of GIOVA, this was done
  through logging through iovec and traversing GPA->HPA list for the
  GPA.

Please consider them for -stable.

Thanks

Jason Wang (4):
  vhost: make sure used idx is seen before log in vhost_add_used_n()
  vhost_net: rework on the lock ordering for busy polling
  Revert "net: vhost: lock the vqs one by one"
  vhost: log dirty page correctly

 drivers/vhost/net.c   |  21 +++++++--
 drivers/vhost/vhost.c | 101 ++++++++++++++++++++++++++++++++++--------
 drivers/vhost/vhost.h |   3 +-
 3 files changed, 102 insertions(+), 23 deletions(-)

-- 
2.17.1
