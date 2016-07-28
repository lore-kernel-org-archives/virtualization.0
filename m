From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [PATCH v2 repost 4/7] virtio-balloon: speed up inflate/deflate
	process
Date: Thu, 28 Jul 2016 03:48:16 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E04213E86@shsmsx102.ccr.corp.intel.com>
References: <1469582616-5729-1-git-send-email-liang.z.li@intel.com>
	<1469582616-5729-5-git-send-email-liang.z.li@intel.com>
	<20160728010616-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160728010616-mutt-send-email-mst@kernel.org>
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
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Amit Shah <amit.shah@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>, Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>, "dgilbert@redhat.com" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> > +/*
> > + * VIRTIO_BALLOON_PFNS_LIMIT is used to limit the size of page bitmap
> > + * to prevent a very large page bitmap, there are two reasons for this:
> > + * 1) to save memory.
> > + * 2) allocate a large bitmap may fail.
> > + *
> > + * The actual limit of pfn is determined by:
> > + * pfn_limit = min(max_pfn, VIRTIO_BALLOON_PFNS_LIMIT);
> > + *
> > + * If system has more pages than VIRTIO_BALLOON_PFNS_LIMIT, we will
> > +scan
> > + * the page list and send the PFNs with several times. To reduce the
> > + * overhead of scanning the page list. VIRTIO_BALLOON_PFNS_LIMIT
> > +should
> > + * be set with a value which can cover most cases.
> > + */
> > +#define VIRTIO_BALLOON_PFNS_LIMIT ((32 * (1ULL << 30)) >>
> PAGE_SHIFT)
> > +/* 32GB */
> > +
> >  static int oom_pages = OOM_VBALLOON_DEFAULT_PAGES;
> > module_param(oom_pages, int, S_IRUSR | S_IWUSR);
> > MODULE_PARM_DESC(oom_pages, "pages to free on OOM");
> >
> > +extern unsigned long get_max_pfn(void);
> > +
> 
> Please just include the correct header. No need for this hackery.
> 

Will change. Thanks!

Liang
