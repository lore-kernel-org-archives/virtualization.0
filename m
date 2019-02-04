From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net] virtio_net: Account for tx bytes and packets on
	sending xdp_frames
Date: Sun, 03 Feb 2019 20:18:39 -0800 (PST)
Message-ID: <20190203.201839.868838128610349474.davem__31956.3346494519$1549341633$gmane$org@davemloft.net>
References: <1548934830-2389-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1548934830-2389-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
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
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, dsahern@gmail.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Date: Thu, 31 Jan 2019 20:40:30 +0900

> Previously virtnet_xdp_xmit() did not account for device tx counters,
> which caused confusions.
> To be consistent with SKBs, account them on freeing xdp_frames.
> 
> Reported-by: David Ahern <dsahern@gmail.com>
> Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>

Applied, thank you.
