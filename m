From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v12 5/8] virtio-balloon: VIRTIO_BALLOON_F_SG
Date: Mon, 31 Jul 2017 20:36:09 +0800
Message-ID: <597F2439.5070309__1325.36401874876$1501504423$gmane$org@intel.com>
References: <59686EEB.8080805@intel.com>
	<20170723044036-mutt-send-email-mst@kernel.org>
	<59781119.8010200@intel.com>
	<20170726155856-mutt-send-email-mst@kernel.org>
	<597954E3.2070801@intel.com>
	<20170729020231-mutt-send-email-mst@kernel.org>
	<597C83CC.7060702@intel.com>
	<20170730043922-mutt-send-email-mst@kernel.org>
	<286AC319A985734F985F78AFA26841F739288D85@shsmsx102.ccr.corp.intel.com>
	<20170730191735-mutt-send-email-mst@kernel.org>
	<20170730191911-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170730191911-mutt-send-email-mst@kernel.org>
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
Cc: "aarcange@redhat.com" <aarcange@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>
List-Id: virtualization@lists.linuxfoundation.org

On 07/31/2017 12:20 AM, Michael S. Tsirkin wrote:
> On Sun, Jul 30, 2017 at 07:18:33PM +0300, Michael S. Tsirkin wrote:
>> On Sun, Jul 30, 2017 at 05:59:17AM +0000, Wang, Wei W wrote:
>> That's a hypervisor implementation detail. From guest point of view,
>> discarding contents can not be distinguished from writing old contents.
>>
> Besides, ignoring the free page tricks, consider regular ballooning.
> We map page with DONTNEED then back with WILLNEED. Result is
> getting a zero page. So at least one of deflate/inflate should be input.
> I'd say both for symmetry.
>

OK, I see the point. Thanks.

Best,
Wei
