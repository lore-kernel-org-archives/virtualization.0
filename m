From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio: set pci bus master enable bit
Date: Tue, 1 Dec 2009 10:34:01 +1030
Message-ID: <200912011034.02251.rusty__27183.564779307$1259625913$gmane$org@rustcorp.com.au>
References: <20091129155200.GA6667@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20091129155200.GA6667@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mark McLoughlin <markmc@redhat.com>, kvm@vger.kernel.org, Yan Vugenfirer <yvugenfi@redhat.com>, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, virtualization@lists.linux-foundation.org, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 30 Nov 2009 02:22:01 am Michael S. Tsirkin wrote:
> As all virtio devices perform DMA, we
> must enable bus mastering for them to be
> spec compliant.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/virtio_pci.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
> index 28d9cf7..717bae1 100644
> --- a/drivers/virtio/virtio_pci.c
> +++ b/drivers/virtio/virtio_pci.c
> @@ -648,6 +648,7 @@ static int __devinit virtio_pci_probe(struct pci_dev *pci_dev,
>  		goto out_req_regions;
>  
>  	pci_set_drvdata(pci_dev, vp_dev);
> +	pci_set_master(pci_dev);

I can believe this, but I have no idea if it's right.  I've applied it, and
hope Jesse will comment if there's something wrong with it.

Thanks,
Rusty.
