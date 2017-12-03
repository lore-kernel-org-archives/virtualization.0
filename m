From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net,stable v4 0/3] vhost: fix a few skb leaks
Date: Sat, 02 Dec 2017 21:32:00 -0500 (EST)
Message-ID: <20171202.213200.1846298318047197403.davem@davemloft.net>
References: <1512123038-15773-1-git-send-email-wexu@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1512123038-15773-1-git-send-email-wexu@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: wexu@redhat.com
Cc: mjrosato@linux.vnet.ibm.com, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: wexu@redhat.com
Date: Fri,  1 Dec 2017 05:10:35 -0500

> Matthew found a roughly 40% tcp throughput regression with commit
> c67df11f(vhost_net: try batch dequing from skb array) as discussed
> in the following thread:
> https://www.mail-archive.com/netdev@vger.kernel.org/msg187936.html

Series applied and queued up for -stable.
