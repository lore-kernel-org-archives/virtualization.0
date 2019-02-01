From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Subject: Re: [PATCH net] virtio_net: Account for tx bytes and packets on
	sending xdp_frames
Date: Fri, 1 Feb 2019 10:53:44 +0900
Message-ID: <8cc0a8c8-39b4-a9c4-0ca0-ee4cc42ea42a__41315.4873227299$1549068540$gmane$org@lab.ntt.co.jp>
References: <1548934830-2389-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
	<20190131101516-mutt-send-email-mst@kernel.org>
	<20190131.094523.2248120325911339180.davem@davemloft.net>
	<20190131211555.3b15c81f@carbon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190131211555.3b15c81f@carbon>
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
To: Jesper Dangaard Brouer <brouer@redhat.com>, David Miller <davem@davemloft.net>
Cc: hawk@kernel.org, mst@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <thoiland@redhat.com>, dsahern@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On 2019/02/01 5:15, Jesper Dangaard Brouer wrote:
> On Thu, 31 Jan 2019 09:45:23 -0800 (PST)
> David Miller <davem@davemloft.net> wrote:
> 
>> From: "Michael S. Tsirkin" <mst@redhat.com>
>> Date: Thu, 31 Jan 2019 10:25:17 -0500
>>
>>> On Thu, Jan 31, 2019 at 08:40:30PM +0900, Toshiaki Makita wrote:  
>>>> Previously virtnet_xdp_xmit() did not account for device tx counters,
>>>> which caused confusions.
>>>> To be consistent with SKBs, account them on freeing xdp_frames.
>>>>
>>>> Reported-by: David Ahern <dsahern@gmail.com>
>>>> Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>  
>>>
>>> Well we count them on receive so I guess it makes sense for consistency
>>>
>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>>
>>> however, I really wonder whether adding more and more standard net stack
>>> things like this will end up costing most of XDP its speed.
>>>
>>> Should we instead make sure *not* to account XDP packets
>>> in any counters at all? XDP programs can use maps
>>> to do their own counting...  
>>
>> This has been definitely a discussion point, and something we should
>> develop a clear, strong, policy on.
>>
>> David, Jesper, care to chime in where we ended up in that last thread
>> discussion this?
> 
> IHMO packets RX and TX on a device need to be accounted, in standard
> counters, regardless of XDP.  For XDP RX the packet is counted as RX,
> regardless if XDP choose to XDP_DROP.  On XDP TX which is via
> XDP_REDIRECT or XDP_TX, the driver that transmit the packet need to
> account the packet in a TX counter (this if often delayed to DMA TX
> completion handling).  We cannot break the expectation that RX and TX
> counter are visible to userspace stats tools. XDP should not make these
> packets invisible.
> 
> Performance wise, I don't see an issue. As updating these counters
> (packets and bytes) can be done as a bulk, either when driver NAPI RX
> func ends, or in TX DMA completion, like most drivers already do today.
> Further more, most drivers save this in per RX ring data-area, which
> are only summed when userspace read these.

Agreed.

> A separate question (and project) raised by David Ahern, was if we
> should have more detailed stats on the different XDP action return
> codes, as an easy means for sysadms to diagnose running XDP programs.
> That is something that require more discussions, as it can impact
> performance, and likely need to be opt-in.  My opinion is yes we should
> do this for the sake of better User eXperience, BUT *only* if we can find
> a technical solution that does not hurt performance.

Basically the situation for the detailed stats is the same as standard
stats, at least in virtio_net. Stats are updated as a bulk, and the
counters reside in RX/TX ring structures.
Probably this way of implementation would be ok performance-wise?
But as other drivers may have different situations, if it is generally
difficult to avoid performance penalty I'm OK with making them opt-in as
a standard way.

-- 
Toshiaki Makita
