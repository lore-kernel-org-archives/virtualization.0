From: Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH net] virtio_net: Account for tx bytes and packets on
	sending xdp_frames
Date: Thu, 31 Jan 2019 21:15:55 +0100
Message-ID: <20190131211555.3b15c81f__48235.7327289478$1548967336$gmane$org@carbon>
References: <1548934830-2389-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
	<20190131101516-mutt-send-email-mst@kernel.org>
	<20190131.094523.2248120325911339180.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190131.094523.2248120325911339180.davem@davemloft.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Miller <davem@davemloft.net>
Cc: hawk@kernel.org, mst@redhat.com, netdev@vger.kernel.org, dsahern@gmail.com, virtualization@lists.linux-foundation.org, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdl?= =?UTF-8?B?bnNlbg==?= <thoiland@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 31 Jan 2019 09:45:23 -0800 (PST)
David Miller <davem@davemloft.net> wrote:

> From: "Michael S. Tsirkin" <mst@redhat.com>
> Date: Thu, 31 Jan 2019 10:25:17 -0500
> 
> > On Thu, Jan 31, 2019 at 08:40:30PM +0900, Toshiaki Makita wrote:  
> >> Previously virtnet_xdp_xmit() did not account for device tx counters,
> >> which caused confusions.
> >> To be consistent with SKBs, account them on freeing xdp_frames.
> >> 
> >> Reported-by: David Ahern <dsahern@gmail.com>
> >> Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>  
> > 
> > Well we count them on receive so I guess it makes sense for consistency
> > 
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > however, I really wonder whether adding more and more standard net stack
> > things like this will end up costing most of XDP its speed.
> > 
> > Should we instead make sure *not* to account XDP packets
> > in any counters at all? XDP programs can use maps
> > to do their own counting...  
> 
> This has been definitely a discussion point, and something we should
> develop a clear, strong, policy on.
> 
> David, Jesper, care to chime in where we ended up in that last thread
> discussion this?

IHMO packets RX and TX on a device need to be accounted, in standard
counters, regardless of XDP.  For XDP RX the packet is counted as RX,
regardless if XDP choose to XDP_DROP.  On XDP TX which is via
XDP_REDIRECT or XDP_TX, the driver that transmit the packet need to
account the packet in a TX counter (this if often delayed to DMA TX
completion handling).  We cannot break the expectation that RX and TX
counter are visible to userspace stats tools. XDP should not make these
packets invisible.

Performance wise, I don't see an issue. As updating these counters
(packets and bytes) can be done as a bulk, either when driver NAPI RX
func ends, or in TX DMA completion, like most drivers already do today.
Further more, most drivers save this in per RX ring data-area, which
are only summed when userspace read these.


A separate question (and project) raised by David Ahern, was if we
should have more detailed stats on the different XDP action return
codes, as an easy means for sysadms to diagnose running XDP programs.
That is something that require more discussions, as it can impact
performance, and likely need to be opt-in.  My opinion is yes we should
do this for the sake of better User eXperience, BUT *only* if we can find
a technical solution that does not hurt performance.

--Jesper
