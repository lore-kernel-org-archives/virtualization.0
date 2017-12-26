From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Subject: Re: [PATCH net-next] virtio_net: Add ethtool stats
Date: Tue, 26 Dec 2017 15:41:18 +0900
Message-ID: <ddac431f-9545-4ec7-8da4-804aea76d184__10569.5150247358$1514270422$gmane$org@lab.ntt.co.jp>
References: <1513744837-2672-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
	<20171224101640.4b14002f@xeon-e3>
	<be339a85-4368-257e-5f23-d0e35c77cd5b@lab.ntt.co.jp>
	<25B612A0-B4BD-4CE9-A166-8630F7F4BD76@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <25B612A0-B4BD-4CE9-A166-8630F7F4BD76@gmail.com>
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
To: Florian Fainelli <f.fainelli@gmail.com>, Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, "David S . Miller" <davem@davemloft.net>, "Michael S . Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 2017/12/26 1:47, Florian Fainelli wrote:
> On December 25, 2017 3:45:36 AM PST, Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp> wrote:
>> On 2017/12/25 3:16, Stephen Hemminger wrote:
>>> On Wed, 20 Dec 2017 13:40:37 +0900
>>> Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp> wrote:
>>>
>>>> +
>>>> +static const struct virtnet_gstats virtnet_gstrings_stats[] = {
>>>> +	{ "rx_packets",		VIRTNET_NETDEV_STAT(rx_packets) },
>>>> +	{ "tx_packets",		VIRTNET_NETDEV_STAT(tx_packets) },
>>>> +	{ "rx_bytes",		VIRTNET_NETDEV_STAT(rx_bytes) },
>>>> +	{ "tx_bytes",		VIRTNET_NETDEV_STAT(tx_bytes) },
>>>> +	{ "rx_dropped",		VIRTNET_NETDEV_STAT(rx_dropped) },
>>>> +	{ "rx_length_errors",	VIRTNET_NETDEV_STAT(rx_length_errors) },
>>>> +	{ "rx_frame_errors",	VIRTNET_NETDEV_STAT(rx_frame_errors) },
>>>> +	{ "tx_dropped",		VIRTNET_NETDEV_STAT(tx_dropped) },
>>>> +	{ "tx_fifo_errors",	VIRTNET_NETDEV_STAT(tx_fifo_errors) },
>>>> +};
>>>> +
>>>
>>> Please do not merge pre-existing global stats into ethtool.
>>> It just duplicates existing functionality.
>>
>> Thanks for the feedback.
>> I thought it's handy to be able to check stats like this in ethtool as
>> well. Some drivers like ixgbe and mlx5 do similar thing.
>> I can remove these duplicate stats (unless anyone has objection).
> 
> For existing drivers, ethtool stats are kind of user ABI, so once these stats get in, we should not consider removing them. For new drivers or existing drivers without ethtool stats, we can do things a bit better as Stephen suggested.

OK. will remove them in v2.

Thanks,
Toshiaki Makita
