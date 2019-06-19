From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/1] scsi: virtio_scsi: remove unused 'affinity_hint_set'
Date: Wed, 19 Jun 2019 12:24:01 +0200
Message-ID: <c111c5a3-1602-e935-300d-d75e14fe2bd9__21600.265363098$1560939846$gmane$org@redhat.com>
References: <1560930739-25692-1-git-send-email-dongli.zhang@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1560930739-25692-1-git-send-email-dongli.zhang@oracle.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dongli Zhang <dongli.zhang@oracle.com>, virtualization@lists.linux-foundation.org, linux-scsi@vger.kernel.org
Cc: martin.petersen@oracle.com, mst@redhat.com, linux-kernel@vger.kernel.org, stefanha@redhat.com, jejb@linux.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On 19/06/19 09:52, Dongli Zhang wrote:
> The 'affinity_hint_set' is not used any longer since
> commit 0d9f0a52c8b9 ("virtio_scsi: use virtio IRQ affinity").
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  drivers/scsi/virtio_scsi.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> index 13f1b3b..1705398 100644
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -74,9 +74,6 @@ struct virtio_scsi {
>  
>  	u32 num_queues;
>  
> -	/* If the affinity hint is set for virtqueues */
> -	bool affinity_hint_set;
> -
>  	struct hlist_node node;
>  
>  	/* Protected by event_vq lock */
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
