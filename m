From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] vhost/vsock: fix vhost vsock cid hashing inconsistent
Date: Fri, 11 Jan 2019 17:48:42 -0800 (PST)
Message-ID: <20190111.174842.384650779633296454.davem__45480.8125192814$1547693147$gmane$org@davemloft.net>
References: <20190108080703.70050-1-zhabin@linux.alibaba.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190108080703.70050-1-zhabin@linux.alibaba.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: zhabin@linux.alibaba.com
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com, kata-dev@lists.katacontainers.io, gerry@linux.alibaba.com
List-Id: virtualization@lists.linuxfoundation.org

From: Zha Bin <zhabin@linux.alibaba.com>
Date: Tue,  8 Jan 2019 16:07:03 +0800

> The vsock core only supports 32bit CID, but the Virtio-vsock spec define
> CID (dst_cid and src_cid) as u64 and the upper 32bits is reserved as
> zero. This inconsistency causes one bug in vhost vsock driver. The
> scenarios is:
> 
>   0. A hash table (vhost_vsock_hash) is used to map an CID to a vsock
>   object. And hash_min() is used to compute the hash key. hash_min() is
>   defined as:
>   (sizeof(val) <= 4 ? hash_32(val, bits) : hash_long(val, bits)).
>   That means the hash algorithm has dependency on the size of macro
>   argument 'val'.
>   0. In function vhost_vsock_set_cid(), a 64bit CID is passed to
>   hash_min() to compute the hash key when inserting a vsock object into
>   the hash table.
>   0. In function vhost_vsock_get(), a 32bit CID is passed to hash_min()
>   to compute the hash key when looking up a vsock for an CID.
> 
> Because the different size of the CID, hash_min() returns different hash
> key, thus fails to look up the vsock object for an CID.
> 
> To fix this bug, we keep CID as u64 in the IOCTLs and virtio message
> headers, but explicitly convert u64 to u32 when deal with the hash table
> and vsock core.
> 
> Fixes: 834e772c8db0 ("vhost/vsock: fix use-after-free in network stack callers")
> Link: https://github.com/stefanha/virtio/blob/vsock/trunk/content.tex
> Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
> Reviewed-by: Liu Jiang <gerry@linux.alibaba.com>

Applied, thank you.
