From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC-v2 3/6] vhost-scsi: add -vhost-scsi host device for use
	with tcm-vhost
Date: Sat, 18 Aug 2012 22:12:43 +0300
Message-ID: <20120818191243.GB17770@redhat.com>
References: <1344846917-7411-1-git-send-email-nab@linux-iscsi.org>
	<1344846917-7411-4-git-send-email-nab@linux-iscsi.org>
	<20120813085325.GH14081@redhat.com>
	<1344976274.22433.93.camel@haakon2.linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1344976274.22433.93.camel@haakon2.linux-iscsi.org>
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

On Tue, Aug 14, 2012 at 01:31:14PM -0700, Nicholas A. Bellinger wrote:
> On Mon, 2012-08-13 at 11:53 +0300, Michael S. Tsirkin wrote:
> > On Mon, Aug 13, 2012 at 08:35:14AM +0000, Nicholas A. Bellinger wrote:
> > > From: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
> > > 
> > > This patch adds a new type of host device that drives the vhost_scsi
> > > device.  The syntax to add vhost-scsi is:
> > > 
> > >   qemu -vhost-scsi id=vhost-scsi0,wwpn=...,tpgt=123
> > > 
> > > The virtio-scsi emulated device will make use of vhost-scsi to process
> > > virtio-scsi requests inside the kernel and hand them to the in-kernel
> > > SCSI target stack using the tcm_vhost fabric driver.
> 
> <SNIP>
> 
> > > +static VHostSCSI *vhost_scsi_add(const char *id, const char *wwpn,
> > > +                                 uint16_t tpgt)
> > > +{
> > > +    VHostSCSI *vs = g_malloc0(sizeof(*vs));
> > > +    int ret;
> > > +
> > > +    /* TODO set up vhost-scsi device and bind to tcm_vhost/$wwpm/tpgt_$tpgt */
> > > +    fprintf(stderr, "wwpn = \"%s\" tpgt = \"%u\"\n", id, tpgt);
> > > +
> > > +    ret = vhost_dev_init(&vs->dev, -1, "/dev/vhost-scsi", false);
> > 
> > This -1 is a hack. You need to support passing in fd from
> > the monitor, and pass it here.
> > 
> 
> Mmm, looking at how vhost_net_init + tap.c does this, but am not quite
> what fd needs to be propagated up for virtio-scsi -> vhost-scsi..
> 
> Can you please elaborate on this one a bit more..?
> 
> --nab
> 


The idea is to allow running as a user without access to
/dev/vhost-scsi.
For this, allow passing in the fd of /dev/vhost-scsi through unix domain sockets.

-- 
MST
