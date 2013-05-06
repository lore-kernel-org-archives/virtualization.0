From: Asias He <asias@redhat.com>
Subject: [PATCH 0/2] vhost-net fix ubuf
Date: Mon,  6 May 2013 11:15:58 +0800
Message-ID: <1367810160-28178-1-git-send-email-asias@redhat.com>
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

Asias He (2):
  vhost: Export vhost_dev_set_owner
  vhost-net: Free ubuf when vhost_dev_set_owner fails

 drivers/vhost/net.c   | 38 ++++++++++++++++++++++++++++++++------
 drivers/vhost/vhost.c |  2 +-
 drivers/vhost/vhost.h |  1 +
 3 files changed, 34 insertions(+), 7 deletions(-)

-- 
1.8.1.4
