From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 8/9] virtio_pci: split out legacy device support
Date: Wed, 17 Dec 2014 01:18:02 +0200
Message-ID: <20141216231802.GB19694@redhat.com>
References: <1418043812-25753-9-git-send-email-mst@redhat.com>
	<20141216210309.GA32071@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20141216210309.GA32071@gondor.apana.org.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Dec 17, 2014 at 08:03:10AM +1100, Herbert Xu wrote:
> Michael S. Tsirkin <mst@redhat.com> wrote:
> > Move everything dealing with legacy devices out to virtio_pci_legacy.c.
> > Expose common code APIs in virtio_pci.h
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> This breaks virtio_pci because you deleted the licence from it.
> 
> -- >8 --
> Subject: virtio_pci: Restore module licence and other attributes
> 
> When the virtio_pci driver was moved into virtio_pci_legacy.c the
> module licence and other attributes went AWOL.  This patch restores
> them.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

I applied this with a minor tweak, and pushed to linux-next.
Unfortunately it's very late here, so I can't test properly
and send pull request today, but will try to do tomorrow.

The tree with a fix is here:
git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git for_linus

> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index 2588252..6b100e3 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -324,3 +324,8 @@ static struct pci_driver virtio_pci_driver = {
>  };
>  
>  module_pci_driver(virtio_pci_driver);
> +
> +MODULE_AUTHOR("Anthony Liguori <aliguori@us.ibm.com>");
> +MODULE_DESCRIPTION("virtio-pci");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION("1");
> 
> Cheers,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
