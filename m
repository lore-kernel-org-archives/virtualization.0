From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v2] vhost: block speculation of translated descriptors
Date: Wed, 11 Sep 2019 14:16:28 +0200
Message-ID: <20190911121628.GT4023@dhcp22.suse.cz>
References: <20190911120908.28410-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190911120908.28410-1-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed 11-09-19 08:10:00, Michael S. Tsirkin wrote:
> iovec addresses coming from vhost are assumed to be
> pre-validated, but in fact can be speculated to a value
> out of range.
> 
> Userspace address are later validated with array_index_nospec so we can
> be sure kernel info does not leak through these addresses, but vhost
> must also not leak userspace info outside the allowed memory table to
> guests.
> 
> Following the defence in depth principle, make sure
> the address is not validated out of node range.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Tested-by: Jason Wang <jasowang@redhat.com>

no need to mark fo stable? Other spectre fixes tend to be backported
even when the security implications are not really clear. The risk
should be low and better to be covered in case.

> ---
> 
> changes from v1: fix build on 32 bit
> 
>  drivers/vhost/vhost.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 5dc174ac8cac..34ea219936e3 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2071,8 +2071,10 @@ static int translate_desc(struct vhost_virtqueue *vq, u64 addr, u32 len,
>  		_iov = iov + ret;
>  		size = node->size - addr + node->start;
>  		_iov->iov_len = min((u64)len - s, size);
> -		_iov->iov_base = (void __user *)(unsigned long)
> -			(node->userspace_addr + addr - node->start);
> +		_iov->iov_base = (void __user *)
> +			((unsigned long)node->userspace_addr +
> +			 array_index_nospec((unsigned long)(addr - node->start),
> +					    node->size));
>  		s += size;
>  		addr += size;
>  		++ret;
> -- 
> MST

-- 
Michal Hocko
SUSE Labs
