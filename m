From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 3/5] libnvdimm: add nd_region buffered dax_dev flag
Date: Wed, 9 Jan 2019 09:02:07 -0800
Message-ID: <CAPcyv4jsa709BVPAx_BT5eFrODf-PUPOZ4aguDsjZVawVXTVHQ__16332.661783281$1547053221$gmane$org@mail.gmail.com>
References: <20190109135024.14093-1-pagupta@redhat.com>
	<20190109135024.14093-4-pagupta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190109135024.14093-4-pagupta@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pankaj Gupta <pagupta@redhat.com>
Cc: Jan Kara <jack@suse.cz>, KVM list <kvm@vger.kernel.org>, linux-nvdimm <linux-nvdimm@ml01.01.org>, Qemu Developers <qemu-devel@nongnu.org>, virtualization@lists.linux-foundation.org, Andreas Dilger <adilger.kernel@dilger.ca>, Ross Zwisler <zwisler@kernel.org>, Eric Blake <eblake@redhat.com>, Dave Jiang <dave.jiang@intel.com>, "Darrick J. Wong" <darrick.wong@oracle.com>, Vishal L Verma <vishal.l.verma@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, Linux ACPI <linux-acpi@vger.kernel.org>, jmoyer <jmoyer@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, Rik van Riel <riel@surriel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, lcapitulino@redhat.com, linux-ext4 <linux-ext4@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>, Xiao Guangrong <xiaoguangrong.eric@>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 9, 2019 at 5:53 AM Pankaj Gupta <pagupta@redhat.com> wrote:
>
> This patch adds 'DAXDEV_BUFFERED' flag which is set
> for virtio pmem corresponding nd_region. This later
> is used to disable MAP_SYNC functionality for ext4
> & xfs filesystem.
>
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  drivers/dax/super.c          | 17 +++++++++++++++++
>  drivers/nvdimm/pmem.c        |  3 +++
>  drivers/nvdimm/region_devs.c |  7 +++++++
>  drivers/virtio/pmem.c        |  1 +
>  include/linux/dax.h          |  9 +++++++++
>  include/linux/libnvdimm.h    |  6 ++++++
>  6 files changed, 43 insertions(+)
>
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 6e928f3..9128740 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -167,6 +167,8 @@ enum dax_device_flags {
>         DAXDEV_ALIVE,
>         /* gate whether dax_flush() calls the low level flush routine */
>         DAXDEV_WRITE_CACHE,
> +       /* flag to disable MAP_SYNC for virtio based host page cache flush */
> +       DAXDEV_BUFFERED,
>  };
>
>  /**
> @@ -335,6 +337,21 @@ bool dax_write_cache_enabled(struct dax_device *dax_dev)
>  }
>  EXPORT_SYMBOL_GPL(dax_write_cache_enabled);
>
> +void virtio_pmem_host_cache(struct dax_device *dax_dev, bool wc)
> +{
> +       if (wc)
> +               set_bit(DAXDEV_BUFFERED, &dax_dev->flags);
> +       else
> +               clear_bit(DAXDEV_BUFFERED, &dax_dev->flags);
> +}
> +EXPORT_SYMBOL_GPL(virtio_pmem_host_cache);

The "write_cache" property was structured this way because it can
conceivably change at runtime. The MAP_SYNC capability should be
static and never changed after init.

> +bool virtio_pmem_host_cache_enabled(struct dax_device *dax_dev)
> +{
> +       return test_bit(DAXDEV_BUFFERED, &dax_dev->flags);
> +}
> +EXPORT_SYMBOL_GPL(virtio_pmem_host_cache_enabled);

Echoing Darrick and Jan this is should be a generic property of a
dax_device and not specific to virtio. I don't like the "buffered"
designation as that's not accurate. There may be hardware reasons why
a dax_device is not synchronous, like a requirement to flush a
write-pending queue or otherwise notify the device of new writes.

I would just have a dax_synchronous() helper and a DAXDEV_SYNC flag. I
would also modify alloc_dax() to take a flags argument so that the
capability can be instantiated when the dax_device is allocated.
