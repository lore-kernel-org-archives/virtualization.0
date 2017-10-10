From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next v2] vhost_net: do not stall on zerocopy depletion
Date: Mon, 09 Oct 2017 20:47:12 -0700 (PDT)
Message-ID: <20171009.204712.443251456571733555.davem__42903.37020434$1507607246$gmane$org@davemloft.net>
References: <20171006172231.87435-1-willemdebruijn.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171006172231.87435-1-willemdebruijn.kernel@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: willemdebruijn.kernel@gmail.com
Cc: willemb@google.com, mst@redhat.com, netdev@vger.kernel.org, den@klaipeden.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Fri,  6 Oct 2017 13:22:31 -0400

> From: Willem de Bruijn <willemb@google.com>
> 
> Vhost-net has a hard limit on the number of zerocopy skbs in flight.
> When reached, transmission stalls. Stalls cause latency, as well as
> head-of-line blocking of other flows that do not use zerocopy.
> 
> Instead of stalling, revert to copy-based transmission.
> 
> Tested by sending two udp flows from guest to host, one with payload
> of VHOST_GOODCOPY_LEN, the other too small for zerocopy (1B). The
> large flow is redirected to a netem instance with 1MBps rate limit
> and deep 1000 entry queue.
> 
>   modprobe ifb
>   ip link set dev ifb0 up
>   tc qdisc add dev ifb0 root netem limit 1000 rate 1MBit
> 
>   tc qdisc add dev tap0 ingress
>   tc filter add dev tap0 parent ffff: protocol ip \
>       u32 match ip dport 8000 0xffff \
>       action mirred egress redirect dev ifb0
> 
> Before the delay, both flows process around 80K pps. With the delay,
> before this patch, both process around 400. After this patch, the
> large flow is still rate limited, while the small reverts to its
> original rate. See also discussion in the first link, below.
> 
> Without rate limiting, {1, 10, 100}x TCP_STREAM tests continued to
> send at 100% zerocopy.
> 
> The limit in vhost_exceeds_maxpend must be carefully chosen. With
> vq->num >> 1, the flows remain correlated. This value happens to
> correspond to VHOST_MAX_PENDING for vq->num == 256. Allow smaller
> fractions and ensure correctness also for much smaller values of
> vq->num, by testing the min() of both explicitly. See also the
> discussion in the second link below.
> 
> Changes
>   v1 -> v2
>     - replaced min with typed min_t
>     - avoid unnecessary whitespace change
> 
> Link:http://lkml.kernel.org/r/CAF=yD-+Wk9sc9dXMUq1+x_hh=3ThTXa6BnZkygP3tgVpjbp93g@mail.gmail.com
> Link:http://lkml.kernel.org/r/20170819064129.27272-1-den@klaipeden.com
> Signed-off-by: Willem de Bruijn <willemb@google.com>

Applied, thanks Willem.
