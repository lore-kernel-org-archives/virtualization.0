From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH V3 2/2] tcm_vhost: Initialize vq->last_used_idx when
	set endpoint
Date: Mon, 08 Apr 2013 14:11:22 -0700
Message-ID: <1365455482.24346.91.camel__49672.8754755624$1365455503$gmane$org@haakon2.linux-iscsi.org>
References: <1364969858-9410-1-git-send-email-asias@redhat.com>
	<1364969858-9410-3-git-send-email-asias@redhat.com>
	<20130408071034.GC18339@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130408071034.GC18339@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2013-04-08 at 10:10 +0300, Michael S. Tsirkin wrote:
> On Wed, Apr 03, 2013 at 02:17:38PM +0800, Asias He wrote:
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
> 
> Please apply for 3.9.
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 

Applied to target-pending/master, and will be including both in the
v3.9-rc7 PULL request.

Thanks again!

--nab

> > ---
> >  drivers/vhost/tcm_vhost.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
> > index 11121ea..a10efd3 100644
> > --- a/drivers/vhost/tcm_vhost.c
> > +++ b/drivers/vhost/tcm_vhost.c
> > @@ -865,6 +865,7 @@ static int vhost_scsi_set_endpoint(
> >  			/* Flushing the vhost_work acts as synchronize_rcu */
> >  			mutex_lock(&vq->mutex);
> >  			rcu_assign_pointer(vq->private_data, vs_tpg);
> > +			vhost_init_used(vq);
> >  			mutex_unlock(&vq->mutex);
> >  		}
> >  		ret = 0;
> > -- 
> > 1.8.1.4
> --
> To unsubscribe from this list: send the line "unsubscribe target-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
