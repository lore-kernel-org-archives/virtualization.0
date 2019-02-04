From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Date: Mon, 04 Feb 2019 16:15:41 -0200
Message-ID: <875ztzxvw2.fsf__39084.2185284541$1555717138$gmane$org@morokweng.localdomain>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
	<87womn8inf.fsf@morokweng.localdomain>
	<20190129134750-mutt-send-email-mst@kernel.org>
	<6c68f7f7-1b28-6eba-9b8b-2c32efac9701@redhat.com>
	<20190129213137-mutt-send-email-mst@kernel.org>
	<20190130074427.GA29516@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-reply-to: <20190130074427.GA29516@lst.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@lst.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Paul Mackerras <paulus@ozlabs.org>, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: virtualization@lists.linuxfoundation.org


Christoph Hellwig <hch@lst.de> writes:

> On Tue, Jan 29, 2019 at 09:36:08PM -0500, Michael S. Tsirkin wrote:
>> This has been discussed ad nauseum. virtio is all about compatibility.
>> Losing a couple of lines of code isn't worth breaking working setups.
>> People that want "just use DMA API no tricks" now have the option.
>> Setting a flag in a feature bit map is literally a single line
>> of code in the hypervisor. So stop pushing for breaking working
>> legacy setups and just fix it in the right place.
>
> I agree with the legacy aspect.  What I am missing is an extremely
> strong wording that says you SHOULD always set this flag for new
> hosts, including an explanation why.

My understanding of ACCESS_PLATFORM is that it means "this device will
behave in all aspects like a regular device attached to this bus". Is
that it? Therefore it should be set because it's the sane thing to do?

--
Thiago Jung Bauermann
IBM Linux Technology Center
