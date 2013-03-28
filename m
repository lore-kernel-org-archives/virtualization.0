From: Asias He <asias@redhat.com>
Subject: Re: [PATCH V2 1/2] tcm_vhost: Initialize vq->last_used_idx when set
	endpoint
Date: Thu, 28 Mar 2013 11:21:53 +0800
Message-ID: <20130328032153.GA9454__23588.2851914086$1364440953$gmane$org@hj.localdomain>
References: <1364437048-19932-1-git-send-email-asias@redhat.com>
	<1364437048-19932-2-git-send-email-asias@redhat.com>
	<1364439247.17698.72.camel@haakon2.linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1364439247.17698.72.camel@haakon2.linux-iscsi.org>
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
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 27, 2013 at 07:54:07PM -0700, Nicholas A. Bellinger wrote:
> Hi Asias,
> 
> On Thu, 2013-03-28 at 10:17 +0800, Asias He wrote:
> > This patch fixes guest hang when booting seabios and guest.
> > 
> >   [    0.576238] scsi0 : Virtio SCSI HBA
> >   [    0.616754] virtio_scsi virtio1: request:id 0 is not a head!
> > 
> > vq->last_used_idx is initialized only when /dev/vhost-scsi is
> > opened or closed.
> > 
> >    vhost_scsi_open -> vhost_dev_init() -> vhost_vq_reset()
> >    vhost_scsi_release() -> vhost_dev_cleanup -> vhost_vq_reset()
> > 
> > So, when guest talks to tcm_vhost after seabios does, vq->last_used_idx
> > still contains the old valule for seabios. This confuses guest.
> > 
> > Fix this by calling vhost_init_used() to init vq->last_used_idx when
> > we set endpoint.
> > 
> > Signed-off-by: Asias He <asias@redhat.com>
> > ---
> >  drivers/vhost/tcm_vhost.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
> > index 43fb11e..5e3d4487 100644
> > --- a/drivers/vhost/tcm_vhost.c
> > +++ b/drivers/vhost/tcm_vhost.c
> > @@ -781,8 +781,9 @@ static int vhost_scsi_set_endpoint(
> >  {
> >  	struct tcm_vhost_tport *tv_tport;
> >  	struct tcm_vhost_tpg *tv_tpg;
> > +	struct vhost_virtqueue *vq;
> >  	bool match = false;
> > -	int index, ret;
> > +	int index, ret, i;
> >  
> >  	mutex_lock(&vs->dev.mutex);
> >  	/* Verify that ring has been setup correctly. */
> > @@ -826,6 +827,12 @@ static int vhost_scsi_set_endpoint(
> >  	if (match) {
> >  		memcpy(vs->vs_vhost_wwpn, t->vhost_wwpn,
> >  		       sizeof(vs->vs_vhost_wwpn));
> > +		for (i = 0; i < VHOST_SCSI_MAX_VQ; i++) {
> > +			vq = &vs->vqs[i];
> > +			mutex_lock(&vq->mutex);
> > +			vhost_init_used(vq);
> > +			mutex_unlock(&vq->mutex);
> > +		}
> 
> Already tried a similar patch earlier today, but as vhost_init_used()
> depends upon a vq->private_data being set it does not actually
> re-initialize ->last_used_idx..
> 

Sigh... Ah, We have this in vhost_init_used

        if (!vq->private_data)
                return 0;


Michael, how bad if we let the original patch 1/2 and 2/2 go to 3.9.

-- 
Asias
