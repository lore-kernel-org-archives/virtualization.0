From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [virtio-dev] Re: [PATCH v17 6/6] virtio-balloon:
	VIRTIO_BALLOON_F_FREE_PAGE_VQ
Date: Thu, 16 Nov 2017 21:27:24 +0800
Message-ID: <5A0D923C.4020807__7914.14397904209$1510838718$gmane$org@intel.com>
References: <1509696786-1597-1-git-send-email-wei.w.wang@intel.com>
	<1509696786-1597-7-git-send-email-wei.w.wang@intel.com>
	<20171115220743-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171115220743-mutt-send-email-mst@kernel.org>
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
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mawilcox@microsoft.com, qemu-devel@nongnu.org, amit.shah@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, linux-kernel@vger.kernel.org, willy@infradead.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, mhocko@kernel.org, mgorman@techsingularity.net, liliang.opensource@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On 11/16/2017 04:32 AM, Michael S. Tsirkin wrote:
> On Fri, Nov 03, 2017 at 04:13:06PM +0800, Wei Wang wrote:
>> Negotiation of the VIRTIO_BALLOON_F_FREE_PAGE_VQ feature indicates the
>> support of reporting hints of guest free pages to the host via
>> virtio-balloon. The host requests the guest to report the free pages by
>> sending commands via the virtio-balloon configuration registers.
>>
>> When the guest starts to report, the first element added to the free page
>> vq is a sequence id of the start reporting command. The id is given by
>> the host, and it indicates whether the following free pages correspond
>> to the command. For example, the host may stop the report and start again
>> with a new command id. The obsolete pages for the previous start command
>> can be detected by the id dismatching on the host. The id is added to the
>> vq using an output buffer, and the free pages are added to the vq using
>> input buffer.
>>
>> Here are some explainations about the added configuration registers:
>> - host2guest_cmd: a register used by the host to send commands to the
>> guest.
>> - guest2host_cmd: written by the guest to ACK to the host about the
>> commands that have been received. The host will clear the corresponding
>> bits on the host2guest_cmd register. The guest also uses this register
>> to send commands to the host (e.g. when finish free page reporting).
>> - free_page_cmd_id: the sequence id of the free page report command
>> given by the host.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> Signed-off-by: Liang Li <liang.z.li@intel.com>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> ---
>>
>> +
>> +static void report_free_page(struct work_struct *work)
>> +{
>> +	struct virtio_balloon *vb;
>> +
>> +	vb = container_of(work, struct virtio_balloon, report_free_page_work);
>> +	report_free_page_cmd_id(vb);
>> +	walk_free_mem_block(vb, 0, &virtio_balloon_send_free_pages);
>> +	/*
>> +	 * The last few free page blocks that were added may not reach the
>> +	 * batch size, but need a kick to notify the device to handle them.
>> +	 */
>> +	virtqueue_kick(vb->free_page_vq);
>> +	report_free_page_end(vb);
>> +}
>> +
> I think there's an issue here: if pages are poisoned and hypervisor
> subsequently drops them, testing them after allocation will
> trigger a false positive.
>
> The specific configuration:
>
> PAGE_POISONING on
> PAGE_POISONING_NO_SANITY off
> PAGE_POISONING_ZERO off
>
>
> Solutions:
> 1. disable the feature in that configuration
> 	suggested as an initial step

Thanks for the finding.
Similar to this option: I'm thinking could we make walk_free_mem_block() 
simply return if that option is on?
That is, at the beginning of the function:
     if (!page_poisoning_enabled())
                 return;

I think in most usages, people would not choose to use the poisoning 
option due to the added overhead.


Probably we could make it a separate fix patch of this report following 
patch 5 to explain the above reasons in the commit.

> 2. pass poison value to host so it can validate page content
>     before it drops it
> 3. pass poison value to host so it can init allocated pages with that value
>
> In fact one nice side effect would be that unmap
> becomes safe even though free list is not locked anymore.

I haven't got this point yet,  how would it bring performance benefit?

> It would be interesting to see whether this last has
> any value performance-wise.
>

Best,
Wei
