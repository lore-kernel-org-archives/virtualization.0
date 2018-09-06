From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v36 0/5] Virtio-balloon: support free page reporting
Date: Thu, 06 Sep 2018 20:18:11 +0800
Message-ID: <5B911B03.2060602__40969.116430688$1536235894$gmane$org@intel.com>
References: <1532075585-39067-1-git-send-email-wei.w.wang@intel.com>
	<20180723122342-mutt-send-email-mst@kernel.org>
	<20180723143604.GB2457@work-vm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180723143604.GB2457@work-vm>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: yang.zhang.wz@gmail.com, virtio-dev@lists.oasis-open.org, riel@redhat.com, quan.xu0@gmail.com, kvm@vger.kernel.org, nilal@redhat.com, liliang.opensource@gmail.com, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, pbonzini@redhat.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 07/23/2018 10:36 PM, Dr. David Alan Gilbert wrote:
> * Michael S. Tsirkin (mst@redhat.com) wrote:
>> On Fri, Jul 20, 2018 at 04:33:00PM +0800, Wei Wang wrote:
>>> This patch series is separated from the previous "Virtio-balloon
>>> Enhancement" series. The new feature, VIRTIO_BALLOON_F_FREE_PAGE_HINT,
>>> implemented by this series enables the virtio-balloon driver to report
>>> hints of guest free pages to the host. It can be used to accelerate live
>>> migration of VMs. Here is an introduction of this usage:
>>>
>>> Live migration needs to transfer the VM's memory from the source machine
>>> to the destination round by round. For the 1st round, all the VM's memory
>>> is transferred. From the 2nd round, only the pieces of memory that were
>>> written by the guest (after the 1st round) are transferred. One method
>>> that is popularly used by the hypervisor to track which part of memory is
>>> written is to write-protect all the guest memory.
>>>
>>> This feature enables the optimization by skipping the transfer of guest
>>> free pages during VM live migration. It is not concerned that the memory
>>> pages are used after they are given to the hypervisor as a hint of the
>>> free pages, because they will be tracked by the hypervisor and transferred
>>> in the subsequent round if they are used and written.
>>>
>>> * Tests
>>> - Test Environment
>>>      Host: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
>>>      Guest: 8G RAM, 4 vCPU
>>>      Migration setup: migrate_set_speed 100G, migrate_set_downtime 2 second
>>>
>>> - Test Results
>>>      - Idle Guest Live Migration Time (results are averaged over 10 runs):
>>>          - Optimization v.s. Legacy = 409ms vs 1757ms --> ~77% reduction
>>> 	(setting page poisoning zero and enabling ksm don't affect the
>>>           comparison result)
>>>      - Guest with Linux Compilation Workload (make bzImage -j4):
>>>          - Live Migration Time (average)
>>>            Optimization v.s. Legacy = 1407ms v.s. 2528ms --> ~44% reduction
>>>          - Linux Compilation Time
>>>            Optimization v.s. Legacy = 5min4s v.s. 5min12s
>>>            --> no obvious difference
>> I'd like to see dgilbert's take on whether this kind of gain
>> justifies adding a PV interfaces, and what kind of guest workload
>> is appropriate.
>>
>> Cc'd.
> Well, 44% is great ... although the measurement is a bit weird.
>
> a) A 2 second downtime is very large; 300-500ms is more normal
> b) I'm not sure what the 'average' is  - is that just between a bunch of
> repeated migrations?
> c) What load was running in the guest during the live migration?
>
> An interesting measurement to add would be to do the same test but
> with a VM with a lot more RAM but the same load;  you'd hope the gain
> would be even better.
> It would be interesting, especially because the users who are interested
> are people creating VMs allocated with lots of extra memory (for the
> worst case) but most of the time migrating when it's fairly idle.
>
> Dave
>

Hi Dave,

The results of the added experiments have been shown in the v37 cover 
letter.
Could you have a look at https://lkml.org/lkml/2018/8/27/29 . Thanks.

Best,
Wei
