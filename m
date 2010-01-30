From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/3 v4] macvtap driver
Date: Sat, 30 Jan 2010 23:22:15 +0100
Message-ID: <201001302322.15237.arnd__43538.4627934129$1264891329$gmane$org@arndb.de>
References: <201001271104.20607.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201001271104.20607.arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Miller <davem@davemloft.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stephen Hemminger <shemminger@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

This is the fourth version of the macvtap driver,
based on the comments I got for the last version
I got a few days ago. Very few changes:

* release netdev in chardev open function so
  we can destroy it properly.
* Implement TUNSETSNDBUF
* fix sleeping call in rcu_read_lock
* Fix comment in namespace isolation patch
* Fix small context difference to make it apply
  to net-next

I can't really test here while travelling, so please
give it a go if you're interested in this driver.

	Arnd
