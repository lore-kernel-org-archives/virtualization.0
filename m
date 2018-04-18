From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net: don't use kvzalloc for DMA memory
Date: Wed, 18 Apr 2018 13:46:51 -0400 (EDT)
Message-ID: <20180418.134651.2225112489265654270.davem__46972.4625502296$1524073516$gmane$org@davemloft.net>
References: <alpine.LRH.2.02.1804181029270.19294@file01.intranet.prod.int.rdu2.redhat.com>
	<3e65977e-53cd-bf09-bc4b-0ce40e9091fe@gmail.com>
	<alpine.LRH.2.02.1804181218270.19136@file01.intranet.prod.int.rdu2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LRH.2.02.1804181218270.19136@file01.intranet.prod.int.rdu2.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mpatocka@redhat.com
Cc: eric.dumazet@gmail.com, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, edumazet@google.com, joby.poriyath@citrix.com, bhutchings@solarflare.com
List-Id: virtualization@lists.linuxfoundation.org

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Wed, 18 Apr 2018 12:44:25 -0400 (EDT)

> The structure net_device is followed by arbitrary driver-specific data 
> (accessible with the function netdev_priv). And for virtio-net, these 
> driver-specific data must be in DMA memory.

And we are saying that this assumption is wrong and needs to be
corrected.
