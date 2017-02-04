From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [PATCH v6 kernel 3/5] virtio-balloon: speed up inflate/deflate
	process
Date: Sat, 4 Feb 2017 04:35:41 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E3C363988@shsmsx102.ccr.corp.intel.com>
References: <1482303148-22059-1-git-send-email-liang.z.li@intel.com>
	<1482303148-22059-4-git-send-email-liang.z.li@intel.com>
	<20170120114809.GH2658@work-vm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170120114809.GH2658@work-vm>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "aarcange@redhat.com" <aarcange@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Hansen,
	Dave" <dave.hansen@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> <snip>
> 
> > +static void free_extended_page_bitmap(struct virtio_balloon *vb) {
> > +	int i, bmap_count = vb->nr_page_bmap;
> > +
> > +	for (i = 1; i < bmap_count; i++) {
> > +		kfree(vb->page_bitmap[i]);
> > +		vb->page_bitmap[i] = NULL;
> > +		vb->nr_page_bmap--;
> > +	}
> > +}
> > +
> > +static void kfree_page_bitmap(struct virtio_balloon *vb) {
> > +	int i;
> > +
> > +	for (i = 0; i < vb->nr_page_bmap; i++)
> > +		kfree(vb->page_bitmap[i]);
> > +}
> 
> It might be worth commenting that pair of functions to make it clear why
> they are so different; I guess the kfree_page_bitmap is used just before you
> free the structure above it so you don't need to keep the count/pointers
> updated?
> 

Yes. I will add some comments for that. Thanks!

Liang
 
> Dave
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
