From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC-v2 1/6] msix: Work-around for vhost-scsi with KVM in-kernel
	MSI injection
Date: Mon, 13 Aug 2012 11:51:17 +0300
Message-ID: <20120813085117.GG14081@redhat.com>
References: <1344846917-7411-1-git-send-email-nab@linux-iscsi.org>
	<1344846917-7411-2-git-send-email-nab@linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1344846917-7411-2-git-send-email-nab@linux-iscsi.org>
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
Cc: Anthony Liguori <aliguori@us.ibm.com>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, lf-virt <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 13, 2012 at 08:35:12AM +0000, Nicholas A. Bellinger wrote:
> From: Nicholas Bellinger <nab@linux-iscsi.org>
> 
> This is required to get past the following assert with:
> 
> commit 1523ed9e1d46b0b54540049d491475ccac7e6421
> Author: Jan Kiszka <jan.kiszka@siemens.com>
> Date:   Thu May 17 10:32:39 2012 -0300
> 
>     virtio/vhost: Add support for KVM in-kernel MSI injection
> 
> Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Anthony Liguori <aliguori@us.ibm.com>
> Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>

Could you please add a bit more explanation why
this happens with virtio scsi and why this is valid?

> ---
>  hw/msix.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/hw/msix.c b/hw/msix.c
> index 800fc32..c1e6dc3 100644
> --- a/hw/msix.c
> +++ b/hw/msix.c
> @@ -544,6 +544,9 @@ void msix_unset_vector_notifiers(PCIDevice *dev)
>  {
>      int vector;
>  
> +    if (!dev->msix_vector_use_notifier && !dev->msix_vector_release_notifier)
> +        return;
> +
>      assert(dev->msix_vector_use_notifier &&
>             dev->msix_vector_release_notifier);
>  
> -- 
> 1.7.2.5
