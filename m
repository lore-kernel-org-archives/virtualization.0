From: Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH net] virtio_net: Account for tx bytes and packets on
	sending xdp_frames
Date: Wed, 6 Feb 2019 14:48:14 +0100
Message-ID: <20190206144814.46996933__780.425900460102$1549469908$gmane$org@carbon>
References: <1548934830-2389-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
	<20190131101516-mutt-send-email-mst@kernel.org>
	<20190131.094523.2248120325911339180.davem@davemloft.net>
	<20190131211555.3b15c81f@carbon>
	<b8c97120-851f-450f-dc71-59350236329e@gmail.com>
	<20190204125307.08492005@redhat.com>
	<bdcfedd6-465d-4485-e268-25c4ce6b9fcf@gmail.com>
	<140ecbe1e25f54f90d859cc696c4119aa96bc6eb.camel@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <140ecbe1e25f54f90d859cc696c4119aa96bc6eb.camel@mellanox.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Saeed Mahameed <saeedm@mellanox.com>
Cc: "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>, "mst@redhat.com" <mst@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>, brouer@redhat.com, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "thoiland@redhat.com" <thoiland@redhat.com>, "dsahern@gmail.com" <dsahern@gmail.com>, "borkmann@iogearbox.net" <borkmann@iogearbox.net>, "davem@davemloft.net" <davem@davemloft.net>, Tariq Toukan <tariqt@mellanox.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 6 Feb 2019 00:06:33 +0000
Saeed Mahameed <saeedm@mellanox.com> wrote:

> 3) Unrelated, In non XDP case, if skb allocation fails or driver fails
> to pass the skb up to the stack for somereason, should the driver
> increase rx packets ? IMHO the answer should be yes if we want to have
> similar behavior between XDP and non XDP cases.

I don't think "skb allocation fails" should increase rx packets
counter.  The difference is that these events are outside sysadm/users
control, and is an error detected inside the driver.  The XDP program
takes a policy choice to XDP_DROP a packet, which can be accounted
inside the XDP prog (as the samples show) or as we also discuss via a
more generic XDP-action counters.

That said, I took at quick look at driver code, and it seems this
behavior differs per driver... ixgbe and mlx5 does not count "skb
allocation fails" as RX-ed packets, while mlx4 seems to count them.


> But this could result in netdev->stats.rx_packets +
> netdev->stats.rx_dropped to be more than the actual rx-ed packets, is
> this acceptable ?

This is one reasons I think this is wrong.

--Jesper
