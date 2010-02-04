From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 0/3 v4] macvtap driver
Date: Wed, 03 Feb 2010 20:21:04 -0800 (PST)
Message-ID: <20100203.202104.151098461.davem__41138.7795270004$1265257571$gmane$org@davemloft.net>
References: <201001271104.20607.arnd@arndb.de>
	<201001302322.15237.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201001302322.15237.arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: arnd@arndb.de
Cc: herbert@gondor.apana.org.au, mst@redhat.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, shemminger@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 30 Jan 2010 23:22:15 +0100

> This is the fourth version of the macvtap driver,
> based on the comments I got for the last version
> I got a few days ago. Very few changes:
> 
> * release netdev in chardev open function so
>   we can destroy it properly.
> * Implement TUNSETSNDBUF
> * fix sleeping call in rcu_read_lock
> * Fix comment in namespace isolation patch
> * Fix small context difference to make it apply
>   to net-next
> 
> I can't really test here while travelling, so please
> give it a go if you're interested in this driver.

All applied to net-next-2.6, thanks!
