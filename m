From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [virtio-dev] [PATCH 2/2] drm/virtio: add iommu support.
Date: Wed, 19 Sep 2018 13:38:07 +0200
Message-ID: <20180919113807.6mwqxkdg6f55h6fg__23824.8229296461$1537356983$gmane$org@sirius.home.kraxel.org>
References: <20180829122026.27012-1-kraxel@redhat.com>
	<20180829122026.27012-3-kraxel@redhat.com>
	<CAPM=9tyXc41DAkgjCRojrqH28qkirxgrpgNmrwu4WAeLpg7tAw@mail.gmail.com>
	<9bf20fa1-3752-edd1-588c-e38cd166c3af@amd.com>
	<20180912072541.nagfrr2dgy34szcx@sirius.home.kraxel.org>
	<5684a3fc-3605-7bb0-b0be-418c2ae702b5@amd.com>
	<20180919044600.utvnu5l6fvvi2qi4@sirius.home.kraxel.org>
	<d4c25272-9df8-33d6-d310-964b17a8c80d@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d4c25272-9df8-33d6-d310-964b17a8c80d@amd.com>
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

> >> Once display manger is kicked off for example (sudo systemctl start lightdm.service) and
> >> resource id 3 gets created from user space down, it still gives a blank black screen.
> > 
> > Hmm.  I'd suspect there is simply a code path missing.  Can you send the
> > patch you have?
> > 
> > cheers,
> >   Gerd
> > 
> 
> I sent the patch.  For now it does dma_sync_sg on the pages in 
> TRANSFER_TO_HOST_2D/3D when use_dma_api is true.
> 
> https://lore.kernel.org/lkml/20180919070931.91168-1-jiandi.an@amd.com/

Hmm, the way it is hooked up it should not miss any resource update.
So not sure why it isn't working.
Pushed the patch nevertheless as it is clearly a step into the right
direction.

cheers,
  Gerd
