From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v12 5/8] virtio-balloon: VIRTIO_BALLOON_F_SG
Date: Sun, 30 Jul 2017 07:22:47 +0300
Message-ID: <20170730043922-mutt-send-email-mst__39556.7685402513$1501388584$gmane$org@kernel.org>
References: <20170712163746-mutt-send-email-mst@kernel.org>
	<5967246B.9030804@intel.com>
	<20170713210819-mutt-send-email-mst@kernel.org>
	<59686EEB.8080805@intel.com>
	<20170723044036-mutt-send-email-mst@kernel.org>
	<59781119.8010200@intel.com>
	<20170726155856-mutt-send-email-mst@kernel.org>
	<597954E3.2070801@intel.com>
	<20170729020231-mutt-send-email-mst@kernel.org>
	<597C83CC.7060702@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <597C83CC.7060702@intel.com>
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
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, amit.shah@redhat.com, liliang.opensource@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Jul 29, 2017 at 08:47:08PM +0800, Wei Wang wrote:
> On 07/29/2017 07:08 AM, Michael S. Tsirkin wrote:
> > On Thu, Jul 27, 2017 at 10:50:11AM +0800, Wei Wang wrote:
> > > > > > OK I thought this over. While we might need these new APIs in
> > > > > > the future, I think that at the moment, there's a way to implement
> > > > > > this feature that is significantly simpler. Just add each s/g
> > > > > > as a separate input buffer.
> > > > > Should it be an output buffer?
> > > > Hypervisor overwrites these pages with zeroes. Therefore it is
> > > > writeable by device: DMA_FROM_DEVICE.
> > > Why would the hypervisor need to zero the buffer?
> > The page is supplied to hypervisor and can lose the value that
> > is there.  That is the definition of writeable by device.
> 
> I think for the free pages, it should be clear that they will be added as
> output buffer to the device, because (as we discussed) they are just hints,
> and some of them may be used by the guest after the report_ API is invoked.
> The device/hypervisor should not use or discard them.

Discarding contents is exactly what you propose doing if
migration is going on, isn't it?

> For the balloon pages, I kind of agree with the existing implementation
> (e.g. inside tell_host()), which uses virtqueue_add_outbuf (instead of
> _add_inbuf()).


This is because it does not pass SGs, it passes weirdly
formatted PA within the buffer.

> I think inbuf should be a buffer which will be written by the device and
> read by the
> driver.

If hypervisor can change it, it's an inbuf. Should not matter
whether driver reads it.

> The cmd buffer put on the vq for the device to send commands can be
> an
> inbuf, I think.
> 
> 
> > 
> > > I think it may only
> > > need to read out the info(base,size).
> > And then do what?
> 
> 
> For the free pages, the info will be used to clear the corresponding "1" in
> the dirty bitmap.
> For balloon pages, they will be made DONTNEED and given to other host
> processes to
> use (the device won't write them, so no need to set "write" when
> virtqueue_map_desc() in
> the device).
> 
> 
> > 
> > > I think it should be like this:
> > > the cmd hdr buffer: input, because the hypervisor would write it to
> > > send a cmd to the guest
> > > the payload buffer: output, for the hypervisor to read the info
> > These should be split.
> > 
> > We have:
> > 
> > 1. request that hypervisor sends to guest, includes ID: input
> > 2. synchronisation header with ID sent by guest: output
> > 3. list of pages: input
> > 
> > 2 and 3 must be on the same VQ. 1 can come on any VQ - reusing stats VQ
> > might make sense.
> 
> I would prefer to make the above item 1 come on the the free page vq,
> because the existing stat_vq doesn't support the cmd hdr.
> Now, I think it is also not necessary to move the existing stat_vq
> implementation to
> a new implementation under the cmd hdr, because
> that new support doesn't make a difference for stats, it will still use its
> stat_vq (the free
> page vq will be used for reporting free pages only)
> 
> What do you think?
> 
> 
> Best,
> Wei
