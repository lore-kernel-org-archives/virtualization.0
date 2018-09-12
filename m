From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [virtio-dev] [PATCH 2/2] drm/virtio: add iommu support.
Date: Wed, 12 Sep 2018 09:25:41 +0200
Message-ID: <20180912072541.nagfrr2dgy34szcx__46740.8311706551$1536737022$gmane$org@sirius.home.kraxel.org>
References: <20180829122026.27012-1-kraxel@redhat.com>
	<20180829122026.27012-3-kraxel@redhat.com>
	<CAPM=9tyXc41DAkgjCRojrqH28qkirxgrpgNmrwu4WAeLpg7tAw@mail.gmail.com>
	<9bf20fa1-3752-edd1-588c-e38cd166c3af@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <9bf20fa1-3752-edd1-588c-e38cd166c3af@amd.com>
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
Cc: virtio-dev@lists.oasis-open.org, Dave Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>, Dave Airlie <airlied@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> I attempted to fix it in the ttm layer and here is the discussion
> https://lore.kernel.org/lkml/b44280d7-eb13-0996-71f5-3fbdeb466801@amd.com/
> 
> The ttm maintainer Christian is suggesting to map and set ttm->pages as decrypted
> right after ttm->pages are allocated.
> 
> Just checking with you guys maybe there is a better way to handle this in
> the virtio gpu layer instead of the common ttm layer.  Could you guys shine some
> light on this?  Thanks.

I think the tty layer is the right place to fix this.  virtio just calls
down to ttm for mappings.  I think virtio should just hint to ttm using
a flag in some struct, probably ttm_buffer_object or
ttm_mem_type_manager, that the objects need decrypted mappings.

cheers,
  Gerd
