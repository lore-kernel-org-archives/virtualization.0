From: Asias He <asias@redhat.com>
Subject: [PATCH v5 0/2] tcm_vhost flush
Date: Tue, 16 Apr 2013 17:16:49 +0800
Message-ID: <1366103811-21887-1-git-send-email-asias__34222.0077793629$1366103840$gmane$org@redhat.com>
References: <1365823754-27730-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1365823754-27730-1-git-send-email-asias@redhat.com>
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

Asias He (2):
  tcm_vhost: Pass vhost_scsi to vhost_scsi_allocate_cmd
  tcm_vhost: Wait for pending requests in vhost_scsi_flush()

 drivers/vhost/tcm_vhost.c | 106 +++++++++++++++++++++++++++++++++++++++++++---
 drivers/vhost/tcm_vhost.h |   5 +++
 2 files changed, 104 insertions(+), 7 deletions(-)

-- 
1.8.1.4
