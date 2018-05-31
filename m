From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next] virtio_net: fix error return code in
	virtnet_probe()
Date: Thu, 31 May 2018 20:37:39 +0300
Message-ID: <20180531203733-mutt-send-email-mst__29051.8765840263$1527788160$gmane$org@kernel.org>
References: <1527732307-145609-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1527732307-145609-1-git-send-email-weiyongjun1@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 31, 2018 at 02:05:07AM +0000, Wei Yongjun wrote:
> Fix to return a negative error code from the failover create fail error
> handling case instead of 0, as done elsewhere in this function.
> 
> Fixes: ba5e4426e80e ("virtio_net: Extend virtio to use VF datapath when available")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8f08a3e..2d55e2a 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2935,8 +2935,10 @@ static int virtnet_probe(struct virtio_device *vdev)
>  
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_STANDBY)) {
>  		vi->failover = net_failover_create(vi->dev);
> -		if (IS_ERR(vi->failover))
> +		if (IS_ERR(vi->failover)) {
> +			err = PTR_ERR(vi->failover);
>  			goto free_vqs;
> +		}
>  	}
>  
>  	err = register_netdev(dev);
