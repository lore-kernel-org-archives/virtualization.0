From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/2] tcm_vhost: Initialize vq->last_used_idx when set
	endpoint
Date: Wed, 27 Mar 2013 23:45:59 +0200
Message-ID: <20130327214559.GB10678@redhat.com>
References: <1363920748-32139-1-git-send-email-asias@redhat.com>
	<1363920748-32139-3-git-send-email-asias@redhat.com>
	<20130325111611.GD9221@redhat.com>
	<1364416155.17698.3.camel@haakon2.linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1364416155.17698.3.camel@haakon2.linux-iscsi.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 27, 2013 at 01:29:15PM -0700, Nicholas A. Bellinger wrote:
> On Mon, 2013-03-25 at 13:16 +0200, Michael S. Tsirkin wrote:
> > On Fri, Mar 22, 2013 at 10:52:28AM +0800, Asias He wrote:
> > > This patch fixes guest hang when booting seabios and guest.
> > > 
> > >   [    0.576238] scsi0 : Virtio SCSI HBA
> > >   [    0.616754] virtio_scsi virtio1: request:id 0 is not a head!
> > > 
> > > vq->last_used_idx is initialized only when /dev/vhost-scsi is
> > > opened or closed.
> > > 
> > >    vhost_scsi_open -> vhost_dev_init() -> vhost_vq_reset()
> > >    vhost_scsi_release() -> vhost_dev_cleanup -> vhost_vq_reset()
> > > 
> > > So, when guest talks to tcm_vhost after seabios does, vq->last_used_idx
> > > still contains the old valule for seabios. This confuses guest.
> > > 
> > > Fix this by calling vhost_init_used() to init vq->last_used_idx when
> > > we set endpoint.
> > > 
> > > Signed-off-by: Asias He <asias@redhat.com>
> > 
> > Good catch, thanks.
> > 
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > Nicholas can you pick this one up for 3.9 please?
> > 
> 
> Just a heads up that this needs PATCH 1/2 as vhost_init_used() expects
> vq->private_data to already have been set..
> 
> Can you take a another look at the first patch as a v3.9 item..?  Both
> are required in order for Asias's seabios changes to work.
> 
> Thanks,
> 
> --nab
> 

Both me and Asias agreed it's not 3.9 material.
Asias, can you please rework 2/2 to avoid dependency on 1/2?
Should be trivial enough ...

> > >  drivers/vhost/tcm_vhost.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
> > > index 099feef..0524267 100644
> > > --- a/drivers/vhost/tcm_vhost.c
> > > +++ b/drivers/vhost/tcm_vhost.c
> > > @@ -848,6 +848,7 @@ static int vhost_scsi_set_endpoint(
> > >  			/* Flushing the vhost_work acts as synchronize_rcu */
> > >  			mutex_lock(&vq->mutex);
> > >  			rcu_assign_pointer(vq->private_data, vs);
> > > +			vhost_init_used(vq);
> > >  			mutex_unlock(&vq->mutex);
> > >  		}
> > >  		ret = 0;
> > > -- 
> > > 1.8.1.4
> > --
> > To unsubscribe from this list: send the line "unsubscribe target-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
