From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2 1/5] VSOCK: support fill mergeable rx buffer in guest
Date: Wed, 12 Dec 2018 11:08:29 -0800 (PST)
Message-ID: <20181212.110829.1327856253463467975.davem__41905.6398830891$1544641588$gmane$org@davemloft.net>
References: <5C10D4B0.8080504@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5C10D4B0.8080504@huawei.com>
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
Date: Wed, 12 Dec 2018 17:28:16 +0800

> +static int fill_mergeable_rx_buff(struct virtio_vsock *vsock,
> +		struct virtqueue *vq)
> +{
> +	struct page_frag *alloc_frag = &vsock->alloc_frag;
> +	struct scatterlist sg;
> +	/* Currently we don't use ewma len, use PAGE_SIZE instead, because too
> +	 * small size can't fill one full packet, sadly we only 128 vq num now.
> +	 */
> +	unsigned int len = PAGE_SIZE, hole;
> +	void *buf;
> +	int err;

Please don't break up a set of local variable declarations with a
comment like this.  The comment seems to be about the initialization
of 'len', so move that initialization into the code below the variable
declarations and bring the comment along for the ride as well.
