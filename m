From: Amos Kong <akong@redhat.com>
Subject: Re: [PATCH] virtio-rng: complete have_data completion in removing
	device
Date: Wed, 6 Aug 2014 16:05:41 +0800
Message-ID: <20140806080541.GA3304@z.redhat.com>
References: <1407260115-26767-1-git-send-email-akong@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1407260115-26767-1-git-send-email-akong@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: amit.shah@redhat.com, kvm@vger.kernel.org, stable@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 06, 2014 at 01:35:15AM +0800, Amos Kong wrote:
> When we try to hot-remove a busy virtio-rng device from QEMU monitor,
> the device can't be hot-removed. Because virtio-rng driver hangs at
> wait_for_completion_killable().
> 
> This patch fixed the hang by completing have_data completion before
> unregistering a virtio-rng device.

Hi Amit,

Before applying this patch, it's blocking insider wait_for_completion_killable()                     
Applied this patch, wait_for_completion_killable() returns 0,
and vi->data_avail becomes 0, then rng_get_date() will return 0.

Is it expected result?

 
> Signed-off-by: Amos Kong <akong@redhat.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/char/hw_random/virtio-rng.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
> index 0027137..416b15c 100644
> --- a/drivers/char/hw_random/virtio-rng.c
> +++ b/drivers/char/hw_random/virtio-rng.c
> @@ -137,6 +137,7 @@ static void remove_common(struct virtio_device *vdev)
>  	struct virtrng_info *vi = vdev->priv;
>  
>  	vdev->config->reset(vdev);
> +	complete(&vi->have_data);
>  	vi->busy = false;
>  	if (vi->hwrng_register_done)
>  		hwrng_unregister(&vi->hwrng);
> -- 
> 1.9.3
> 
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization

-- 
			Amos.
