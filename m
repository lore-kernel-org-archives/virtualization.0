From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] scsi: virtio_scsi: unplug LUNs when events missed
Date: Wed, 4 Sep 2019 05:14:33 -0400
Message-ID: <20190904051230-mutt-send-email-mst__31555.9778989822$1567588511$gmane$org@kernel.org>
References: <20190903170408.32286-1-mlupfer@ddn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190903170408.32286-1-mlupfer@ddn.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Matt Lupfer <mlupfer@ddn.com>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "Martin K . Petersen" <martin.petersen@oracle.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "James E . J . Bottomley" <jejb@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Sep 03, 2019 at 05:04:20PM +0000, Matt Lupfer wrote:
> The event handler calls scsi_scan_host() when events are missed, which
> will hotplug new LUNs.  However, this function won't remove any
> unplugged LUNs.  The result is that hotunplug doesn't work properly when
> the number of unplugged LUNs exceeds the event queue size (currently 8).
> 
> Scan existing LUNs when events are missed to check if they are still
> present.  If not, remove them.
> 
> Signed-off-by: Matt Lupfer <mlupfer@ddn.com>
> ---
>  drivers/scsi/virtio_scsi.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> index 297e1076e571..18df77bf371b 100644
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -324,6 +324,36 @@ static void virtscsi_handle_param_change(struct virtio_scsi *vscsi,
>  	scsi_device_put(sdev);
>  }
>  
> +static void virtscsi_rescan_hotunplug(struct virtio_scsi *vscsi)
> +{
> +	struct scsi_device *sdev;
> +	struct Scsi_Host *shost = virtio_scsi_host(vscsi->vdev);
> +	unsigned char scsi_cmd[MAX_COMMAND_SIZE];
> +	int result, inquiry_len, inq_result_len = 256;
> +	char *inq_result = kmalloc(inq_result_len, GFP_KERNEL);
> +
> +	shost_for_each_device(sdev, shost) {
> +		inquiry_len = sdev->inquiry_len ? sdev->inquiry_len : 36;
> +
> +		memset(scsi_cmd, 0, sizeof(scsi_cmd));
> +		scsi_cmd[0] = INQUIRY;
> +		scsi_cmd[4] = (unsigned char) inquiry_len;
> +
> +		memset(inq_result, 0, inq_result_len);
> +
> +		result = scsi_execute_req(sdev, scsi_cmd, DMA_FROM_DEVICE,
> +					  inq_result, inquiry_len, NULL,
> +					  2, 3, NULL);


Where do the weird 2 and 3 values come from?

Most callers seem to use SD_TIMEOUT, SD_MAX_RETRIES...

> +
> +		if (result == 0 && inq_result[0] >> 5) {
> +			/* PQ indicates the LUN is not attached */
> +			scsi_remove_device(sdev);
> +		}
> +	}
> +
> +	kfree(inq_result);
> +}
> +
>  static void virtscsi_handle_event(struct work_struct *work)
>  {
>  	struct virtio_scsi_event_node *event_node =
> @@ -335,6 +365,7 @@ static void virtscsi_handle_event(struct work_struct *work)
>  	    cpu_to_virtio32(vscsi->vdev, VIRTIO_SCSI_T_EVENTS_MISSED)) {
>  		event->event &= ~cpu_to_virtio32(vscsi->vdev,
>  						   VIRTIO_SCSI_T_EVENTS_MISSED);
> +		virtscsi_rescan_hotunplug(vscsi);
>  		scsi_scan_host(virtio_scsi_host(vscsi->vdev));
>  	}
>  
> -- 
> 2.23.0
