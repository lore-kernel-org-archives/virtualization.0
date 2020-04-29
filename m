From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 5/5] virtio: Add bounce DMA ops
Date: Wed, 29 Apr 2020 06:45:10 -0400
Message-ID: <20200429064458-mutt-send-email-mst@kernel.org>
References: <20200428163448-mutt-send-email-mst@kernel.org>
 <275eba4b-dd35-aa95-b2e3-9c5cbf7c6d71@linux.intel.com>
 <20200429004531-mutt-send-email-mst@kernel.org>
 <b676430c-65b3-096e-ca48-ceebf10f4b28@linux.intel.com>
 <20200429023842-mutt-send-email-mst@kernel.org>
 <20200429094410.GD5097@quicinc.com>
 <20200429055125-mutt-send-email-mst@kernel.org>
 <20200429100953.GE5097@quicinc.com>
 <20200429061621-mutt-send-email-mst@kernel.org>
 <f52556e2-253e-2dbc-cb7a-a7991e3bcfde@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f52556e2-253e-2dbc-cb7a-a7991e3bcfde@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Srivatsa Vaddagiri <vatsa@codeaurora.org>, Lu Baolu <baolu.lu@linux.intel.com>, tsoni@codeaurora.org, virtio-dev@lists.oasis-open.org, konrad.wilk@oracle.com, jasowang@redhat.com, christoffer.dall@arm.com, virtualization@lists.linux-foundation.org, alex.bennee@linaro.org, iommu@lists.linux-foundation.org, stefano.stabellini@xilinx.com, will@kernel.org, linux-kernel@vger.kernel.org, pratikp@codeaurora.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 29, 2020 at 12:26:43PM +0200, Jan Kiszka wrote:
> On 29.04.20 12:20, Michael S. Tsirkin wrote:
> > On Wed, Apr 29, 2020 at 03:39:53PM +0530, Srivatsa Vaddagiri wrote:
> > > That would still not work I think where swiotlb is used for pass-thr devices
> > > (when private memory is fine) as well as virtio devices (when shared memory is
> > > required).
> > 
> > So that is a separate question. When there are multiple untrusted
> > devices, at the moment it looks like a single bounce buffer is used.
> > 
> > Which to me seems like a security problem, I think we should protect
> > untrusted devices from each other.
> > 
> 
> Definitely. That's the model we have for ivshmem-virtio as well.
> 
> Jan

Want to try implementing that?

> -- 
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
