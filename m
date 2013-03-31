From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/3] virtio/vhost: Add checks for uninitialized VQs
Date: Sun, 31 Mar 2013 10:46:00 +0300
Message-ID: <20130331074559.GD23484__31256.8878675394$1364715952$gmane$org@redhat.com>
References: <1364531592-8368-1-git-send-email-nab@linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1364531592-8368-1-git-send-email-nab@linux-iscsi.org>
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

On Fri, Mar 29, 2013 at 04:33:09AM +0000, Nicholas A. Bellinger wrote:
> From: Nicholas Bellinger <nab@linux-iscsi.org>
> 
> Hi folks,
> 
> This series adds a virtio_queue_valid() for use by virtio-pci code in
> order to prevent opreations upon uninitialized VQs, that is currently
> expected to occur during seabios setup of virtio-scsi.
> 
> This also includes a vhost specific check for uninitialized VQs in
> vhost_verify_ring_mappings() to avoid this same case.
> 
> Please review.
> 
> --nab

Okay, and does this fix the failures in vhost_verify_ring_mappings
that you've observed?

> Michael S. Tsirkin (1):
>   virtio: add API to check that ring is setup
> 
> Nicholas Bellinger (2):
>   virtio-pci: Add virtio_queue_valid checks ahead of
>     virtio_queue_get_num
>   vhost: Check+skip uninitialized VQs in vhost_verify_ring_mappings
> 
>  hw/vhost.c      |    3 +++
>  hw/virtio-pci.c |   27 +++++++++++++++++++++++++++
>  hw/virtio.c     |    5 +++++
>  hw/virtio.h     |    1 +
>  4 files changed, 36 insertions(+), 0 deletions(-)
> 
> -- 
> 1.7.2.5
