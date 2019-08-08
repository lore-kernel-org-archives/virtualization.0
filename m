From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 07/17] drm/shmem: drop DEFINE_DRM_GEM_SHMEM_FOPS
Date: Thu, 8 Aug 2019 16:51:37 -0600
Message-ID: <CAL_Jsq+rqigmySoJg0iknkEJ5hzWeD3w2iSTpWoqoD67fGV3cw__24478.0582886719$1565304717$gmane$org@mail.gmail.com>
References: <20190808134417.10610-1-kraxel@redhat.com>
	<20190808134417.10610-8-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190808134417.10610-8-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, Thomas Zimmermann <tzimmermann@suse.de>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, David Airlie <airlied@linux.ie>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, open list <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" <virtualization@lists.linux-foundation.org>, Eric Anholt <eric@anholt.net>, Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>, Sean Paul <sean@poorly.run>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 8, 2019 at 7:44 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> DEFINE_DRM_GEM_SHMEM_FOPS is identical to DEFINE_DRM_GEM_FOPS now,
> drop it.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/drm/drm_gem_shmem_helper.h      | 26 -------------------------
>  drivers/gpu/drm/cirrus/cirrus.c         |  2 +-
>  drivers/gpu/drm/panfrost/panfrost_drv.c |  2 +-
>  drivers/gpu/drm/v3d/v3d_drv.c           |  2 +-
>  4 files changed, 3 insertions(+), 29 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
