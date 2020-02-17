From: Jean-Philippe Brucker <jean-philippe-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] iommu/virtio: Enable x86 support
Date: Mon, 17 Feb 2020 10:01:07 +0100
Message-ID: <20200217090107.GA1650092@myrica>
References: <20200214160413.1475396-1-jean-philippe@linaro.org>
 <20200214160413.1475396-4-jean-philippe@linaro.org>
 <311a1885-c619-3c8d-29dd-14fbfbf74898@arm.com>
 <20200216045006-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200216045006-mutt-send-email-mst-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Sender: "iommu" <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
To: "Michael S. Tsirkin" <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sebastien.boeuf-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Feb 16, 2020 at 04:50:33AM -0500, Michael S. Tsirkin wrote:
> On Fri, Feb 14, 2020 at 04:57:11PM +0000, Robin Murphy wrote:
> > On 14/02/2020 4:04 pm, Jean-Philippe Brucker wrote:
> > > With the built-in topology description in place, x86 platforms can now
> > > use the virtio-iommu.
> > > 
> > > Signed-off-by: Jean-Philippe Brucker <jean-philippe-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > > ---
> > >   drivers/iommu/Kconfig | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > > index 068d4e0e3541..adcbda44d473 100644
> > > --- a/drivers/iommu/Kconfig
> > > +++ b/drivers/iommu/Kconfig
> > > @@ -508,8 +508,9 @@ config HYPERV_IOMMU
> > >   config VIRTIO_IOMMU
> > >   	bool "Virtio IOMMU driver"
> > >   	depends on VIRTIO=y
> > > -	depends on ARM64
> > > +	depends on (ARM64 || X86)
> > >   	select IOMMU_API
> > > +	select IOMMU_DMA
> > 
> > Can that have an "if X86" for clarity? AIUI it's not necessary for
> > virtio-iommu itself (and really shouldn't be), but is merely to satisfy the
> > x86 arch code's expectation that IOMMU drivers bring their own DMA ops,
> > right?
> > 
> > Robin.
> 
> In fact does not this work on any platform now?

There is ongoing work to use the generic IOMMU_DMA ops on X86. AMD IOMMU
has been converted recently [1] but VT-d still implements its own DMA ops
(conversion patches are on the list [2]). On Arm the arch Kconfig selects
IOMMU_DMA, and I assume we'll have the same on X86 once Tom's work is
complete. Until then I can add a "if X86" here for clarity.

Thanks,
Jean

[1] https://lore.kernel.org/linux-iommu/20190613223901.9523-1-murphyt7-/Zw1syy4LHg@public.gmane.org/
[2] https://lore.kernel.org/linux-iommu/20191221150402.13868-1-murphyt7-/Zw1syy4LHg@public.gmane.org/
