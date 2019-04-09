From: David Airlie <airlied@redhat.com>
Subject: Re: [PATCH] drm/qxl: drop prime import/export callbacks
Date: Tue, 9 Apr 2019 16:06:19 +1000
Message-ID: <CAMwc25q-7rfR=31R=FEVC47z2HvDK5xN+aOKqq00yoXSpudusQ__36001.8970490032$1555717999$gmane$org@mail.gmail.com>
References: <20190110081750.11358-1-kraxel@redhat.com>
	<CAPM=9tx8N6jxVzsT-RqtQFrFb9qLK4qUUje+d=fpTYZ6+PnYpg@mail.gmail.com>
	<CAPM=9tyEmn2LXhNmPSOi7JAgBc3QZwNtM+8FT8CWebz4GztaJA@mail.gmail.com>
	<20190409060323.xrw3fwj3yvcxsx3t@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190409060323.xrw3fwj3yvcxsx3t@sirius.home.kraxel.org>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, Dave Airlie <airlied@redhat.com>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 9, 2019 at 4:03 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Tue, Apr 09, 2019 at 02:01:33PM +1000, Dave Airlie wrote:
> > On Sat, 12 Jan 2019 at 07:13, Dave Airlie <airlied@gmail.com> wrote:
> > >
> > > On Thu, 10 Jan 2019 at 18:17, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > > >
> > > > Also set prime_handle_to_fd and prime_fd_to_handle to NULL,
> > > > so drm will not advertive DRM_PRIME_CAP_{IMPORT,EXPORT} to
> > > > userspace.
> >
> > It's been pointed out to me that disables DRI3 for these devices, I'm
> > not sure that is the solution we actually wanted.
> >
> > any ideas?
>
> Well.  Lets have a look at where we stand:
>
>  * drm_gem_prime_export() works with qxl, you'll get a dma-buf handle.
>
>  * Other drivers trying to map that dma-buf (drm_gem_map_dma_buf()
>    callback) will not work, due to the ->gem_prime_get_sg_table()
>    callback not being there.
>
>  * drm_gem_prime_import() will work with buffers from the same qxl
>    device, there is a shortcut for this special case.  Otherwise it
>    will not work, due to the ->gem_prime_import_sg_table() callback
>    not being there.
>
> Bottom line: you can use prime to pass qxl object handles from one
> application to another.  But you can't actually export/import qxl
> buffer objects from/to other devices.
>
> Problem is that we have no way to signal to userspace that prime can
> be used that way.
>
> Setting DRM_PRIME_CAP_{IMPORT,EXPORT} even though the driver can't
> do that leads to other problems.  Userspace thinks it can have other
> devices (intel vgpu for example) handle the rendering, then import
> the rendered buffer into qxl for scanout.
>
> Should we add something like DRM_PRIME_CAP_SAME_DEVICE?

Yeah I expect we need some sort of same device only capability, so
that dri3 userspace can work.

If we just fail importing in these cases what happens? userspace just
gets confused, I know we used to print a backtrace if we hit the mmap
path, but if we didn't do that what happens?

Dave.
