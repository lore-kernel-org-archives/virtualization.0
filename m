From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 4/5] virtio-scsi: Add start/stop functionality for
	vhost-scsi
Date: Fri, 07 Sep 2012 18:00:50 +0200
Message-ID: <504A1A32.5050705@redhat.com>
References: <1347000499-28701-1-git-send-email-nab@linux-iscsi.org>
	<1347000499-28701-5-git-send-email-nab@linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1347000499-28701-5-git-send-email-nab@linux-iscsi.org>
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
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, lf-virt <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

Il 07/09/2012 08:48, Nicholas A. Bellinger ha scritto:
> Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
> Cc: Zhi Yong Wu <wuzhy@linux.vnet.ibm.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
> ---
>  hw/virtio-pci.c  |    2 ++
>  hw/virtio-scsi.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/virtio-scsi.h |    1 +
>  3 files changed, 52 insertions(+), 0 deletions(-)

Please create a completely separate device vhost-scsi-pci instead (or
virtio-scsi-tcm-pci, or something like that).  It is used completely
differently from virtio-scsi-pci, it does not make sense to conflate the
two.

Paolo
