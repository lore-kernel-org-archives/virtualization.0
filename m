From: "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [PATCH v7 kernel 3/5] virtio-balloon: implementation of
	VIRTIO_BALLOON_F_CHUNK_TRANSFER
Date: Mon, 13 Mar 2017 12:41:39 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73919FFDB@shsmsx102.ccr.corp.intel.com>
References: <1488519630-89058-1-git-send-email-wei.w.wang@intel.com>
	<1488519630-89058-4-git-send-email-wei.w.wang@intel.com>
	<20170309141411.GZ16328@bombadil.infradead.org>
	<58C28FF8.5040403@intel.com>
	<20170310175349-mutt-send-email-mst@kernel.org>
	<20170310171143.GA16328@bombadil.infradead.org>
	<58C3E6A3.1000000@intel.com>
	<20170311140946.GA1860@bombadil.infradead.org>
	<286AC319A985734F985F78AFA26841F73919E524@shsmsx102.ccr.corp.intel.com>
	<20170312055658-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170312055658-mutt-send-email-mst@kernel.org>
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Hansen,
	Dave" <dave.hansen@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Amit Shah <amit.shah@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Liang Li <liliang324@gmail.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sunday, March 12, 2017 12:04 PM, Michael S. Tsirkin wrote:
> On Sun, Mar 12, 2017 at 01:59:54AM +0000, Wang, Wei W wrote:
> > On 03/11/2017 10:10 PM, Matthew Wilcox wrote:
> > > On Sat, Mar 11, 2017 at 07:59:31PM +0800, Wei Wang wrote:
> > > > I'm thinking what if the guest needs to transfer these much
> > > > physically continuous memory to host: 1GB+2MB+64KB+32KB+16KB+4KB.
> > > > Is it going to use Six 64-bit chunks? Would it be simpler if we
> > > > just use the 128-bit chunk format (we can drop the previous normal
> > > > 64-bit format)?
> > >
> > > Is that a likely thing for the guest to need to do though?  Freeing
> > > a 1GB page is much more liikely, IMO.
> >
> > Yes, I think it's very possible. The host can ask for any number of pages (e.g.
> 1.5GB) that the guest can afford.  Also, the ballooned 1.5G memory is not
> guaranteed to be continuous in any pattern like 1GB+512MB. That's why we
> need to use a bitmap to draw the whole picture first, and then seek for
> continuous bits to chunk.
> >
> > Best,
> > Wei
> 
> While I like the clever format that Matthew came up with, I'm also inclined to
> say let's keep things simple.
> the simplest thing seems to be to use the ext format all the time.
> Except let's reserve the low 12 bits in both address and size, since they are
> already 0, we might be able to use them for flags down the road.

Thanks for reminding us about the hugepage story. I'll use the ext format in the implementation if no further objections from others.

Best,
Wei
