From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC v4 01/13] ACPI: NUMA: export pxm_to_node
Date: Fri, 13 Dec 2019 10:41:20 +0100
Message-ID: <ec81db03-b970-420a-9c1b-29849b5e8902__15308.3117607579$1576230109$gmane$org@redhat.com>
References: <20191212171137.13872-1-david@redhat.com>
 <20191212171137.13872-2-david@redhat.com> <5687328.t4MNS9KDDX@kreacher>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5687328.t4MNS9KDDX@kreacher>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: virtio-dev@lists.oasis-open.org, linux-acpi@vger.kernel.org, kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.linux-foundation.org, Len Brown <lenb@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 12.12.19 22:43, Rafael J. Wysocki wrote:
> On Thursday, December 12, 2019 6:11:25 PM CET David Hildenbrand wrote:
>> Will be needed by virtio-mem to identify the node from a pxm.
>>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Len Brown <lenb@kernel.org>
>> Cc: linux-acpi@vger.kernel.org
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  drivers/acpi/numa/srat.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
>> index eadbf90e65d1..d5847fa7ac69 100644
>> --- a/drivers/acpi/numa/srat.c
>> +++ b/drivers/acpi/numa/srat.c
>> @@ -35,6 +35,7 @@ int pxm_to_node(int pxm)
>>  		return NUMA_NO_NODE;
>>  	return pxm_to_node_map[pxm];
>>  }
>> +EXPORT_SYMBOL(pxm_to_node);
>>  
>>  int node_to_pxm(int node)
>>  {
>>
> 
> This is fine by me FWIW.

Can I count that as an Acked-by and carry it along? Thanks!

-- 
Thanks,

David / dhildenb
