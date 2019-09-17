From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 8/8] drm/vram: drop DRM_VRAM_MM_FILE_OPERATIONS
Date: Tue, 17 Sep 2019 10:39:02 +0200
Message-ID: <20190917083902.fn32iznnjm3zhudl__17300.2124227182$1568709555$gmane$org@sirius.home.kraxel.org>
References: <20190913122908.784-1-kraxel@redhat.com>
	<20190913122908.784-9-kraxel@redhat.com>
	<e9712055-c6db-5515-0c11-4d7add138856@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <e9712055-c6db-5515-0c11-4d7add138856@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Hans de Goede <hdegoede@redhat.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, Xinliang Liu <z.liuxinliang@hisilicon.com>, David Airlie <airlied@linux.ie>, Xinwei Kong <kong.kongxinwei@hisilicon.com>, Chen Feng <puck.chen@hisilicon.com>, Rongrong Zou <zourongrong@gmail.com>, Dave Airlie <airlied@redhat.com>, Sean Paul <sean@poorly.run>
List-Id: virtualization@lists.linuxfoundation.org

> >  include/drm/drm_vram_mm_helper.h              | 82 +++++++++++++++++++

> > diff --git a/include/drm/drm_vram_mm_helper.h b/include/drm/drm_vram_mm_helper.h
> > new file mode 100644
> 
> Please rebase onto the latest drm-tip. This entire file has been removed
> in a recent patch.

I did rebase already, then re-added the file by mistake.  Didn't pay
enough attention while solving the conflict.  Fixed now.

cheers,
  Gerd
