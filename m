From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2 2/5] VSOCK: support fill data to mergeable rx buffer
	in host
Date: Wed, 12 Dec 2018 21:59:05 -0800 (PST)
Message-ID: <20181212.215905.1657023590815103551.davem__47456.6854689785$1544680624$gmane$org@davemloft.net>
References: <5C10D4FB.6070009@huawei.com>
	<20181212.110944.1077302806391053539.davem@davemloft.net>
	<5C11CDF4.4040405@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5C11CDF4.4040405@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jiangyiwen@huawei.com
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: jiangyiwen <jiangyiwen@huawei.com>
Date: Thu, 13 Dec 2018 11:11:48 +0800

> I hope Host can fill fewer bytes into rx virtqueue, so
> I keep structure virtio_vsock_mrg_rxbuf_hdr one byte
> alignment.

The question is if this actully matters.

Do you know?

If the obejct this is embeeded inside of is at least 2 byte aligned,
you are marking it packed for nothing.

There are only %100 downsides to using the packed attribute.

Simply define your datastructures properly, with fixed sized types,
and all padding defined explicitly.
