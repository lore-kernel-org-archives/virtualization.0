From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1] virtio_blk: Use sysfs_match_string() helper
Date: Mon, 3 Jul 2017 19:37:51 +0300
Message-ID: <20170703193730-mutt-send-email-mst@kernel.org>
References: <20170609120742.21959-1-andriy.shevchenko@linux.intel.com>
	<1499083530.22624.239.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1499083530.22624.239.camel@linux.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jens Axboe <axboe@fb.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 03, 2017 at 03:05:30PM +0300, Andy Shevchenko wrote:
> On Fri, 2017-06-09 at 15:07 +0300, Andy Shevchenko wrote:
> > Use sysfs_match_string() helper instead of open coded variant.
> =

> Did I miss maintainer?
> =

> > =

> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


You didn't, I'll merge this in the next PULL.

Thanks!

> > ---
> > =A0drivers/block/virtio_blk.c | 7 ++-----
> > =A01 file changed, 2 insertions(+), 5 deletions(-)
> > =

> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 553cc4c542b4..0e707b8cce9d 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -541,12 +541,9 @@ virtblk_cache_type_store(struct device *dev,
> > struct device_attribute *attr,
> > =A0	int i;
> > =A0
> > =A0	BUG_ON(!virtio_has_feature(vblk->vdev,
> > VIRTIO_BLK_F_CONFIG_WCE));
> > -	for (i =3D ARRAY_SIZE(virtblk_cache_types); --i >=3D 0; )
> > -		if (sysfs_streq(buf, virtblk_cache_types[i]))
> > -			break;
> > -
> > +	i =3D sysfs_match_string(virtblk_cache_types, buf);
> > =A0	if (i < 0)
> > -		return -EINVAL;
> > +		return i;
> > =A0
> > =A0	virtio_cwrite8(vdev, offsetof(struct virtio_blk_config, wce),
> > i);
> > =A0	virtblk_update_cache_mode(vdev);
> =

> -- =

> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy
