From: jiangyiwen <jiangyiwen@huawei.com>
Subject: Re: [PATCH v2 2/5] VSOCK: support fill data to mergeable rx buffer in
	host
Date: Thu, 13 Dec 2018 15:42:33 +0800
Message-ID: <5C120D69.10201__566.844494506036$1544686837$gmane$org@huawei.com>
References: <5C10D4FB.6070009@huawei.com>
	<20181212.110944.1077302806391053539.davem@davemloft.net>
	<5C11CDF4.4040405@huawei.com>
	<20181212.215905.1657023590815103551.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181212.215905.1657023590815103551.davem@davemloft.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Miller <davem@davemloft.net>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On 2018/12/13 13:59, David Miller wrote:
> From: jiangyiwen <jiangyiwen@huawei.com>
> Date: Thu, 13 Dec 2018 11:11:48 +0800
> 
>> I hope Host can fill fewer bytes into rx virtqueue, so
>> I keep structure virtio_vsock_mrg_rxbuf_hdr one byte
>> alignment.
> 
> The question is if this actully matters.
> 
> Do you know?
> 
> If the obejct this is embeeded inside of is at least 2 byte aligned,
> you are marking it packed for nothing.
> 
> There are only %100 downsides to using the packed attribute.
> 
> Simply define your datastructures properly, with fixed sized types,
> and all padding defined explicitly.
> 
> .
> 

Hi David,

Thanks a lot, I need to send number buffers from Host to Guest, so I think
we need to keep the structure size the same between host and guest.
But after your reminder, I feel my code may exist a serious problem,
that in mergeable mode, I send the total structure virtio_vsock_pkt
from Host to Guest, however, this structure size may be different
under different compilers (Guest and Host are different). Then, Guest
may parse the wrong packet length.

David, I want to ask if there is such a problem?

In addition, why I send total virtio_vsock_pkt structure from Host to Guest?
- In order to avoid to allocate virtio_vsock_pkt memory when receiving
  packets, in case of insufficient memory, it may have some advantages, and
  we may keep consistent with old version.

Thanks again,
Yiwen.
