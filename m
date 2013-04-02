From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [Qemu-devel] [PATCH 0/5] vhost-scsi: Add support for host
	virtualized target
Date: Mon, 01 Apr 2013 22:07:07 -0700
Message-ID: <1364879227.3898.64.camel__2433.08016001738$1364879274$gmane$org@haakon2.linux-iscsi.org>
References: <1347000499-28701-1-git-send-email-nab@linux-iscsi.org>
	<515A5046.7020704@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <515A5046.7020704@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wenchao Xia <xiawenc@linux.vnet.ibm.com>
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, "Michael S.
	Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, lf-virt <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

Hello Wenchao,

On Tue, 2013-04-02 at 11:28 +0800, Wenchao Xia wrote:
> Hi, Nicholas
>   Have this serial been merged to qemu 1.4?

Not just yet.  Asias, MST, Paolo and myself have been working recently
on the series for qemu 1.4.

>  If not, I am rebasing it to
> upstream, hope no one else is working on that.
> 

The latest PATCH-v2 for vhost-scsi-pci against upstream qemu commit
dcadaa9b (from March 25th) is here:

http://www.spinics.net/lists/target-devel/msg04263.html

Note that you'll need this small work-around patch to avoid a bug that
we're currently tracking down:

http://www.spinics.net/lists/target-devel/msg04122.html

Also, you'll need a recent SeaBios build with the following commits:

commit 5a7730db57ab0715223421e65b54fb50d6fefe5c
Author: Asias He <asias@redhat.com>
Date:   Fri Mar 15 09:45:15 2013 +0800

    virtio-scsi: Set _DRIVER_OK flag before scsi target scanning

commit b44a7be17bdd270ea029a8e2ec0c2e80c6cd0444
Author: Asias He <asias@redhat.com>
Date:   Fri Mar 15 09:45:16 2013 +0800

    virtio-scsi: Pack struct virtio_scsi_{req_cmd,resp_cmd}

I'll be rebasing to qemu HEAD over the next few days and posting a
PATCH-v3, and would be happy to include you in the CC to follow along.

Thanks!

--nab


> > From: Nicholas Bellinger <nab@linux-iscsi.org>
> > 
> > Hello Anthony & Co,
> > 
> > This is the fourth installment to add host virtualized target support for
> > the mainline tcm_vhost fabric driver using Linux v3.6-rc into QEMU 1.3.0-rc.
> > 
> > The series is available directly from the following git branch:
> > 
> >     git://git.kernel.org/pub/scm/virt/kvm/nab/qemu-kvm.git vhost-scsi-for-1.3
> > 
> > Note the code is cut against yesterday's QEMU head, and dispite the name
> > of the tree is based upon mainline qemu.org git code + has thus far been
> > running overnight with > 100K IOPs small block 4k workloads using v3.6-rc2+
> > based target code with RAMDISK_DR backstores.
> > 
> > Other than some minor fuzz between jumping from QEMU 1.2.0 -> 1.2.50, this
> > series is functionally identical to what's been posted for vhost-scsi RFC-v3
> > to qemu-devel.
> > 
> > Please consider applying these patches for an initial vhost-scsi merge into
> > QEMU 1.3.0-rc code, or let us know what else you'd like to see addressed for
> > this series to in order to merge.
> > 
> > Thank you!
> > 
> > --nab
> > 
> > Nicholas Bellinger (2):
> >    monitor: Rename+move net_handle_fd_param -> monitor_handle_fd_param
> >    virtio-scsi: Set max_target=0 during vhost-scsi operation
> > 
> > Stefan Hajnoczi (3):
> >    vhost: Pass device path to vhost_dev_init()
> >    vhost-scsi: add -vhost-scsi host device for use with tcm-vhost
> >    virtio-scsi: Add start/stop functionality for vhost-scsi
> > 
> >   configure            |   10 +++
> >   hw/Makefile.objs     |    1 +
> >   hw/qdev-properties.c |   41 +++++++++++
> >   hw/vhost-scsi.c      |  190 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >   hw/vhost-scsi.h      |   62 ++++++++++++++++
> >   hw/vhost.c           |    5 +-
> >   hw/vhost.h           |    3 +-
> >   hw/vhost_net.c       |    2 +-
> >   hw/virtio-pci.c      |    2 +
> >   hw/virtio-scsi.c     |   55 ++++++++++++++-
> >   hw/virtio-scsi.h     |    1 +
> >   monitor.c            |   18 +++++
> >   monitor.h            |    1 +
> >   net.c                |   18 -----
> >   net.h                |    2 -
> >   net/socket.c         |    2 +-
> >   net/tap.c            |    4 +-
> >   qemu-common.h        |    1 +
> >   qemu-config.c        |   19 +++++
> >   qemu-options.hx      |    4 +
> >   vl.c                 |   18 +++++
> >   21 files changed, 431 insertions(+), 28 deletions(-)
> >   create mode 100644 hw/vhost-scsi.c
> >   create mode 100644 hw/vhost-scsi.h
> > 
> 
> 
