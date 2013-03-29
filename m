From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH] tcm_vhost: Avoid VIRTIO_RING_F_EVENT_IDX feature bit
Date: Thu, 28 Mar 2013 18:03:05 -0700
Message-ID: <1364518985.10253.42.camel__4453.99795794419$1364519019$gmane$org@haakon2.linux-iscsi.org>
References: <1364430430-968-1-git-send-email-nab@linux-iscsi.org>
	<20130328060446.GA16579@redhat.com>
	<1364451902.17698.86.camel@haakon2.linux-iscsi.org>
	<20130328164423.GE30183@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130328164423.GE30183@redhat.com>
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
Cc: kvm-devel <kvm@vger.kernel.org>, lf-virt <virtualization@lists.linux-foundation.org>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2013-03-28 at 18:44 +0200, Michael S. Tsirkin wrote:
> On Wed, Mar 27, 2013 at 11:25:02PM -0700, Nicholas A. Bellinger wrote:
> > On Thu, 2013-03-28 at 08:04 +0200, Michael S. Tsirkin wrote:
> > > On Thu, Mar 28, 2013 at 12:27:10AM +0000, Nicholas A. Bellinger wrote:
> > > > From: Nicholas Bellinger <nab@linux-iscsi.org>
> > > > 
> > > > This patch adds a VHOST_TCM_FEATURES mask minus VIRTIO_RING_F_EVENT_IDX
> > > > so that vhost-scsi-pci userspace will strip this feature bit once
> > > > GET_FEATURES reports it as being unsupported on the host.
> > > > 
> > > > This is to avoid a bug where ->handle_kicks() are missed when EVENT_IDX
> > > > is enabled by default in userspace code.
> > > > 
> > > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > > Cc: Asias He <asias@redhat.com>
> > > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > > Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
> > > 
> > > No chance we can debug this properly?
> > > 
> > 
> > Well, I assumed this was a low priority item ahead of tracking down the
> > other blocking seabios related issue.
> > 
> > I'm fine with dropping this patch and requiring the event_idx=off option
> > for now for an initial QEMU merge, but thought this made things a little
> > easier for CLI users to avoid confusion.
> > 
> > > > ---
> > > >  drivers/vhost/tcm_vhost.c |   10 ++++++++--
> > > >  1 files changed, 8 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
> > > > index 0524267..b127edc 100644
> > > > --- a/drivers/vhost/tcm_vhost.c
> > > > +++ b/drivers/vhost/tcm_vhost.c
> > > > @@ -60,6 +60,12 @@ enum {
> > > >  	VHOST_SCSI_VQ_IO = 2,
> > > >  };
> > > >  
> > > > +enum {
> > > > +	VHOST_TCM_FEATURES = (1ULL << VIRTIO_F_NOTIFY_ON_EMPTY) |
> > > > +			     (1ULL << VIRTIO_RING_F_INDIRECT_DESC) |
> > > > +			     (1ULL << VHOST_F_LOG_ALL)
> > > 
> > > All the rest of the code uses VHOST_SCSI so rename this too?
> > > 
> > > > +};
> > > > +
> > > 
> > > Please do something like
> > > 
> > > +/*
> > > +* VIRTIO_RING_F_EVENT_IDX seems broken. Not sure the bug is in
> > > +* kernel but disabling it helps.
> > > +* TODO: debug and remove the workaround.
> > > +*/
> > > +enum {
> > > +     VHOST_SCSI_FEATURES = VHOST_FEATURES & (~VIRTIO_RING_F_EVENT_IDX)
> > > +}
> > > 
> > 
> > Patch updated.
> > 
> > Thanks,
> > 
> > --nab
> 
> 
> Still haven't seen it, anyway

Apologies, I had to attend to some other items this afternoon..

Sent this updated patch out a moment ago.

> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> 

Thanks, including this now.
