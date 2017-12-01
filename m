From: "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [PATCH v18 05/10] xbitmap: add more operations
Date: Fri, 1 Dec 2017 15:09:08 +0000
Message-ID: <286AC319A985734F985F78AFA26841F739376DA1__47943.4458110065$1512140962$gmane$org@shsmsx102.ccr.corp.intel.com>
References: <1511963726-34070-1-git-send-email-wei.w.wang@intel.com>
	<1511963726-34070-6-git-send-email-wei.w.wang@intel.com>
	<201711301934.CDC21800.FSLtJFFOOVQHMO@I-love.SAKURA.ne.jp>
	<5A210C96.8050208@intel.com>
	<201712012202.BDE13557.MJFQLtOOHVOFSF@I-love.SAKURA.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201712012202.BDE13557.MJFQLtOOHVOFSF@I-love.SAKURA.ne.jp>
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
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "aarcange@redhat.com" <aarcange@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mawilcox@microsoft.com" <mawilcox@microsoft.com>, "willy@infradead.org" <willy@infradead.org>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>, "nilal@redhat.com" <nilal@redhat.com>, "riel@redhat.com" <riel@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "mhocko@kernel.org" <mhocko@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, amit.shah@red
List-Id: virtualization@lists.linuxfoundation.org

On Friday, December 1, 2017 9:02 PM, Tetsuo Handa wrote:
> Wei Wang wrote:
> > On 11/30/2017 06:34 PM, Tetsuo Handa wrote:
> > > Wei Wang wrote:
> > >> + * @start: the start of the bit range, inclusive
> > >> + * @end: the end of the bit range, inclusive
> > >> + *
> > >> + * This function is used to clear a bit in the xbitmap. If all the
> > >> +bits of the
> > >> + * bitmap are 0, the bitmap will be freed.
> > >> + */
> > >> +void xb_clear_bit_range(struct xb *xb, unsigned long start,
> > >> +unsigned long end) {
> > >> +	struct radix_tree_root *root = &xb->xbrt;
> > >> +	struct radix_tree_node *node;
> > >> +	void **slot;
> > >> +	struct ida_bitmap *bitmap;
> > >> +	unsigned int nbits;
> > >> +
> > >> +	for (; start < end; start = (start | (IDA_BITMAP_BITS - 1)) + 1) {
> > >> +		unsigned long index = start / IDA_BITMAP_BITS;
> > >> +		unsigned long bit = start % IDA_BITMAP_BITS;
> > >> +
> > >> +		bitmap = __radix_tree_lookup(root, index, &node, &slot);
> > >> +		if (radix_tree_exception(bitmap)) {
> > >> +			unsigned long ebit = bit + 2;
> > >> +			unsigned long tmp = (unsigned long)bitmap;
> > >> +
> > >> +			nbits = min(end - start + 1, BITS_PER_LONG - ebit);
> > > "nbits = min(end - start + 1," seems to expect that start == end is
> > > legal for clearing only 1 bit. But this function is no-op if start == end.
> > > Please clarify what "inclusive" intended.
> >
> > If xb_clear_bit_range(xb,10,10), then it is effectively the same as
> > xb_clear_bit(10). Why would it be illegal?
> >
> > "@start inclusive" means that the @start will also be included to be
> > cleared.
> 
> If start == end is legal,
> 
>    for (; start < end; start = (start | (IDA_BITMAP_BITS - 1)) + 1) {
> 
> makes this loop do nothing because 10 < 10 is false.


How about "start <= end "?

Best,
Wei
