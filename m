From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net] virtio_net: Account for tx bytes and packets on
	sending xdp_frames
Date: Thu, 31 Jan 2019 09:45:23 -0800 (PST)
Message-ID: <20190131.094523.2248120325911339180.davem__25769.1266526066$1548966858$gmane$org@davemloft.net>
References: <1548934830-2389-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
	<20190131101516-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190131101516-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: hawk@kernel.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, dsahern@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Thu, 31 Jan 2019 10:25:17 -0500

> On Thu, Jan 31, 2019 at 08:40:30PM +0900, Toshiaki Makita wrote:
>> Previously virtnet_xdp_xmit() did not account for device tx counters,
>> which caused confusions.
>> To be consistent with SKBs, account them on freeing xdp_frames.
>> 
>> Reported-by: David Ahern <dsahern@gmail.com>
>> Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
> 
> Well we count them on receive so I guess it makes sense for consistency
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> however, I really wonder whether adding more and more standard net stack
> things like this will end up costing most of XDP its speed.
> 
> Should we instead make sure *not* to account XDP packets
> in any counters at all? XDP programs can use maps
> to do their own counting...

This has been definitely a discussion point, and something we should
develop a clear, strong, policy on.

David, Jesper, care to chime in where we ended up in that last thread
discussion this?
