From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Date: Thu, 18 Jul 2019 00:39:18 -0300
Message-ID: <87y30wj9jt.fsf__26131.2115284213$1563421184$gmane$org@morokweng.localdomain>
References: <20190204144048-mutt-send-email-mst@kernel.org>
	<87ef71seve.fsf@morokweng.localdomain>
	<20190320171027-mutt-send-email-mst@kernel.org>
	<87tvfvbwpb.fsf@morokweng.localdomain>
	<20190323165456-mutt-send-email-mst@kernel.org>
	<87a7go71hz.fsf@morokweng.localdomain>
	<20190520090939-mutt-send-email-mst@kernel.org>
	<877ea26tk8.fsf@morokweng.localdomain>
	<20190603211528-mutt-send-email-mst@kernel.org>
	<877e96qxm7.fsf@morokweng.localdomain>
	<20190701092212-mutt-send-email-mst@kernel.org>
	<87d0id9nah.fsf@morokweng.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-reply-to: <87d0id9nah.fsf@morokweng.localdomain>
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
Cc: Alexey Kardashevskiy <aik@linux.ibm.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Mike Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>, David Gibson <david@gibson.dropbear.id.au>
List-Id: virtualization@lists.linuxfoundation.org


Hello,

Just going back to this question which I wasn't able to answer.

Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:

> Michael S. Tsirkin <mst@redhat.com> writes:
>
>> So far so good, but now a question:
>>
>> how are we handling guest address width limitations?
>> Is VIRTIO_F_ACCESS_PLATFORM_IDENTITY_ADDRESS subject to
>> guest address width limitations?
>> I am guessing we can make them so ...
>> This needs to be documented.
>
> I'm not sure. I will get back to you on this.

We don't have address width limitations between host and guest.

--
Thiago Jung Bauermann
IBM Linux Technology Center
