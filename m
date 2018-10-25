From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v37 0/3] Virtio-balloon: support free page reporting
Date: Thu, 25 Oct 2018 18:18:53 +0800
Message-ID: <5BD1988D.7010606__41966.4681693122$1540462339$gmane$org@intel.com>
References: <1535333539-32420-1-git-send-email-wei.w.wang@intel.com>
	<20181024205759-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181024205759-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: yang.zhang.wz@gmail.com, virtio-dev@lists.oasis-open.org, riel@redhat.com, quan.xu0@gmail.com, kvm@vger.kernel.org, nilal@redhat.com, liliang.opensource@gmail.com, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, pbonzini@redhat.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, torvalds@linux-foundation.org, dgilbert@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On 10/25/2018 08:58 AM, Michael S. Tsirkin wrote:
> On Mon, Aug 27, 2018 at 09:32:16AM +0800, Wei Wang wrote:
>> The new feature, VIRTIO_BALLOON_F_FREE_PAGE_HINT, implemented by this
>> series enables the virtio-balloon driver to report hints of guest free
>> pages to host. It can be used to accelerate virtual machine (VM) live
>> migration. Here is an introduction of this usage:
>>
>> Live migration needs to transfer the VM's memory from the source machine
>> to the destination round by round. For the 1st round, all the VM's memory
>> is transferred. From the 2nd round, only the pieces of memory that were
>> written by the guest (after the 1st round) are transferred. One method
>> that is popularly used by the hypervisor to track which part of memory is
>> written is to have the hypervisor write-protect all the guest memory.
>>
>> This feature enables the optimization by skipping the transfer of guest
>> free pages during VM live migration. It is not concerned that the memory
>> pages are used after they are given to the hypervisor as a hint of the
>> free pages, because they will be tracked by the hypervisor and transferred
>> in the subsequent round if they are used and written.
> OK so it will be in linux-next.  Now can I trouble you for a virtio spec
> patch with the description please?

No problem, I'll start to patch the spec. Thanks!

Best,
Wei
