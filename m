From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v6 0/7] Add virtio-iommu driver
Date: Tue, 11 Dec 2018 19:39:28 -0500
Message-ID: <20181211193249-mutt-send-email-mst__7467.77053359455$1544575051$gmane$org@kernel.org>
References: <20181211182104.18241-1-jean-philippe.brucker@arm.com>
	<20181211183101.GA31936@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181211183101.GA31936@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@infradead.org>
Cc: mark.rutland@arm.com, virtio-dev@lists.oasis-open.org, tnowicki@caviumnetworks.com, devicetree@vger.kernel.org, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, linux-pci@vger.kernel.org, joro@8bytes.org, will.deacon@arm.com, virtualization@lists.linux-foundation.org, marc.zyngier@arm.com, iommu@lists.linux-foundation.org, robh+dt@kernel.org, kvmarm@lists.cs.columbia.edu, bhelgaas@google.com, robin.murphy@arm.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 11, 2018 at 10:31:01AM -0800, Christoph Hellwig wrote:
> On Tue, Dec 11, 2018 at 06:20:57PM +0000, Jean-Philippe Brucker wrote:
> > Implement the virtio-iommu driver, following specification v0.9 [1].
> > 
> > Only minor changes since v5 [2]. I fixed issues reported by Michael and
> > added tags from Eric and Bharat. Thanks!
> > 
> > You can find Linux driver and kvmtool device on v0.9 branches [3],
> > module and x86 support on virtio-iommu/devel. Also tested with Eric's
> > QEMU device [4].
> 
> Just curious, what is the use case for it?

If what I saw is any indication, it allows a very simple implementation
of page table shadowing on the host, at the cost of not being able to
accelerate with a hardware nested page tables support when available.

-- 
MST
