From: "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [PATCH v16 5/5] virtio-balloon: VIRTIO_BALLOON_F_CTRL_VQ
Date: Mon, 2 Oct 2017 16:38:01 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73932025A__49458.1820829355$1506962320$gmane$org@shsmsx102.ccr.corp.intel.com>
References: <1506744354-20979-1-git-send-email-wei.w.wang@intel.com>
	<1506744354-20979-6-git-send-email-wei.w.wang@intel.com>
	<20171001060305-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171001060305-mutt-send-email-mst@kernel.org>
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
To: "'Michael S. Tsirkin'" <mst@redhat.com>
Cc: "aarcange@redhat.com" <aarcange@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mawilcox@microsoft.com" <mawilcox@microsoft.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "willy@infradead.org" <willy@infradead.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, mhocko@kernel.or
List-Id: virtualization@lists.linuxfoundation.org

On Sunday, October 1, 2017 11:19 AM, Michael S. Tsirkin wrote:
> On Sat, Sep 30, 2017 at 12:05:54PM +0800, Wei Wang wrote:
> > +static void ctrlq_send_cmd(struct virtio_balloon *vb,
> > +			  struct virtio_balloon_ctrlq_cmd *cmd,
> > +			  bool inbuf)
> > +{
> > +	struct virtqueue *vq = vb->ctrl_vq;
> > +
> > +	ctrlq_add_cmd(vq, cmd, inbuf);
> > +	if (!inbuf) {
> > +		/*
> > +		 * All the input cmd buffers are replenished here.
> > +		 * This is necessary because the input cmd buffers are lost
> > +		 * after live migration. The device needs to rewind all of
> > +		 * them from the ctrl_vq.
> 
> Confused. Live migration somehow loses state? Why is that and why is it a good
> idea? And how do you know this is migration even?
> Looks like all you know is you got free page end. Could be any reason for this.


I think this would be something that the current live migration lacks - what the
device read from the vq is not transferred during live migration, an example is the 
stat_vq_elem: 
Line 476 at https://github.com/qemu/qemu/blob/master/hw/virtio/virtio-balloon.c

For all the things that are added to the vq and need to be held by the device
to use later need to consider the situation that live migration might happen at any
time and they need to be re-taken from the vq by the device on the destination
machine.

So, even without this live migration optimization feature, I think all the things that are 
added to the vq for the device to hold, need a way for the device to rewind back from
the vq - re-adding all the elements to the vq is a trick to keep a record of all of them
on the vq so that the device side rewinding can work. 

Please let me know if anything is missed or if you have other suggestions.


> > +static void ctrlq_handle(struct virtqueue *vq) {
> > +	struct virtio_balloon *vb = vq->vdev->priv;
> > +	struct virtio_balloon_ctrlq_cmd *msg;
> > +	unsigned int class, cmd, len;
> > +
> > +	msg = (struct virtio_balloon_ctrlq_cmd *)virtqueue_get_buf(vq, &len);
> > +	if (unlikely(!msg))
> > +		return;
> > +
> > +	/* The outbuf is sent by the host for recycling, so just return. */
> > +	if (msg == &vb->free_page_cmd_out)
> > +		return;
> > +
> > +	class = virtio32_to_cpu(vb->vdev, msg->class);
> > +	cmd =  virtio32_to_cpu(vb->vdev, msg->cmd);
> > +
> > +	switch (class) {
> > +	case VIRTIO_BALLOON_CTRLQ_CLASS_FREE_PAGE:
> > +		if (cmd == VIRTIO_BALLOON_FREE_PAGE_F_STOP) {
> > +			vb->report_free_page_stop = true;
> > +		} else if (cmd == VIRTIO_BALLOON_FREE_PAGE_F_START) {
> > +			vb->report_free_page_stop = false;
> > +			queue_work(vb->balloon_wq, &vb-
> >report_free_page_work);
> > +		}
> > +		vb->free_page_cmd_in.class =
> > +
> 	VIRTIO_BALLOON_CTRLQ_CLASS_FREE_PAGE;
> > +		ctrlq_send_cmd(vb, &vb->free_page_cmd_in, true);
> > +	break;
> > +	default:
> > +		dev_warn(&vb->vdev->dev, "%s: cmd class not supported\n",
> > +			 __func__);
> > +	}
> 
> Manipulating report_free_page_stop without any locks looks very suspicious.

> Also, what if we get two start commands? we should restart from beginning,
> should we not?
> 


Yes, it will start to report free pages from the beginning.
walk_free_mem_block() doesn't maintain any internal status, so the invoking of
it will always start from the beginning.


> > +/* Ctrlq commands related to VIRTIO_BALLOON_CTRLQ_CLASS_FREE_PAGE
> */
> > +#define VIRTIO_BALLOON_FREE_PAGE_F_STOP		0
> > +#define VIRTIO_BALLOON_FREE_PAGE_F_START	1
> > +
> >  #endif /* _LINUX_VIRTIO_BALLOON_H */
> 
> The stop command does not appear to be thought through.
> 
> Let's assume e.g. you started migration. You ask guest for free pages.
> Then you cancel it.  There are a bunch of pages in free vq and you are getting
> more.  You now want to start migration again. What to do?
> 
> A bunch of vq flushing and waiting will maybe do the trick, but waiting on guest
> is never a great idea.
> 


I think the device can flush (pop out what's left in the vq and push them back) the
vq right after the Stop command is sent to the guest, rather than doing the flush
when the 2nd initiation of live migration begins. The entries pushed back to the vq
will be in the used ring, what would the device need to wait for?


> I previously suggested pushing the stop/start commands from guest to host on
> the free page vq, and including an ID in host to guest and guest to host
> commands. This way ctrl vq is just for host to guest commands, and host
> matches commands and knows which command is a free page in response to.
> 
> I still think it's a good idea but go ahead and propose something else that works.
> 

Thanks for the suggestion. Probably I haven't fully understood it. Please see the example
below:

1) host-to-guest ctrl_vq:
StartCMD, ID=1

2) guest-to-host free_page_vq:
free_page, ID=1
free_page, ID=1
free_page, ID=1
free_page, ID=1

3) host-to-guest ctrl_vq:
StopCMD, ID=1

4) initiate the 2nd try of live migration via host-to-guest ctrl_vq:
StartCMD, ID=2

5) the guest-to-host free_page_vq might look like this:
free_page, ID=1
free_page, ID=1
free_page, ID=2
free_page, ID=2

The device will need to drop (pop out the two entries and push them back)
the first 2 obsolete free pages which are sent by ID=1.

I haven't found the benefits above yet. The device will perform the same operations
to get rid of the old free pages. If we drop the old free pages after the StopCMD (
ID may also not be needed in this case), the overhead won't be added to the live
migration time.

Would you have any thought about this?


Best,
Wei
