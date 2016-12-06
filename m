From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] virtio-net: Fix DMA-from-the-stack in
	virtnet_set_mac_address()
Date: Tue, 06 Dec 2016 11:39:01 -0500 (EST)
Message-ID: <20161206.113901.1729006808840379027.davem__24740.9878801138$1481042355$gmane$org@davemloft.net>
References: <fe889e578d5dffa9ae0834b449a35fcfd1e10694.1480990173.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <fe889e578d5dffa9ae0834b449a35fcfd1e10694.1480990173.git.luto@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: luto@kernel.org
Cc: mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, labbott@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Andy Lutomirski <luto@kernel.org>
Date: Mon,  5 Dec 2016 18:10:58 -0800

> With CONFIG_VMAP_STACK=y, virtnet_set_mac_address() can be passed a
> pointer to the stack and it will OOPS.  Copy the address to the heap
> to prevent the crash.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Laura Abbott <labbott@redhat.com>
> Reported-by: zbyszek@in.waw.pl
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

Applied, thanks.
