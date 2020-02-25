From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 1/2] virtio: add dma-buf support for exported objects
Date: Tue, 25 Feb 2020 07:10:08 +0100
Message-ID: <20200225061008.wqxqppfglzmwvtid@sirius.home.kraxel.org>
References: <20200219080637.61312-1-stevensd@chromium.org>
 <20200219080637.61312-2-stevensd@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtio-dev-return-6772-gcvd-virtio-dev=m.gmane-mx.org@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Content-Disposition: inline
In-Reply-To: <20200219080637.61312-2-stevensd@chromium.org>
To: David Stevens <stevensd@chromium.org>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, virtio-dev@lists.oasis-open.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 19, 2020 at 05:06:36PM +0900, David Stevens wrote:
> This change adds a new flavor of dma-bufs that can be used by virtio
> drivers to share exported objects. A virtio dma-buf can be queried by
> virtio drivers to obtain the UUID which identifies the underlying
> exported object.

That duplicates a bunch of code from dma-buf.c in virtio_dma_buf.c.

How about dma_buf_{get,set}_uuid, simliar to dma_buf_set_name?

cheers,
  Gerd
