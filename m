From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v6 0/7] Add virtio-iommu driver
Date: Tue, 11 Dec 2018 10:31:01 -0800
Message-ID: <20181211183101.GA31936__21392.2278293923$1544552947$gmane$org@infradead.org>
References: <20181211182104.18241-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181211182104.18241-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: mark.rutland@arm.com, virtio-dev@lists.oasis-open.org, tnowicki@caviumnetworks.com, devicetree@vger.kernel.org, marc.zyngier@arm.com, linux-pci@vger.kernel.org, joro@8bytes.org, mst@redhat.com, will.deacon@arm.com, virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org, robh+dt@kernel.org, kvmarm@lists.cs.columbia.edu, bhelgaas@google.com, robin.murphy@arm.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 11, 2018 at 06:20:57PM +0000, Jean-Philippe Brucker wrote:
> Implement the virtio-iommu driver, following specification v0.9 [1].
> 
> Only minor changes since v5 [2]. I fixed issues reported by Michael and
> added tags from Eric and Bharat. Thanks!
> 
> You can find Linux driver and kvmtool device on v0.9 branches [3],
> module and x86 support on virtio-iommu/devel. Also tested with Eric's
> QEMU device [4].

Just curious, what is the use case for it?
