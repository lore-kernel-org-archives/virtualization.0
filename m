From: Jason Wang <jasowang@redhat.com>
Subject: Re: [REGRESSION] 07ec51480b5e ("virtio_pci: use shared interrupts for
	virtqueues") causes crashes in guest
Date: Thu, 23 Mar 2017 13:13:50 +0800
Message-ID: <e042635f-e30e-45e8-f4a5-b03b9228eec2@redhat.com>
References: <43ffa887-a20d-f836-cba8-11196924d82d@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------F6912386D4376D92DD7F5C55"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <43ffa887-a20d-f836-cba8-11196924d82d@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Laura Abbott <labbott@redhat.com>, Christoph Hellwig <hch@lst.de>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------F6912386D4376D92DD7F5C55
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2017年03月23日 08:30, Laura Abbott wrote:
> Hi,
>
> Fedora has received multiple reports of crashes when running
> 4.11 as a guest
>
> https://bugzilla.redhat.com/show_bug.cgi?id=1430297
> https://bugzilla.redhat.com/show_bug.cgi?id=1434462
> https://bugzilla.kernel.org/show_bug.cgi?id=194911
> https://bugzilla.redhat.com/show_bug.cgi?id=1433899
>
> The crashes are not always consistent but they are generally
> some flavor of oops or GPF in virtio related code. Multiple people
> have done bisections (Thank you Thorsten Leemhuis and
> Richard W.M. Jones) and found this commit to be at fault
>
> 07ec51480b5eb1233f8c1b0f5d7a7c8d1247c507 is the first bad commit
> commit 07ec51480b5eb1233f8c1b0f5d7a7c8d1247c507
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Sun Feb 5 18:15:19 2017 +0100
>
>      virtio_pci: use shared interrupts for virtqueues
>      
>      This lets IRQ layer handle dispatching IRQs to separate handlers for the
>      case where we don't have per-VQ MSI-X vectors, and allows us to greatly
>      simplify the code based on the assumption that we always have interrupt
>      vector 0 (legacy INTx or config interrupt for MSI-X) available, and
>      any other interrupt is request/freed throught the VQ, even if the
>      actual interrupt line might be shared in some cases.
>      
>      This allows removing a great deal of variables keeping track of the
>      interrupt state in struct virtio_pci_device, as we can now simply walk the
>      list of VQs and deal with per-VQ interrupt handlers there, and only treat
>      vector 0 special.
>      
>      Additionally clean up the VQ allocation code to properly unwind on error
>      instead of having a single global cleanup label, which is error prone,
>      and in this case also leads to more code.
>      
>      Signed-off-by: Christoph Hellwig <hch@lst.de>
>      Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> :040000 040000 79a8267ffb73f9d244267c5f68365305bddd4696 8832a160b978710bbd24ba6966f462b3faa27fcc M	drivers
>
> It doesn't revert cleanly so we haven't been able to do a clean
> test. Any ideas?
>
> Thanks,
> Laura

Hello:

Can you try the attached patch to see if it solves the problem? (At 
least it silent KASan warnings for me).

Thanks



--------------F6912386D4376D92DD7F5C55
Content-Type: text/x-patch;
 name="0001-virtio_pci-fix-out-of-bound-access-for-msix_names.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-virtio_pci-fix-out-of-bound-access-for-msix_names.patch"

From 312859b596e83a2164a8430343d31fce2a5ad808 Mon Sep 17 00:00:00 2001
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 23 Mar 2017 13:07:16 +0800
Subject: [PATCH] virtio_pci: fix out of bound access for msix_names

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_common.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index df548a6..5905349 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -147,7 +147,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	const char *name = dev_name(&vp_dev->vdev.dev);
-	int i, err = -ENOMEM, allocated_vectors, nvectors;
+	int i, j, err = -ENOMEM, allocated_vectors, nvectors;
 	unsigned flags = PCI_IRQ_MSIX;
 	bool shared = false;
 	u16 msix_vec;
@@ -212,7 +212,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 	if (!vp_dev->msix_vector_map)
 		goto out_disable_config_irq;
 
-	allocated_vectors = 1; /* vector 0 is the config interrupt */
+	allocated_vectors = j = 1; /* vector 0 is the config interrupt */
 	for (i = 0; i < nvqs; ++i) {
 		if (!names[i]) {
 			vqs[i] = NULL;
@@ -236,18 +236,19 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 			continue;
 		}
 
-		snprintf(vp_dev->msix_names[i + 1],
+		snprintf(vp_dev->msix_names[j],
 			 sizeof(*vp_dev->msix_names), "%s-%s",
 			 dev_name(&vp_dev->vdev.dev), names[i]);
 		err = request_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec),
 				  vring_interrupt, IRQF_SHARED,
-				  vp_dev->msix_names[i + 1], vqs[i]);
+				  vp_dev->msix_names[j], vqs[i]);
 		if (err) {
 			/* don't free this irq on error */
 			vp_dev->msix_vector_map[i] = VIRTIO_MSI_NO_VECTOR;
 			goto out_remove_vqs;
 		}
 		vp_dev->msix_vector_map[i] = msix_vec;
+		j++;
 
 		/*
 		 * Use a different vector for each queue if they are available,
-- 
2.7.4


--------------F6912386D4376D92DD7F5C55
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--------------F6912386D4376D92DD7F5C55--
