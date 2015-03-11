From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] uapi/virtio_scsi: allow overriding CDB/SENSE size
Date: Wed, 11 Mar 2015 14:31:51 +0100
Message-ID: <550043C7.3030301@redhat.com>
References: <20150311141903-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150311141903-mutt-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



On 11/03/2015 14:19, Michael S. Tsirkin wrote:
> QEMU wants to use virtio scsi structures with
> a different VIRTIO_SCSI_CDB_SIZE/VIRTIO_SCSI_SENSE_SIZE,
> let's add ifdefs to allow overriding them.
> 
> Keep the old defines under new names:
> VIRTIO_SCSI_CDB_DEFAULT_SIZE/VIRTIO_SCSI_SENSE_DEFAULT_SIZE,
> since that's what these values really are:
> defaults for cdb/sense size fields.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

QEMU will then use a zero-element array instead of a flexible array
member.  That's okay.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

> ---
>  include/uapi/linux/virtio_scsi.h | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/virtio_scsi.h b/include/uapi/linux/virtio_scsi.h
> index 42b9370..cc18ef8 100644
> --- a/include/uapi/linux/virtio_scsi.h
> +++ b/include/uapi/linux/virtio_scsi.h
> @@ -29,8 +29,16 @@
>  
>  #include <linux/virtio_types.h>
>  
> -#define VIRTIO_SCSI_CDB_SIZE   32
> -#define VIRTIO_SCSI_SENSE_SIZE 96
> +/* Default values of the CDB and sense data size configuration fields */
> +#define VIRTIO_SCSI_CDB_DEFAULT_SIZE   32
> +#define VIRTIO_SCSI_SENSE_DEFAULT_SIZE 96
> +
> +#ifndef VIRTIO_SCSI_CDB_SIZE
> +#define VIRTIO_SCSI_CDB_SIZE VIRTIO_SCSI_CDB_DEFAULT_SIZE
> +#endif
> +#ifndef VIRTIO_SCSI_SENSE_SIZE
> +#define VIRTIO_SCSI_SENSE_SIZE VIRTIO_SCSI_SENSE_DEFAULT_SIZE
> +#endif
>  
>  /* SCSI command request, followed by data-out */
>  struct virtio_scsi_cmd_req {
> 
