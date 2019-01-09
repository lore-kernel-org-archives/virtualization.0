From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] vhost/vsock: fix vhost vsock cid hashing inconsistent
Date: Wed, 9 Jan 2019 09:21:22 +0100
Message-ID: <3dc7c965-6847-029d-7163-01d3f40897b7@de.ibm.com>
References: <20190108080703.70050-1-zhabin@linux.alibaba.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190108080703.70050-1-zhabin@linux.alibaba.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zha Bin <zhabin@linux.alibaba.com>, stefanha@redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Peter Morjan <peter.morjan@de.ibm.com>, kata-dev@lists.katacontainers.io, gerry@linux.alibaba.com
List-Id: virtualization@lists.linuxfoundation.org

Adding Peter,

is this the same problem that you reported me today?
Can you test Zha Bins patch?

Christian

On 08.01.2019 09:07, Zha Bin wrote:
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
> ---
>  drivers/vhost/vsock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index bc42d38ae031..3fbc068eaa9b 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -642,7 +642,7 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
>  		hash_del_rcu(&vsock->hash);
>  
>  	vsock->guest_cid = guest_cid;
> -	hash_add_rcu(vhost_vsock_hash, &vsock->hash, guest_cid);
> +	hash_add_rcu(vhost_vsock_hash, &vsock->hash, vsock->guest_cid);
>  	mutex_unlock(&vhost_vsock_mutex);
>  
>  	return 0;
> 
