From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [RFC-v2 1/6] msix: Work-around for vhost-scsi with KVM in-kernel
	MSI injection
Date: Mon, 13 Aug 2012 14:06:10 +0200
Message-ID: <5028EDB2.10506__48127.9424894184$1344860851$gmane$org@siemens.com>
References: <1344846917-7411-1-git-send-email-nab@linux-iscsi.org>
	<1344846917-7411-2-git-send-email-nab@linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: Anthony Liguori <aliguori@us.ibm.com>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, lf-virt <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On 2012-08-13 10:35, Nicholas A. Bellinger wrote:
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
> 

I think to remember pointing out that there is a bug somewhere in the
reset code which deactivates a non-active vhost instance, no?

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux
