From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v14 3/5] virtio-balloon: VIRTIO_BALLOON_F_SG
Date: Mon, 21 Aug 2017 23:22:17 +0300
Message-ID: <20170821232052-mutt-send-email-mst__17525.6278984763$1503346945$gmane$org@kernel.org>
References: <1502940416-42944-1-git-send-email-wei.w.wang@intel.com>
	<1502940416-42944-4-git-send-email-wei.w.wang@intel.com>
	<20170818051451-mutt-send-email-mst@kernel.org>
	<599699AF.1090705@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <599699AF.1090705@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Wang <wei.w.wang@intel.com>
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mawilcox@microsoft.com, qemu-devel@nongnu.org, amit.shah@redhat.com, liliang.opensource@gmail.com, linux-kernel@vger.kernel.org, willy@infradead.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, mhocko@kernel.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Aug 18, 2017 at 03:39:27PM +0800, Wei Wang wrote:
> On 08/18/2017 10:22 AM, Michael S. Tsirkin wrote:
> > +static void send_balloon_page_sg(struct virtio_balloon *vb,
> > +				 struct virtqueue *vq,
> > +				 void *addr,
> > +				 uint32_t size)
> > +{
> > +	unsigned int len;
> > +	int ret;
> > +
> > +	do {
> > +		ret = add_one_sg(vq, addr, size);
> > +		virtqueue_kick(vq);
> > +		wait_event(vb->acked, virtqueue_get_buf(vq, &len));
> > +		/*
> > +		 * It is uncommon to see the vq is full, because the sg is sent
> > +		 * one by one and the device is able to handle it in time. But
> > +		 * if that happens, we go back to retry after an entry gets
> > +		 * released.
> > +		 */
> > Why send one by one though? Why not batch some s/gs and wait for all
> > of them to be completed? If memory if fragmented, waiting every time is
> > worse than what we have now (VIRTIO_BALLOON_ARRAY_PFNS_MAX at a time).
> > 
> 
> OK, I'll do batching in some fashion.
> 
> 
> Best,
> Wei
> 
> 

btw you need to address the build errors that kbot has found.

-- 
MST
