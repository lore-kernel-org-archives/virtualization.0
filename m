From: Asias He <asias@redhat.com>
Subject: [PATCH 0/4] vhost private_data rcu removal
Date: Tue,  7 May 2013 14:54:32 +0800
Message-ID: <1367909676-11788-1-git-send-email-asias@redhat.com>
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

Asias He (4):
  vhost-net: Always access vq->private_data under vq mutex
  vhost-test: Always access vq->private_data under vq mutex
  vhost-scsi: Always access vq->private_data under vq mutex
  vhost: Remove custom vhost rcu usage

 drivers/vhost/net.c   | 37 ++++++++++++++++---------------------
 drivers/vhost/scsi.c  | 17 ++++++-----------
 drivers/vhost/test.c  | 20 +++++++++-----------
 drivers/vhost/vhost.h | 10 ++--------
 4 files changed, 33 insertions(+), 51 deletions(-)

-- 
1.8.1.4
