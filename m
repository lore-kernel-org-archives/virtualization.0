From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/3] vhost: Check+skip uninitialized VQs in
	vhost_verify_ring_mappings
Date: Sun, 31 Mar 2013 10:45:16 +0300
Message-ID: <20130331074516.GC23484@redhat.com>
References: <1364531592-8368-1-git-send-email-nab@linux-iscsi.org>
	<1364531592-8368-4-git-send-email-nab@linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1364531592-8368-4-git-send-email-nab@linux-iscsi.org>
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

On Fri, Mar 29, 2013 at 04:33:12AM +0000, Nicholas A. Bellinger wrote:
> From: Nicholas Bellinger <nab@linux-iscsi.org>
> 
> With the virtio_queue_valid() checks in place to skip uninitialized VQs
> within virtio-pci code, go ahead and skip the same uninitialized VQs
> during vhost_verify_ring_mappings().
> 
> Note this patch does not prevent vhost_virtqueue_start() from executing
> by checking virtio_queue_valid(), as other logic during seabios ->
> virtio-scsi LLD guest hand-off appears to depend upon this execution.

Weird.
cpu_physical_memory_map only succeeds for PA==0 by chance,
we really should not depend on this.
So the right thing really should be to skip vhost_virtqueue_start IMHO,
maybe add an explicit valid flag in vhost_virtqueue
so vhost_verify_ring_mappings can check it.
What exactly does it do that is needed?

> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Asias He <asias@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
> ---
>  hw/vhost.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/hw/vhost.c b/hw/vhost.c
> index 4d6aee3..3a71aee 100644
> --- a/hw/vhost.c
> +++ b/hw/vhost.c
> @@ -314,6 +314,9 @@ static int vhost_verify_ring_mappings(struct vhost_dev *dev,
>          hwaddr l;
>          void *p;
>  
> +        if (!vq->ring_phys || !vq->ring_size) {
> +            continue;
> +        }
>          if (!ranges_overlap(start_addr, size, vq->ring_phys, vq->ring_size)) {
>              continue;
>          }
> -- 
> 1.7.2.5
