From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net] vhost: synchronize IOTLB message with dev cleanup
Date: Thu, 24 May 2018 15:35:19 -0400 (EDT)
Message-ID: <20180524.153519.452683890193996505.davem__17028.1610255644$1527190402$gmane$org@davemloft.net>
References: <1526990337-24892-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1526990337-24892-1-git-send-email-jasowang@redhat.com>
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
Date: Tue, 22 May 2018 19:58:57 +0800

> DaeRyong Jeong reports a race between vhost_dev_cleanup() and
> vhost_process_iotlb_msg():
> 
> Thread interleaving:
> CPU0 (vhost_process_iotlb_msg)			CPU1 (vhost_dev_cleanup)
> (In the case of both VHOST_IOTLB_UPDATE and
> VHOST_IOTLB_INVALIDATE)
> =====						=====
> 						vhost_umem_clean(dev->iotlb);
> if (!dev->iotlb) {
> 	        ret = -EFAULT;
> 		        break;
> }
> 						dev->iotlb = NULL;
> 
> The reason is we don't synchronize between them, fixing by protecting
> vhost_process_iotlb_msg() with dev mutex.
> 
> Reported-by: DaeRyong Jeong <threeearcat@gmail.com>
> Fixes: 6b1e6cc7855b0 ("vhost: new device IOTLB API")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Michael, please review.
