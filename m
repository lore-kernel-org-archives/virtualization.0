From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Date: Tue, 3 Mar 2020 09:02:23 -0500
Message-ID: <20200303090046-mutt-send-email-mst@kernel.org>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
 <20200228172537.377327-2-jean-philippe@linaro.org>
 <20200302161611.GD7829@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200302161611.GD7829@8bytes.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, linux-pci@vger.kernel.org, virtualization@lists.linux-foundation.org, eric.auger@redhat.com, iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com, jacob.jun.pan@intel.com, bhelgaas@google.com, robin.murphy@arm.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Mar 02, 2020 at 05:16:12PM +0100, Joerg Roedel wrote:
> On Fri, Feb 28, 2020 at 06:25:36PM +0100, Jean-Philippe Brucker wrote:
> > This solution isn't elegant nor foolproof, but is the best we can do at
> > the moment and works with existing virtio-iommu implementations. It also
> > enables an IOMMU for lightweight hypervisors that do not rely on
> > firmware methods for booting.
> 
> I appreciate the enablement on x86, but putting the conmfiguration into
> mmio-space isn't really something I want to see upstream.

It's in virtio config space, not in mmio-space. With a PCI virtio-IOMMU
device this will be in memory.

> What is the
> problem with defining an ACPI table instead? This would also make things
> work on AARCH64 UEFI machines.
> 
> Regards,
> 
> 	Joerg
