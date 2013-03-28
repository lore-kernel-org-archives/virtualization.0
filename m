From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] tcm_vhost: Avoid VIRTIO_RING_F_EVENT_IDX feature bit
Date: Thu, 28 Mar 2013 18:43:20 +0200
Message-ID: <20130328164320.GD30183@redhat.com>
References: <1364430430-968-1-git-send-email-nab@linux-iscsi.org>
	<20130328060446.GA16579@redhat.com>
	<1364451902.17698.86.camel@haakon2.linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1364451902.17698.86.camel@haakon2.linux-iscsi.org>
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
Cc: kvm-devel <kvm@vger.kernel.org>, lf-virt <virtualization@lists.linux-foundation.org>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 27, 2013 at 11:25:02PM -0700, Nicholas A. Bellinger wrote:
> On Thu, 2013-03-28 at 08:04 +0200, Michael S. Tsirkin wrote:
> > On Thu, Mar 28, 2013 at 12:27:10AM +0000, Nicholas A. Bellinger wrote:
> > > From: Nicholas Bellinger <nab@linux-iscsi.org>
> > > 
> > > This patch adds a VHOST_TCM_FEATURES mask minus VIRTIO_RING_F_EVENT_IDX
> > > so that vhost-scsi-pci userspace will strip this feature bit once
> > > GET_FEATURES reports it as being unsupported on the host.
> > > 
> > > This is to avoid a bug where ->handle_kicks() are missed when EVENT_IDX
> > > is enabled by default in userspace code.
> > > 
> > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > Cc: Asias He <asias@redhat.com>
> > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
> > 
> > No chance we can debug this properly?
> > 
> 
> Well, I assumed this was a low priority item ahead of tracking down the
> other blocking seabios related issue.
> 
> I'm fine with dropping this patch and requiring the event_idx=off option
> for now for an initial QEMU merge, but thought this made things a little
> easier for CLI users to avoid confusion.

Yea, we can't drink the ocean.

> > > ---
> > >  drivers/vhost/tcm_vhost.c |   10 ++++++++--
> > >  1 files changed, 8 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
> > > index 0524267..b127edc 100644
> > > --- a/drivers/vhost/tcm_vhost.c
> > > +++ b/drivers/vhost/tcm_vhost.c
> > > @@ -60,6 +60,12 @@ enum {
> > >  	VHOST_SCSI_VQ_IO = 2,
> > >  };
> > >  
> > > +enum {
> > > +	VHOST_TCM_FEATURES = (1ULL << VIRTIO_F_NOTIFY_ON_EMPTY) |
> > > +			     (1ULL << VIRTIO_RING_F_INDIRECT_DESC) |
> > > +			     (1ULL << VHOST_F_LOG_ALL)
> > 
> > All the rest of the code uses VHOST_SCSI so rename this too?
> > 
> > > +};
> > > +
> > 
> > Please do something like
> > 
> > +/*
> > +* VIRTIO_RING_F_EVENT_IDX seems broken. Not sure the bug is in
> > +* kernel but disabling it helps.
> > +* TODO: debug and remove the workaround.
> > +*/
> > +enum {
> > +     VHOST_SCSI_FEATURES = VHOST_FEATURES & (~VIRTIO_RING_F_EVENT_IDX)
> > +}
> > 
> 
> Patch updated.
> 
> Thanks,
> 
> --nab
> 
> > >  #define VHOST_SCSI_MAX_TARGET	256
> > >  #define VHOST_SCSI_MAX_VQ	128
> > >  
> > > @@ -981,7 +987,7 @@ static void vhost_scsi_flush(struct vhost_scsi *vs)
> > >  
> > >  static int vhost_scsi_set_features(struct vhost_scsi *vs, u64 features)
> > >  {
> > > -	if (features & ~VHOST_FEATURES)
> > > +	if (features & ~VHOST_TCM_FEATURES)
> > >  		return -EOPNOTSUPP;
> > >  
> > >  	mutex_lock(&vs->dev.mutex);
> > > @@ -1027,7 +1033,7 @@ static long vhost_scsi_ioctl(struct file *f, unsigned int ioctl,
> > >  			return -EFAULT;
> > >  		return 0;
> > >  	case VHOST_GET_FEATURES:
> > > -		features = VHOST_FEATURES;
> > > +		features = VHOST_TCM_FEATURES;
> > >  		if (copy_to_user(featurep, &features, sizeof features))
> > >  			return -EFAULT;
> > >  		return 0;
> > > -- 
> > > 1.7.2.5
> 
