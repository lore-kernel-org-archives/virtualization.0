From: Asias He <asias@redhat.com>
Subject: [PATCH 0/3] tcm_vhost: Optimize gup in vhost_scsi_map_to_sgl
Date: Mon, 21 Jan 2013 16:05:25 +0800
Message-ID: <1358755528-31421-1-git-send-email-asias__40676.9318077297$1358755450$gmane$org@redhat.com>
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
Cc: target-devel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Asias He (3):
  tcm_vhost: Introduce iov_num_pages
  tcm_vhost: Optimize gup in vhost_scsi_map_to_sgl
  tcm_vhost: Use iov_num_pages to calculate sgl_count

 drivers/vhost/tcm_vhost.c | 47 +++++++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 18 deletions(-)

-- 
1.8.1
