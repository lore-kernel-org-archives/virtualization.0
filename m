From: Will Deacon <will@kernel.org>
Subject: Re: [RFC/PATCH 0/1] virtio_mmio: hypervisor specific interfaces for
 MMIO
Date: Thu, 30 Apr 2020 11:08:22 +0100
Message-ID: <20200430100821.GC19932@willie-the-truck>
References: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Cc: konrad.wilk@oracle.com, mst@redhat.com, jasowang@redhat.com, jan.kiszka@siemens.com, stefano.stabellini@xilinx.com, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org, pratikp@codeaurora.org, christoffer.dall@arm.com, alex.bennee@linaro.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 30, 2020 at 03:32:55PM +0530, Srivatsa Vaddagiri wrote:
> The Type-1 hypervisor we are dealing with does not allow for MMIO transport. 
> [1] summarizes some of the problems we have in making virtio work on such
> hypervisors. This patch proposes a solution for transport problem viz how we can
> do config space IO on such a hypervisor. Hypervisor specific methods
> introduced allows for seamless IO of config space.

Seamless huh? You'd hope that might obviate the need for extra patches...

> This patch is meant to seek comments. If its considered to be in right
> direction, will work on making it more complete and send the next version!

What's stopping you from implementing the trapping support in the
hypervisor? Unlike the other patches you sent out, where the guest memory
is not accessible to the host, there doesn't seem to be any advantage to
not having trapping support, or am I missing something here?

Will
