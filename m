From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net] vhost: fix OOB in get_rx_bufs()
Date: Mon, 28 Jan 2019 22:54:44 -0800 (PST)
Message-ID: <20190128.225444.1929870241029842289.davem__25397.3379543581$1548826290$gmane$org@davemloft.net>
References: <20190128070505.18335-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190128070505.18335-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jasowang@redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Mon, 28 Jan 2019 15:05:05 +0800

> After batched used ring updating was introduced in commit e2b3b35eb989
> ("vhost_net: batch used ring update in rx"). We tend to batch heads in
> vq->heads for more than one packet. But the quota passed to
> get_rx_bufs() was not correctly limited, which can result a OOB write
> in vq->heads.
> 
>         headcount = get_rx_bufs(vq, vq->heads + nvq->done_idx,
>                     vhost_len, &in, vq_log, &log,
>                     likely(mergeable) ? UIO_MAXIOV : 1);
> 
> UIO_MAXIOV was still used which is wrong since we could have batched
> used in vq->heads, this will cause OOB if the next buffer needs more
> than 960 (1024 (UIO_MAXIOV) - 64 (VHOST_NET_BATCH)) heads after we've
> batched 64 (VHOST_NET_BATCH) heads:
 ...
> Fixing this by allocating UIO_MAXIOV + VHOST_NET_BATCH iovs for
> vhost-net. This is done through set the limitation through
> vhost_dev_init(), then set_owner can allocate the number of iov in a
> per device manner.
> 
> This fixes CVE-2018-16880.
> 
> Fixes: e2b3b35eb989 ("vhost_net: batch used ring update in rx")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied and queued up for -stable, thanks!
