From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v11 6/6] virtio-balloon: VIRTIO_BALLOON_F_CMD_VQ
Date: Tue, 13 Jun 2017 18:17:32 +0800
Message-ID: <593FBBBC.3060603__19969.9318306104$1497348933$gmane$org@intel.com>
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
	<1497004901-30593-7-git-send-email-wei.w.wang@intel.com>
	<db8cc3d1-50fc-2412-af2f-1070dda38be3@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <db8cc3d1-50fc-2412-af2f-1070dda38be3@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dave Hansen <dave.hansen@intel.com>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, david@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On 06/12/2017 10:07 PM, Dave Hansen wrote:
> On 06/09/2017 03:41 AM, Wei Wang wrote:
>> +	for_each_populated_zone(zone) {
>> +		for (order = MAX_ORDER - 1; order > 0; order--) {
>> +			for (migratetype = 0; migratetype < MIGRATE_TYPES;
>> +			     migratetype++) {
>> +				do {
>> +					ret = report_unused_page_block(zone,
>> +						order, migratetype, &page);
>> +					if (!ret) {
>> +						pfn = (u64)page_to_pfn(page);
>> +						add_one_chunk(vb, vq,
>> +						PAGE_CHNUK_UNUSED_PAGE,
>> +						pfn << VIRTIO_BALLOON_PFN_SHIFT,
>> +						(u64)(1 << order) *
>> +						VIRTIO_BALLOON_PAGES_PER_PAGE);
>> +					}
>> +				} while (!ret);
>> +			}
>> +		}
>> +	}
> This is pretty unreadable.    Please add some indentation.  If you go
> over 80 cols, then you might need to break this up into a separate
> function.  But, either way, it can't be left like this.

OK, I'll re-arrange it.

Best,
Wei
