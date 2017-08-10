From: "Richard W.M. Jones" <rjones@redhat.com>
Subject: [PATCH v2 0/2] virtio_scsi: Set can_queue based on size of virtqueue.
Date: Thu, 10 Aug 2017 17:56:50 +0100
Message-ID: <20170810165652.21515-1-rjones__3522.86001802913$1502384237$gmane$org@redhat.com>
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

v1 was here:

  https://lkml.org/lkml/2017/8/10/689

v1 -> v2:

  Remove .can_queue field from the templates.

Rich.
