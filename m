From: Asias He <asias@redhat.com>
Subject: [PATCH v8 0/3] tcm_vhost hotplug
Date: Wed, 24 Apr 2013 11:32:21 +0800
Message-ID: <1366774344-11127-1-git-send-email-asias@redhat.com>
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
To: Nicholas Bellinger <nab@linux-iscsi.org>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hello guys,

MST and I had a phone call yesterday and we had some aggrement.

Please review.

Asias He (3):
  tcm_vhost: Introduce tcm_vhost_check_feature()
  tcm_vhost: Add hotplug/hotunplug support
  tcm_vhost: Add ioctl to get and set events missed flag

 drivers/vhost/tcm_vhost.c | 231 +++++++++++++++++++++++++++++++++++++++++++++-
 drivers/vhost/tcm_vhost.h |  13 +++
 2 files changed, 240 insertions(+), 4 deletions(-)

-- 
1.8.1.4
