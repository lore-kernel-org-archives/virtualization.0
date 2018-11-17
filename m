From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next 1/2] vhost_net: mitigate page reference
	counting during page frag refill
Date: Sat, 17 Nov 2018 12:01:05 -0800 (PST)
Message-ID: <20181117.120105.1022512033566284108.davem@davemloft.net>
References: <20181115094310.17307-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181115094310.17307-1-jasowang@redhat.com>
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
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Thu, 15 Nov 2018 17:43:09 +0800

> We do a get_page() which involves a atomic operation. This patch tries
> to mitigate a per packet atomic operation by maintaining a reference
> bias which is initially USHRT_MAX. Each time a page is got, instead of
> calling get_page() we decrease the bias and when we find it's time to
> use a new page we will decrease the bias at one time through
> __page_cache_drain_cache().
> 
> Testpmd(virtio_user + vhost_net) + XDP_DROP on TAP shows about 1.6%
> improvement.
> 
> Before: 4.63Mpps
> After:  4.71Mpps
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied.
