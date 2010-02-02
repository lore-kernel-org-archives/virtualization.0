From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/2] virtio_net: Defer skb allocation in receive path
	Date: Wed, 13 Jan 2010 12:53:38 -0800
Date: Tue, 02 Feb 2010 15:59:16 -0800 (PST)
Message-ID: <20100202.155916.136472373.davem__5577.20800065926$1265155177$gmane$org@davemloft.net>
References: <201001292346.43675.rusty@rustcorp.com.au>
	<201001292349.05360.rusty@rustcorp.com.au>
	<201001292350.04544.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201001292350.04544.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au
Cc: netdev@vger.kernel.org, mashirle@us.ibm.com, mst@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Rusty Russell <rusty@rustcorp.com.au>
Date: Fri, 29 Jan 2010 23:50:04 +1030

> From: Shirley Ma <mashirle@us.ibm.com>
> 
> virtio_net receives packets from its pre-allocated vring buffers, then it 
> delivers these packets to upper layer protocols as skb buffs. So it's not
> necessary to pre-allocate skb for each mergable buffer, then frees extra 
> skbs when buffers are merged into a large packet. This patch has deferred 
> skb allocation in receiving packets for both big packets and mergeable buffers
> to reduce skb pre-allocations and skb frees. It frees unused buffers by calling 
> detach_unused_buf in vring, so recv skb queue is not needed.
> 
> Signed-off-by: Shirley Ma <xma@us.ibm.com>
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Applied.
