From: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH net] vhost: correctly check the iova range when waking
	virtqueue
Date: Fri, 24 Aug 2018 17:36:35 +0800
Message-ID: <20180824093635.GC3020__13649.1805002608$1535103283$gmane$org@xz-x1>
References: <20180824085313.21798-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Aug 24, 2018 at 04:53:13PM +0800, Jason Wang wrote:
> We don't wakeup the virtqueue if the first byte of pending iova range
> is the last byte of the range we just got updated. This will lead a
> virtqueue to wait for IOTLB updating forever. Fixing by correct the
> check and wake up the virtqueue in this case.
> 
> Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")
> Reported-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Without this patch, this command will trigger the IO hang merely every
time from host to guest:

  netperf -H 1.2.3.4 -l 5 -t TCP_RR -- -b 100

After applying, I can run it 10 times continuously without a problem.

Reviewed-by: Peter Xu <peterx@redhat.com>
Tested-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu
