From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v13 3/5] virtio-balloon: VIRTIO_BALLOON_F_SG
Date: Thu, 3 Aug 2017 18:55:50 +0300
Message-ID: <20170803185508-mutt-send-email-mst__34248.0548112237$1501795346$gmane$org@kernel.org>
References: <1501742299-4369-1-git-send-email-wei.w.wang@intel.com>
	<1501742299-4369-4-git-send-email-wei.w.wang@intel.com>
	<20170803151212-mutt-send-email-mst@kernel.org>
	<286AC319A985734F985F78AFA26841F73928C952@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <286AC319A985734F985F78AFA26841F73928C952@shsmsx102.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "aarcange@redhat.com" <aarcange@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mawilcox@microsoft.com" <mawilcox@microsoft.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mhocko@kernel.org" <mhocko@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 03, 2017 at 03:17:59PM +0000, Wang, Wei W wrote:
> On Thursday, August 3, 2017 10:23 PM, Michael S. Tsirkin wrote:
> > On Thu, Aug 03, 2017 at 02:38:17PM +0800, Wei Wang wrote:
> > > +static void send_one_sg(struct virtio_balloon *vb, struct virtqueue *vq,
> > > +			void *addr, uint32_t size)
> > > +{
> > > +	struct scatterlist sg;
> > > +	unsigned int len;
> > > +
> > > +	sg_init_one(&sg, addr, size);
> > > +	while (unlikely(virtqueue_add_inbuf(vq, &sg, 1, vb, GFP_KERNEL)
> > > +			== -ENOSPC)) {
> > > +		/*
> > > +		 * It is uncommon to see the vq is full, because the sg is sent
> > > +		 * one by one and the device is able to handle it in time. But
> > > +		 * if that happens, we kick and wait for an entry is released.
> > 
> > is released -> to get used.
> > 
> > > +		 */
> > > +		virtqueue_kick(vq);
> > > +		while (!virtqueue_get_buf(vq, &len) &&
> > > +		       !virtqueue_is_broken(vq))
> > > +			cpu_relax();
> > 
> > Please rework to use wait_event in that case too.
> 
> For the balloon page case here, it is fine to use wait_event. But for the free page
> case, I think it might not be suitable because the mm lock is being held.
> 
> Best,
> Wei

You will have to find a way to drop the lock and restart from where you
stopped then.

-- 
MST
