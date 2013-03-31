From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/3] virtio-pci: Add virtio_queue_valid checks ahead of
	virtio_queue_get_num
Date: Sun, 31 Mar 2013 10:37:27 +0300
Message-ID: <20130331073727.GB23484__28466.5074119859$1364715447$gmane$org@redhat.com>
References: <1364531592-8368-1-git-send-email-nab@linux-iscsi.org>
	<1364531592-8368-3-git-send-email-nab@linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1364531592-8368-3-git-send-email-nab@linux-iscsi.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Cc: kvm-devel <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, lf-virt <virtualization@lists.linux-foundation.org>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 29, 2013 at 04:33:11AM +0000, Nicholas A. Bellinger wrote:
> From: Nicholas Bellinger <nab@linux-iscsi.org>
> 
> This patch adds a number of virtio_queue_valid() checks to virtio-pci
> ahead of virtio_queue_get_num() usage in order to skip operation upon
> the detection of an uninitialized VQ.
> 
> There is one exception in virtio_ioport_read():VIRTIO_PCI_QUEUE_NUM,
> where virtio_queue_get_num() may still be called without a valid
> vdev->vq[n].vring.desc physical address.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Asias He <asias@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>

Makes sense. Minor nit: virtio_queue_valid calls virtio_queue_get_num
internally, so we can drop it everywhere we know queue is valid.

> ---
>  hw/virtio-pci.c |   27 +++++++++++++++++++++++++++
>  1 files changed, 27 insertions(+), 0 deletions(-)
> 
> diff --git a/hw/virtio-pci.c b/hw/virtio-pci.c
> index 0d67b84..231ca0c 100644
> --- a/hw/virtio-pci.c
> +++ b/hw/virtio-pci.c
> @@ -211,6 +211,9 @@ static void virtio_pci_start_ioeventfd(VirtIOPCIProxy *proxy)
>      }
>  
>      for (n = 0; n < VIRTIO_PCI_QUEUE_MAX; n++) {
> +        if (!virtio_queue_valid(proxy->vdev, n)) {
> +            continue;
> +        }
>          if (!virtio_queue_get_num(proxy->vdev, n)) {
>              continue;
>          }
> @@ -225,6 +228,9 @@ static void virtio_pci_start_ioeventfd(VirtIOPCIProxy *proxy)
>  
>  assign_error:
>      while (--n >= 0) {
> +        if (!virtio_queue_valid(proxy->vdev, n)) {
> +            continue;
> +        }
>          if (!virtio_queue_get_num(proxy->vdev, n)) {
>              continue;
>          }
> @@ -246,6 +252,9 @@ static void virtio_pci_stop_ioeventfd(VirtIOPCIProxy *proxy)
>      }
>  
>      for (n = 0; n < VIRTIO_PCI_QUEUE_MAX; n++) {
> +        if (!virtio_queue_valid(proxy->vdev, n)) {
> +            continue;
> +        }
>          if (!virtio_queue_get_num(proxy->vdev, n)) {
>              continue;
>          }
> @@ -546,6 +555,9 @@ static int kvm_virtio_pci_vector_use(VirtIOPCIProxy *proxy, int nvqs)
>      MSIMessage msg;
>  
>      for (queue_no = 0; queue_no < nvqs; queue_no++) {
> +        if (!virtio_queue_valid(vdev, queue_no)) {
> +            continue;
> +        }
>          if (!virtio_queue_get_num(vdev, queue_no)) {
>              break;
>          }
> @@ -593,6 +605,9 @@ static void kvm_virtio_pci_vector_release(VirtIOPCIProxy *proxy, int nvqs)
>      int queue_no;
>  
>      for (queue_no = 0; queue_no < nvqs; queue_no++) {
> +        if (!virtio_queue_valid(vdev, queue_no)) {
> +            continue;
> +        }
>          if (!virtio_queue_get_num(vdev, queue_no)) {
>              break;
>          }
> @@ -665,6 +680,9 @@ static int kvm_virtio_pci_vector_unmask(PCIDevice *dev, unsigned vector,
>      int ret, queue_no;
>  
>      for (queue_no = 0; queue_no < proxy->nvqs_with_notifiers; queue_no++) {
> +        if (!virtio_queue_valid(vdev, queue_no)) {
> +            continue;
> +        }
>          if (!virtio_queue_get_num(vdev, queue_no)) {
>              break;
>          }
> @@ -695,6 +713,9 @@ static void kvm_virtio_pci_vector_mask(PCIDevice *dev, unsigned vector)
>      int queue_no;
>  
>      for (queue_no = 0; queue_no < proxy->nvqs_with_notifiers; queue_no++) {
> +        if (!virtio_queue_valid(vdev, queue_no)) {
> +            continue;
> +        }
>          if (!virtio_queue_get_num(vdev, queue_no)) {
>              break;
>          }
> @@ -717,6 +738,9 @@ static void kvm_virtio_pci_vector_poll(PCIDevice *dev,
>      VirtQueue *vq;
>  
>      for (queue_no = 0; queue_no < proxy->nvqs_with_notifiers; queue_no++) {
> +        if (!virtio_queue_valid(vdev, queue_no)) {
> +            continue;
> +        }
>          if (!virtio_queue_get_num(vdev, queue_no)) {
>              break;
>          }
> @@ -790,6 +814,9 @@ static int virtio_pci_set_guest_notifiers(DeviceState *d, int nvqs, bool assign)
>      }
>  
>      for (n = 0; n < nvqs; n++) {
> +        if (!virtio_queue_valid(vdev, n)) {
> +            continue;
> +        }
>          if (!virtio_queue_get_num(vdev, n)) {
>              break;
>          }
> -- 
> 1.7.2.5
