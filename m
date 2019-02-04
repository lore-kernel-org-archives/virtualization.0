From: Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH net] virtio_net: Account for tx bytes and packets on
	sending xdp_frames
Date: Mon, 4 Feb 2019 12:53:07 +0100
Message-ID: <20190204125307.08492005__48459.4487746776$1549341809$gmane$org@redhat.com>
References: <1548934830-2389-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
	<20190131101516-mutt-send-email-mst@kernel.org>
	<20190131.094523.2248120325911339180.davem@davemloft.net>
	<20190131211555.3b15c81f@carbon>
	<b8c97120-851f-450f-dc71-59350236329e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <b8c97120-851f-450f-dc71-59350236329e@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Ahern <dsahern@gmail.com>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>, hawk@kernel.org, mst@redhat.com, netdev@vger.kernel.org, brouer@redhat.com, John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux-foundation.org, Saeed Mahameed <saeedm@mellanox.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <thoiland@redhat.com>, Daniel Borkmann <borkmann@iogearbox.net>, David Miller <davem@davemloft.net>, Tariq Toukan <tariqt@mellanox.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 2 Feb 2019 14:27:26 -0700
David Ahern <dsahern@gmail.com> wrote:

> On 1/31/19 1:15 PM, Jesper Dangaard Brouer wrote:
> >>
> >> David, Jesper, care to chime in where we ended up in that last thread
> >> discussion this?  
> > 
> > IHMO packets RX and TX on a device need to be accounted, in standard
> > counters, regardless of XDP.  For XDP RX the packet is counted as RX,
> > regardless if XDP choose to XDP_DROP.  On XDP TX which is via
> > XDP_REDIRECT or XDP_TX, the driver that transmit the packet need to
> > account the packet in a TX counter (this if often delayed to DMA TX
> > completion handling).  We cannot break the expectation that RX and TX
> > counter are visible to userspace stats tools. XDP should not make these
> > packets invisible.  
> 
> Agreed. What I was pushing on that last thread was Rx, Tx and dropped
> are all accounted by the driver in standard stats. Basically if the
> driver touched it, the driver's counters should indicate that.

Sound like we all agree (except with the dropped counter, see below).

Do notice that mlx5 driver doesn't do this.  It is actually rather
confusing to use XDP on mlx5, as when XDP "consume" which include
XDP_DROP, XDP_REDIRECT or XDP_TX, then the driver standard stats are
not incremented... the packet is invisible to "ifconfig" stat based
tools.


> The push back was on dropped packets and whether that counter should be
> bumped on XDP_DROP.

My opinion is the XDP_DROP action should NOT increment the drivers drop
counter.  First of all the "dropped" counter is also use for other
stuff, which will confuse that this counter express.  Second, choosing
XDP_DROP is a policy choice, it still means it was RX-ed at the driver
level.

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
