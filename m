From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [RFC qemu 2/4] virtio-balloon: Add a new feature to balloon device
Date: Thu, 3 Mar 2016 13:23:34 +0100
Message-ID: <20160303132334.5e4565df.cornelia.huck__10888.1757398651$1457007842$gmane$org@de.ibm.com>
References: <1457001868-15949-1-git-send-email-liang.z.li@intel.com>
	<1457001868-15949-3-git-send-email-liang.z.li@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1457001868-15949-3-git-send-email-liang.z.li@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Liang Li <liang.z.li@intel.com>
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, linux-mm@kvack.org, amit.shah@redhat.com, pbonzini@redhat.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, dgilbert@redhat.com, rth@twiddle.net
List-Id: virtualization@lists.linuxfoundation.org

On Thu,  3 Mar 2016 18:44:26 +0800
Liang Li <liang.z.li@intel.com> wrote:

> Extend the virtio balloon device to support a new feature, this
> new feature can help to get guest's free pages information, which
> can be used for live migration optimzation.

Do you have a spec for this, e.g. as a patch to the virtio spec?

> 
> Signed-off-by: Liang Li <liang.z.li@intel.com>
> ---
>  balloon.c                                       | 30 ++++++++-
>  hw/virtio/virtio-balloon.c                      | 81 ++++++++++++++++++++++++-
>  include/hw/virtio/virtio-balloon.h              | 17 +++++-
>  include/standard-headers/linux/virtio_balloon.h |  1 +
>  include/sysemu/balloon.h                        | 10 ++-
>  5 files changed, 134 insertions(+), 5 deletions(-)

> +static int virtio_balloon_free_pages(void *opaque,
> +                                     unsigned long *free_pages_bitmap,
> +                                     unsigned long *free_pages_count)
> +{
> +    VirtIOBalloon *s = opaque;
> +    VirtIODevice *vdev = VIRTIO_DEVICE(s);
> +    VirtQueueElement *elem = s->free_pages_vq_elem;
> +    int len;
> +
> +    if (!balloon_free_pages_supported(s)) {
> +        return -1;
> +    }
> +
> +    if (s->req_status == NOT_STARTED) {
> +        s->free_pages_bitmap = free_pages_bitmap;
> +        s->req_status = STARTED;
> +        s->mem_layout.low_mem = pc_get_lowmem(PC_MACHINE(current_machine));

Please don't leak pc-specific information into generic code.
