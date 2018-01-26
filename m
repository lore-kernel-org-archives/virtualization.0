From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v25 1/2 RESEND] mm: support reporting free page blocks
Date: Fri, 26 Jan 2018 10:11:34 +0800
Message-ID: <5A6A8E56.90408__47394.4710138769$1516932557$gmane$org@intel.com>
References: <1516873107-34950-1-git-send-email-wei.w.wang@intel.com>
	<20180125144124.7e9f6e2156b1b940b07aecfc@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180125144124.7e9f6e2156b1b940b07aecfc@linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: yang.zhang.wz@gmail.com, virtio-dev@lists.oasis-open.org, riel@redhat.com, quan.xu0@gmail.com, kvm@vger.kernel.org, mst@redhat.com, nilal@redhat.com, liliang.opensource@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, pbonzini@redhat.com, mhocko@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 01/26/2018 06:41 AM, Andrew Morton wrote:
> On Thu, 25 Jan 2018 17:38:27 +0800 Wei Wang <wei.w.wang@intel.com> wrote:
>
>> This patch adds support to walk through the free page blocks in the
>> system and report them via a callback function. Some page blocks may
>> leave the free list after zone->lock is released, so it is the caller's
>> responsibility to either detect or prevent the use of such pages.
>>
>> One use example of this patch is to accelerate live migration by skipping
>> the transfer of free pages reported from the guest. A popular method used
>> by the hypervisor to track which part of memory is written during live
>> migration is to write-protect all the guest memory. So, those pages that
>> are reported as free pages but are written after the report function
>> returns will be captured by the hypervisor, and they will be added to the
>> next round of memory transfer.
> It would be useful if we had some quantitative testing results, so we
> can see the real-world benefits from this change?
>

Sure. Thanks for the reminder, I think I'll also attach this to the 
cover letter:

Without this feature, locally live migrating an 8G idle guest takes 
~2286 ms. With this featrue, it takes ~260 ms, which reduces the 
migration time to ~11%.

Idle guest means a guest which doesn't run any specific workloads after 
boots. The improvement depends on how much free memory the guest has, 
idle guest is a good case to show the improvement. From the optimization 
point of view, having something is better than nothing, IMHO. If the 
guest has less free memory, the improvement will be less, but still 
better than no improvement.

Best,
Wei
