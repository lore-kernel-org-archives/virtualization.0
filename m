From: Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH 2/2] vhost: re-introducing metadata acceleration through
	kernel virtual address
Date: Fri,  6 Sep 2019 11:21:54 +0800
Message-ID: <20190906032154.9376-1-hdanton__23122.0118979522$1567740671$gmane$org@sina.com>
References: <20190905122736.19768-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190905122736.19768-1-jasowang@redhat.com>
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
Cc: aarcange@redhat.com, Christoph Hellwig <hch@infradead.org>, linux-parisc@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-mm@kvack.org, jglisse@redhat.com, jgg@mellanox.com, David Miller <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org


On Thu,  5 Sep 2019 20:27:36 +0800 From:   Jason Wang <jasowang@redhat.com>
> 
> +static void vhost_set_map_dirty(struct vhost_virtqueue *vq,
> +				struct vhost_map *map, int index)
> +{
> +	struct vhost_uaddr *uaddr = &vq->uaddrs[index];
> +	int i;
> +
> +	if (uaddr->write) {
> +		for (i = 0; i < map->npages; i++)
> +			set_page_dirty(map->pages[i]);
> +	}

Not sure need to set page dirty under page lock.
