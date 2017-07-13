From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [virtio-dev] Re: [PATCH v12 7/8] mm: export symbol of next_zone
	and first_online_pgdat
Date: Thu, 13 Jul 2017 16:41:54 +0800
Message-ID: <59673252.7090203__2785.57979404486$1499935171$gmane$org@intel.com>
References: <1499863221-16206-1-git-send-email-wei.w.wang@intel.com>
	<1499863221-16206-8-git-send-email-wei.w.wang@intel.com>
	<20170713031526-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170713031526-mutt-send-email-mst@kernel.org>
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
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, amit.shah@redhat.com, liliang.opensource@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On 07/13/2017 08:16 AM, Michael S. Tsirkin wrote:
> On Wed, Jul 12, 2017 at 08:40:20PM +0800, Wei Wang wrote:
>> This patch enables for_each_zone()/for_each_populated_zone() to be
>> invoked by a kernel module.
> ... for use by virtio balloon.

With this patch, other kernel modules can also use the for_each_zone().
Would it be better to claim it broader?

>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> balloon seems to only use
> +       for_each_populated_zone(zone)
> +               for_each_migratetype_order(order, type)
>

Yes. using for_each_populated_zone() requires the following export.

Best,
Wei
>> ---
>>   mm/mmzone.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/mmzone.c b/mm/mmzone.c
>> index a51c0a6..08a2a3a 100644
>> --- a/mm/mmzone.c
>> +++ b/mm/mmzone.c
>> @@ -13,6 +13,7 @@ struct pglist_data *first_online_pgdat(void)
>>   {
>>   	return NODE_DATA(first_online_node);
>>   }
>> +EXPORT_SYMBOL_GPL(first_online_pgdat);
>>   
>>   struct pglist_data *next_online_pgdat(struct pglist_data *pgdat)
>>   {
>> @@ -41,6 +42,7 @@ struct zone *next_zone(struct zone *zone)
>>   	}
>>   	return zone;
>>   }
>> +EXPORT_SYMBOL_GPL(next_zone);
>>   
>>   static inline int zref_in_nodemask(struct zoneref *zref, nodemask_t *nodes)
>>   {
>> -- 
>> 2.7.4
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>
