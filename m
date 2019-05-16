From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net 0/4] Prevent vhost kthread from hogging CPU
Date: Thu, 16 May 2019 03:47:38 -0400
Message-ID: <1557992862-27320-1-git-send-email-jasowang__13489.8178091802$1557992890$gmane$org@redhat.com>
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
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: pbonzini@redhat.com, stefanha@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Hi:

This series try to prvernt a guest triggerable CPU hogging through
vhost kthread. This is done by introducing and checking the weight
after each requrest. The patch has been tested with reproducer of
vsock and virtio-net. Only compile test is done for vhost-scsi.

Please review.

This addresses CVE-2019-3900.

Jason Wang (4):
  vhost: introduce vhost_exceeds_weight()
  vhost_net: fix possible infinite loop
  vhost: vsock: add weight support
  vhost: scsi: add weight support

 drivers/vhost/net.c   | 41 ++++++++++++++---------------------------
 drivers/vhost/scsi.c  | 21 ++++++++++++++-------
 drivers/vhost/vhost.c | 20 +++++++++++++++++++-
 drivers/vhost/vhost.h |  5 ++++-
 drivers/vhost/vsock.c | 28 +++++++++++++++++++++-------
 5 files changed, 72 insertions(+), 43 deletions(-)

-- 
1.8.3.1
