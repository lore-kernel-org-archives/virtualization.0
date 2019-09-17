From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 2/8] drm/shmem: switch shmem helper to
	&drm_gem_object_funcs.mmap
Date: Tue, 17 Sep 2019 10:14:48 +0200
Message-ID: <20190917081448.zonghnqa4aoc4bmp__18313.2828258508$1568708102$gmane$org@sirius.home.kraxel.org>
References: <20190913122908.784-1-kraxel@redhat.com>
	<20190913122908.784-3-kraxel@redhat.com>
	<197fdced-cf4a-c59a-47fd-aa5dbf8e04a2@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <197fdced-cf4a-c59a-47fd-aa5dbf8e04a2@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Steven Price <steven.price@arm.com>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, David Airlie <airlied@linux.ie>, Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>, Thomas Zimmermann <tzimmermann@suse.de>, Sean Paul <sean@poorly.run>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> > -	/* VM_PFNMAP was set by drm_gem_mmap() */
> > -	vma->vm_flags &= ~VM_PFNMAP;
> > -	vma->vm_flags |= VM_MIXEDMAP;
> > +	vma->vm_flags |= (VM_MIXEDMAP|VM_DONTEXPAND);
> 
> I'm finding this a bit hard to follow - but I think here we've lost
> VM_IO and VM_DONTDUMP which used to be set by drm_gem_mmap().

Yep.  Intentional, but I think I better split that off to a separate
patch with a commit message explaining things.

> Also it looks like nothing is fiddling vma->vm_page_prot anymore.

Oops, that one was not intentional.  Will fix.

cheers,
  Gerd
