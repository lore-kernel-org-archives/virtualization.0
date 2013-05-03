From: Asias He <asias@redhat.com>
Subject: [PATCH 0/4] vhost and vhost-net cleanups
Date: Fri,  3 May 2013 14:25:14 +0800
Message-ID: <1367562318-11989-1-git-send-email-asias@redhat.com>
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
  vhost: Remove comments for hdr in vhost.h
  vhost: Simplify dev->vqs[i] access
  vhost-net: Free ubuf when vhost_dev_ioctl fails
  vhost-net: Cleanup vhost_ubuf adn vhost_zcopy

 drivers/vhost/net.c   | 76 +++++++++++++++++++++++++++++++--------------------
 drivers/vhost/vhost.c | 35 ++++++++++++------------
 drivers/vhost/vhost.h |  3 --
 3 files changed, 65 insertions(+), 49 deletions(-)

-- 
1.8.1.4
