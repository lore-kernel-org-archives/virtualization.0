From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC-v2 6/6] virtio-scsi: Fix incorrect VirtIOSCSI->cmd_vqs[0]
	definition
Date: Mon, 13 Aug 2012 12:02:59 +0300
Message-ID: <20120813090259.GJ14081@redhat.com>
References: <1344846917-7411-1-git-send-email-nab@linux-iscsi.org>
	<1344846917-7411-7-git-send-email-nab@linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1344846917-7411-7-git-send-email-nab@linux-iscsi.org>
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
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, lf-virt <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 13, 2012 at 08:35:17AM +0000, Nicholas A. Bellinger wrote:
> From: Nicholas Bellinger <nab@linux-iscsi.org>
> 
> This patch fixes bug in the definition of VirtIOSCSI->cmd_vqs[0],
> where the return of virtio_add_queue() in virtio_scsi_init() ends up
> overwriting past the end of ->cmd_vqs[0].
> 
> Since virtio_scsi currently assumes a single vqs for data, this patch
> simply changes ->cmd_vqs[1] to handle the single VirtQueue.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>

This is a bugfix we need even without vhost, right?

> ---
>  hw/virtio-scsi.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/hw/virtio-scsi.c b/hw/virtio-scsi.c
> index 5e2ff6b..2c70f89 100644
> --- a/hw/virtio-scsi.c
> +++ b/hw/virtio-scsi.c
> @@ -150,7 +150,7 @@ typedef struct {
>      bool events_dropped;
>      VirtQueue *ctrl_vq;
>      VirtQueue *event_vq;
> -    VirtQueue *cmd_vqs[0];
> +    VirtQueue *cmd_vqs[1];
>  
>      bool vhost_started;
>      VHostSCSI *vhost_scsi;
> -- 
> 1.7.2.5
