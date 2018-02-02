From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v25 0/2] Virtio-balloon: support free page reporting
Date: Fri, 02 Feb 2018 20:48:39 +0800
Message-ID: <5A745E27.7070002__39621.6970323168$1517575470$gmane$org@intel.com>
References: <1516871646-22741-1-git-send-email-wei.w.wang@intel.com>
	<20180201211525-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180201211525-mutt-send-email-mst@kernel.org>
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
Cc: yang.zhang.wz@gmail.com, virtio-dev@lists.oasis-open.org, riel@redhat.com, quan.xu0@gmail.com, kvm@vger.kernel.org, nilal@redhat.com, liliang.opensource@gmail.com, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, pbonzini@redhat.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 02/02/2018 03:15 AM, Michael S. Tsirkin wrote:
> On Thu, Jan 25, 2018 at 05:14:04PM +0800, Wei Wang wrote:
>> This patch series is separated from the previous "Virtio-balloon
>> Enhancement" series. The new feature, VIRTIO_BALLOON_F_FREE_PAGE_HINT,
>> implemented by this series enables the virtio-balloon driver to report
>> hints of guest free pages to the host. It can be used to accelerate live
>> migration of VMs. Here is an introduction of this usage:
>>
>> Live migration needs to transfer the VM's memory from the source machine
>> to the destination round by round. For the 1st round, all the VM's memory
>> is transferred. From the 2nd round, only the pieces of memory that were
>> written by the guest (after the 1st round) are transferred. One method
>> that is popularly used by the hypervisor to track which part of memory is
>> written is to write-protect all the guest memory.
>>
>> The second feature enables the optimization of the 1st round memory
>> transfer - the hypervisor can skip the transfer of guest free pages in the
>> 1st round. It is not concerned that the memory pages are used after they
>> are given to the hypervisor as a hint of the free pages, because they will
>> be tracked by the hypervisor and transferred in the next round if they are
>> used and written.
> Could you post performance numbers please?

Yes, it was posted here https://lkml.org/lkml/2018/1/25/698

I just changed the host side to poll the vq so that we don't need kick 
in the driver, it works pretty well. I'll test a little bit more and 
post out a new version with new performance numbers attached in the 
cover letter.

Best,
Wei
