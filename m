From: David Miller <davem@davemloft.net>
Subject: Re: [RFC PATCH V2 3/3] vhost: access vq metadata through kernel
	virtual address
Date: Fri, 28 Dec 2018 11:34:44 -0800 (PST)
Message-ID: <20181228.113444.2162917443074434767.davem__40130.3674131215$1546025567$gmane$org@davemloft.net>
References: <20181228075537.21402-1-jasowang@redhat.com>
	<20181228075537.21402-4-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181228075537.21402-4-jasowang@redhat.com>
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
Date: Fri, 28 Dec 2018 15:55:37 +0800

> +static int vhost_invalidate_vmap(struct vhost_virtqueue *vq,
> +				 struct vhost_vmap *map,
> +				 unsigned long uaddr,
> +				 unsigned long start,
> +				 unsigned long end,
> +				 bool blockable)
> +{
> +	if (start < uaddr && end >= uaddr) {
> +		if (!blockable)
> +			return -EAGAIN;
> +		mutex_lock(&vq->mutex);
> +		if (map->addr)
> +			vunmap(map->unmap_addr);
> +		map->addr = NULL;
> +		map->unmap_addr = NULL;
> +		mutex_unlock(&vq->mutex);
> +	}
> +
> +	return 0;
> +}

What are the rules for these invalidate operations?

Can there be partial overlaps?  If so, wouldn't you need some way of
keeping track of the partially overlapping unmaps so that once all of
the invalidates covering the range occur you properly cleanup and do
the vunmap()?
