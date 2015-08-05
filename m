From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio-input: reset device during remove
Date: Wed, 5 Aug 2015 10:56:08 +0300
Message-ID: <20150805104654-mutt-send-email-mst__32603.6680060954$1438761388$gmane$org@redhat.com>
References: <1438759218-30038-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1438759218-30038-1-git-send-email-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 05, 2015 at 03:20:18PM +0800, Jason Wang wrote:
> Spec requires a device reset during cleanup, so do it and avoid warn
> in virtio core.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

OK but now that I look at this driver, that's not enough.

Need to also detach and free unused buffers, otherwise
we leak memory in evt and sts queues.



> ---
>  drivers/virtio/virtio_input.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
> index 60e2a16..6222f9b 100644
> --- a/drivers/virtio/virtio_input.c
> +++ b/drivers/virtio/virtio_input.c
> @@ -320,6 +320,7 @@ static void virtinput_remove(struct virtio_device *vdev)
>  	spin_unlock_irqrestore(&vi->lock, flags);
>  
>  	input_unregister_device(vi->idev);
> +	vdev->config->reset(vdev);
>  	vdev->config->del_vqs(vdev);
>  	kfree(vi);
>  }
> -- 
> 2.1.4
