From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/2] virtio-pci: check name when counting MSI-X vectors
Date: Wed, 18 Dec 2019 00:19:12 -0500
Message-ID: <20191218001901-mutt-send-email-mst@kernel.org>
References: <20191217190610.248061-1-dverkamp@chromium.org>
 <20191217190610.248061-2-dverkamp@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191217190610.248061-2-dverkamp@chromium.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Daniel Verkamp <dverkamp@chromium.org>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 17, 2019 at 11:06:10AM -0800, Daniel Verkamp wrote:
> VQs without a name specified are not valid; they are skipped in the
> later loop that assigns MSI-X vectors to queues, but the per_vq_vectors
> loop above that counts the required number of vectors previously still
> counted any queue with a non-NULL callback as needing a vector.
> 
> Add a check to the per_vq_vectors loop so that vectors with no name are
> not counted to make the two loops consistent.  This prevents
> over-counting unnecessary vectors (e.g. for features which were not
> negotiated with the device).
> 
> Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>

OK so I will add
Fixes: 86a559787e6f ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")

here too?

> ---
>  drivers/virtio/virtio_pci_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index f2862f66c2ac..222d630c41fc 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -294,7 +294,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
>  		/* Best option: one for change interrupt, one per vq. */
>  		nvectors = 1;
>  		for (i = 0; i < nvqs; ++i)
> -			if (callbacks[i])
> +			if (names[i] && callbacks[i])
>  				++nvectors;
>  	} else {
>  		/* Second best: one for change, shared for all vqs. */
> -- 
> 2.24.1.735.g03f4e72817-goog
