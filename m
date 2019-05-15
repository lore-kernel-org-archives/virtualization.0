From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v9 4/7] dm: enable synchronous dax
Date: Wed, 15 May 2019 13:48:57 -0700
Message-ID: <CAPcyv4jp+9eBQMX+KXhT1oZRkxLeCp9r9g9hFUCRw=OcuQ9wmQ__27344.6264838398$1557953364$gmane$org@mail.gmail.com>
References: <20190514145422.16923-1-pagupta@redhat.com>
	<20190514145422.16923-5-pagupta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190514145422.16923-5-pagupta@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mike Snitzer <snitzer@redhat.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, cohuck@redhat.com, Jan Kara <jack@suse.cz>, KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, david <david@fromorbit.com>, Qemu Developers <qemu-devel@nongnu.org>, virtualization@lists.linux-foundation.org, device-mapper development <dm-devel@redhat.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Ross Zwisler <zwisler@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>, Dave Jiang <dave.jiang@intel.com>, jstaron@google.com, linux-nvdimm <linux-nvdimm@lists.01.org>, Vishal L Verma <vishal.l.verma@intel.com>, Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, Linux ACPI <linux-acpi@vger.kernel.org>, jmoyer <jmoyer@redhat.com>, linux-ext4 <linux-ext4@vger.kernel.org>, Len Brown <lenb@kernel.org>, Adam Borowski <kilobyte@angband.pl>, Rik van Riel <riel@surriel.com>, yuval shaia <yuval.shaia>
List-Id: virtualization@lists.linuxfoundation.org

[ add Mike and dm-devel ]

Mike, any concerns with the below addition to the device-mapper-dax
implementation?

On Tue, May 14, 2019 at 7:58 AM Pankaj Gupta <pagupta@redhat.com> wrote:
>
>  This patch sets dax device 'DAXDEV_SYNC' flag if all the target
>  devices of device mapper support synchrononous DAX. If device
>  mapper consists of both synchronous and asynchronous dax devices,
>  we don't set 'DAXDEV_SYNC' flag.
>
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  drivers/md/dm-table.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index cde3b49b2a91..1cce626ff576 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -886,10 +886,17 @@ static int device_supports_dax(struct dm_target *ti, struct dm_dev *dev,
>         return bdev_dax_supported(dev->bdev, PAGE_SIZE);
>  }
>
> +static int device_synchronous(struct dm_target *ti, struct dm_dev *dev,
> +                              sector_t start, sector_t len, void *data)
> +{
> +       return dax_synchronous(dev->dax_dev);
> +}
> +
>  static bool dm_table_supports_dax(struct dm_table *t)
>  {
>         struct dm_target *ti;
>         unsigned i;
> +       bool dax_sync = true;
>
>         /* Ensure that all targets support DAX. */
>         for (i = 0; i < dm_table_get_num_targets(t); i++) {
> @@ -901,7 +908,14 @@ static bool dm_table_supports_dax(struct dm_table *t)
>                 if (!ti->type->iterate_devices ||
>                     !ti->type->iterate_devices(ti, device_supports_dax, NULL))
>                         return false;
> +
> +               /* Check devices support synchronous DAX */
> +               if (dax_sync &&
> +                   !ti->type->iterate_devices(ti, device_synchronous, NULL))
> +                       dax_sync = false;
>         }
> +       if (dax_sync)
> +               set_dax_synchronous(t->md->dax_dev);
>
>         return true;
>  }
> --
> 2.20.1
>
