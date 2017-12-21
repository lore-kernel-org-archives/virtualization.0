From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v20 0/7] Virtio-balloon Enhancement
Date: Thu, 21 Dec 2017 10:49:44 +0800
Message-ID: <5A3B2148.8050306__5910.37210911072$1513824397$gmane$org@intel.com>
References: <1513685879-21823-1-git-send-email-wei.w.wang@intel.com>
	<201712192305.AAE21882.MtQHJOFFSFVOLO@I-love.SAKURA.ne.jp>
	<5A3A3CBC.4030202@intel.com>
	<20171220122547.GA1654@bombadil.infradead.org>
	<286AC319A985734F985F78AFA26841F73938CC3E@shsmsx102.ccr.corp.intel.com>
	<20171220171019.GA12236@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171220171019.GA12236@bombadil.infradead.org>
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

On 12/21/2017 01:10 AM, Matthew Wilcox wrote:
> On Wed, Dec 20, 2017 at 04:13:16PM +0000, Wang, Wei W wrote:
>> On Wednesday, December 20, 2017 8:26 PM, Matthew Wilcox wrote:
>>> 	unsigned long bit;
>>> 	xb_preload(GFP_KERNEL);
>>> 	xb_set_bit(xb, 700);
>>> 	xb_preload_end();
>>> 	bit = xb_find_set(xb, ULONG_MAX, 0);
>>> 	assert(bit == 700);
>> This above test will result in "!node with bitmap !=NULL", and it goes to the regular "if (bitmap)" path, which finds 700.
>>
>> A better test would be
>> ...
>> xb_set_bit(xb, 700);
>> assert(xb_find_set(xb, ULONG_MAX, 800) == ULONG_MAX);
>> ...
> I decided to write a test case to show you what I meant, then I discovered
> the test suite didn't build, then the test I wrote took forever to run, so
> I rewrote xb_find_set() using the radix tree iterators.  So I have no idea
> what bugs may be in your implementation, but at least this function passes
> the current test suite.  Of course, there may be gaps in the test suite.
> And since I changed the API to not have the ambiguous return value, I
> also changed the test suite, and maybe I introduced a bug.

Thanks for the effort. That's actually caused by the previous "!node" 
path, which incorrectly changed "index = (index | RADIX_TREE_MAP_MASK) + 
1". With the change below, it will run pretty well with the test cases.

if (!node && !bitmap)
     return size;

Would you mind to have a try with the v20 RESEND patch that was just 
shared? It makes the above change and added the test case you suggested?

One more question is about the return value, why would it be ambiguous? 
I think it is the same as find_next_bit() which returns the found bit or 
size if not found.


Best,
Wei
