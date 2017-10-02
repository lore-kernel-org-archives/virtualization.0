From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v16 3/5] virtio-balloon: VIRTIO_BALLOON_F_SG
Date: Mon, 2 Oct 2017 16:44:52 +0300
Message-ID: <20171002160757-mutt-send-email-mst__27995.7210565501$1506951925$gmane$org@kernel.org>
References: <1506744354-20979-1-git-send-email-wei.w.wang@intel.com>
	<1506744354-20979-4-git-send-email-wei.w.wang@intel.com>
	<20171002072106-mutt-send-email-mst@kernel.org>
	<286AC319A985734F985F78AFA26841F73931FDB5@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <286AC319A985734F985F78AFA26841F73931FDB5@shsmsx102.ccr.corp.intel.com>
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
Cc: "aarcange@redhat.com" <aarcange@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mawilcox@microsoft.com" <mawilcox@microsoft.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "willy@infradead.org" <willy@infradead.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, mhocko@kernel.or
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Oct 02, 2017 at 12:39:30PM +0000, Wang, Wei W wrote:
> On Monday, October 2, 2017 12:30 PM, Michael S. Tsirkin wrote:
> > On Sat, Sep 30, 2017 at 12:05:52PM +0800, Wei Wang wrote:
> > > +static int send_balloon_page_sg(struct virtio_balloon *vb,
> > > +				 struct virtqueue *vq,
> > > +				 void *addr,
> > > +				 uint32_t size,
> > > +				 bool batch)
> > > +{
> > > +	int err;
> > > +
> > > +	err = add_one_sg(vq, addr, size);
> > > +
> > > +	/* If batchng is requested, we batch till the vq is full */
> > 
> > typo
> > 
> > > +	if (!batch || !vq->num_free)
> > > +		kick_and_wait(vq, vb->acked);
> > > +
> > > +	return err;
> > > +}
> > 
> > If add_one_sg fails, kick_and_wait will hang forever.
> > 
> > The reason this might work in because
> > 1. with 1 sg there are no memory allocations 2. if adding fails on vq full, then
> > something
> >    is in queue and will wake up kick_and_wait.
> > 
> > So in short this is expected to never fail.
> > How about a BUG_ON here then?
> > And make it void, and add a comment with above explanation.
> > 
> 
> 
> Yes, agree that this wouldn't fail - the worker thread performing the ballooning operations has been put into sleep when the vq is full, so I think there shouldn't be anyone else to put more sgs onto the vq then.
> Btw, not sure if we need to mention memory allocation in the comment, I found virtqueue_add() doesn't return any error when allocation (for indirect desc-s) fails - it simply avoids the use of indirect desc.
> 
> What do you think of the following? 
> 
> err = add_one_sg(vq, addr, size);
> /* 
>   * This is expected to never fail: there is always at least 1 entry available on the vq,
>   * because when the vq is full the worker thread that adds the sg will be put into
>   * sleep until at least 1 entry is available to use.
>   */
> BUG_ON(err);
> 
> Best,
> Wei
> 
> 
> 
>  

Sounds good.
