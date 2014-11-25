From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 11/42] virtio: add legacy feature table support
Date: Tue, 25 Nov 2014 23:39:42 +0200
Message-ID: <20141125213942.GD22343@redhat.com>
References: <1416933600-21398-1-git-send-email-mst@redhat.com>
	<1416933600-21398-12-git-send-email-mst@redhat.com>
	<20141125185342.761bf72e.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20141125185342.761bf72e.cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Pawel Moll <pawel.moll@arm.com>, rusty@au1.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, pbonzini@redhat.com, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Nov 25, 2014 at 06:53:42PM +0100, Cornelia Huck wrote:
> On Tue, 25 Nov 2014 18:42:09 +0200
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > virtio blk has some legacy feature bits that modern drivers
> 
> virtio-blk
> 
> > must not negotiate, but are needed for old legacy hosts
> > (e.g. that dn't support virtio scsi).
> 
> (that e.g. don't support virtio-scsi)
> 
> > Allow a separate legacy feature table for such cases.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  include/linux/virtio.h  |  4 ++++
> >  drivers/virtio/virtio.c | 25 ++++++++++++++++++++++++-
> >  2 files changed, 28 insertions(+), 1 deletion(-)
> > 
> 
> > @@ -177,7 +185,22 @@ static int virtio_dev_probe(struct device *_d)
> >  		driver_features |= (1ULL << f);
> >  	}
> > 
> > -	dev->features = driver_features & device_features;
> > +	/* Some drivers have a separate feature tables for virtio v1.0 */
> 
> /* some drivers have a separate feature table for legacy virtio */
> 
> ?

I prefer have separate feature tables:  drivers (plural) have tables
(plural).

Agree?

> > +	if (drv->feature_table_legacy) {
> > +		driver_features_legacy = 0;
> > +		for (i = 0; i < drv->feature_table_size_legacy; i++) {
> > +			unsigned int f = drv->feature_table_legacy[i];
> > +			BUG_ON(f >= 64);
> > +			driver_features_legacy |= (1ULL << f);
> > +		}
> > +	} else {
> > +		driver_features_legacy = driver_features;
> > +	}
> (...)
