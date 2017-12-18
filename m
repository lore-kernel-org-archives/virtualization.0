From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v19 3/7] xbitmap: add more operations
Date: Mon, 18 Dec 2017 16:05:28 +0800
Message-ID: <5A3776C8.1040801__12795.7892408178$1513584118$gmane$org@intel.com>
References: <5A34F193.5040700@intel.com>	<201712162028.FEB87079.FOJFMQHVOSLtFO@I-love.SAKURA.ne.jp>	<5A35FF89.8040500@intel.com>	<201712171921.IBB30790.VOOOFMQHFSLFJt@I-love.SAKURA.ne.jp>	<286AC319A985734F985F78AFA26841F739387B68@shsmsx102.ccr.corp.intel.com>
	<201712180016.GHD34301.MQOLOFFJHOVFtS@I-love.SAKURA.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201712180016.GHD34301.MQOLOFFJHOVFtS@I-love.SAKURA.ne.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, willy@infradead.org
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, riel@redhat.com, nilal@redhat.com, kvm@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org, amit.shah@redhat.com, liliang.opensource@gmail.com, mawilcox@microsoft.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, mhocko@kernel.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On 12/17/2017 11:16 PM, Tetsuo Handa wrote:
> Wang, Wei W wrote:
>>> Wei Wang wrote:
>>>>> But passing GFP_NOWAIT means that we can handle allocation failure.
>>>>> There is no need to use preload approach when we can handle allocation failure.
>>>> I think the reason we need xb_preload is because radix tree insertion
>>>> needs the memory being preallocated already (it couldn't suffer from
>>>> memory failure during the process of inserting, probably because
>>>> handling the failure there isn't easy, Matthew may know the backstory
>>>> of
>>>> this)
>>> According to https://lwn.net/Articles/175432/ , I think that preloading is
>>> needed only when failure to insert an item into a radix tree is a significant
>>> problem.
>>> That is, when failure to insert an item into a radix tree is not a problem, I
>>> think that we don't need to use preloading.
>> It also mentions that the preload attempts to allocate sufficient memory to *guarantee* that the next radix tree insertion cannot fail.
>>
>> If we check radix_tree_node_alloc(), the comments there says "this assumes that the caller has performed appropriate preallocation".
> If you read what radix_tree_node_alloc() is doing, you will find that
> radix_tree_node_alloc() returns NULL when memory allocation failed.
>
> I think that "this assumes that the caller has performed appropriate preallocation"
> means "The caller has to perform appropriate preallocation if the caller does not
> want radix_tree_node_alloc() to return NULL".

For the radix tree, I agree that we may not need preload. But 
ida_bitmap, which the xbitmap is based on, is allocated via preload, so 
I think we cannot bypass preload, otherwise, we get no ida_bitmap to use.

Best,
Wei
