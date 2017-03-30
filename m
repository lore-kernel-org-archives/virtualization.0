From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 1/6] virtio: wrap find_vqs
Date: Thu, 30 Mar 2017 09:18:41 +0200
Message-ID: <20170330091841.2797eca4.cornelia.huck__7404.52378890968$1490858342$gmane$org@de.ibm.com>
References: <1490820507-8005-1-git-send-email-mst@redhat.com>
	<1490820507-8005-2-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1490820507-8005-2-git-send-email-mst@redhat.com>
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
Cc: Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>, "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, Herbert Xu <herbert@gondor.apana.org.au>, kvm@vger.kernel.org, Amit Shah <amit@kernel.org>, David Airlie <airlied@linux.ie>, John Fastabend <john.fastabend@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Bjorn Andersson <bjorn.andersson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Martin
	K. Petersen" <martin.petersen@oracle.com>, Arnd Bergmann <arnd@arndb.de>, linux-crypto@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 29 Mar 2017 23:48:44 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> We are going to add more parameters to find_vqs, let's wrap the call so
> we don't need to tweak all drivers every time.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/block/virtio_blk.c                 | 3 +--
>  drivers/char/virtio_console.c              | 6 +++---
>  drivers/crypto/virtio/virtio_crypto_core.c | 3 +--
>  drivers/gpu/drm/virtio/virtgpu_kms.c       | 3 +--
>  drivers/net/caif/caif_virtio.c             | 3 +--
>  drivers/net/virtio_net.c                   | 3 +--
>  drivers/rpmsg/virtio_rpmsg_bus.c           | 2 +-
>  drivers/scsi/virtio_scsi.c                 | 3 +--
>  drivers/virtio/virtio_balloon.c            | 3 +--
>  drivers/virtio/virtio_input.c              | 3 +--
>  include/linux/virtio_config.h              | 9 +++++++++
>  net/vmw_vsock/virtio_transport.c           | 6 +++---
>  12 files changed, 24 insertions(+), 23 deletions(-)

Regardless whether that context thing is the right thing to do, this
looks like a sensible cleanup.
