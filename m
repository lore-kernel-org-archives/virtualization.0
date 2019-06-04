From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Date: Mon, 03 Jun 2019 22:13:59 -0300
Message-ID: <877ea26tk8.fsf__16706.9906064839$1559610907$gmane$org@morokweng.localdomain>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
	<87womn8inf.fsf@morokweng.localdomain>
	<20190129134750-mutt-send-email-mst@kernel.org>
	<877eefxvyb.fsf@morokweng.localdomain>
	<20190204144048-mutt-send-email-mst@kernel.org>
	<87ef71seve.fsf@morokweng.localdomain>
	<20190320171027-mutt-send-email-mst@kernel.org>
	<87tvfvbwpb.fsf@morokweng.localdomain>
	<20190323165456-mutt-send-email-mst@kernel.org>
	<87a7go71hz.fsf@morokweng.localdomain>
	<20190520090939-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-reply-to: <20190520090939-mutt-send-email-mst@kernel.org>
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
Cc: Mike Anderson <andmike@linux.ibm.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Paul Mackerras <paulus@ozlabs.org>, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>, David Gibson <david@gibson.dropbear.id.au>
List-Id: virtualization@lists.linuxfoundation.org



Michael S. Tsirkin <mst@redhat.com> writes:

> On Wed, Apr 17, 2019 at 06:42:00PM -0300, Thiago Jung Bauermann wrote:
>> I rephrased it in terms of address translation. What do you think of
>> this version? The flag name is slightly different too:
>>
>>
>> VIRTIO_F_ACCESS_PLATFORM_NO_TRANSLATION This feature has the same
>>     meaning as VIRTIO_F_ACCESS_PLATFORM both when set and when not set,
>>     with the exception that address translation is guaranteed to be
>>     unnecessary when accessing memory addresses supplied to the device
>>     by the driver. Which is to say, the device will always use physical
>>     addresses matching addresses used by the driver (typically meaning
>>     physical addresses used by the CPU) and not translated further. This
>>     flag should be set by the guest if offered, but to allow for
>>     backward-compatibility device implementations allow for it to be
>>     left unset by the guest. It is an error to set both this flag and
>>     VIRTIO_F_ACCESS_PLATFORM.
>
>
> OK so VIRTIO_F_ACCESS_PLATFORM is designed to allow unpriveledged
> drivers. This is why devices fail when it's not negotiated.

Just to clarify, what do you mean by unprivileged drivers? Is it drivers
implemented in guest userspace such as with VFIO? Or unprivileged in
some other sense such as needing to use bounce buffers for some reason?

> This confuses me.
> If driver is unpriveledged then what happens with this flag?
> It can supply any address it wants. Will that corrupt kernel
> memory?

Not needing address translation doesn't necessarily mean that there's no
IOMMU. On powerpc we don't use VIRTIO_F_ACCESS_PLATFORM but there's
always an IOMMU present. And we also support VFIO drivers. The VFIO API
for pseries (sPAPR section in Documentation/vfio.txt) has extra ioctls
to program the IOMMU.

For our use case, we don't need address translation because we set up an
identity mapping in the IOMMU so that the device can use guest physical
addresses.

If the guest kernel is concerned that an unprivileged driver could
jeopardize its integrity it should not negotiate this feature flag.
Perhaps there should be a note about this in the flag definition? This
concern is platform-dependant though. I don't believe it's an issue in
pseries.

--
Thiago Jung Bauermann
IBM Linux Technology Center
