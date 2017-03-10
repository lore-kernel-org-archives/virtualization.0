From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH] virtio: remove redundant check on error return err
Date: Fri, 10 Mar 2017 11:36:52 +0800
Message-ID: <CAJSP0QUEUgxKD51nLt6vEAbGP5Hq1KJ4UPU1Re72-6tR5FsPAw@mail.gmail.com>
References: <20170307140821.29689-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170307140821.29689-1-colin.king@canonical.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Colin King <colin.king@canonical.com>
Cc: Linux Virtualization <virtualization@lists.linux-foundation.org>, kernel-janitors@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 7, 2017 at 10:08 PM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> err has previously been checked for a -ve error return so this
> redundant check can be removed.
>
> Detected by CoverityScan, CID#1415271 ("Logically Dead Code")
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/virtio/virtio_pci_common.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index df548a6..ceb4395 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -173,8 +173,6 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
>                 if (err < 0)
>                         return err;
>         }
> -       if (err < 0)
> -               return err;
>
>         vp_dev->msix_vectors = nvectors;
>         vp_dev->msix_names = kmalloc_array(nvectors,

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
