From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v18 06/10] virtio_ring: add a new API,
	virtqueue_add_one_desc
Date: Fri, 01 Dec 2017 16:06:05 +0800
Message-ID: <5A210D6D.3090402__29269.4373209544$1512115458$gmane$org@intel.com>
References: <1511963726-34070-1-git-send-email-wei.w.wang@intel.com>
	<1511963726-34070-7-git-send-email-wei.w.wang@intel.com>
	<20171130213231-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171130213231-mutt-send-email-mst@kernel.org>
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
Cc: yang.zhang.wz@gmail.com, kvm@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp, liliang.opensource@gmail.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, aarcange@redhat.com, virtio-dev@lists.oasis-open.org, mawilcox@microsoft.com, willy@infradead.org, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com, cornelia.huck@de.ibm.com, mhocko@kernel.org, linux-kernel@vger.kernel.org, amit.shah@redhat.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On 12/01/2017 03:38 AM, Michael S. Tsirkin wrote:
> On Wed, Nov 29, 2017 at 09:55:22PM +0800, Wei Wang wrote:
>> Current virtqueue_add API implementation is based on the scatterlist
>> struct, which uses kaddr. This is inadequate to all the use case of
>> vring. For example:
>> - Some usages don't use IOMMU, in this case the user can directly pass
>>    in a physical address in hand, instead of going through the sg
>>    implementation (e.g. the VIRTIO_BALLOON_F_SG feature)
>> - Sometimes, a guest physical page may not have a kaddr (e.g. high
>>    memory) but need to use vring (e.g. the VIRTIO_BALLOON_F_FREE_PAGE_VQ
>>    feature)
>>
>> The new API virtqueue_add_one_desc enables the caller to assign a vring
>> desc with a physical address and len. Also, factor out the common code
>> with virtqueue_add in vring_set_avail.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
> You previously managed without this patch, and it's preferable
> IMHO since this patchset is already too big.
>
> I don't really understand what is wrong with virtio_add_sgs + sg_set_page.
> I don't think is assumes a kaddr.
>

OK, I will use the previous method to send sgs.
Please have a check if there are other things need to be improved.

Best,
Wei
