From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [RESEND PATCH v3 kernel 2/7] virtio-balloon: define new feature
	bit and page bitmap head
Date: Tue, 25 Oct 2016 01:21:21 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E3A0FB4FF@shsmsx102.ccr.corp.intel.com>
References: <1477031080-12616-1-git-send-email-liang.z.li@intel.com>
	<1477031080-12616-3-git-send-email-liang.z.li@intel.com>
	<580E3C07.701@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <580E3C07.701@intel.com>
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
To: "Hansen, Dave" <dave.hansen@intel.com>, "mst@redhat.com" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> On 10/20/2016 11:24 PM, Liang Li wrote:
> > Add a new feature which supports sending the page information with a
> > bitmap. The current implementation uses PFNs array, which is not very
> > efficient. Using bitmap can improve the performance of
> > inflating/deflating significantly
> 
> Why is it not efficient?  How is using a bitmap more efficient?  What kinds of
> cases is the bitmap inefficient?
> 
> > The page bitmap header will used to tell the host some information
> > about the page bitmap. e.g. the page size, page bitmap length and
> > start pfn.
> 
> Why did you choose to add these features to the structure?  What benefits
> do they add?
> 
> Could you describe your solution a bit here, and describe its strengths and
> weaknesses?
> 

Will elaborate the solution in V4.

> >  /* Size of a PFN in the balloon interface. */  #define
> > VIRTIO_BALLOON_PFN_SHIFT 12 @@ -82,4 +83,22 @@ struct
> > virtio_balloon_stat {
> >  	__virtio64 val;
> >  } __attribute__((packed));
> >
> > +/* Page bitmap header structure */
> > +struct balloon_bmap_hdr {
> > +	/* Used to distinguish different request */
> > +	__virtio16 cmd;
> > +	/* Shift width of page in the bitmap */
> > +	__virtio16 page_shift;
> > +	/* flag used to identify different status */
> > +	__virtio16 flag;
> > +	/* Reserved */
> > +	__virtio16 reserved;
> > +	/* ID of the request */
> > +	__virtio64 req_id;
> > +	/* The pfn of 0 bit in the bitmap */
> > +	__virtio64 start_pfn;
> > +	/* The length of the bitmap, in bytes */
> > +	__virtio64 bmap_len;
> > +};
> 
> FWIW this is totally unreadable.  Please do something like this:
> 
> > +struct balloon_bmap_hdr {
> > +	__virtio16 cmd; 	/* Used to distinguish different ...
> > +	__virtio16 page_shift; 	/* Shift width of page in the bitmap */
> > +	__virtio16 flag; 	/* flag used to identify different...
> > +	__virtio16 reserved;	/* Reserved */
> > +	__virtio64 req_id;	/* ID of the request */
> > +	__virtio64 start_pfn;	/* The pfn of 0 bit in the bitmap */
> > +	__virtio64 bmap_len;	/* The length of the bitmap, in bytes */
> > +};
> 
> and please make an effort to add useful comments.  "/* Reserved */"
> seems like a waste of bytes to me.

OK. Maybe 'padding' is better than 'reserved' .

Thanks for your comments!

Liang
