From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/5] vhost-scsi: Add support for host virtualized target
Date: Mon, 28 Jan 2013 14:29:23 +0100
Message-ID: <51067D33.5080609@redhat.com>
References: <1347000499-28701-1-git-send-email-nab@linux-iscsi.org>
	<20130117164314.GA19458@redhat.com>
	<1358456841.18551.48.camel@haakon2.linux-iscsi.org>
	<20130121085034.GA31047@redhat.com> <510676B5.4070209@redhat.com>
	<20130128131133.GA15108@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130128131133.GA15108@redhat.com>
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
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, lf-virt <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

Il 28/01/2013 14:11, Michael S. Tsirkin ha scritto:
> > I asked for a standalone device because the configuration mechanism
> > (configfs vs. command-line) and the feature set are completely
> > different.  Unlike virtio-net, it's not possible to switch one to the
> > other at run time.
> 
> Exactly the same applies to any other frontend option.
> For example if you have two qemu instances with
> different num_queues values you can not migrate one
> to the other.
> So in this sense it is not different from any other
> frontend option, right?

Indeed, in this sense it is not.

Actually in this case migrating one to the other could succeed, and make
all disks disappear on the destination (because of the different
configuration mechanism).  That however could be overcome with vhost=on
registering a migration blocker.

I won't really block the patch with the vhost=on/off frontend option if
it is properly done (e.g. the QEMU SCSI bus should not be created for
vhost=on) and minimally invasive to the non-vhost code.

Paolo
