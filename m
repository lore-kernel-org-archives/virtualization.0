From: Christoph Hellwig <hch@lst.de>
Subject: automatic IRQ affinity for virtio V2
Date: Fri, 27 Jan 2017 09:16:28 +0100
Message-ID: <1485504997-17584-1-git-send-email-hch@lst.de>
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
To: mst@redhat.com, jasowang@redhat.com
Cc: axboe@kernel.dk, pbonzini@redhat.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Michael, hi Jason,

This patches applies a few cleanups to the virtio PCI interrupt handling
code, and then converts the virtio PCI code to use the automatic MSI-X
vectors spreading, as well as using the information in virtio-blk
and virtio-scsi to automatically align the blk-mq queues to the MSI-X
vectors.

Changes since V1:
 - dropped the patches already merged for 4.10-rc
 - new patch to remove struct virtio_pci_vq_info
 - improve probe error handling by unwinding step by step
 - new patch to convert virtio-scsi
