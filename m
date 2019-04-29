From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] Revert "drm/qxl: drop prime import/export callbacks"
Date: Mon, 29 Apr 2019 09:40:47 +0200
Message-ID: <20190429074047.GJ3271__12338.8767520495$1556523770$gmane$org@phenom.ffwll.local>
References: <20190426053324.26443-1-kraxel@redhat.com>
	<CAKMK7uG+vMU0hqqiKAswu=LqpkcXtLPqbYLRWgoAPpsQQV4qzA@mail.gmail.com>
	<8ae152fe-7811-4de3-e26f-350650a8f992@shipmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <8ae152fe-7811-4de3-e26f-350650a8f992@shipmail.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Hellstrom <thomas@shipmail.org>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@redhat.com>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 26, 2019 at 05:42:23PM +0200, Thomas Hellstrom wrote:
> On 4/26/19 4:21 PM, Daniel Vetter wrote:
> > On Fri, Apr 26, 2019 at 7:33 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > > This reverts commit f4c34b1e2a37d5676180901fa6ff188bcb6371f8.
> > > 
> > > Simliar to commit a0cecc23cfcb Revert "drm/virtio: drop prime
> > > import/export callbacks".  We have to do the same with qxl,
> > > for the same reasons (it breaks DRI3).
> > > 
> > > Drop the WARN_ON_ONCE().
> > > 
> > > Fixes: f4c34b1e2a37d5676180901fa6ff188bcb6371f8
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > Maybe we need some helpers for virtual drivers which only allow
> > self-reimport and nothing else at all? I think there's qxl, virgl,
> > vmwgfx and maybe also vbox one who could use this ... Just a quick
> > idea.
> > -Daniel
> 
> I think vmwgfx could, in theory, support the full range of operations,
> at least for reasonably recent device versions. However, it wouldn't be
> terribly efficient since the exported dma-buf sglist would basically be a
> bounce-buffer.

Yeah not sure that makes sense to support really ...
-Daniel

> 
> /Thomas
> 
> 
> > > ---
> > >   drivers/gpu/drm/qxl/qxl_drv.c   |  4 ++++
> > >   drivers/gpu/drm/qxl/qxl_prime.c | 12 ++++++++++++
> > >   2 files changed, 16 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> > > index 578d867a81d5..f33e349c4ec5 100644
> > > --- a/drivers/gpu/drm/qxl/qxl_drv.c
> > > +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> > > @@ -255,10 +255,14 @@ static struct drm_driver qxl_driver = {
> > >   #if defined(CONFIG_DEBUG_FS)
> > >          .debugfs_init = qxl_debugfs_init,
> > >   #endif
> > > +       .prime_handle_to_fd = drm_gem_prime_handle_to_fd,
> > > +       .prime_fd_to_handle = drm_gem_prime_fd_to_handle,
> > >          .gem_prime_export = drm_gem_prime_export,
> > >          .gem_prime_import = drm_gem_prime_import,
> > >          .gem_prime_pin = qxl_gem_prime_pin,
> > >          .gem_prime_unpin = qxl_gem_prime_unpin,
> > > +       .gem_prime_get_sg_table = qxl_gem_prime_get_sg_table,
> > > +       .gem_prime_import_sg_table = qxl_gem_prime_import_sg_table,
> > >          .gem_prime_vmap = qxl_gem_prime_vmap,
> > >          .gem_prime_vunmap = qxl_gem_prime_vunmap,
> > >          .gem_prime_mmap = qxl_gem_prime_mmap,
> > > diff --git a/drivers/gpu/drm/qxl/qxl_prime.c b/drivers/gpu/drm/qxl/qxl_prime.c
> > > index 8b448eca1cd9..114653b471c6 100644
> > > --- a/drivers/gpu/drm/qxl/qxl_prime.c
> > > +++ b/drivers/gpu/drm/qxl/qxl_prime.c
> > > @@ -42,6 +42,18 @@ void qxl_gem_prime_unpin(struct drm_gem_object *obj)
> > >          qxl_bo_unpin(bo);
> > >   }
> > > 
> > > +struct sg_table *qxl_gem_prime_get_sg_table(struct drm_gem_object *obj)
> > > +{
> > > +       return ERR_PTR(-ENOSYS);
> > > +}
> > > +
> > > +struct drm_gem_object *qxl_gem_prime_import_sg_table(
> > > +       struct drm_device *dev, struct dma_buf_attachment *attach,
> > > +       struct sg_table *table)
> > > +{
> > > +       return ERR_PTR(-ENOSYS);
> > > +}
> > > +
> > >   void *qxl_gem_prime_vmap(struct drm_gem_object *obj)
> > >   {
> > >          struct qxl_bo *bo = gem_to_qxl_bo(obj);
> > > --
> > > 2.18.1
> > > 
> > 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
