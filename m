From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v17 4/6] virtio-balloon: VIRTIO_BALLOON_F_SG
Date: Mon, 06 Nov 2017 16:21:06 +0800
Message-ID: <5A001B72.1010204__1736.84495171091$1509956349$gmane$org@intel.com>
References: <1509696786-1597-1-git-send-email-wei.w.wang@intel.com>	<1509696786-1597-5-git-send-email-wei.w.wang@intel.com>	<201711032025.HJC78622.SFFOMLOtFQHVJO@I-love.SAKURA.ne.jp>	<59FD9FE3.5090409@intel.com>
	<201711042028.EGB64074.FOLMHtFJVQOOFS@I-love.SAKURA.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201711042028.EGB64074.FOLMHtFJVQOOFS@I-love.SAKURA.ne.jp>
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
Cc: aarcange@redhat.com, yang.zhang.wz@gmail.com, liliang.opensource@gmail.com, willy@infradead.org, amit.shah@redhat.com, quan.xu@aliyun.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On 11/04/2017 07:28 PM, Tetsuo Handa wrote:
> Wei Wang wrote:
>> On 11/03/2017 07:25 PM, Tetsuo Handa wrote:
>>
>> If this is inside vb->balloon_lock mutex (isn't this?), xb_set_page() must not
>> use __GFP_DIRECT_RECLAIM allocation, for leak_balloon_sg_oom() will be blocked
>> on vb->balloon_lock mutex.
>> OK. Since the preload() doesn't need too much memory (< 4K in total),
>> how about GFP_NOWAIT here?
> Maybe GFP_NOWAIT | __GFP_NOWARN ?

Sounds good to me. I also plan to move "xb_set_page()" under mutex_lock, 
that is,

     fill_balloon()
     {
         ...
         mutex_lock(&vb->balloon_lock);

         vb->num_pfns = 0;
         while ((page = balloon_page_pop(&pages))) {
==>        xb_set_page(..,page,..);
                 balloon_page_enqueue(&vb->vb_dev_info, page);
         ...
     }

As explained in the xbitmap patch, we need the lock to avoid concurrent 
access to the bitmap.

Best,
Wei
