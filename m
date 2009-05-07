From: Sheng Yang <sheng@linux.intel.com>
Subject: Re: [PATCH] msi-x: let drivers retry when not enough vectors
Date: Thu, 7 May 2009 16:51:24 +0800
Message-ID: <200905071651.24970.sheng__46547.6872669116$1241686335$gmane$org@linux.intel.com>
References: <20090507082841.GA31751@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090507082841.GA31751@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, virtualization@lists.linux-foundation.org, Matthew Wilcox <willy@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 07 May 2009 16:28:41 Michael S. Tsirkin wrote:
> pci_enable_msix currently returns -EINVAL if you ask
> for more vectors than supported by the device, which would
> typically cause fallback to regular interrupts.
>
> It's better to return the table size, making the driver retry
> MSI-X with less vectors.

Hi Michael

I think driver should read from capability list to know how many vector 
supported by this device before enable MSI-X for device, as 
pci_msix_table_size() did...

-- 
regards
Yang, Sheng

>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>
> Hi Jesse,
> This came up when I was adding MSI-X support to virtio pci driver,
> which does not know the exact table size upfront.
> Could you consider this patch for 2.6.31 please?
>
>
>  drivers/pci/msi.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 6f2e629..f5bd1c9 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -687,8 +687,8 @@ int pci_msix_table_size(struct pci_dev *dev)
>   * indicates the successful configuration of MSI-X capability structure
>   * with new allocated MSI-X irqs. A return of < 0 indicates a failure.
>   * Or a return of > 0 indicates that driver request is exceeding the
> number - * of irqs available. Driver should use the returned value to
> re-send - * its request.
> + * of irqs or MSI-X vectors available. Driver should use the returned
> value to + * re-send its request.
>   **/
>  int pci_enable_msix(struct pci_dev* dev, struct msix_entry *entries, int
> nvec) {
> @@ -704,7 +704,7 @@ int pci_enable_msix(struct pci_dev* dev, struct
> msix_entry *entries, int nvec)
>
>  	nr_entries = pci_msix_table_size(dev);
>  	if (nvec > nr_entries)
> -		return -EINVAL;
> +		return nr_entries;
>
>  	/* Check for any invalid entries */
>  	for (i = 0; i < nvec; i++) {
