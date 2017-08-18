From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v14 3/5] virtio-balloon: VIRTIO_BALLOON_F_SG
Date: Fri, 18 Aug 2017 15:39:27 +0800
Message-ID: <599699AF.1090705__49089.991374831$1503041838$gmane$org@intel.com>
References: <1502940416-42944-1-git-send-email-wei.w.wang@intel.com>
	<1502940416-42944-4-git-send-email-wei.w.wang@intel.com>
	<20170818051451-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170818051451-mutt-send-email-mst@kernel.org>
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
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mawilcox@microsoft.com, qemu-devel@nongnu.org, amit.shah@redhat.com, liliang.opensource@gmail.com, linux-kernel@vger.kernel.org, willy@infradead.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, mhocko@kernel.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On 08/18/2017 10:22 AM, Michael S. Tsirkin wrote:
> +static void send_balloon_page_sg(struct virtio_balloon *vb,
> +				 struct virtqueue *vq,
> +				 void *addr,
> +				 uint32_t size)
> +{
> +	unsigned int len;
> +	int ret;
> +
> +	do {
> +		ret = add_one_sg(vq, addr, size);
> +		virtqueue_kick(vq);
> +		wait_event(vb->acked, virtqueue_get_buf(vq, &len));
> +		/*
> +		 * It is uncommon to see the vq is full, because the sg is sent
> +		 * one by one and the device is able to handle it in time. But
> +		 * if that happens, we go back to retry after an entry gets
> +		 * released.
> +		 */
> Why send one by one though? Why not batch some s/gs and wait for all
> of them to be completed? If memory if fragmented, waiting every time is
> worse than what we have now (VIRTIO_BALLOON_ARRAY_PFNS_MAX at a time).
>

OK, I'll do batching in some fashion.


Best,
Wei
