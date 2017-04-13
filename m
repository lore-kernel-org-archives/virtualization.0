From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH kernel v8 3/4] mm: add inerface to offer info about unused
	pages
Date: Thu, 13 Apr 2017 19:07:57 +0800
Message-ID: <58EF5C0D.60603__17197.1840238713$1492081585$gmane$org@intel.com>
References: <1489648127-37282-1-git-send-email-wei.w.wang@intel.com>	<1489648127-37282-4-git-send-email-wei.w.wang@intel.com>
	<20170316142842.69770813b98df70277431b1e@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170316142842.69770813b98df70277431b1e@linux-foundation.org>
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
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org, amit.shah@redhat.com, liliang.opensource@gmail.com, dave.hansen@intel.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, cornelia.huck@de.ibm.com, pbonzini@redhat.com, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On 03/17/2017 05:28 AM, Andrew Morton wrote:
> On Thu, 16 Mar 2017 15:08:46 +0800 Wei Wang <wei.w.wang@intel.com> wrote:
>
>> From: Liang Li <liang.z.li@intel.com>
>>
>> This patch adds a function to provides a snapshot of the present system
>> unused pages. An important usage of this function is to provide the
>> unsused pages to the Live migration thread, which skips the transfer of
>> thoses unused pages. Newly used pages can be re-tracked by the dirty
>> page logging mechanisms.
> I don't think this will be useful for anything other than
> virtio-balloon.  I guess it would be better to keep this code in the
> virtio-balloon driver if possible, even though that's rather a layering
> violation :( What would have to be done to make that possible?  Perhaps
> we can put some *small* helpers into page_alloc.c to prevent things
> from becoming too ugly.
>
>
Thanks for the suggestion. Small helpers do look more elegant. The nice 
thing is that I also didn't see any performance loss.
To make that possible, we need to enable for_each_polulated_zone() to be 
callable by a kernel module. Please have a check the v9 patches that I 
just posted out.

Best,
Wei
