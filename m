From: Andy King <acking@vmware.com>
Subject: Re: [PATCH 0/2] VMCI: Add support for virtual IOMMU
Date: Wed, 21 Aug 2013 06:43:38 -0700 (PDT)
Message-ID: <1988970649.33605490.1377092618300.JavaMail.root@vmware.com>
References: <1377019803-1490-1-git-send-email-acking@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1377019803-1490-1-git-send-email-acking@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: gregkh@linuxfoundation.org
Cc: pv-drivers@vmware.com, David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Greg,

I'd like to withdraw this in light of DaveM's comments on
a similar patch to vmxnet3 regarding dma_alloc_coherent() vs
pci_alloc_consistent().  I'll fix it and send out a new patchset.

Sorry about this!

Thanks!
- Andy

----- Original Message -----
> This patchset adds support for virtual IOMMU to the VMCI module.  We switch
> to
> DMA consistent mappings for queuepair and doorbell pages that are passed to
> the
> device, which allows the module to work in the presence of vIOMMU/VT-d.
> 
> Andy King (2):
>   VMCI: Remove non-blocking/pinned queuepair support
>   VMCI: Add support for virtual IOMMU
> 
>  drivers/misc/vmw_vmci/vmci_driver.c     |    2 +-
>  drivers/misc/vmw_vmci/vmci_driver.h     |    7 +
>  drivers/misc/vmw_vmci/vmci_guest.c      |   21 ++-
>  drivers/misc/vmw_vmci/vmci_queue_pair.c |  312
>  ++++++++++++-------------------
>  drivers/misc/vmw_vmci/vmci_queue_pair.h |   18 --
>  5 files changed, 140 insertions(+), 220 deletions(-)
> 
> --
> 1.7.4.1
> 
