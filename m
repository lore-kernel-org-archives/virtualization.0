From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [RFC-v2 3/6] vhost-scsi: add -vhost-scsi host device for use
	with tcm-vhost
Date: Mon, 20 Aug 2012 15:24:58 -0700
Message-ID: <1345501498.23278.80.camel@haakon2.linux-iscsi.org>
References: <1344846917-7411-1-git-send-email-nab@linux-iscsi.org>
	<1344846917-7411-4-git-send-email-nab@linux-iscsi.org>
	<20120813085325.GH14081@redhat.com>
	<1344976274.22433.93.camel@haakon2.linux-iscsi.org>
	<20120818191243.GB17770@redhat.com>
	<1345336586.25161.373.camel@haakon2.linux-iscsi.org>
	<20120819084426.GB26215@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120819084426.GB26215@redhat.com>
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
Cc: Anthony Liguori <aliguori@us.ibm.com>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, lf-virt <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2012-08-19 at 11:44 +0300, Michael S. Tsirkin wrote:
> On Sat, Aug 18, 2012 at 05:36:26PM -0700, Nicholas A. Bellinger wrote:
> > On Sat, 2012-08-18 at 22:12 +0300, Michael S. Tsirkin wrote:
> > > On Tue, Aug 14, 2012 at 01:31:14PM -0700, Nicholas A. Bellinger wrote:
> > > > On Mon, 2012-08-13 at 11:53 +0300, Michael S. Tsirkin wrote:
> > > > > On Mon, Aug 13, 2012 at 08:35:14AM +0000, Nicholas A. Bellinger wrote:
> > > > > > From: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>

<SNIP>

> > > > Mmm, looking at how vhost_net_init + tap.c does this, but am not quite
> > > > what fd needs to be propagated up for virtio-scsi -> vhost-scsi..
> > > > 
> > > > Can you please elaborate on this one a bit more..?
> > > > 
> > > 
> > > The idea is to allow running as a user without access to
> > > /dev/vhost-scsi.
> > > For this, allow passing in the fd of /dev/vhost-scsi through unix domain sockets.
> > > 
> > 
> > Ah, that is a pretty neat trick..   So for vhost-scsi code, this would
> > mean something along the lines of the following, yes..?
> 
> Yes but with one correction. See below.
> 
> > Thanks MST!
> 
> > diff --git a/hw/vhost-scsi.c b/hw/vhost-scsi.c
> > index 4206a75..8af8758 100644
> > --- a/hw/vhost-scsi.c
> > +++ b/hw/vhost-scsi.c
> > @@ -21,6 +21,7 @@ struct VHostSCSI {
> >      const char *id;
> >      const char *wwpn;
> >      uint16_t tpgt;
> > +    int vhostfd;
> >      struct vhost_dev dev;
> >      struct vhost_virtqueue vqs[VHOST_SCSI_VQ_NUM];
> >      QLIST_ENTRY(VHostSCSI) list;
> > @@ -114,13 +115,32 @@ void vhost_scsi_stop(VHostSCSI *vs, VirtIODevice *vdev)
> >  }
> >  
> >  static VHostSCSI *vhost_scsi_add(const char *id, const char *wwpn,
> > -                                 uint16_t tpgt)
> > +                                 uint16_t tpgt, const char *vhostfd_str)
> >  {
> > -    VHostSCSI *vs = g_malloc0(sizeof(*vs));
> > +    VHostSCSI *vs;
> >      int ret;
> >  
> > +    vs = g_malloc0(sizeof(*vs));
> > +    if (!vs) {
> > +        error_report("vhost-scsi: unable to allocate *vs\n");
> > +        return NULL;
> > +    }
> > +    vs->vhostfd = -1;
> > +
> > +    if (vhostfd_str) {
> > +        if (!qemu_isdigit(vhostfd_str[0])) {
> > +            error_report("vhost-scsi: passed vhostfd value is not a digit\n");
> > +            return NULL;
> 
> This let you use an fd which was open at exec
> but does not allow for fd to be open later in
> case device is hot-plugged.
> 
> See net_handle_fd_param - I think you can just rename it
> qemu_handle_fd_param to avoid code duplication.
> 

OK, so monitor_get_fd() will set this up for the case where the device
is hot-plugged.  That makes alot more sense now..

So renaming net_handle_fd_param -> qemu_handle_fd_param + moving into
cutils.c, and will include as a leading patch for RFC-v3.

Thanks MST!

--nab
