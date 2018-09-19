From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [virtio-dev] [PATCH 2/2] drm/virtio: add iommu support.
Date: Wed, 19 Sep 2018 06:46:00 +0200
Message-ID: <20180919044600.utvnu5l6fvvi2qi4__29895.8065723584$1537332243$gmane$org@sirius.home.kraxel.org>
References: <20180829122026.27012-1-kraxel@redhat.com>
	<20180829122026.27012-3-kraxel@redhat.com>
	<CAPM=9tyXc41DAkgjCRojrqH28qkirxgrpgNmrwu4WAeLpg7tAw@mail.gmail.com>
	<9bf20fa1-3752-edd1-588c-e38cd166c3af@amd.com>
	<20180912072541.nagfrr2dgy34szcx@sirius.home.kraxel.org>
	<5684a3fc-3605-7bb0-b0be-418c2ae702b5@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5684a3fc-3605-7bb0-b0be-418c2ae702b5@amd.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jiandi An <jiandi@amd.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Singh,
	Brijesh" <brijesh.singh@amd.com>, "Lendacky,
	Thomas" <Thomas.Lendacky@amd.com>, Dave Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>, Dave Airlie <airlied@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> buffer.  I tried to put a dma_sync_sg_for_device() on virtio_gpu_object obj->pages-sgl
> before VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D is sent.  This fixes the kernel console path.

That should be the right place.

> Once display manger is kicked off for example (sudo systemctl start lightdm.service) and
> resource id 3 gets created from user space down, it still gives a blank black screen.

Hmm.  I'd suspect there is simply a code path missing.  Can you send the
patch you have?

cheers,
  Gerd
