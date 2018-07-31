From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next 1/2] virtio-net: correctly update XDP_TX counters
Date: Tue, 31 Jul 2018 10:03:16 -0700 (PDT)
Message-ID: <20180731.100316.237748978913578486.davem@davemloft.net>
References: <1533030219-9904-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1533030219-9904-1-git-send-email-jasowang@redhat.com>
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
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Tue, 31 Jul 2018 17:43:38 +0800

> Commit 5b8f3c8d30a6 ("virtio_net: Add XDP related stats") tries to
> count TX XDP stats in virtnet_receive(). This will cause several
> issues:
> 
> - virtnet_xdp_sq() was called without checking whether or not XDP is
>   set. This may cause out of bound access when there's no enough txq
>   for XDP.
> - Stats were updated even if there's no XDP/XDP_TX.
> 
> Fixing this by reusing virtnet_xdp_xmit() for XDP_TX which can counts
> TX XDP counter itself and remove the unnecessary tx stats embedded in
> rx stats.
> 
> Reported-by: syzbot+604f8271211546f5b3c7@syzkaller.appspotmail.com
> Fixes: 5b8f3c8d30a6 ("virtio_net: Add XDP related stats")
> Cc: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied.
