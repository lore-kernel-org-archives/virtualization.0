From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC-v2 3/6] vhost-scsi: add -vhost-scsi host device for use
	with tcm-vhost
Date: Sun, 19 Aug 2012 11:44:26 +0300
Message-ID: <20120819084426.GB26215@redhat.com>
References: <1344846917-7411-1-git-send-email-nab@linux-iscsi.org>
	<1344846917-7411-4-git-send-email-nab@linux-iscsi.org>
	<20120813085325.GH14081@redhat.com>
	<1344976274.22433.93.camel@haakon2.linux-iscsi.org>
	<20120818191243.GB17770@redhat.com>
	<1345336586.25161.373.camel@haakon2.linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1345336586.25161.373.camel@haakon2.linux-iscsi.org>
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
Cc: Anthony Liguori <aliguori@us.ibm.com>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, lf-virt <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Aug 18, 2012 at 05:36:26PM -0700, Nicholas A. Bellinger wrote:
> On Sat, 2012-08-18 at 22:12 +0300, Michael S. Tsirkin wrote:
> > On Tue, Aug 14, 2012 at 01:31:14PM -0700, Nicholas A. Bellinger wrote:
> > > On Mon, 2012-08-13 at 11:53 +0300, Michael S. Tsirkin wrote:
> > > > On Mon, Aug 13, 2012 at 08:35:14AM +0000, Nicholas A. Bellinger wrote:
> > > > > From: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
> 
> <SNIP>
> 
> > > > > +static VHostSCSI *vhost_scsi_add(const char *id, const char *wwpn,
> > > > > +                                 uint16_t tpgt)
> > > > > +{
> > > > > +    VHostSCSI *vs = g_malloc0(sizeof(*vs));
> > > > > +    int ret;
> > > > > +
> > > > > +    /* TODO set up vhost-scsi device and bind to tcm_vhost/$wwpm/tpgt_$tpgt */
> > > > > +    fprintf(stderr, "wwpn = \"%s\" tpgt = \"%u\"\n", id, tpgt);
> > > > > +
> > > > > +    ret = vhost_dev_init(&vs->dev, -1, "/dev/vhost-scsi", false);
> > > > 
> > > > This -1 is a hack. You need to support passing in fd from
> > > > the monitor, and pass it here.
> > > > 
> > > 
> > > Mmm, looking at how vhost_net_init + tap.c does this, but am not quite
> > > what fd needs to be propagated up for virtio-scsi -> vhost-scsi..
> > > 
> > > Can you please elaborate on this one a bit more..?
> > > 
> > 
> > The idea is to allow running as a user without access to
> > /dev/vhost-scsi.
> > For this, allow passing in the fd of /dev/vhost-scsi through unix domain sockets.
> > 
> 
> Ah, that is a pretty neat trick..   So for vhost-scsi code, this would
> mean something along the lines of the following, yes..?

Yes but with one correction. See below.

> Thanks MST!

> diff --git a/hw/vhost-scsi.c b/hw/vhost-scsi.c
> index 4206a75..8af8758 100644
> --- a/hw/vhost-scsi.c
> +++ b/hw/vhost-scsi.c
> @@ -21,6 +21,7 @@ struct VHostSCSI {
>      const char *id;
>      const char *wwpn;
>      uint16_t tpgt;
> +    int vhostfd;
>      struct vhost_dev dev;
>      struct vhost_virtqueue vqs[VHOST_SCSI_VQ_NUM];
>      QLIST_ENTRY(VHostSCSI) list;
> @@ -114,13 +115,32 @@ void vhost_scsi_stop(VHostSCSI *vs, VirtIODevice *vdev)
>  }
>  
>  static VHostSCSI *vhost_scsi_add(const char *id, const char *wwpn,
> -                                 uint16_t tpgt)
> +                                 uint16_t tpgt, const char *vhostfd_str)
>  {
> -    VHostSCSI *vs = g_malloc0(sizeof(*vs));
> +    VHostSCSI *vs;
>      int ret;
>  
> +    vs = g_malloc0(sizeof(*vs));
> +    if (!vs) {
> +        error_report("vhost-scsi: unable to allocate *vs\n");
> +        return NULL;
> +    }
> +    vs->vhostfd = -1;
> +
> +    if (vhostfd_str) {
> +        if (!qemu_isdigit(vhostfd_str[0])) {
> +            error_report("vhost-scsi: passed vhostfd value is not a digit\n");
> +            return NULL;

This let you use an fd which was open at exec
but does not allow for fd to be open later in
case device is hot-plugged.

See net_handle_fd_param - I think you can just rename it
qemu_handle_fd_param to avoid code duplication.

> +        }
> +
> +        vs->vhostfd = qemu_parse_fd(vhostfd_str);
> +        if (vs->vhostfd == -1) {
> +            error_report("vhost-scsi: unable to parse vs->vhostfd\n");
> +            return NULL;
> +        }
> +    }
>      /* TODO set up vhost-scsi device and bind to tcm_vhost/$wwpm/tpgt_$tpgt */
> -    ret = vhost_dev_init(&vs->dev, -1, "/dev/vhost-scsi", false);
> +    ret = vhost_dev_init(&vs->dev, vs->vhostfd, "/dev/vhost-scsi", false);
>      if (ret < 0) {
>          error_report("vhost-scsi: vhost initialization failed: %s\n",
>                  strerror(-ret));
> @@ -140,7 +160,7 @@ static VHostSCSI *vhost_scsi_add(const char *id, const char *wwpn,
>  VHostSCSI *vhost_scsi_add_opts(QemuOpts *opts)
>  {
>      const char *id;
> -    const char *wwpn;
> +    const char *wwpn, *vhostfd;
>      uint64_t tpgt;
>  
>      id = qemu_opts_id(opts);
> @@ -164,6 +184,7 @@ VHostSCSI *vhost_scsi_add_opts(QemuOpts *opts)
>          error_report("vhost-scsi: \"%s\" needs a 16-bit tpgt\n", id);
>          return NULL;
>      }
> +    vhostfd = qemu_opt_get(opts, "vhostfd");
>  
> -    return vhost_scsi_add(id, wwpn, tpgt);
> +    return vhost_scsi_add(id, wwpn, tpgt, vhostfd);
>  }
> diff --git a/qemu-config.c b/qemu-config.c
> index 33399ea..2d4884c 100644
> --- a/qemu-config.c
> +++ b/qemu-config.c
> @@ -636,6 +636,9 @@ QemuOptsList qemu_vhost_scsi_opts = {
>          }, {
>              .name = "tpgt",
>              .type = QEMU_OPT_NUMBER,
> +        }, {
> +            .name = "vhostfd",
> +            .type = QEMU_OPT_STRING,
>          },
>          { /* end of list */ }
>      },
