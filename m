From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 15/15] drm/bochs: reserve bo for pin/unpin
Date: Wed, 9 Jan 2019 15:54:43 +0100
Message-ID: <20190109145443.l5yus2pgvxcl4zbt__41754.3804309846$1547045566$gmane$org@sirius.home.kraxel.org>
References: <20190108112519.27473-1-kraxel@redhat.com>
	<20190108112519.27473-16-kraxel@redhat.com>
	<20190109101044.GS21184@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190109101044.GS21184@phenom.ffwll.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>, andr2000@gmail.com, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 09, 2019 at 11:10:44AM +0100, Daniel Vetter wrote:
> On Tue, Jan 08, 2019 at 12:25:19PM +0100, Gerd Hoffmann wrote:
> > The buffer object must be reserved before calling
> > ttm_bo_validate for pinning/unpinning.
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> Seems a bit a bisect fumble in your series here: legacy kms code reserved
> the ttm bo before calling boch_bo_pin/unpin, your atomic code doesn't. I
> think pushing this into bochs_bo_pin/unpin makes sense for atomic, but to
> avoid bisect fail I think you need to have these temporarily in your
> cleanup/prepare_plane functions too.

I think I've sorted that.  Have some other changes too, will probably
send v3 tomorrow.

> Looked through the entire series, this here is the only issue I think
> should be fixed before merging (making atomic_enable optional can be done
> as a follow-up if you feel like it). With that addressed on the series:
> 
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Thanks.

While being at it:  I'm also looking at dma-buf export and import
support for the qemu drivers.

Right now both qxl and virtio have gem_prime_get_sg_table and
gem_prime_import_sg_table handlers which throw a WARN_ONCE() and return
an error.

If I understand things correctly it is valid to set all import/export
callbacks (prime_handle_to_fd, prime_fd_to_handle,
gem_prime_get_sg_table, gem_prime_import_sg_table) to NULL when not
supporting dma-buf import/export and still advertise DRIVER_PRIME to
indicate the other prime callbacks are supported (so generic fbdev
emulation can use gem_prime_vmap etc).  Is that correct?

On exporting:

TTM_PL_TT should be easy, just pin the buffer, grab the pages list and
feed that into drm_prime_pages_to_sg.  Didn't try yet though.  Is that
approach correct?

Is it possible to export TTM_PL_VRAM objects (with backing storage being
a pci memory bar)?  If so, how?

On importing:

Importing into TTM_PL_TT object looks easy again, at least when the
object is actually stored in RAM.  What if not?

Importing into TTM_PL_VRAM:  Impossible I think, without copying over
the data.  Should that be done?  If so, how?  Or is it better to just
not support import then?

thanks,
  Gerd
