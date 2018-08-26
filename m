From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net] vhost: correctly check the iova range when waking
	virtqueue
Date: Sat, 25 Aug 2018 17:40:21 -0700 (PDT)
Message-ID: <20180825.174021.1633894476704616364.davem__15237.3490542688$1535243902$gmane$org@davemloft.net>
References: <20180824085313.21798-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180824085313.21798-1-jasowang@redhat.com>
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
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Fri, 24 Aug 2018 16:53:13 +0800

> We don't wakeup the virtqueue if the first byte of pending iova range
> is the last byte of the range we just got updated. This will lead a
> virtqueue to wait for IOTLB updating forever. Fixing by correct the
> check and wake up the virtqueue in this case.
> 
> Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")
> Reported-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> The patch is needed for -stable.

Applied and queued up for -stable, thanks Jason.
