From: Asias He <asias@redhat.com>
Subject: [PATCH 0/3] vhost cleanups and separate module
Date: Fri,  3 May 2013 13:34:26 +0800
Message-ID: <1367559269-8325-1-git-send-email-asias@redhat.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Asias He (3):
  vhost: Remove vhost_enable_zcopy in vhost.h
  vhost: Move VHOST_NET_FEATURES to net.c
  vhost: Make vhost a separate module

 drivers/vhost/Kconfig  |  8 ++++++++
 drivers/vhost/Makefile |  3 ++-
 drivers/vhost/net.c    |  6 ++++++
 drivers/vhost/scsi.c   |  1 -
 drivers/vhost/vhost.c  | 50 +++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/vhost/vhost.h  |  8 ++------
 6 files changed, 67 insertions(+), 9 deletions(-)

-- 
1.8.1.4
