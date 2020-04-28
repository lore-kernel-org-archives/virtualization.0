From: Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH 5/5] virtio: Add bounce DMA ops
Date: Tue, 28 Apr 2020 16:04:34 -0700 (PDT)
Message-ID: <alpine.DEB.2.21.2004281556180.29217@sstabellini-ThinkPad-T480s>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org> <1588073958-1793-6-git-send-email-vatsa@codeaurora.org> <20200428121232-mutt-send-email-mst@kernel.org> <20200428174952.GA5097@quicinc.com> <20200428163448-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200428163448-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Srivatsa Vaddagiri <vatsa@codeaurora.org>, konrad.wilk@oracle.com, jasowang@redhat.com, jan.kiszka@siemens.com, will@kernel.org, stefano.stabellini@xilinx.com, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org, pratikp@codeaurora.org, christoffer.dall@arm.com, alex.bennee@linaro.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 28 Apr 2020, Michael S. Tsirkin wrote:
> On Tue, Apr 28, 2020 at 11:19:52PM +0530, Srivatsa Vaddagiri wrote:
> > * Michael S. Tsirkin <mst@redhat.com> [2020-04-28 12:17:57]:
> > 
> > > Okay, but how is all this virtio specific?  For example, why not allow
> > > separate swiotlbs for any type of device?
> > > For example, this might make sense if a given device is from a
> > > different, less trusted vendor.
> > 
> > Is swiotlb commonly used for multiple devices that may be on different trust
> > boundaries (and not behind a hardware iommu)?

The trust boundary is not a good way of describing the scenario and I
think it leads to miscommunication.

A better way to describe the scenario would be that the device can only
DMA to/from a small reserved-memory region advertised on device tree.

Do we have other instances of devices that can only DMA to/from very
specific and non-configurable address ranges? If so, this series could
follow their example.


> Even a hardware iommu does not imply a 100% security from malicious
> hardware. First lots of people use iommu=pt for performance reasons.
> Second even without pt, unmaps are often batched, and sub-page buffers
> might be used for DMA, so we are not 100% protected at all times.
