From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/2] virtio-mmio: Reject invalid IRQ 0 command line
 argument
Date: Wed, 22 Jul 2020 07:46:36 -0400
Message-ID: <20200722074630-mutt-send-email-mst@kernel.org>
References: <20200701221040.3667868-1-helgaas@kernel.org>
 <20200701221040.3667868-3-helgaas@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200701221040.3667868-3-helgaas@kernel.org>
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
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 01, 2020 at 05:10:40PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The "virtio_mmio.device=" command line argument allows a user to specify
> the size, address, and IRQ of a virtio device.  Previously the only
> requirement for the IRQ was that it be an unsigned integer.
> 
> Zero is an unsigned integer but an invalid IRQ number, and after
> a85a6c86c25be ("driver core: platform: Clarify that IRQ 0 is invalid"),
> attempts to use IRQ 0 cause warnings.
> 
> If the user specifies IRQ 0, return failure instead of registering a device
> with IRQ 0.
> 
> Fixes: a85a6c86c25be ("driver core: platform: Clarify that IRQ 0 is invalid")
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: virtualization@lists.linux-foundation.org

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/virtio/virtio_mmio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 9d16aaffca9d..627ac0487494 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -641,11 +641,11 @@ static int vm_cmdline_set(const char *device,
>  			&vm_cmdline_id, &consumed);
>  
>  	/*
> -	 * sscanf() must processes at least 2 chunks; also there
> +	 * sscanf() must process at least 2 chunks; also there
>  	 * must be no extra characters after the last chunk, so
>  	 * str[consumed] must be '\0'
>  	 */
> -	if (processed < 2 || str[consumed])
> +	if (processed < 2 || str[consumed] || irq == 0)
>  		return -EINVAL;
>  
>  	resources[0].flags = IORESOURCE_MEM;
> -- 
> 2.25.1
