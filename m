From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v14 5/5] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_VQ
Date: Fri, 18 Aug 2017 21:26:51 +0300
Message-ID: <20170818211119-mutt-send-email-mst__35545.2799740762$1503080831$gmane$org@kernel.org>
References: <1502940416-42944-1-git-send-email-wei.w.wang@intel.com>
	<1502940416-42944-6-git-send-email-wei.w.wang@intel.com>
	<20170818045519-mutt-send-email-mst@kernel.org>
	<5996A845.4010405@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5996A845.4010405@intel.com>
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

On Fri, Aug 18, 2017 at 04:41:41PM +0800, Wei Wang wrote:
> On 08/18/2017 10:13 AM, Michael S. Tsirkin wrote:
> > On Thu, Aug 17, 2017 at 11:26:56AM +0800, Wei Wang wrote:
> > > Add a new vq to report hints of guest free pages to the host.
> > Please add some text here explaining the report_free_page_signal
> > thing.
> > 
> > 
> > I also really think we need some kind of ID in the
> > buffer to do a handshake. whenever id changes you
> > add another outbuf.
> 
> Please let me introduce the current design first:
> 1) device put the signal buf to the vq and notify the driver (we need
> a buffer because currently the device can't notify when the vq is empty);
> 
> 2) the driver starts the report of free page blocks via inbuf;
> 
> 3) the driver adds an the signal buf via outbuf to tell the device all are
> reported.
> 
> 
> Could you please elaborate more on the usage of ID?

While driver is free to maintain at most one buffer in flight
the design must work with pipelined requests as that
is important for performance.

So host might be able to request the reporting twice.
How does it know what is the report in response to?

If we put an id in request and in response, then that fixes it.


So there's a vq used for requesting free page reports.
driver does add_inbuf( &device->id).

Then when it starts reporting it does


add_outbuf(&device->id)

followed by pages.


Also if device->id changes it knows it should restart
reporting from beginning.






> > > +retry:
> > > +	ret = virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
> > > +	virtqueue_kick(vq);
> > > +	if (unlikely(ret == -ENOSPC)) {
> > what if there's another error?
> 
> Another error is -EIO, how about disabling the free page report feature?
> (I also saw it isn't handled in many other virtio devices e.g. virtio-net)
> 
> > > +		wait_event(vb->acked, virtqueue_get_buf(vq, &len));
> > > +		goto retry;
> > > +	}
> > what is this trickery doing? needs more comments or
> > a simplification.
> 
> Just this:
> if the vq is full, blocking wait till an entry gets released, then retry.
> This is the
> final one, which puts the signal buf to the vq to signify the end of the
> report and
> the mm lock is not held here, so it is fine to block.
> 

But why do you kick here on failure? I would understand it if you
did not kick when adding pages, as it is I don't understand.


Also pls rewrite this with a for or while loop for clarity.


> > 
> > 
> > > +}
> > > +
> > > +static void report_free_page(struct work_struct *work)
> > > +{
> > > +	struct virtio_balloon *vb;
> > > +
> > > +	vb = container_of(work, struct virtio_balloon, report_free_page_work);
> > > +	walk_free_mem_block(vb, 0, &virtio_balloon_send_free_pages);
> > That's a lot of work here. And system_wq documentation says:
> >   *
> >   * system_wq is the one used by schedule[_delayed]_work[_on]().
> >   * Multi-CPU multi-threaded.  There are users which expect relatively
> >   * short queue flush time.  Don't queue works which can run for too
> >   * long.
> > 
> > You might want to create your own wq, maybe even with WQ_CPU_INTENSIVE.
> 
> Thanks for the reminder. If not creating a new wq, how about
> system_unbound_wq?

I don't think that one's freezeable. 

> The first round of live migration needs the free pages, in that way we can
> have the
> pages reported to the hypervisor quicker.

The reason people call it *live* migration is because tasks keep
running. If you pin VCPUs with maintainance tasks it becomes pointless.

Maybe we need to set a special wq which will create idle
class threads. Does not seem to be supported but not hard to do.

> > 
> > > +	report_free_page_completion(vb);
> > So first you get list of pages, then an outbuf telling you
> > what they are in end of.  I think it's backwards.
> > Add an outbuf first followed by inbufs that tell you
> > what they are.
> 
> 
> If we have the signal filled with those flags like
> VIRTIO_BALLOON_F_FREE_PAGE_REPORT_START,
> Probably not necessary to have an inbuf followed by an outbuf, right?
> 
> 
> Best,
> Wei

You really should document the messages in the commit log
and in the header.

-- 
MST
