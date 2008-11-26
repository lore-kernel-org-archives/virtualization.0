From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] virtio_net: large tx MTU support
Date: Wed, 26 Nov 2008 15:28:20 -0800 (PST)
Message-ID: <20081126.152820.52837825.davem__36694.8327668526$1227742330$gmane$org@davemloft.net>
References: <1227707891.9579.44.camel@blaa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1227707891.9579.44.camel@blaa>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: markmc@redhat.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Mark McLoughlin <markmc@redhat.com>
Date: Wed, 26 Nov 2008 13:58:11 +0000

> We don't really have a max tx packet size limit, so allow configuring
> the device with up to 64k tx MTU.
> 
> Signed-off-by: Mark McLoughlin <markmc@redhat.com>

Rusty, ACK?

If so, I'll toss this into net-next-2.6, thanks!
