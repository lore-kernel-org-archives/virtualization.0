From: Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH] drm/qxl: drop prime import/export callbacks
Date: Tue, 9 Apr 2019 14:01:33 +1000
Message-ID: <CAPM=9tyEmn2LXhNmPSOi7JAgBc3QZwNtM+8FT8CWebz4GztaJA__5595.28425089724$1554782519$gmane$org@mail.gmail.com>
References: <20190110081750.11358-1-kraxel@redhat.com>
	<CAPM=9tx8N6jxVzsT-RqtQFrFb9qLK4qUUje+d=fpTYZ6+PnYpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAPM=9tx8N6jxVzsT-RqtQFrFb9qLK4qUUje+d=fpTYZ6+PnYpg@mail.gmail.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, Dave Airlie <airlied@redhat.com>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 12 Jan 2019 at 07:13, Dave Airlie <airlied@gmail.com> wrote:
>
> On Thu, 10 Jan 2019 at 18:17, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > Also set prime_handle_to_fd and prime_fd_to_handle to NULL,
> > so drm will not advertive DRM_PRIME_CAP_{IMPORT,EXPORT} to
> > userspace.

It's been pointed out to me that disables DRI3 for these devices, I'm
not sure that is the solution we actually wanted.

any ideas?
Dave.

> >
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>
> Reviewed-by: Dave Airlie <airlied@redhat.com>
> > ---
> >  drivers/gpu/drm/qxl/qxl_drv.c   |  4 ----
> >  drivers/gpu/drm/qxl/qxl_prime.c | 14 --------------
> >  2 files changed, 18 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> > index 13c8a662f9..ccb090f3ab 100644
> > --- a/drivers/gpu/drm/qxl/qxl_drv.c
> > +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> > @@ -250,14 +250,10 @@ static struct drm_driver qxl_driver = {
> >  #if defined(CONFIG_DEBUG_FS)
> >         .debugfs_init = qxl_debugfs_init,
> >  #endif
> > -       .prime_handle_to_fd = drm_gem_prime_handle_to_fd,
> > -       .prime_fd_to_handle = drm_gem_prime_fd_to_handle,
> >         .gem_prime_export = drm_gem_prime_export,
> >         .gem_prime_import = drm_gem_prime_import,
> >         .gem_prime_pin = qxl_gem_prime_pin,
> >         .gem_prime_unpin = qxl_gem_prime_unpin,
> > -       .gem_prime_get_sg_table = qxl_gem_prime_get_sg_table,
> > -       .gem_prime_import_sg_table = qxl_gem_prime_import_sg_table,
> >         .gem_prime_vmap = qxl_gem_prime_vmap,
> >         .gem_prime_vunmap = qxl_gem_prime_vunmap,
> >         .gem_prime_mmap = qxl_gem_prime_mmap,
> > diff --git a/drivers/gpu/drm/qxl/qxl_prime.c b/drivers/gpu/drm/qxl/qxl_prime.c
> > index a55dece118..df65d3c1a7 100644
> > --- a/drivers/gpu/drm/qxl/qxl_prime.c
> > +++ b/drivers/gpu/drm/qxl/qxl_prime.c
> > @@ -38,20 +38,6 @@ void qxl_gem_prime_unpin(struct drm_gem_object *obj)
> >         WARN_ONCE(1, "not implemented");
> >  }
> >
> > -struct sg_table *qxl_gem_prime_get_sg_table(struct drm_gem_object *obj)
> > -{
> > -       WARN_ONCE(1, "not implemented");
> > -       return ERR_PTR(-ENOSYS);
> > -}
> > -
> > -struct drm_gem_object *qxl_gem_prime_import_sg_table(
> > -       struct drm_device *dev, struct dma_buf_attachment *attach,
> > -       struct sg_table *table)
> > -{
> > -       WARN_ONCE(1, "not implemented");
> > -       return ERR_PTR(-ENOSYS);
> > -}
> > -
> >  void *qxl_gem_prime_vmap(struct drm_gem_object *obj)
> >  {
> >         WARN_ONCE(1, "not implemented");
> > --
> > 2.9.3
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
