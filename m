From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [RFC PATCH] drm/virtio: Export resource handles via DMA-buf API
Date: Thu, 12 Sep 2019 14:38:21 +0200
Message-ID: <20190912123821.rraib5entkcxt5p5__12322.3382326373$1568291913$gmane$org@sirius.home.kraxel.org>
References: <20190912094121.228435-1-tfiga@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190912094121.228435-1-tfiga@chromium.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tomasz Figa <tfiga@chromium.org>
Cc: zachr@chromium.org, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, keiichiw@chromium.org, stevensd@chromium.org, Daniel Vetter <daniel@ffwll.ch>, marcheu@chromium.org, posciak@chromium.org
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> To seamlessly enable buffer sharing with drivers using such frameworks,
> make the virtio-gpu driver expose the resource handle as the DMA address
> of the buffer returned from the DMA-buf mapping operation.  Arguably, the
> resource handle is a kind of DMA address already, as it is the buffer
> identifier that the device needs to access the backing memory, which is
> exactly the same role a DMA address provides for native devices.

No.  A scatter list has guest dma addresses, period.  Stuffing something
else into a scatterlist is asking for trouble, things will go seriously
wrong when someone tries to use such a fake scatterlist as real scatterlist.

Also note that "the DMA address of the buffer" is bonkers in virtio-gpu
context.  virtio-gpu resources are not required to be physically
contigous in memory, so typically you actually need a scatter list to
describe them.

cheers,
  Gerd
