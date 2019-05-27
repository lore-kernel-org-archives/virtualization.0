From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v7 0/7] Add virtio-iommu driver
Date: Mon, 27 May 2019 11:26:04 +0200
Message-ID: <20190527092604.GB21613__24662.1189800621$1558949193$gmane$org@8bytes.org>
References: <20190115121959.23763-1-jean-philippe.brucker@arm.com>
	<20190512123022-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190512123022-mutt-send-email-mst@kernel.org>
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
Cc: mark.rutland@arm.com, virtio-dev@lists.oasis-open.org, lorenzo.pieralisi@arm.com, tnowicki@caviumnetworks.com, devicetree@vger.kernel.org, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, linux-pci@vger.kernel.org, will.deacon@arm.com, robin.murphy@arm.com, virtualization@lists.linux-foundation.org, eric.auger@redhat.com, iommu@lists.linux-foundation.org, robh+dt@kernel.org, marc.zyngier@arm.com, bhelgaas@google.com, kvmarm@lists.cs.columbia.edu
List-Id: virtualization@lists.linuxfoundation.org

On Sun, May 12, 2019 at 12:31:59PM -0400, Michael S. Tsirkin wrote:
> OK this has been in next for a while.
> 
> Last time IOMMU maintainers objected. Are objections
> still in force?
> 
> If not could we get acks please?

No objections against the code, I only hesitated because the Spec was
not yet official.

So for the code:

	Acked-by: Joerg Roedel <jroedel@suse.de>
