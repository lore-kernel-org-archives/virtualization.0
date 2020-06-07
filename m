From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC 03/13] vhost: batching fetches
Date: Sun, 7 Jun 2020 09:57:10 -0400
Message-ID: <20200607095219-mutt-send-email-mst@kernel.org>
References: <20200602130543.578420-1-mst@redhat.com>
 <20200602130543.578420-4-mst@redhat.com>
 <3323daa2-19ed-02de-0ff7-ab150f949fff@redhat.com>
 <20200604045830-mutt-send-email-mst@kernel.org>
 <6c2e6cc7-27c5-445b-f252-0356ff8a83f3@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6c2e6cc7-27c5-445b-f252-0356ff8a83f3@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: linux-kernel@vger.kernel.org, Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 05, 2020 at 11:40:17AM +0800, Jason Wang wrote:
> 
> On 2020/6/4 下午4:59, Michael S. Tsirkin wrote:
> > On Wed, Jun 03, 2020 at 03:27:39PM +0800, Jason Wang wrote:
> > > On 2020/6/2 下午9:06, Michael S. Tsirkin wrote:
> > > > With this patch applied, new and old code perform identically.
> > > > 
> > > > Lots of extra optimizations are now possible, e.g.
> > > > we can fetch multiple heads with copy_from/to_user now.
> > > > We can get rid of maintaining the log array.  Etc etc.
> > > > 
> > > > Signed-off-by: Michael S. Tsirkin<mst@redhat.com>
> > > > Signed-off-by: Eugenio Pérez<eperezma@redhat.com>
> > > > Link:https://lore.kernel.org/r/20200401183118.8334-4-eperezma@redhat.com
> > > > Signed-off-by: Michael S. Tsirkin<mst@redhat.com>
> > > > ---
> > > >    drivers/vhost/test.c  |  2 +-
> > > >    drivers/vhost/vhost.c | 47 ++++++++++++++++++++++++++++++++++++++-----
> > > >    drivers/vhost/vhost.h |  5 ++++-
> > > >    3 files changed, 47 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
> > > > index 9a3a09005e03..02806d6f84ef 100644
> > > > --- a/drivers/vhost/test.c
> > > > +++ b/drivers/vhost/test.c
> > > > @@ -119,7 +119,7 @@ static int vhost_test_open(struct inode *inode, struct file *f)
> > > >    	dev = &n->dev;
> > > >    	vqs[VHOST_TEST_VQ] = &n->vqs[VHOST_TEST_VQ];
> > > >    	n->vqs[VHOST_TEST_VQ].handle_kick = handle_vq_kick;
> > > > -	vhost_dev_init(dev, vqs, VHOST_TEST_VQ_MAX, UIO_MAXIOV,
> > > > +	vhost_dev_init(dev, vqs, VHOST_TEST_VQ_MAX, UIO_MAXIOV + 64,
> > > >    		       VHOST_TEST_PKT_WEIGHT, VHOST_TEST_WEIGHT, NULL);
> > > >    	f->private_data = n;
> > > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > > index 8f9a07282625..aca2a5b0d078 100644
> > > > --- a/drivers/vhost/vhost.c
> > > > +++ b/drivers/vhost/vhost.c
> > > > @@ -299,6 +299,7 @@ static void vhost_vq_reset(struct vhost_dev *dev,
> > > >    {
> > > >    	vq->num = 1;
> > > >    	vq->ndescs = 0;
> > > > +	vq->first_desc = 0;
> > > >    	vq->desc = NULL;
> > > >    	vq->avail = NULL;
> > > >    	vq->used = NULL;
> > > > @@ -367,6 +368,11 @@ static int vhost_worker(void *data)
> > > >    	return 0;
> > > >    }
> > > > +static int vhost_vq_num_batch_descs(struct vhost_virtqueue *vq)
> > > > +{
> > > > +	return vq->max_descs - UIO_MAXIOV;
> > > > +}
> > > 1 descriptor does not mean 1 iov, e.g userspace may pass several 1 byte
> > > length memory regions for us to translate.
> > > 
> > Yes but I don't see the relevance. This tells us how many descriptors to
> > batch, not how many IOVs.
> 
> 
> Yes, but questions are:
> 
> - this introduce another obstacle to support more than 1K queue size
> - if we support 1K queue size, does it mean we need to cache 1K descriptors,
> which seems a large stress on the cache
> 
> Thanks
> 
> 
> > 

Still don't understand the relevance. We support up to 1K descriptors
per buffer just for IOV since we always did. This adds 64 more
descriptors - is that a big deal?
