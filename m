From: Asias He <asias@redhat.com>
Subject: [PATCH V2 0/2] tcm_vhost endpoint
Date: Thu, 28 Mar 2013 10:17:26 +0800
Message-ID: <1364437048-19932-1-git-send-email-asias@redhat.com>
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

Reordered the patch, so patch 1 can go to v3.9.

Asias He (2):
  tcm_vhost: Initialize vq->last_used_idx when set endpoint
  tcm_vhost: Use vq->private_data to indicate if the endpoint is setup

 drivers/vhost/tcm_vhost.c | 47 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 6 deletions(-)

-- 
1.8.1.4
