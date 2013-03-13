From: Asias He <asias@redhat.com>
Subject: Re: [PATCH 3/4] tcm_vhost: Fix vs->vs_endpoint checking in
	vhost_scsi_handle_vq()
Date: Wed, 13 Mar 2013 11:13:03 +0800
Message-ID: <20130313031303.GD15369@hj.localdomain>
References: <1363056171-5854-1-git-send-email-asias@redhat.com>
	<1363056171-5854-4-git-send-email-asias@redhat.com>
	<20130312111119.GA6788@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130312111119.GA6788@redhat.com>
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

On Tue, Mar 12, 2013 at 01:11:19PM +0200, Michael S. Tsirkin wrote:
> On Tue, Mar 12, 2013 at 10:42:50AM +0800, Asias He wrote:
> > vs->vs_endpoint is protected by the vs->dev.mutex. Use
> > tcm_vhost_check_endpoint() to do check. The helper does the needed
> > locking for us.
> > 
> > Signed-off-by: Asias He <asias@redhat.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> 
> This takes dev mutex on data path which will introduce
> contention esp for multiqueue.

Yes, for now it is okay, but for concurrent execution of multiqueue it is
really bad.

By the way, what is the overhead of taking and releasing the
vs->dev.mutex even if no one contents for it? Is this overhead gnorable.

> How about storing the endpoint as part of vq
> private data and protecting with vq mutex?

Hmm, this makes sense, let's see how well it works.

> > ---
> >  drivers/vhost/tcm_vhost.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
> > index 29612bc..61093d1 100644
> > --- a/drivers/vhost/tcm_vhost.c
> > +++ b/drivers/vhost/tcm_vhost.c
> > @@ -594,7 +594,7 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs,
> >  	u8 target;
> >  
> >  	/* Must use ioctl VHOST_SCSI_SET_ENDPOINT */
> > -	if (unlikely(!vs->vs_endpoint))
> > +	if (!tcm_vhost_check_endpoint(vs))
> >  		return;
> >  
> >  	mutex_lock(&vq->mutex);
> > -- 
> > 1.8.1.4

-- 
Asias
