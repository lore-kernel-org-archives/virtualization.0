From: Asias He <asias@redhat.com>
Subject: Re: [PATCH v7 2/3] tcm_vhost: Add helper to check if endpoint is setup
Date: Mon, 22 Apr 2013 16:53:27 +0800
Message-ID: <20130422085327.GA21692__19878.6773522899$1366620822$gmane$org@hj.localdomain>
References: <20130417131726.GA26157@redhat.com>
	<1366247154-3136-3-git-send-email-asias@redhat.com>
	<20130418070953.GD13787@redhat.com>
	<20130418083230.GC13554@hj.localdomain>
	<20130418073823.GG13787@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130418073823.GG13787@redhat.com>
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

On Thu, Apr 18, 2013 at 10:38:23AM +0300, Michael S. Tsirkin wrote:
> On Thu, Apr 18, 2013 at 04:32:30PM +0800, Asias He wrote:
> > On Thu, Apr 18, 2013 at 10:09:53AM +0300, Michael S. Tsirkin wrote:
> > > On Thu, Apr 18, 2013 at 09:05:53AM +0800, Asias He wrote:
> > > > Signed-off-by: Asias He <asias@redhat.com>
> > > > ---
> > > >  drivers/vhost/tcm_vhost.c | 18 ++++++++++++++++++
> > > >  1 file changed, 18 insertions(+)
> > > > 
> > > > diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
> > > > index 88ebb79..8f05528 100644
> > > > --- a/drivers/vhost/tcm_vhost.c
> > > > +++ b/drivers/vhost/tcm_vhost.c
> > > > @@ -111,6 +111,24 @@ static bool tcm_vhost_check_feature(struct vhost_scsi *vs, int feature)
> > > >  	return ret;
> > > >  }
> > > >  
> > > > +static bool tcm_vhost_check_endpoint(struct vhost_virtqueue *vq)
> > > > +{
> > > > +	bool ret = false;
> > > > +
> > > > +	/*
> > > > +	* We can handle the vq only after the endpoint is setup by calling the
> > > > +	* VHOST_SCSI_SET_ENDPOINT ioctl.
> > > > +	*
> > > > +	* TODO: Check that we are running from vhost_worker which acts
> > > > +	* as read-side critical section for vhost kind of RCU.
> > > > +	* See the comments in struct vhost_virtqueue in drivers/vhost/vhost.h
> > > > +	*/
> > > > +	if (rcu_dereference_check(vq->private_data, 1))
> > > > +		ret = true;
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > 
> > > You can't use RCU in this way. You need to actually
> > > derefence. Instead, just move this within vq mutex
> > > and do rcu_dereference_protected. document that this function
> > > requires vq mutex.
> > 
> > Any difference with: 
> > 
> >    vs_tpg = rcu_dereference_check(vq->private_data, 1);
> 
> Yes, it's not the same. rcu_dereference_protected says
> "this is generally RCU but here I use it under lock".
> rcu_dereference_check can only be used if you
> really dereference later, and you don't.

So you want the helper to be this?

static bool tcm_vhost_check_endpoint()
{
        struct tcm_vhost_tpg **vs_tpg;

        vs_tpg = rcu_dereference_check(vq->private_data, 1);
        if (vs_tpg)
                return true;
        else
                return false
}

And what difference code the compiler will generate with this:

static bool tcm_vhost_check_endpoint()
{

        if (rcu_dereference_check(vq->private_data, 1))
                return true
        else
                return false
}


> 
> >    if (vs_tpg)
> > 	return ture
> >    else
> >         return false;
> > 
> > Note, tcm_vhost_check_endpoint() is called in multiple places. Having a
> > helper is more convenient.
> 
> I'm fine with the helper, but fix the implementation
> and fix all callers to have vq mutex when calling.

All the caller are in the vhost thread. Why need vq mutex to be taken?

> > > >  static int tcm_vhost_check_true(struct se_portal_group *se_tpg)
> > > >  {
> > > >  	return 1;
> > > > -- 
> > > > 1.8.1.4
> > 
> > -- 
> > Asias

-- 
Asias
