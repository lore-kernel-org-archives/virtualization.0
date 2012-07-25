From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC 7/9] virtio-scsi: Start/stop vhost
Date: Wed, 25 Jul 2012 09:01:08 +0200
Message-ID: <500F99B4.4050209__15305.1399662674$1343199683$gmane$org@redhat.com>
References: <1343169246-17636-1-git-send-email-nab@linux-iscsi.org>
	<1343169246-17636-8-git-send-email-nab@linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1343169246-17636-8-git-send-email-nab@linux-iscsi.org>
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
Cc: Jens Axboe <axboe@kernel.dk>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, lf-virt <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

Il 25/07/2012 00:34, Nicholas A. Bellinger ha scritto:
> From: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
> 
> This patch starts and stops vhost as the virtio device transitions
> through its status phases.  Vhost can only be started once the guest
> reports its driver has successfully initialized, which means the
> virtqueues have been set up by the guest.
> 
> (v2: Squash virtio-scsi: use the vhost-scsi host device from stefan)
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
> Signed-off-by: Zhi Yong Wu <wuzhy@linux.vnet.ibm.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>

Hmm, this is not what the patch does... :)

Paolo
