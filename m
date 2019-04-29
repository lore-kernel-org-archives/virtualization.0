From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Spice-devel] [PATCH] Revert "drm/qxl: drop prime import/export
	callbacks"
Date: Mon, 29 Apr 2019 09:58:14 +0200
Message-ID: <CAKMK7uFB8deXDMP9cT634p_dK5LsM37R1v_vGhAEY1ZLZ+WBVA__2050.37572174973$1556524842$gmane$org@mail.gmail.com>
References: <20190426053324.26443-1-kraxel@redhat.com>
	<CAKMK7uG+vMU0hqqiKAswu=LqpkcXtLPqbYLRWgoAPpsQQV4qzA@mail.gmail.com>
	<20190429075413.smcocftjd2viznhv@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190429075413.smcocftjd2viznhv@sirius.home.kraxel.org>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, David Airlie <airlied@redhat.com>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 29, 2019 at 9:54 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Fri, Apr 26, 2019 at 04:21:37PM +0200, Daniel Vetter wrote:
> > On Fri, Apr 26, 2019 at 7:33 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >
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
> >
> > Maybe we need some helpers for virtual drivers which only allow
> > self-reimport and nothing else at all?
>
> The current gem prime helpers handle this reasonable well,
> I don't see a need for that.
>
> More useful would be some way to signal this self-reimport capability
> to userspace somehow.  See DRM_PRIME_CAP_LOCAL patch.

Userspace is supposed to test whether import/export works for a
specific combo, not blindly assume it does and then keel over. I think
we need to fix that, not add more flags - there's lots of reasons why
a given pair of devices can't share buffers (e.g. all the contiguous
allocations stuff on socs).

> Right now I have the choice to set DRM_PRIME_CAP_{IMPORT,EXPORT}, in
> which case some userspace assumes it can do cross-driver export/import
> and trips over that not working.  Or I do not set
> DRM_PRIME_CAP_{IMPORT,EXPORT}, which breaks DRI3 ...

Yeah that's not an option.
-Daniel

> > I think there's qxl, virgl,
>
> export is implemented for virgl, and import should be possible too.
>
> qxl/bochs is simliar to vmgfx, it could be done but dma-bufs would
> basically be bounce buffers (need copy from/to vram) so probably not
> worth the effort.
>
> cheers,
>   Gerd
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
