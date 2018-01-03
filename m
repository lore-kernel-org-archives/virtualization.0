From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next 1/2] virtio_net: Introduce VIRTIO_NET_F_MASTER
	feature bit
Date: Wed, 03 Jan 2018 11:36:13 -0500 (EST)
Message-ID: <20180103.113613.853688806332918499.davem__6746.45803305811$1514997285$gmane$org@davemloft.net>
References: <1514939738-22423-1-git-send-email-sridhar.samudrala@intel.com>
	<1514939738-22423-2-git-send-email-sridhar.samudrala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1514939738-22423-2-git-send-email-sridhar.samudrala@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: sridhar.samudrala@intel.com
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Tue,  2 Jan 2018 16:35:37 -0800

> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index fc353b518288..a9b4e0836786 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -56,6 +56,7 @@
>  #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
>  					 * Steering */
>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
> +#define VIRTIO_NET_F_MASTER	62	/* act as master for a VF device */

Please respin this series with something in this commit message which
explains why we are using "62" rather than something like "24" here.

Thank you.
