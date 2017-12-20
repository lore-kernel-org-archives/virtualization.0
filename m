From: "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [PATCH v20 0/7] Virtio-balloon Enhancement
Date: Wed, 20 Dec 2017 16:13:16 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73938CC3E__21184.2824741781$1513786335$gmane$org@shsmsx102.ccr.corp.intel.com>
References: <1513685879-21823-1-git-send-email-wei.w.wang@intel.com>
	<201712192305.AAE21882.MtQHJOFFSFVOLO@I-love.SAKURA.ne.jp>
	<5A3A3CBC.4030202@intel.com>
	<20171220122547.GA1654@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171220122547.GA1654@bombadil.infradead.org>
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
To: Matthew Wilcox <willy@infradead.org>
Cc: "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "aarcange@redhat.com" <aarcange@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mawilcox@microsoft.com" <mawilcox@microsoft.com>, "nilal@redhat.com" <nilal@redhat.com>, "riel@redhat.com" <riel@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "mhocko@kernel.org" <mhocko@kernel.org>, "quan.xu0@gmail.com" <quan.xu0@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, amit.sh
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday, December 20, 2017 8:26 PM, Matthew Wilcox wrote:
> On Wed, Dec 20, 2017 at 06:34:36PM +0800, Wei Wang wrote:
> > On 12/19/2017 10:05 PM, Tetsuo Handa wrote:
> > > I think xb_find_set() has a bug in !node path.
> >
> > I think we can probably remove the "!node" path for now. It would be
> > good to get the fundamental part in first, and leave optimization to
> > come as separate patches with corresponding test cases in the future.
> 
> You can't remove the !node path.  You'll see !node when the highest set bit
> is less than 1024.  So do something like this:
> 
> 	unsigned long bit;
> 	xb_preload(GFP_KERNEL);
> 	xb_set_bit(xb, 700);
> 	xb_preload_end();
> 	bit = xb_find_set(xb, ULONG_MAX, 0);
> 	assert(bit == 700);

This above test will result in "!node with bitmap !=NULL", and it goes to the regular "if (bitmap)" path, which finds 700.

A better test would be
...
xb_set_bit(xb, 700);
assert(xb_find_set(xb, ULONG_MAX, 800) == ULONG_MAX);
...

The first try with the "if (bitmap)" path doesn't find a set bit, and the remaining tries will always result in "!node && !bitmap", which implies no set bit anymore and no need to try in this case.

So, I think we can change it to

If (!node && !bitmap)
	return size;


Best,
Wei
