From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH net-next] virtio_net: Add ethtool stats
Date: Sun, 24 Dec 2017 10:16:40 -0800
Message-ID: <20171224101640.4b14002f__49549.4693670937$1514139318$gmane$org@xeon-e3>
References: <1513744837-2672-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1513744837-2672-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, "David S . Miller" <davem@davemloft.net>, "Michael S . Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 20 Dec 2017 13:40:37 +0900
Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp> wrote:

> +
> +static const struct virtnet_gstats virtnet_gstrings_stats[] = {
> +	{ "rx_packets",		VIRTNET_NETDEV_STAT(rx_packets) },
> +	{ "tx_packets",		VIRTNET_NETDEV_STAT(tx_packets) },
> +	{ "rx_bytes",		VIRTNET_NETDEV_STAT(rx_bytes) },
> +	{ "tx_bytes",		VIRTNET_NETDEV_STAT(tx_bytes) },
> +	{ "rx_dropped",		VIRTNET_NETDEV_STAT(rx_dropped) },
> +	{ "rx_length_errors",	VIRTNET_NETDEV_STAT(rx_length_errors) },
> +	{ "rx_frame_errors",	VIRTNET_NETDEV_STAT(rx_frame_errors) },
> +	{ "tx_dropped",		VIRTNET_NETDEV_STAT(tx_dropped) },
> +	{ "tx_fifo_errors",	VIRTNET_NETDEV_STAT(tx_fifo_errors) },
> +};
> +

Please do not merge pre-existing global stats into ethtool.
It just duplicates existing functionality.
