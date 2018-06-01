From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next] virtio_net: fix error return code in
	virtnet_probe()
Date: Thu, 31 May 2018 22:50:50 -0400 (EDT)
Message-ID: <20180531.225050.158410894134322151.davem__48987.7202235677$1527821350$gmane$org@davemloft.net>
References: <1527732307-145609-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1527732307-145609-1-git-send-email-weiyongjun1@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: weiyongjun1@huawei.com
Cc: mst@redhat.com, sridhar.samudrala@intel.com, kernel-janitors@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Thu, 31 May 2018 02:05:07 +0000

> Fix to return a negative error code from the failover create fail error
> handling case instead of 0, as done elsewhere in this function.
> 
> Fixes: ba5e4426e80e ("virtio_net: Extend virtio to use VF datapath when available")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied.
