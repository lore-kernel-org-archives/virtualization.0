From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] virtio-net: per cpu 64 bit stats (v2)
Date: Fri, 17 Jun 2011 15:18:21 -0400 (EDT)
Message-ID: <20110617.151821.1341973645484302135.davem__1171.02695298872$1308338341$gmane$org@davemloft.net>
References: <20110615114337.09fe62f6@s6510.ftrdhcpuser.net>
	<1308153538.3128.3.camel@edumazet-laptop>
	<20110615123629.6efae8aa@s6510.ftrdhcpuser.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110615123629.6efae8aa@s6510.ftrdhcpuser.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: shemminger@vyatta.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, eric.dumazet@gmail.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Stephen Hemminger <shemminger@vyatta.com>
Date: Wed, 15 Jun 2011 12:36:29 -0400

> Use per-cpu variables to maintain 64 bit statistics.
> 
> Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>

I'll apply this, thanks.
