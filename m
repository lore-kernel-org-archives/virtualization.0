From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v3 20/27] PCI, xen: Use for_each_pci_resource() with xen
	pci
Date: Fri, 15 Mar 2013 09:35:56 -0400
Message-ID: <20130315133556.GK8582@phenom.dumpdata.com>
References: <1363217302-14383-1-git-send-email-yinghai@kernel.org>
	<1363217302-14383-21-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1363217302-14383-21-git-send-email-yinghai@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 13, 2013 at 04:28:15PM -0700, Yinghai Lu wrote:
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>


Reviewed-by: Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: virtualization@lists.linux-foundation.org
> ---
>  drivers/pci/xen-pcifront.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
> index 966abc6..c90835f 100644
> --- a/drivers/pci/xen-pcifront.c
> +++ b/drivers/pci/xen-pcifront.c
> @@ -395,9 +395,7 @@ static int pcifront_claim_resource(struct pci_dev *dev, void *data)
>  	int i;
>  	struct resource *r;
>  
> -	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
> -		r = &dev->resource[i];
> -
> +	for_each_pci_resource(dev, r, i, PCI_ALL_RES) {
>  		if (!r->parent && r->start && r->flags) {
>  			dev_info(&pdev->xdev->dev, "claiming resource %s/%d\n",
>  				pci_name(dev), i);
> -- 
> 1.7.10.4
> 
