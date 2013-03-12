From: Asias He <asias@redhat.com>
Subject: [PATCH V3 0/2] tcm_vhost hotplug/hotunplug support
Date: Tue, 12 Mar 2013 10:45:37 +0800
Message-ID: <1363056339-6061-1-git-send-email-asias@redhat.com>
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

Changes in v3:
- Separate the bug fix to another thread

Changes in v2:
- Remove code duplication in tcm_vhost_{hotplug,hotunplug}
- Fix racing of vs_events_nr
- Add flush fix patch to this series


Asias He (2):
  tcm_vhost: Introduce tcm_vhost_check_feature()
  tcm_vhost: Add hotplug/hotunplug support

 drivers/vhost/tcm_vhost.c | 224 ++++++++++++++++++++++++++++++++++++++++++++--
 drivers/vhost/tcm_vhost.h |  10 +++
 2 files changed, 229 insertions(+), 5 deletions(-)

-- 
1.8.1.4
