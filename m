From: "Richard W.M. Jones" <rjones@redhat.com>
Subject: [PATCH 0/2] virtio_scsi: Set can_queue based on size of virtqueue.
Date: Thu, 10 Aug 2017 17:40:33 +0100
Message-ID: <20170810164035.19963-1-rjones__24652.819420635$1502383253$gmane$org@redhat.com>
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
To: jejb@linux.vnet.ibm.com
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, pbonzini@redhat.com, hch@lst.de
List-Id: virtualization@lists.linuxfoundation.org

Earlier discussion:
https://lkml.org/lkml/2017/8/4/601
"Increased memory usage with scsi-mq"

Downstream bug report:
https://bugzilla.redhat.com/show_bug.cgi?id=1478201
