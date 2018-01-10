From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v21 2/5 RESEND] virtio-balloon: VIRTIO_BALLOON_F_SG
Date: Wed, 10 Jan 2018 18:26:57 +0800
Message-ID: <5A55EA71.6020309__2508.01595761931$1515579792$gmane$org@intel.com>
References: <1515501687-7874-1-git-send-email-wei.w.wang@intel.com>
	<201801092342.FCH56215.LJHOMVFFFOOSQt@I-love.SAKURA.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201801092342.FCH56215.LJHOMVFFFOOSQt@I-love.SAKURA.ne.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com
Cc: aarcange@redhat.com, yang.zhang.wz@gmail.com, riel@redhat.com, quan.xu0@gmail.com, liliang.opensource@gmail.com, willy@infradead.org, amit.shah@redhat.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, nilal@redhat.com, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On 01/09/2018 10:42 PM, Tetsuo Handa wrote:
> Wei Wang wrote:
>> - enable OOM to free inflated pages maintained in the local temporary
>>    list.
> I do want to see it before applying this patch.


Fine, then what do you think of the method I shared in your post here: 
https://patchwork.kernel.org/patch/10140731/

Michael, could we merge patch 3-5 first?


>
> Please carefully check how the xbitmap implementation works, and you will
> find that you are adding a lot of redundant operations with a bug.

This version mainly added some test cases, and it passes the test run 
without any issue. Appreciate it if your comments could be more 
specific, that would make the discussion more effective, for example, I 
deliberately added "xb_find_set(xb1, 2, ULONG_MAX - 3)" for the overflow 
test, not sure if this is the "bug" you referred to, but I'm glad to 
hear your different thought.

I agree that some tests may be repeated in some degree, since we test 
the implementation from different aspects, for example, 
xbitmap_check_bit_range() may have already performed xb_zero() while we 
specifically have another xbitmap_check_zero_bits() which may test 
something that has already been tested when checking bit range. But I 
think testing twice is better than omission.
Also, I left the "Regualr test1: node=NULL" case though the new 
implementation doesn't explicitly use "node" as before, but that 
node=NULL is still a radix tree implementation internally and that case 
looks special to me, so maybe not bad to cover in the test.

You are also welcome to send a patch to remove the redundant one if you 
think that's an issue. Thanks.

Best,
Wei
