From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH-v2 0/3] virtio/vhost: Add checks for uninitialized VQs
Date: Tue, 2 Apr 2013 15:01:45 +0300
Message-ID: <20130402120145.GB21545__10316.8429145173$1364904193$gmane$org@redhat.com>
References: <1364860704-11896-1-git-send-email-nab@linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1364860704-11896-1-git-send-email-nab@linux-iscsi.org>
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
Cc: kvm-devel <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, lf-virt <virtualization@lists.linux-foundation.org>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 01, 2013 at 11:58:21PM +0000, Nicholas A. Bellinger wrote:
> From: Nicholas Bellinger <nab@linux-iscsi.org>
> 
> Hi folks,
> 
> This series adds a virtio_queue_valid() for use by virtio-pci code in
> order to prevent opreations upon uninitialized VQs, which is currently
> expected to occur during seabios setup of virtio-scsi with in-flight
> vhost-scsi-pci device code.
> 
> On the vhost side, it also adds virtio_queue_valid() sanity checks in
> vhost_virtqueue_[start,stop]() and vhost_verify_ring_mappings() in order
> to skip the same uninitialized VQs.
> 
> Changes from v1:
>   - Remove now unnecessary virtio_queue_get_num() calls in virtio-pci.c
>   - Add virtio_queue_valid() calls in vhost_virtqueue_[start,stop]()
> 
> Please review.
> 
> --nab

Looks reasonable.
Acked-by: Michael S. Tsirkin <mst@redhat.com>

So - does this fix the issues you saw with vhost-scsi?

> Michael S. Tsirkin (1):
>   virtio: add API to check that ring is setup
> 
> Nicholas Bellinger (2):
>   virtio-pci: Add virtio_queue_valid checks ahead of
>     virtio_queue_get_num
>   vhost: Skip uninitialized VQs in vhost_virtqueue_[start,stop]
> 
>  hw/vhost.c      |   12 ++++++++++++
>  hw/virtio-pci.c |   34 +++++++++++++++-------------------
>  hw/virtio.c     |    5 +++++
>  hw/virtio.h     |    1 +
>  4 files changed, 33 insertions(+), 19 deletions(-)
> 
> -- 
> 1.7.2.5
