From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net 0/3] Several fixes for vhost_net ptr_ring usage
Date: Fri,  9 Mar 2018 14:50:31 +0800
Message-ID: <1520578234-5565-1-git-send-email-jasowang@redhat.com>
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
Cc: glider@google.com, dvyukov@google.com
List-Id: virtualization@lists.linuxfoundation.org

Hi:

This small series try to fix several bugs of ptr_ring usage in
vhost_net. Please review.

Thanks

Alexander Potapenko (1):
  vhost_net: initialize rx_ring in vhost_net_open()

Jason Wang (2):
  vhost_net: keep private_data and rx_ring synced
  vhost_net: examine pointer types during un-producing

 drivers/net/tun.c      | 3 ++-
 drivers/vhost/net.c    | 8 +++++---
 include/linux/if_tun.h | 4 ++++
 3 files changed, 11 insertions(+), 4 deletions(-)

-- 
2.7.4
