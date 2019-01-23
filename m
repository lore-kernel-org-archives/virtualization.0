From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v7 0/7] Add virtio-iommu driver
Date: Wed, 23 Jan 2019 09:34:35 +0100
Message-ID: <20190123083435.x3svwqp472mdgglw__1631.39377707324$1548232729$gmane$org@8bytes.org>
References: <20190115121959.23763-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190115121959.23763-1-jean-philippe.brucker@arm.com>
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
Cc: mark.rutland@arm.com, virtio-dev@lists.oasis-open.org, lorenzo.pieralisi@arm.com, tnowicki@caviumnetworks.com, mst@redhat.com, marc.zyngier@arm.com, linux-pci@vger.kernel.org, will.deacon@arm.com, robin.murphy@arm.com, virtualization@lists.linux-foundation.org, eric.auger@redhat.com, iommu@lists.linux-foundation.org, robh+dt@kernel.org, bhelgaas@google.com, kvmarm@lists.cs.columbia.edu, devicetree@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Jean-Philippe,

thanks for all your hard work on this!

On Tue, Jan 15, 2019 at 12:19:52PM +0000, Jean-Philippe Brucker wrote:
> Implement the virtio-iommu driver, following specification v0.9 [1].

To make progress on this I think the spec needs to be close to something
that can be included into the official virtio-specification. Have you
proposed the specification for inclusion there?

This is because I can't merge a driver that might be incompatible to
future implementations because the specification needs to be changed on
its way to an official standard.

I had a short discussion with Michael S. Tsirkin about that and from
what I understood the spec needs to be proposed for inclusion on the
virtio-comment[1] mailing list and later the TC needs to vote on it.
Please work with Michael on this to get the specification official (or
at least pretty close to something that will be part of the official
virtio standard).

Regards,

	Joerg

[1] https://www.oasis-open.org/committees/comments/index.php?wg_abbrev=virtio
