From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v5 5/7] iommu: Add virtio-iommu driver
Date: Tue, 27 Nov 2018 13:13:24 -0500
Message-ID: <20181127131116-mutt-send-email-mst__46530.0224525437$1543342301$gmane$org@kernel.org>
References: <20181122193801.50510-1-jean-philippe.brucker@arm.com>
	<20181122193801.50510-6-jean-philippe.brucker@arm.com>
	<20181123165742-mutt-send-email-mst@kernel.org>
	<fd221210-7e12-1d15-0c80-52a761f6893d@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <fd221210-7e12-1d15-0c80-52a761f6893d@arm.com>
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
Cc: mark.rutland@arm.com, virtio-dev@lists.oasis-open.org, lorenzo.pieralisi@arm.com, tnowicki@caviumnetworks.com, devicetree@vger.kernel.org, marc.zyngier@arm.com, linux-pci@vger.kernel.org, joro@8bytes.org, will.deacon@arm.com, virtualization@lists.linux-foundation.org, eric.auger@redhat.com, iommu@lists.linux-foundation.org, robh+dt@kernel.org, bhelgaas@google.com, robin.murphy@arm.com, kvmarm@lists.cs.columbia.edu
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Nov 27, 2018 at 05:50:50PM +0000, Jean-Philippe Brucker wrote:
> > I didn't notice this in the past but it seems this will spin
> > with interrupts disabled until host handles the request.
> > Please do not do this - host execution can be another
> > task that needs the same host CPU. This will then disable
> > interrupts for a very very long time.
> 
> In the guest yes, but that doesn't prevent the host from running another
> task right? My tests run fine when QEMU is bound to a single CPU, even
> though vcpu and viommu run in different threads

So a kind of a solution is to add a config space field for sync.
That at least can give host a hint that yes, vcpu
is stopped now and it should do something else.
Not ideal but better than polling VQ forever.

-- 
MST
