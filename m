From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next 2/2] tuntap: free XDP dropped packets in a batch
Date: Sat, 17 Nov 2018 12:01:10 -0800 (PST)
Message-ID: <20181117.120110.1928716941460171365.davem__34982.2586322718$1542484760$gmane$org@davemloft.net>
References: <20181115094310.17307-1-jasowang@redhat.com>
	<20181115094310.17307-2-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181115094310.17307-2-jasowang@redhat.com>
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
Date: Thu, 15 Nov 2018 17:43:10 +0800

> Thanks to the batched XDP buffs through msg_control. Instead of
> calling put_page() for each page which involves a atomic operation,
> let's batch them by record the last page that needs to be freed and
> its refcnt count and free them in a batch.
> 
> Testpmd(virtio-user + vhost_net) + XDP_DROP shows 3.8% improvement.
> 
> Before: 4.71Mpps
> After : 4.89Mpps
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied.
