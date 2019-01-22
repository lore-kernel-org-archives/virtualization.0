From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm: Split out drm_probe_helper.h
Date: Tue, 22 Jan 2019 09:03:36 +0100
Message-ID: <CAKMK7uF_8yRycA4ZUyudH7dM23DOiFEkKStAbbAvD=79y_UE_Q__18049.5768597879$1548144351$gmane$org@mail.gmail.com>
References: <20190116163442.12622-1-daniel.vetter@ffwll.ch>
	<20190116181018.GA27364@ravnborg.org>
	<20190117164541.GE3271@phenom.ffwll.local>
	<20190117174531.GA14041@ravnborg.org>
	<20190121221329.GA6512@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190121221329.GA6512@ravnborg.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Neil Armstrong <narmstrong@baylibre.com>, Nouveau Dev <nouveau@lists.freedesktop.org>, Liviu Dudau <liviu.dudau@arm.com>, DRI Development <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Daniel Vetter <daniel.vetter@intel.com>, linux-stm32@st-md-mailman.stormreply.com, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, Jani Nikula <jani.nikula@intel.com>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, The etnaviv authors <etnaviv@lists.freedesktop.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jan 21, 2019 at 11:13 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Daniel et al.
>
> > >
> > > Yeah the drm_crtc_helper.h header is a bit the miniature drmP.h for legacy
> > > kms drivers. Just removing it from all the atomic drivers caused lots of
> > > fallout, I expect even more if you entirely remove the includes it has.
> > > Maybe a todo, care to pls create that patch since it's your idea?
> >
> > The main reason I bailed out initially was that this would create
> > small changes to several otherwise seldomly touched files.
> > And then we would later come and remove drmP.h - so lots of
> > small but incremental changes to the same otherwise seldomly
> > edited files.
> > And the job was only partially done.
> >
> > I will try to experiment with an approach where I clean up the
> > include/drm/*.h files a little (like suggested above, +delete drmP.h
> > and maybe a bit more).
> >
> > Then to try on a driver by driver basis to make it build with a
> > cleaned set of include files.
> > I hope that the cleaned up driver can still build without the
> > cleaned header files so the changes can be submitted piecemal.
> >
> > Will do so with an eye on the lesser maintained drivers to try it
> > out to avoid creating too much chrunch for others.
>
> I have now a few patches queued, but the result is not too pretty.
> I did the following:
>
> - For all files in include/drm/*.h the set of include files
>   were adjusted to the minimum number of files required to make
>   them build without any other files included first.
>
>   Created one .c file for each .h file. Then included the .h
>   file and adjusted to the minimal set of include files.
>   In the process a lot of forwards were added.
>
> - Deleted drmP.h
>
> - Fixed build of a few drivers: sti, tilcdc, gma500, tve200, via
>
> Some observations:
>
> - Killing all the includes not needed in the headers files
>   results in a a lot of extra changes.
>   Examples:
>     drm_modseset_helper_vtables.h is no longer
>     included by anyone, so needs to be added in many files
>
>     drm_atomic_state_helper.h is no longer included
>     by anyone so likewise needs to be added in many files
>
> - It is very tedious to do this properly.
>   The process I followed was:
>   - delete / comment out all include files
>   - add back the obvious from a quick scan of the code
>   - build - fix - build - fix - build - fix ...
>   -   next file...
>
> - The result is errorprone as only the allyesconfig + allmodconfig
>   variants are tested. But reallife configurations are more diverse.
>
> Current diffstat:
>    111 files changed, 771 insertions(+), 401 deletions(-)
>
> This is for the 5 drivers alone and not the header cleanup.
> So long story short - this is not good and not the way forward.
>
> I will try to come up with a few improvements to make the
> headers files selfcontained, but restricted to the changes that
> add forwards/include to avoid the chrunch in all the drivers.
>
> And then post for review a few patches to clean up some headers.
> If the cleanup gets a go I will try to persuade the introduction
> of these.
> This will include, but will not be limited to, the above mentioned
> drm_crtc_helper.h header file.
>
> For now too much time was already spent on this, so it is at the
> moment pushed back on my TODO list.
> This mail serve also as a kind of "where had I left", when/if I
> pick this up again.
>
> If there are anyone that knows some tooling that can help in the
> process of adjusting the header files I am all ears.

Yeah in the process of splitting up drmP.h we've created a few smaller
such piles of headers. I think in some cases it's just not going to be
worth it to fully split them up, e.g. drm_crtc_helper.h is going to be
a pure legacy helper, only needed by pre-atomic drivers. Splitting
that up doesn't seem to useful to me. Similarly we might want
drm_atomic_helper.h to keep pulling in the other helper headers. So
probably going to be a judgement call on a case-by-case basis.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
