From: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH] virtio: Honour 'may_reduce_num' in vring_create_virtqueue
Date: Mon, 8 Apr 2019 15:32:38 +0200
Message-ID: <20190408133238.2ahk6u3k7mv7nd5g__45026.3469874457$1554730375$gmane$org@jenstp.localdomain>
References: <20190408123322.24086-1-cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190408123322.24086-1-cohuck@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 08, 2019 at 02:33:22PM +0200, Cornelia Huck wrote:
>vring_create_virtqueue() allows the caller to specify via the
>may_reduce_num parameter whether the vring code is allowed to
>allocate a smaller ring than specified.
>
>However, the split ring allocation code tries to allocate a
>smaller ring on allocation failure regardless of what the
>caller specified. This may cause trouble for e.g. virtio-pci
>in legacy mode, which does not support ring resizing. (The
>packed ring code does not resize in any case.)
>
>Let's fix this by bailing out immediately in the split ring code
>if the requested size cannot be allocated and may_reduce_num has
>not been specified.
>
>While at it, fix a typo in the usage instructions.
>
>Fixes: 2a2d1382fe9d ("virtio: Add improved queue allocation API")
>Cc: stable@vger.kernel.org # v4.6+
>Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>---
> drivers/virtio/virtio_ring.c | 2 ++
> include/linux/virtio_ring.h  | 2 +-
> 2 files changed, 3 insertions(+), 1 deletion(-)
>

Reviewed-by: Jens Freimann <jfreimann@redhat.com>
