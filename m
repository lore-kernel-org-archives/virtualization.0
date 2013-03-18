From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V3 3/3] tcm_vhost: Use vq->private_data to indicate if
	the endpoint is setup
Date: Mon, 18 Mar 2013 11:30:57 +0200
Message-ID: <20130318093057.GB5267@redhat.com>
References: <1363310047-21652-1-git-send-email-asias@redhat.com>
	<1363310047-21652-4-git-send-email-asias@redhat.com>
	<20130318081900.GA4760@redhat.com>
	<20130318091433.GA6668@hj.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130318091433.GA6668@hj.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Mar 18, 2013 at 05:14:33PM +0800, Asias He wrote:
> On Mon, Mar 18, 2013 at 10:19:00AM +0200, Michael S. Tsirkin wrote:
> > On Fri, Mar 15, 2013 at 09:14:07AM +0800, Asias He wrote:
> > > Currently, vs->vs_endpoint is used indicate if the endpoint is setup or
> > > not. It is set or cleared in vhost_scsi_set_endpoint() or
> > > vhost_scsi_clear_endpoint() under the vs->dev.mutex lock. However, when
> > > we check it in vhost_scsi_handle_vq(), we ignored the lock, this is
> > > wrong.
> > 
> > This one, I don't get. Why is it wrong? Could you please describe the
> > race codition you are trying to prevent?
> 
> Why is it safe to access vs->vs_endpoint without any lock?

For the same reason it's safe with the pointer: either readers
see the old or the new value, and we flush before relying on
the new value.
RCU macros also include barriers that are irrelevant if you are not
going to access any data through the pointer.
Nowdays they also including lockdep-like checks, which you override.

> > > Instead of using the vs->vs_endpoint and the vs->dev.mutex lock to
> > > indicate the status of the endpoint, we use per virtqueue
> > > vq->private_data to indicate it. In this way, we can only take the
> > > vq->mutex lock which is per queue and make the concurrent multiqueue
> > > process having less lock contention. Further, in the read side of
> > > vq->private_data, we can even do not take only lock if it is accessed in
> > > the vhost worker thread, because it is protected by "vhost rcu".
> > 
> > But (unlike with -net) you never actually need the pointer. So why all
> > the complexity?
> 
> It works as a flag, NULL or !NULL.
> 
> This is from your other mail:
> 
> '''
> This takes dev mutex on data path which will introduce
> contention esp for multiqueue.
> How about storing the endpoint as part of vq
> private data and protecting with vq mutex?
> '''

Yes this is better than taking the mutex but I don't see
a problem as is, either. For patch to go into 3.9 it needs
to fix a bug, not just be a refactoring.

> > > Signed-off-by: Asias He <asias@redhat.com>
> > > ---
> > >  drivers/vhost/tcm_vhost.c | 46 ++++++++++++++++++++++++++++++++++++++++------
> > >  1 file changed, 40 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
> > > index 43fb11e..099feef 100644
> > > --- a/drivers/vhost/tcm_vhost.c
> > > +++ b/drivers/vhost/tcm_vhost.c
> > > @@ -67,7 +67,6 @@ struct vhost_scsi {
> > >  	/* Protected by vhost_scsi->dev.mutex */
> > >  	struct tcm_vhost_tpg *vs_tpg[VHOST_SCSI_MAX_TARGET];
> > >  	char vs_vhost_wwpn[TRANSPORT_IQN_LEN];
> > > -	bool vs_endpoint;
> > >  
> > >  	struct vhost_dev dev;
> > >  	struct vhost_virtqueue vqs[VHOST_SCSI_MAX_VQ];
> > > @@ -91,6 +90,24 @@ static int iov_num_pages(struct iovec *iov)
> > >  	       ((unsigned long)iov->iov_base & PAGE_MASK)) >> PAGE_SHIFT;
> > >  }
> > >  
> > > +static bool tcm_vhost_check_endpoint(struct vhost_virtqueue *vq)
> > > +{
> > > +	bool ret = false;
> > > +
> > > +	/*
> > > +	 * We can handle the vq only after the endpoint is setup by calling the
> > > +	 * VHOST_SCSI_SET_ENDPOINT ioctl.
> > > +	 *
> > > +	 * TODO: Check that we are running from vhost_worker which acts
> > > +	 * as read-side critical section for vhost kind of RCU.
> > > +	 * See the comments in struct vhost_virtqueue in drivers/vhost/vhost.h
> > > +	 */
> > > +	if (rcu_dereference_check(vq->private_data, 1))
> > > +		ret = true;
> > > +
> > > +	return ret;
> > > +}
> > > +
> > >  static int tcm_vhost_check_true(struct se_portal_group *se_tpg)
> > >  {
> > >  	return 1;
> > > @@ -581,8 +598,7 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs,
> > >  	int head, ret;
> > >  	u8 target;
> > >  
> > > -	/* Must use ioctl VHOST_SCSI_SET_ENDPOINT */
> > > -	if (unlikely(!vs->vs_endpoint))
> > > +	if (!tcm_vhost_check_endpoint(vq))
> > >  		return;
> > >  
> > >  	mutex_lock(&vq->mutex);
> > > @@ -781,8 +797,9 @@ static int vhost_scsi_set_endpoint(
> > >  {
> > >  	struct tcm_vhost_tport *tv_tport;
> > >  	struct tcm_vhost_tpg *tv_tpg;
> > > +	struct vhost_virtqueue *vq;
> > >  	bool match = false;
> > > -	int index, ret;
> > > +	int index, ret, i;
> > >  
> > >  	mutex_lock(&vs->dev.mutex);
> > >  	/* Verify that ring has been setup correctly. */
> > > @@ -826,7 +843,13 @@ static int vhost_scsi_set_endpoint(
> > >  	if (match) {
> > >  		memcpy(vs->vs_vhost_wwpn, t->vhost_wwpn,
> > >  		       sizeof(vs->vs_vhost_wwpn));
> > > -		vs->vs_endpoint = true;
> > > +		for (i = 0; i < VHOST_SCSI_MAX_VQ; i++) {
> > > +			vq = &vs->vqs[i];
> > > +			/* Flushing the vhost_work acts as synchronize_rcu */
> > > +			mutex_lock(&vq->mutex);
> > > +			rcu_assign_pointer(vq->private_data, vs);
> > > +			mutex_unlock(&vq->mutex);
> > > +		}
> > >  		ret = 0;
> > >  	} else {
> > >  		ret = -EEXIST;
> > > @@ -842,6 +865,8 @@ static int vhost_scsi_clear_endpoint(
> > >  {
> > >  	struct tcm_vhost_tport *tv_tport;
> > >  	struct tcm_vhost_tpg *tv_tpg;
> > > +	struct vhost_virtqueue *vq;
> > > +	bool match = false;
> > >  	int index, ret, i;
> > >  	u8 target;
> > >  
> > > @@ -877,9 +902,18 @@ static int vhost_scsi_clear_endpoint(
> > >  		}
> > >  		tv_tpg->tv_tpg_vhost_count--;
> > >  		vs->vs_tpg[target] = NULL;
> > > -		vs->vs_endpoint = false;
> > > +		match = true;
> > >  		mutex_unlock(&tv_tpg->tv_tpg_mutex);
> > >  	}
> > > +	if (match) {
> > > +		for (i = 0; i < VHOST_SCSI_MAX_VQ; i++) {
> > > +			vq = &vs->vqs[i];
> > > +			/* Flushing the vhost_work acts as synchronize_rcu */
> > > +			mutex_lock(&vq->mutex);
> > > +			rcu_assign_pointer(vq->private_data, NULL);
> > > +			mutex_unlock(&vq->mutex);
> > > +		}
> > > +	}
> > >  	mutex_unlock(&vs->dev.mutex);
> > >  	return 0;
> > >  
> > > -- 
> > > 1.8.1.4
> 
> -- 
> Asias
