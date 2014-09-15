From: Matt Wilson <msw@linux.com>
Subject: Re: [PATCH] virtio-pci: also bind to Amazon PCI vendor ID
Date: Sun, 14 Sep 2014 20:43:42 -0700
Message-ID: <20140915034342.GC4546@u109add4315675089e695.ant.amazon.com>
References: <1410751773-10519-1-git-send-email-anthony@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1410751773-10519-1-git-send-email-anthony@codemonkey.ws>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Anthony Liguori <aliguori@amazon.com>, Michael Tsirkin <mst@redhat.com>, kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Matt Wilson <msw@amazon.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Sep 14, 2014 at 08:29:33PM -0700, Anthony Liguori wrote:
> From: Anthony Liguori <aliguori@amazon.com>
> 
> See https://issues.oasis-open.org/browse/VIRTIO-16 although it
> was prematurely closed.
> 
> Red Hat has non-redistributable Windows drivers and Microsoft
> will not allow anyone else to WHQL certify drivers using that
> vendor ID.  That makes it impossible to use virtio drivers with
> a Windows guest without changing the vendor ID.
> 
> Cc: Matt Wilson <msw@amazon.com>
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> Cc: Michael Tsirkin <mst@redhat.com>
> Signed-off-by: Anthony Liguori <aliguori@amazon.com>

Reviewed-by: Matt Wilson <msw@amazon.com>

--msw

> ---
>  drivers/virtio/virtio_pci.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
> index 101db3f..9cbac33 100644
> --- a/drivers/virtio/virtio_pci.c
> +++ b/drivers/virtio/virtio_pci.c
> @@ -93,6 +93,8 @@ struct virtio_pci_vq_info
>  /* Qumranet donated their vendor ID for devices 0x1000 thru 0x10FF. */
>  static DEFINE_PCI_DEVICE_TABLE(virtio_pci_id_table) = {
>  	{ PCI_DEVICE(0x1af4, PCI_ANY_ID) },
> +	/* Amazon.com vendor ID */
> +	{ PCI_DEVICE(0x1d0f, PCI_ANY_ID) },
>  	{ 0 }
>  };
>  
