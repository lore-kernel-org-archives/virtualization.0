From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH-v2 1/2] virtio-scsi: create VirtIOSCSICommon
Date: Tue, 09 Apr 2013 09:14:43 +0200
Message-ID: <5163BFE3.3010507@redhat.com>
References: <1364519296-31883-1-git-send-email-nab@linux-iscsi.org>
	<1364519296-31883-2-git-send-email-nab@linux-iscsi.org>
	<87bo9oheex.fsf@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87bo9oheex.fsf@codemonkey.ws>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, lf-virt <virtualization@lists.linux-foundation.org>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Il 08/04/2013 23:59, Anthony Liguori ha scritto:
> > This patch refactors existing virtio-scsi code into VirtIOSCSICommon
> > in order to allow virtio_scsi_init_common() to be used by both internal
> > virtio_scsi_init() and external vhost-scsi-pci code.
> >
> > Changes in Patch-v2:
> >    - Move ->get_features() assignment to virtio_scsi_init() instead of
> >      virtio_scsi_init_common()
> 
> Any reason we're not doing this as a QOM base class?
> 
> Similiar to how the in-kernel PIT/PIC work using a common base class...

Because when the patch was written virtio-scsi was not a QOM class.

Paolo
