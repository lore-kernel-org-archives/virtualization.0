From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [RFC-v3 0/5] vhost-scsi: Add support for host virtualized target
Date: Thu, 06 Sep 2012 23:56:59 -0700
Message-ID: <1347001019.4162.614.camel__11706.2257173986$1347001035$gmane$org@haakon2.linux-iscsi.org>
References: <1345582331-22593-1-git-send-email-nab@linux-iscsi.org>
	<20120907062322.GB9232@redhat.com> <20120907063237.GA13651@redhat.com>
	<20120907063757.GA16041@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120907063757.GA16041@redhat.com>
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
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, lf-virt <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2012-09-07 at 09:37 +0300, Michael S. Tsirkin wrote:
> On Fri, Sep 07, 2012 at 09:32:37AM +0300, Michael S. Tsirkin wrote:
> > On Fri, Sep 07, 2012 at 09:23:22AM +0300, Michael S. Tsirkin wrote:
> > > On Tue, Aug 21, 2012 at 08:52:06PM +0000, Nicholas A. Bellinger wrote:
> > > > From: Nicholas Bellinger <nab@linux-iscsi.org>
> > > > 
> > > > Hi folks,
> > > > 
> > > > This is the third RFC for vhost-scsi patches against mainline QEMU v1.1
> > > 
> > > I rebased on top of 1.2 and put this in my tree:
> > > git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git pci
> > > 
> > > Please check it out, meanwhile we'll see if anyone complains.
> > 
> > OK I will be the first :).
> > Looks like build *without* CONFIG_VHOST_SCSI
> > is broken now:
> >  LINK  sparc64-softmmu/qemu-system-sparc64
> > ../hw/qdev-properties.o: In function `parse_vhost_scsi_dev':
> > /scm/qemu/hw/qdev-properties.c:706: undefined reference to
> > `find_vhost_scsi'
> > ../hw/qdev-properties.o: In function `print_vhost_scsi_dev':
> > /scm/qemu/hw/qdev-properties.c:719: undefined reference to
> > `vhost_scsi_get_id'
> > ../libhw64/vl.o: In function `vhost_scsi_init_func':
> > /scm/qemu/vl.c:1943: undefined reference to `vhost_scsi_add_opts'
> > hw/virtio-scsi.o: In function `virtio_scsi_set_status':
> > /scm/qemu/hw/virtio-scsi.c:733: undefined reference to `vhost_scsi_stop'
> > /scm/qemu/hw/virtio-scsi.c:724: undefined reference to
> > `vhost_scsi_start'
> > 
> > Please add stubs *and test* without CONFIG_VHOST_SCSI.
> > 
> > While at it can we please rename file to vhost_scsi.c, vhost_scsi.h?
> > qemu is inconsistent but vhost files all use _ as separator:
> > this means function names and file names are in sync.
> > 
> > Reverted for now, waiting for v4.
> 
> Please note vhost, net and monitor changes are all merged.
> That's patches 1/5 and 2/5.

Hi MST!

Looks like we just cross emails here within 10 mins here..

I'm happy to respin a PATCH and/or GIT PULL request minus 1-2 depending
on the vhost-scsi workflow that ALiguori is comfortable with here.

Thank you!

--nab
