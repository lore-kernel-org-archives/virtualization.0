From: Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: [PATCH net] virtio_net: Account for tx bytes and packets on
	sending xdp_frames
Date: Wed, 6 Feb 2019 07:52:16 -0800
Message-ID: <20190206075216.22b66d58__5476.26252971298$1549469921$gmane$org@cakuba.netronome.com>
References: <1548934830-2389-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
	<20190131101516-mutt-send-email-mst@kernel.org>
	<20190131.094523.2248120325911339180.davem@davemloft.net>
	<20190131211555.3b15c81f@carbon>
	<b8c97120-851f-450f-dc71-59350236329e@gmail.com>
	<20190204125307.08492005@redhat.com>
	<bdcfedd6-465d-4485-e268-25c4ce6b9fcf@gmail.com>
	<140ecbe1e25f54f90d859cc696c4119aa96bc6eb.camel@mellanox.com>
	<20190206144814.46996933@carbon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190206144814.46996933@carbon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Saeed Mahameed <saeedm@mellanox.com>, "thoiland@redhat.com" <thoiland@redhat.com>, "dsahern@gmail.com" <dsahern@gmail.com>, "borkmann@iogearbox.net" <borkmann@iogearbox.net>, "davem@davemloft.net" <davem@davemloft.net>, Tariq Toukan <tariqt@mellanox.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 6 Feb 2019 14:48:14 +0100, Jesper Dangaard Brouer wrote:
> On Wed, 6 Feb 2019 00:06:33 +0000
> Saeed Mahameed <saeedm@mellanox.com> wrote:
> 
> > 3) Unrelated, In non XDP case, if skb allocation fails or driver fails
> > to pass the skb up to the stack for somereason, should the driver
> > increase rx packets ? IMHO the answer should be yes if we want to have
> > similar behavior between XDP and non XDP cases.  
> 
> I don't think "skb allocation fails" should increase rx packets
> counter.  The difference is that these events are outside sysadm/users
> control, and is an error detected inside the driver.  The XDP program
> takes a policy choice to XDP_DROP a packet, which can be accounted
> inside the XDP prog (as the samples show) or as we also discuss via a
> more generic XDP-action counters.

FWIW that's my understanding as well.  My understanding of Linux stats
is that they are incrementing one counter per packet.  I.e. in RX
direction success packets are those given to the stack, and for TX
those given to the hardware.  Standards (IETF/IEEE) usually count stats
on the same layer boundary, but I think software generally counts when
it's done with the packet.

I haven't seen it documented anywhere, yet.  I have tried to document
it in the docs of the recent RFC:
https://patchwork.ozlabs.org/patch/1032332/

Incidentally XDP_DROP may have been better named XDP_DISCARD from stats
perspective ;)
