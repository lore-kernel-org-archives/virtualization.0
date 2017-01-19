From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [PATCH v6 kernel 3/5] virtio-balloon: speed up inflate/deflate
	process
Date: Thu, 19 Jan 2017 01:44:36 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E3C3578BF@shsmsx102.ccr.corp.intel.com>
References: <1482303148-22059-1-git-send-email-liang.z.li@intel.com>
	<1482303148-22059-4-git-send-email-liang.z.li@intel.com>
	<20170117211131-mutt-send-email-mst@kernel.org>
	<F2CBF3009FA73547804AE4C663CAB28E3C355672@shsmsx102.ccr.corp.intel.com>
	<20170118172401-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170118172401-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "aarcange@redhat.com" <aarcange@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Hansen,
	Dave" <dave.hansen@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> On Wed, Jan 18, 2017 at 04:56:58AM +0000, Li, Liang Z wrote:
> > > > -	virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
> > > > -	virtqueue_kick(vq);
> > > > +static void do_set_resp_bitmap(struct virtio_balloon *vb,
> > > > +		unsigned long base_pfn, int pages)
> > > >
> > > > -	/* When host has read buffer, this completes via balloon_ack */
> > > > -	wait_event(vb->acked, virtqueue_get_buf(vq, &len));
> > > > +{
> > > > +	__le64 *range = vb->resp_data + vb->resp_pos;
> > > >
> > > > +	if (pages > (1 << VIRTIO_BALLOON_NR_PFN_BITS)) {
> > > > +		/* when the length field can't contain pages, set it to 0 to
> > >
> > > /*
> > >  * Multi-line
> > >  * comments
> > >  * should look like this.
> > >  */
> > >
> > > Also, pls start sentences with an upper-case letter.
> > >
> >
> > Sorry for that.
> >
> > > > +		 * indicate the actual length is in the next __le64;
> > > > +		 */
> > >
> > > This is part of the interface so should be documented as such.
> > >
> > > > +		*range = cpu_to_le64((base_pfn <<
> > > > +				VIRTIO_BALLOON_NR_PFN_BITS) | 0);
> > > > +		*(range + 1) = cpu_to_le64(pages);
> > > > +		vb->resp_pos += 2;
> > >
> > > Pls use structs for this kind of stuff.
> >
> > I am not sure if you mean to use
> >
> > struct  range {
> >  	__le64 pfn: 52;
> > 	__le64 nr_page: 12
> > }
> > Instead of the shift operation?
> 
> Not just that. You want to add a pages field as well.
> 

pages field? Could you give more hints?

> Generally describe the format in the header in some way so host and guest
> can easily stay in sync.

'VIRTIO_BALLOON_NR_PFN_BITS' is for this purpose and it will be passed to the
related function in page_alloc.c as a parameter.

Thanks!
Liang
> All the pointer math and void * means we get zero type safety and I'm not
> happy about it.
> 
> It's not good that virtio format seeps out to page_alloc anyway.
> If unavoidable it is not a good idea to try to hide this fact, people will assume
> they can change the format at will.
> 
> --
> MST
