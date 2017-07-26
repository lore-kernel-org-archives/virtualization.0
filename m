From: "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [PATCH v12 6/8] mm: support reporting free page blocks
Date: Wed, 26 Jul 2017 12:47:47 +0000
Message-ID: <286AC319A985734F985F78AFA26841F739285191__28463.0836839371$1501073294$gmane$org@shsmsx102.ccr.corp.intel.com>
References: <20170724090042.GF25221@dhcp22.suse.cz>
	<59771010.6080108@intel.com> <20170725112513.GD26723@dhcp22.suse.cz>
	<597731E8.9040803@intel.com> <20170725124141.GF26723@dhcp22.suse.cz>
	<286AC319A985734F985F78AFA26841F739283F62@shsmsx102.ccr.corp.intel.com>
	<20170725145333.GK26723@dhcp22.suse.cz> <5977FCDF.7040606@intel.com>
	<20170726102458.GH2981@dhcp22.suse.cz> <59788097.6010402@intel.com>
	<20170726115506.GM2981@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170726115506.GM2981@dhcp22.suse.cz>
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
To: Michal Hocko <mhocko@kernel.org>
Cc: "aarcange@redhat.com" <aarcange@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday, July 26, 2017 7:55 PM, Michal Hocko wrote:
> On Wed 26-07-17 19:44:23, Wei Wang wrote:
> [...]
> > I thought about it more. Probably we can use the callback function
> > with a little change like this:
> >
> > void walk_free_mem(void *opaque1, void (*visit)(void *opaque2,
> > unsigned long pfn,
> >            unsigned long nr_pages))
> > {
> >     ...
> >     for_each_populated_zone(zone) {
> >                    for_each_migratetype_order(order, type) {
> >                         report_unused_page_block(zone, order, type,
> > &page); // from patch 6
> >                         pfn = page_to_pfn(page);
> >                         visit(opaque1, pfn, 1 << order);
> >                     }
> >     }
> > }
> >
> > The above function scans all the free list and directly sends each
> > free page block to the hypervisor via the virtio_balloon callback
> > below. No need to implement a bitmap.
> >
> > In virtio-balloon, we have the callback:
> > void *virtio_balloon_report_unused_pages(void *opaque,  unsigned long
> > pfn, unsigned long nr_pages) {
> >     struct virtio_balloon *vb = (struct virtio_balloon *)opaque;
> >     ...put the free page block to the the ring of vb; }
> >
> >
> > What do you think?
> 
> I do not mind conveying a context to the callback. I would still prefer
> to keep the original min_order to check semantic though. Why? Well,
> it doesn't make much sense to scan low order free blocks all the time
> because they are simply too volatile. Larger blocks tend to surivive for
> longer. So I assume you would only care about larger free blocks. This
> will also make the call cheaper.
> --

OK, I will keep min order there in the next version.

Best,
Wei
