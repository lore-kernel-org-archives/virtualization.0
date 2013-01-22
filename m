From: Asias He <asias@redhat.com>
Subject: [PATCH v2 0/3] tcm_vhost: Optimize gup in vhost_scsi_map_to_sgl
Date: Tue, 22 Jan 2013 11:20:24 +0800
Message-ID: <1358824827-16169-1-git-send-email-asias@redhat.com>
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
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Changes in v2:
- Use GFP_KERNEL instead of GFP_ATOMIC
- Handle pages pinned less than wanted

Asias He (3):
  tcm_vhost: Introduce iov_num_pages
  tcm_vhost: Use iov_num_pages to calculate sgl_count
  tcm_vhost: Optimize gup in vhost_scsi_map_to_sgl

 drivers/vhost/tcm_vhost.c | 68 +++++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 29 deletions(-)

-- 
1.8.1
