From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next] vhost_net: disable zerocopy by default
Date: Mon, 17 Jun 2019 13:58:21 -0700 (PDT)
Message-ID: <20190617.135821.1970853531857836652.davem__24479.7872657486$1560805118$gmane$org@davemloft.net>
References: <20190617092054.12299-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190617092054.12299-1-jasowang@redhat.com>
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
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, huhai@kylinos.cn
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jun 2019 05:20:54 -0400

> Vhost_net was known to suffer from HOL[1] issues which is not easy to
> fix. Several downstream disable the feature by default. What's more,
> the datapath was split and datacopy path got the support of batching
> and XDP support recently which makes it faster than zerocopy part for
> small packets transmission.
> 
> It looks to me that disable zerocopy by default is more
> appropriate. It cold be enabled by default again in the future if we
> fix the above issues.
> 
> [1] https://patchwork.kernel.org/patch/3787671/
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied, thanks Jason.
