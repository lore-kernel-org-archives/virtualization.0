From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Date: Tue, 26 Mar 2019 12:53:59 -0400
Message-ID: <20190325084348-mutt-send-email-mst__34742.2226493777$1553619257$gmane$org@kernel.org>
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
Content-Disposition: inline
In-Reply-To: <20190130074427.GA29516@lst.de>
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
Cc: Lorenzo.Pieralisi@arm.com, tnowicki@caviumnetworks.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org, Will.Deacon@arm.com, virtualization@lists.linux-foundation.org, Paul Mackerras <paulus@ozlabs.org>, eric.auger@redhat.com, iommu@lists.linux-foundation.org, Marc.Zyngier@arm.com, Robin.Murphy@arm.com, linuxppc-dev@lists.ozlabs.org, joro@8bytes.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 30, 2019 at 08:44:27AM +0100, Christoph Hellwig wrote:
> On Tue, Jan 29, 2019 at 09:36:08PM -0500, Michael S. Tsirkin wrote:
> > This has been discussed ad nauseum. virtio is all about compatibility.
> > Losing a couple of lines of code isn't worth breaking working setups.
> > People that want "just use DMA API no tricks" now have the option.
> > Setting a flag in a feature bit map is literally a single line
> > of code in the hypervisor. So stop pushing for breaking working
> > legacy setups and just fix it in the right place.
> 
> I agree with the legacy aspect.  What I am missing is an extremely
> strong wording that says you SHOULD always set this flag for new
> hosts, including an explanation why.


So as far as power is concerned, IIUC the issue they are struggling with is
that some platforms do not support pass-through mode in the emulated IOMMU.
Disabling PLATFORM_ACCESS is so far a way around that, unfortunately just for
virtio devices.  I would like virtio-iommu to be able to address that need as
well.

-- 
MST
