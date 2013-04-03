From: Asias He <asias@redhat.com>
Subject: [PATCH V3 0/2] tcm_vhost endpoint
Date: Wed,  3 Apr 2013 14:17:36 +0800
Message-ID: <1364969858-9410-1-git-send-email-asias@redhat.com>
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

Hello mst,

How about this one?

Asias He (2):
  tcm_vhost: Use vq->private_data to indicate if the endpoint is setup
  tcm_vhost: Initialize vq->last_used_idx when set endpoint

 drivers/vhost/tcm_vhost.c | 145 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 102 insertions(+), 43 deletions(-)

-- 
1.8.1.4
