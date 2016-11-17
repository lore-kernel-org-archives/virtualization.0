From: Christoph Hellwig <hch@lst.de>
Subject: automatic IRQ affinity for virtio
Date: Thu, 17 Nov 2016 11:43:12 +0100
Message-ID: <1479379403-27880-1-git-send-email-hch@lst.de>
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
To: mst@redhat.com
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Michael,

this series contains a couple cleanups for the virtio_pci interrupt
handling code, including a switch to the new pci_irq_alloc_vectors
helper, and support for automatic affinity by the PCI layer if the
consumers ask for it.  It then converts over virtio_blk to use this
functionality so that it's blk-mq queues are aligned to the MSI-X
vector routing.  I have a similar patch in the queue for virtio-scsi,
but that would require pulling in the SCSI tree, so I'm not sure if
you'd like it for this window, but if you do I can send it in another
series.  The third driver using per-CPU virtqueues is virtio_net,
but that will take some more time as I haven't started work on the
networking infrastructure yet.

Note that these patches require core IRQ changes from a stable
branch in the tip tree to be pulled in first:

	git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/for-block

Gitweb:

	https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/log/?h=irq/for-block
