From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH v6 kernel 2/5] virtio-balloon: define
	new feature bit and head struct
Date: Tue, 17 Jan 2017 21:11:26 +0200
Message-ID: <20170117210845-mutt-send-email-mst__2285.91155396334$1484680327$gmane$org@kernel.org>
References: <1482303148-22059-1-git-send-email-liang.z.li@intel.com>
	<1482303148-22059-3-git-send-email-liang.z.li@intel.com>
	<20170112185719-mutt-send-email-mst@kernel.org>
	<F2CBF3009FA73547804AE4C663CAB28E3C351AE8@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <F2CBF3009FA73547804AE4C663CAB28E3C351AE8@shsmsx102.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Li, Liang Z" <liang.z.li@intel.com>
Cc: "aarcange@redhat.com" <aarcange@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Hansen,
	Dave" <dave.hansen@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jan 13, 2017 at 09:24:22AM +0000, Li, Liang Z wrote:
> > On Wed, Dec 21, 2016 at 02:52:25PM +0800, Liang Li wrote:
> > > Add a new feature which supports sending the page information with
> > > range array. The current implementation uses PFNs array, which is not
> > > very efficient. Using ranges can improve the performance of
> > > inflating/deflating significantly.
> > >
> > > Signed-off-by: Liang Li <liang.z.li@intel.com>
> > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> > > Cc: Amit Shah <amit.shah@redhat.com>
> > > Cc: Dave Hansen <dave.hansen@intel.com>
> > > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > > Cc: David Hildenbrand <david@redhat.com>
> > > ---
> > >  include/uapi/linux/virtio_balloon.h | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> > > diff --git a/include/uapi/linux/virtio_balloon.h
> > > b/include/uapi/linux/virtio_balloon.h
> > > index 343d7dd..2f850bf 100644
> > > --- a/include/uapi/linux/virtio_balloon.h
> > > +++ b/include/uapi/linux/virtio_balloon.h
> > > @@ -34,10 +34,14 @@
> > >  #define VIRTIO_BALLOON_F_MUST_TELL_HOST	0 /* Tell before
> > reclaiming pages */
> > >  #define VIRTIO_BALLOON_F_STATS_VQ	1 /* Memory Stats virtqueue
> > */
> > >  #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon
> > on OOM */
> > > +#define VIRTIO_BALLOON_F_PAGE_RANGE	3 /* Send page info
> > with ranges */
> > >
> > >  /* Size of a PFN in the balloon interface. */  #define
> > > VIRTIO_BALLOON_PFN_SHIFT 12
> > >
> > > +/* Bits width for the length of the pfn range */
> > 
> > What does this mean? Couldn't figure it out.
> > 
> > > +#define VIRTIO_BALLOON_NR_PFN_BITS 12
> > > +
> > >  struct virtio_balloon_config {
> > >  	/* Number of pages host wants Guest to give up. */
> > >  	__u32 num_pages;
> > > @@ -82,4 +86,12 @@ struct virtio_balloon_stat {
> > >  	__virtio64 val;
> > >  } __attribute__((packed));
> > >
> > > +/* Response header structure */
> > > +struct virtio_balloon_resp_hdr {
> > > +	__le64 cmd : 8; /* Distinguish different requests type */
> > > +	__le64 flag: 8; /* Mark status for a specific request type */
> > > +	__le64 id : 16; /* Distinguish requests of a specific type */
> > > +	__le64 data_len: 32; /* Length of the following data, in bytes */
> > 
> > This use of __le64 makes no sense.  Just use u8/le16/le32 pls.
> > 
> 
> Got it, will change in the next version. 
> 
> And could help take a look at other parts? as well as the QEMU part.
> 
> Thanks!
> Liang

Yes but first I would like to understand how come no fields
in this new structure come up if I search for them in the
following patch. I don't see why should I waste time on
reviewing the implementation if the interface isn't
reasonable. You don't have to waste it too - just send RFC
patches with the header until we can agree on it.

-- 
MST
