From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] msi-x: let drivers retry when not enough vectors
Date: Thu, 7 May 2009 05:57:39 -0600
Message-ID: <20090507115739.GJ8112__27782.82472068$1241697575$gmane$org@parisc-linux.org>
References: <20090507082841.GA31751@redhat.com>
	<200905071651.24970.sheng@linux.intel.com>
	<20090507092731.GH8112@parisc-linux.org>
	<200905071740.16190.sheng@linux.intel.com>
	<20090507095302.GI8112@parisc-linux.org>
	<1241691830.24385.6.camel@concordia> <4A02BB96.8070103@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A02BB96.8070103@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, virtualization@lists.linux-foundation.org, michael@ellerman.id.au, Matthew Wilcox <willy@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 07, 2009 at 01:44:38PM +0300, Avi Kivity wrote:
> I imagine this loop is present in many drivers.  So why not add a helper

Let's look!

arch/x86/kernel/amd_iommu_init.c : Needs an exact number of vectors.
drivers/block/cciss.c : If it doesn't get all 4 vectors, falls back to pin mode (instead of MSI mode -- bug!)
drivers/dma/ioat_dma.c : Falls back down to 1 vector if it can't get nvec
drivers/infiniband/hw/mthca/mthca_main.c : Reverts to MSI if it can't get 3.
drivers/net/benet/be_main.c : Falls back to MSI if it can't get 2.
drivers/net/bnx2.c : Falls back to MSI if it can't get 9.
drivers/net/bnx2x_main.c : Falls back to MSI if it can't get N.
drivers/net/e1000e/netdev.c: Falls back to MSI if it can't get N.
drivers/net/enic/enic_main.c: Falls back to MSI if it can't get N.
drivers/net/forcedeth.c: Falls back to MSI if it can't get N.
drivers/net/igb/igb_main.c: Falls back to MSI if it can't get N.
drivers/net/igbvf/netdev.c: Falls back to MSI if it can't get 3.
drivers/net/myri10ge/myri10ge.c: Falls back to Pin if it can't get N.
drivers/net/netxen/netxen_nic_main.c: Falls back to MSI if it can't get N.
drivers/net/qlge/qlge_main.c: Falls back to MSI if it can't get N.
drivers/net/s2io.c: Falls back to MSI if it can't get N.
drivers/net/vxge/vxge-main.c: Falls back once to a second number.
drivers/pci/pcie/portdrv_core.c: Falls back to MSI if it can't get all of them.
drivers/scsi/lpfc/lpfc_init.c: Falls back to MSI if it can't get N.
drivers/scsi/mpt2sas/mpt2sas_base.c: Only allocates 1.

drivers/net/cxgb3/cxgb3_main.c: Actually falls back ... in a bit of a weird way.  This one could definitely do with the proposed loop.
drivers/net/ixgbe/ixgbe_main.c: Could also be improved with this loop.
drivers/net/mlx4/main.c: Nasty goto-based loop.
drivers/net/niu.c: Ditto
drivers/net/sfc/efx.c: Only falls back once.  Would benefit from loop.
drivers/scsi/qla2xxx/qla_isr.c: Only falls back once.  Would benefit from loop.
drivers/staging/sxg/sxg.c: /*Should try with less vector returned.*/

so ... 7 drivers would benefit from this loop.  20 seem like they wouldn't.

What a lot of drivers seem to do is fall back either to a single MSI or
just pin-based interrupts when they can't get as many interrupts as they
would like.  They don't try to get a single MSI-X interrupt.  I feel an
update to the MSI-HOWTO coming on.

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
