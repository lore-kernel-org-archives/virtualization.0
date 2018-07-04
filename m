From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 net-next 0/4] vhost_net: Avoid vq kicks during busyloop
Date: Wed, 4 Jul 2018 08:35:30 +0300
Message-ID: <20180704083506-mutt-send-email-mst@kernel.org>
References: <1530603094-2476-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1530603094-2476-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 03, 2018 at 04:31:30PM +0900, Toshiaki Makita wrote:
> Under heavy load vhost tx busypoll tend not to suppress vq kicks, which
> causes poor guest tx performance. The detailed scenario is described in
> commitlog of patch 2.
> Rx seems not to have that serious problem, but for consistency I made a
> similar change on rx to avoid rx wakeups (patch 3).
> Additionary patch 4 is to avoid rx kicks under heavy load during
> busypoll.
> 
> Tx performance is greatly improved by this change. I don't see notable
> performance change on rx with this series though.
> 
> Performance numbers (tx):
> 
> - Bulk transfer from guest to external physical server.
>     [Guest]->vhost_net->tap--(XDP_REDIRECT)-->i40e --(wire)--> [Server]
> - Set 10us busypoll.
> - Guest disables checksum and TSO because of host XDP.
> - Measured single flow Mbps by netperf, and kicks by perf kvm stat
>   (EPT_MISCONFIG event).
> 
>                             Before              After
>                           Mbps  kicks/s      Mbps  kicks/s
> UDP_STREAM 1472byte              247758                 27
>                 Send   3645.37            6958.10
>                 Recv   3588.56            6958.10
>               1byte                9865                 37
>                 Send      4.34               5.43
>                 Recv      4.17               5.26
> TCP_STREAM             8801.03    45794   9592.77     2884

Thanks!
Series:

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> v2:
> - Split patches into 3 parts (renaming variables, tx-kick fix, rx-wakeup
>   fix).
> - Avoid rx-kicks too (patch 4).
> - Don't memorize endtime as it is not needed for now.
> 
> Toshiaki Makita (4):
>   vhost_net: Rename local variables in vhost_net_rx_peek_head_len
>   vhost_net: Avoid tx vring kicks during busyloop
>   vhost_net: Avoid rx queue wake-ups during busypoll
>   vhost_net: Avoid rx vring kicks during busyloop
> 
>  drivers/vhost/net.c | 95 +++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 60 insertions(+), 35 deletions(-)
> 
> -- 
> 1.8.3.1
> 
