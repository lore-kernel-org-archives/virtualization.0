From: "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [PATCH v12 6/8] mm: support reporting free page blocks
Date: Tue, 25 Jul 2017 14:47:16 +0000
Message-ID: <286AC319A985734F985F78AFA26841F739283F62__30299.1931363524$1500994049$gmane$org@shsmsx102.ccr.corp.intel.com>
References: <20170714123023.GA2624@dhcp22.suse.cz>
	<20170714181523-mutt-send-email-mst@kernel.org>
	<20170717152448.GN12888@dhcp22.suse.cz> <596D6E7E.4070700@intel.com>
	<20170719081311.GC26779@dhcp22.suse.cz> <596F4A0E.4010507@intel.com>
	<20170724090042.GF25221@dhcp22.suse.cz> <59771010.6080108@intel.com>
	<20170725112513.GD26723@dhcp22.suse.cz> <597731E8.9040803@intel.com>
	<20170725124141.GF26723@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170725124141.GF26723@dhcp22.suse.cz>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Michal Hocko <mhocko@kernel.org>
Cc: "aarcange@redhat.com" <aarcange@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday, July 25, 2017 8:42 PM, hal Hocko wrote:
> On Tue 25-07-17 19:56:24, Wei Wang wrote:
> > On 07/25/2017 07:25 PM, Michal Hocko wrote:
> > >On Tue 25-07-17 17:32:00, Wei Wang wrote:
> > >>On 07/24/2017 05:00 PM, Michal Hocko wrote:
> > >>>On Wed 19-07-17 20:01:18, Wei Wang wrote:
> > >>>>On 07/19/2017 04:13 PM, Michal Hocko wrote:
> > >>>[...
> > We don't need to do the pfn walk in the guest kernel. When the API
> > reports, for example, a 2MB free page block, the API caller offers to
> > the hypervisor the base address of the page block, and size=2MB, to
> > the hypervisor.
> 
> So you want to skip pfn walks by regularly calling into the page allocator to
> update your bitmap. If that is the case then would an API that would allow you
> to update your bitmap via a callback be s sufficient? Something like
> 	void walk_free_mem(int node, int min_order,
> 			void (*visit)(unsigned long pfn, unsigned long nr_pages))
> 
> The function will call the given callback for each free memory block on the given
> node starting from the given min_order. The callback will be strictly an atomic
> and very light context. You can update your bitmap from there.

I would need to introduce more about the background here:
The hypervisor and the guest live in their own address space. The hypervisor's bitmap
isn't seen by the guest. I think we also wouldn't be able to give a callback function 
from the hypervisor to the guest in this case.

> 
> This would address my main concern that the allocator internals would get
> outside of the allocator proper. 

What issue would it have to expose the internal, for_each_zone()?
I think new code which would call it will also be strictly checked when they
are pushed to upstream.

Best,
Wei
