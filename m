From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v11 4/4] tcm_vhost: Enable VIRTIO_SCSI_F_HOTPLUG
Date: Thu, 25 Apr 2013 10:40:48 +0300
Message-ID: <20130425074048.GE7857@redhat.com>
References: <1366875323-17639-1-git-send-email-asias@redhat.com>
	<1366875323-17639-5-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1366875323-17639-5-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 25, 2013 at 03:35:23PM +0800, Asias He wrote:
> Everything for hotplug is ready. Let's enable the feature bit.
> 
> Signed-off-by: Asias He <asias@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/vhost/tcm_vhost.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
> index 07217d8..1677238 100644
> --- a/drivers/vhost/tcm_vhost.c
> +++ b/drivers/vhost/tcm_vhost.c
> @@ -66,7 +66,8 @@ enum {
>   * TODO: debug and remove the workaround.
>   */
>  enum {
> -	VHOST_SCSI_FEATURES = VHOST_FEATURES & (~VIRTIO_RING_F_EVENT_IDX)
> +	VHOST_SCSI_FEATURES = (VHOST_FEATURES & (~VIRTIO_RING_F_EVENT_IDX)) |
> +			      (1ULL << VIRTIO_SCSI_F_HOTPLUG)
>  };
>  
>  #define VHOST_SCSI_MAX_TARGET	256
> -- 
> 1.8.1.4
