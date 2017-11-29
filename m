From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v17 2/6] radix tree test suite: add tests for xbitmap
Date: Wed, 29 Nov 2017 22:20:42 +0800
Message-ID: <5A1EC23A.5090900__48593.9026614234$1511965161$gmane$org@intel.com>
References: <1509696786-1597-1-git-send-email-wei.w.wang@intel.com>
	<1509696786-1597-3-git-send-email-wei.w.wang@intel.com>
	<20171106170000.GA1195@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171106170000.GA1195@bombadil.infradead.org>
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
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org, amit.shah@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, mawilcox@microsoft.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, mhocko@kernel.org, mgorman@techsingularity.net, liliang.opensource@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On 11/07/2017 01:00 AM, Matthew Wilcox wrote:
> On Fri, Nov 03, 2017 at 04:13:02PM +0800, Wei Wang wrote:
>> From: Matthew Wilcox <mawilcox@microsoft.com>
>>
>> Add the following tests for xbitmap:
>> 1) single bit test: single bit set/clear/find;
>> 2) bit range test: set/clear a range of bits and find a 0 or 1 bit in
>> the range.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> Cc: Matthew Wilcox <mawilcox@microsoft.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>   tools/include/linux/bitmap.h            |  34 ++++
>>   tools/include/linux/kernel.h            |   2 +
>>   tools/testing/radix-tree/Makefile       |   7 +-
>>   tools/testing/radix-tree/linux/kernel.h |   2 -
>>   tools/testing/radix-tree/main.c         |   5 +
>>   tools/testing/radix-tree/test.h         |   1 +
>>   tools/testing/radix-tree/xbitmap.c      | 278 ++++++++++++++++++++++++++++++++
> Umm.  No.  You've duplicated xbitmap.c into the test framework, so now it can
> slowly get out of sync with the one in lib/.  That's not OK.
>
> Put it back the way it was, with the patch I gave you as patch 1/n
> (relocating xbitmap.c from tools/testing/radix-tree to lib/).
> Then add your enhancements as patch 2/n.  All you should need to
> change in your 1/n from
> http://git.infradead.org/users/willy/linux-dax.git/commit/727e401bee5ad7d37e0077291d90cc17475c6392
> is a bit of Makefile tooling.  Leave the test suite embedded in the file;
> that way people might remember to update the test suite when adding
> new functionality.
>

Thanks for you suggestions. Please have a check the v18 patches:
The original implementation is put in patch 4, and the proposed changes 
are separated into patch 5 (we can merge them to patch 4 later if they 
look good to you), and the new APIs are in patch 6.

Best,
Wei
