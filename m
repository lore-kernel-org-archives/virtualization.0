From: Asias He <asias@redhat.com>
Subject: [PATCH v7 0/3] tcm_vhost hotplug
Date: Thu, 18 Apr 2013 09:05:51 +0800
Message-ID: <1366247154-3136-1-git-send-email-asias__31846.3831012652$1366247194$gmane$org@redhat.com>
References: <20130417131726.GA26157@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130417131726.GA26157@redhat.com>
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

Changes in v7:
- Add vhost_work_flush for vs->vs_event_work to this series

Asias He (3):
  tcm_vhost: Introduce tcm_vhost_check_feature()
  tcm_vhost: Add helper to check if endpoint is setup
  tcm_vhost: Add hotplug/hotunplug support

 drivers/vhost/tcm_vhost.c | 238 +++++++++++++++++++++++++++++++++++++++++++++-
 drivers/vhost/tcm_vhost.h |  10 ++
 2 files changed, 244 insertions(+), 4 deletions(-)

-- 
1.8.1.4
