From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH 3/3] virtio_net: make lower netdevs for virtio_bypass
	hidden
Date: Tue, 3 Apr 2018 15:20:27 +0300
Message-ID: <20180403151915-mutt-send-email-mst__42593.3265513324$1522757912$gmane$org@kernel.org>
References: <1522573990-5242-1-git-send-email-si-wei.liu@oracle.com>
	<1522573990-5242-4-git-send-email-si-wei.liu@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1522573990-5242-4-git-send-email-si-wei.liu@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, jiri@resnulli.us, kubakici@wp.pl, sridhar.samudrala@intel.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Apr 01, 2018 at 05:13:10AM -0400, Si-Wei Liu wrote:
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index aa40664..0827b7e 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -80,6 +80,8 @@ struct virtio_net_config {
>  	__u16 max_virtqueue_pairs;
>  	/* Default maximum transmit unit advice */
>  	__u16 mtu;
> +	/* Device at bus:slot.function backed up by virtio_net */
> +	__u16 bsf2backup;
>  } __attribute__((packed));

I'm not sure this is a good interface.  This isn't unique even on some
PCI systems, not to speak of non-PCI ones.

>  /*
> -- 
> 1.8.3.1
