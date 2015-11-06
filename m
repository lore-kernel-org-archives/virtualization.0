From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [GIT PULL v4 3/3] s390/dma: Allow per device dma ops
Date: Fri, 6 Nov 2015 09:35:30 +0100
Message-ID: <20151106093530.536ab959.cornelia.huck__26766.0245452591$1446798966$gmane$org@de.ibm.com>
References: <1446754136-125772-1-git-send-email-borntraeger@de.ibm.com>
	<1446754136-125772-4-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1446754136-125772-4-git-send-email-borntraeger@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, Michael Tsirkin <mst@redhat.com>, benh@kernel.crashing.org, Sebastian Ott <sebott@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org, Andy Lutomirski <luto@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, dwmw2@infradead.org, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Thu,  5 Nov 2015 21:08:56 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> As virtio-ccw will have dma ops, we can no longer default to the
> zPCI ones. Make use of dev_archdata to keep the dma_ops per device.
> The pci devices now use that to override the default, and the
> default is changed to use the noop ops for everything that does not
> specify a device specific one.
> To compile without PCI support we will enable HAS_DMA all the time,
> via the default config in lib/Kconfig.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Joerg Roedel <jroedel@suse.de>
> Acked-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
> ---
>  arch/s390/Kconfig                   | 7 ++-----
>  arch/s390/include/asm/device.h      | 6 +++++-
>  arch/s390/include/asm/dma-mapping.h | 6 ++++--
>  arch/s390/pci/pci.c                 | 1 +
>  arch/s390/pci/pci_dma.c             | 4 ++--
>  5 files changed, 14 insertions(+), 10 deletions(-)

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
