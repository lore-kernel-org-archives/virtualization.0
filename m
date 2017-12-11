From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ptr_ring: add barriers
Date: Mon, 11 Dec 2017 10:53:08 -0500 (EST)
Message-ID: <20171211.105308.1899676147655539775.davem__29096.4637803429$1513007625$gmane$org@davemloft.net>
References: <1512501990-30029-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1512501990-30029-1-git-send-email-mst@redhat.com>
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
Cc: george.cherian@cavium.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, edumazet@google.com
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Tue, 5 Dec 2017 21:29:37 +0200

> Users of ptr_ring expect that it's safe to give the
> data structure a pointer and have it be available
> to consumers, but that actually requires an smb_wmb
> or a stronger barrier.
> 
> In absence of such barriers and on architectures that reorder writes,
> consumer might read an un=initialized value from an skb pointer stored
> in the skb array.  This was observed causing crashes.
> 
> To fix, add memory barriers.  The barrier we use is a wmb, the
> assumption being that producers do not need to read the value so we do
> not need to order these reads.
> 
> Reported-by: George Cherian <george.cherian@cavium.com>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

I'm asked for asking for testing feedback and did not get it in a
reasonable amount of time.

So I'm applying this as-is, and queueing it up for -stable.

Thank you.
