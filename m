From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 04/16] virtio-pci: move freeze/restore to virtio core
Date: Mon, 6 Oct 2014 12:54:35 +0200
Message-ID: <20141006125435.12c69ab1.cornelia.huck@de.ibm.com>
References: <1412525038-15871-1-git-send-email-mst@redhat.com>
	<1412525038-15871-5-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1412525038-15871-5-git-send-email-mst@redhat.com>
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
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 5 Oct 2014 19:07:02 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> This is in preparation to extending config changed event handling
> in core.
> Wrapping these in an API also seems to make for a cleaner code.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/linux/virtio.h      |  6 +++++
>  drivers/virtio/virtio.c     | 53 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/virtio/virtio_pci.c | 55 ++-------------------------------------------
>  3 files changed, 61 insertions(+), 53 deletions(-)
> 
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 3c19bd3..8df7ba8 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -78,6 +78,7 @@ bool virtqueue_is_broken(struct virtqueue *vq);
>  /**
>   * virtio_device - representation of a device using virtio
>   * @index: unique position on the virtio bus
> + * @failed: saved value for CONFIG_S_FAILED bit (for restore)
>   * @dev: underlying device.
>   * @id: the device type identification (used to match it with a driver).
>   * @config: the configuration ops for this device.

The only minor gripe I have is with the naming of this field: To a
cursory reader, it might indicate the current 'failed' status of the
device. What about 'saved_failed'?

Otherwise, moving this into common virtio code makes sense.

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
