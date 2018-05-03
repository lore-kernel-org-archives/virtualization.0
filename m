From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC] virtio: support VIRTIO_F_IO_BARRIER
Date: Thu, 3 May 2018 14:50:07 +0100
Message-ID: <CAJSP0QUfvRH0SVMPZB_5xYa2LbSFy9jXe=c7v68AFMf01eSWuQ__40307.7885312543$1525355288$gmane$org@mail.gmail.com>
References: <20180503025955.28816-1-tiwei.bie@intel.com>
	<20180503090652.GB5301@stefanha-x1.localdomain>
	<20180503132647.yfulyzbygdfgu2or@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180503132647.yfulyzbygdfgu2or@debian>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Wang,
	Zhihong" <zhihong.wang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 3, 2018 at 2:26 PM, Tiwei Bie <tiwei.bie@intel.com> wrote:
> On Thu, May 03, 2018 at 10:06:52AM +0100, Stefan Hajnoczi wrote:
>> On Thu, May 03, 2018 at 10:59:55AM +0800, Tiwei Bie wrote:
>> > This patch introduces the support for VIRTIO_F_IO_BARRIER.
>> > When this feature is negotiated, driver will use the barriers
>> > suitable for hardware devices.
>> >
>> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
>>
>> I should have thought of this earlier, but why is a new feature bit
>> necessary?  If a hardware virtio device is in use, then the device
>> should already negotiate VIRTIO_F_IOMMU_PLATFORM (i.e. use DMA APIs and
>> IOMMU callbacks).
>>
>> Does disabling weak_barriers when VIRTIO_F_IOMMU_PLATFORM is set solve
>> the problem?
>
> The VIRTIO_F_IOMMU_PLATFORM feature can be set when the
> device is implemented in software. And I think we don't
> want the performance drop in this case.

Good point.

Stefan
