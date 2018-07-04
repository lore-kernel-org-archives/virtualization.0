From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2 net-next 0/4] vhost_net: Avoid vq kicks during busyloop
Date: Wed, 04 Jul 2018 21:31:47 +0900 (KST)
Message-ID: <20180704.213147.556876353476580416.davem@davemloft.net>
References: <1530603094-2476-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: makita.toshiaki@lab.ntt.co.jp
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Date: Tue,  3 Jul 2018 16:31:30 +0900

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
 ...

Series applied, thank you.
