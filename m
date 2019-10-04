From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next] net, uapi: fix -Wpointer-arith warnings
Date: Fri, 04 Oct 2019 14:25:29 -0700 (PDT)
Message-ID: <20191004.142529.870317230438336454.davem__39469.5048032858$1570224342$gmane$org@davemloft.net>
References: <20191003202924.GA21016@avx2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191003202924.GA21016@avx2>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: adobriyan@gmail.com
Cc: jon.maloy@ericsson.com, mst@redhat.com, netdev@vger.kernel.org, fw@strlen.de, kadlec@netfilter.org, netfilter-devel@vger.kernel.org, ying.xue@windriver.com, virtualization@lists.linux-foundation.org, pablo@netfilter.org
List-Id: virtualization@lists.linuxfoundation.org

From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Thu, 3 Oct 2019 23:29:24 +0300

> Add casts to fix these warnings:
> 
> ./usr/include/linux/netfilter_arp/arp_tables.h:200:19: error: pointer of type 'void *' used in arithmetic [-Werror=pointer-arith]
> ./usr/include/linux/netfilter_bridge/ebtables.h:197:19: error: pointer of type 'void *' used in arithmetic [-Werror=pointer-arith]
> ./usr/include/linux/netfilter_ipv4/ip_tables.h:223:19: error: pointer of type 'void *' used in arithmetic [-Werror=pointer-arith]
> ./usr/include/linux/netfilter_ipv6/ip6_tables.h:263:19: error: pointer of type 'void *' used in arithmetic [-Werror=pointer-arith]
> ./usr/include/linux/tipc_config.h:310:28: error: pointer of type 'void *' used in arithmetic [-Werror=pointer-arith]
> ./usr/include/linux/tipc_config.h:410:24: error: pointer of type 'void *' used in arithmetic [-Werror=pointer-arith]
> ./usr/include/linux/virtio_ring.h:170:16: error: pointer of type 'void *' used in arithmetic [-Werror=pointer-arith]
> 
> Those are theoretical probably but kernel doesn't control compiler flags
> in userspace.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Applied.
