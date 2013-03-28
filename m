From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2 2/2] tcm_vhost: Use vq->private_data to indicate if
	the endpoint is setup
Date: Thu, 28 Mar 2013 11:18:22 +0200
Message-ID: <20130328091821.GC18482__20039.8006629714$1364462297$gmane$org@redhat.com>
References: <1364437048-19932-1-git-send-email-asias@redhat.com>
	<1364437048-19932-3-git-send-email-asias@redhat.com>
	<20130328061659.GA16438@redhat.com>
	<20130328081002.GA4915@hj.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130328081002.GA4915@hj.localdomain>
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

On Thu, Mar 28, 2013 at 04:10:02PM +0800, Asias He wrote:
> On Thu, Mar 28, 2013 at 08:16:59AM +0200, Michael S. Tsirkin wrote:
> > On Thu, Mar 28, 2013 at 10:17:28AM +0800, Asias He wrote:
> > > Currently, vs->vs_endpoint is used indicate if the endpoint is setup or
> > > not. It is set or cleared in vhost_scsi_set_endpoint() or
> > > vhost_scsi_clear_endpoint() under the vs->dev.mutex lock. However, when
> > > we check it in vhost_scsi_handle_vq(), we ignored the lock.
> > > 
> > > Instead of using the vs->vs_endpoint and the vs->dev.mutex lock to
> > > indicate the status of the endpoint, we use per virtqueue
> > > vq->private_data to indicate it. In this way, we can only take the
> > > vq->mutex lock which is per queue and make the concurrent multiqueue
> > > process having less lock contention. Further, in the read side of
> > > vq->private_data, we can even do not take only lock if it is accessed in
> > > the vhost worker thread, because it is protected by "vhost rcu".
> > > 
> > > Signed-off-by: Asias He <asias@redhat.com>
> > > ---
> > >  drivers/vhost/tcm_vhost.c | 38 +++++++++++++++++++++++++++++++++-----
> > >  1 file changed, 33 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
> > > index 5e3d4487..0524267 100644
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
> > 
> > I would just move the check to under vq mutex,
> > and avoid rcu completely. In vhost-net we are using
> > private data outside lock so we can't do this,
> > no such issue here.
> 
> Are you talking about:
> 
>    handle_tx:
>            /* TODO: check that we are running from vhost_worker? */
>            sock = rcu_dereference_check(vq->private_data, 1);
>            if (!sock)
>                    return;
>    
>            wmem = atomic_read(&sock->sk->sk_wmem_alloc);
>            if (wmem >= sock->sk->sk_sndbuf) {
>                    mutex_lock(&vq->mutex);
>                    tx_poll_start(net, sock);
>                    mutex_unlock(&vq->mutex);
>                    return;
>            }
>            mutex_lock(&vq->mutex);
> 
> Why not do the atomic_read and tx_poll_start under the vq->mutex, and thus do
> the check under the lock as well.
>    
>    handle_rx:
>            mutex_lock(&vq->mutex);
>    
>            /* TODO: check that we are running from vhost_worker? */
>            struct socket *sock = rcu_dereference_check(vq->private_data, 1);
>    
>            if (!sock)
>                    return;
>    
>            mutex_lock(&vq->mutex);
> 
> Can't we can do the check under the vq->mutex here?
> 
> The rcu is still there but it makes the code easier to read. IMO, If we want to
> use rcu, use it explicitly and avoid the vhost rcu completely. 
> 
> > >  	mutex_lock(&vq->mutex);
> > > @@ -829,11 +845,12 @@ static int vhost_scsi_set_endpoint(
> > >  		       sizeof(vs->vs_vhost_wwpn));
> > >  		for (i = 0; i < VHOST_SCSI_MAX_VQ; i++) {
> > >  			vq = &vs->vqs[i];
> > > +			/* Flushing the vhost_work acts as synchronize_rcu */
> > >  			mutex_lock(&vq->mutex);
> > > +			rcu_assign_pointer(vq->private_data, vs);
> > >  			vhost_init_used(vq);
> > >  			mutex_unlock(&vq->mutex);
> > >  		}
> > > -		vs->vs_endpoint = true;
> > >  		ret = 0;
> > >  	} else {
> > >  		ret = -EEXIST;
> > 
> > 
> > There's also some weird smp_mb__after_atomic_inc() with no
> > atomic in sight just above ... Nicholas what was the point there?
> > 
> > 
> > > @@ -849,6 +866,8 @@ static int vhost_scsi_clear_endpoint(
> > >  {
> > >  	struct tcm_vhost_tport *tv_tport;
> > >  	struct tcm_vhost_tpg *tv_tpg;
> > > +	struct vhost_virtqueue *vq;
> > > +	bool match = false;
> > >  	int index, ret, i;
> > >  	u8 target;
> > >  
> > > @@ -884,9 +903,18 @@ static int vhost_scsi_clear_endpoint(
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
> > 
> > I'm trying to understand what's going on here.
> > Does vhost_scsi only have a single target?
> > Because the moment you clear one target you
> > also set private_data to NULL ...
> 
> vhost_scsi supports multi target. Currently, We can not disable specific target
> under the wwpn. When we clear or set the endpoint, we disable or enable all the
> targets under the wwpn.

okay, but changing vs->vs_tpg[target] under dev mutex, then using
it under vq mutex looks wrong.

Since we want to use private_data anyway, how about
making private_data point at struct tcm_vhost_tpg * ?

Allocate it dynamically in SET_ENDPOINT (and free old value if any).


> > 
> > >  	mutex_unlock(&vs->dev.mutex);
> > >  	return 0;
> > >  
> > > -- 
> > > 1.8.1.4
> 
> -- 
> Asias
