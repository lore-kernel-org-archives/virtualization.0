From: Tom Murphy <murphyt7-/Zw1syy4LHg@public.gmane.org>
Subject: Re: [PATCH 0/8] Convert the intel iommu driver to the dma-iommu api
Date: Thu, 19 Mar 2020 23:28:09 -0700
Message-ID: <CALQxJuujCe7TsqkbfusPnzef2SApDBNPa7wj=U4ozDJWCoBHOg@mail.gmail.com>
References: <20191221150402.13868-1-murphyt7@tcd.ie> <87blrzwcn8.fsf@intel.com>
 <432d306c-fe9f-75b2-f0f7-27698f1467ad@arm.com> <87o8vzuv4i.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87o8vzuv4i.fsf-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jani Nikula <jani.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joonas Lahtinen <joonas.lahtinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Rodrigo Vivi <rodrigo.vivi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andy Gross <agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding@gmail.>
List-Id: virtualization@lists.linuxfoundation.org

Any news on this? Is there anyone who wants to try and fix this possible bu=
g?

On Mon, 23 Dec 2019 at 03:41, Jani Nikula <jani.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wro=
te:
>
> On Mon, 23 Dec 2019, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> > On 2019-12-23 10:37 am, Jani Nikula wrote:
> >> On Sat, 21 Dec 2019, Tom Murphy <murphyt7-/Zw1syy4LHg@public.gmane.org> wrote:
> >>> This patchset converts the intel iommu driver to the dma-iommu api.
> >>>
> >>> While converting the driver I exposed a bug in the intel i915 driver
> >>> which causes a huge amount of artifacts on the screen of my
> >>> laptop. You can see a picture of it here:
> >>> https://github.com/pippy360/kernelPatches/blob/master/IMG_20191219_22=
5922.jpg
> >>>
> >>> This issue is most likely in the i915 driver and is most likely cause=
d
> >>> by the driver not respecting the return value of the
> >>> dma_map_ops::map_sg function. You can see the driver ignoring the
> >>> return value here:
> >>> https://github.com/torvalds/linux/blob/7e0165b2f1a912a06e381e91f0f4e4=
95f4ac3736/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c#L51
> >>>
> >>> Previously this didn=E2=80=99t cause issues because the intel map_sg =
always
> >>> returned the same number of elements as the input scatter gather list
> >>> but with the change to this dma-iommu api this is no longer the
> >>> case. I wasn=E2=80=99t able to track the bug down to a specific line =
of code
> >>> unfortunately.
> >>>
> >>> Could someone from the intel team look at this?
> >>
> >> Let me get this straight. There is current API that on success always
> >> returns the same number of elements as the input scatter gather
> >> list. You propose to change the API so that this is no longer the case=
?
> >
> > No, the API for dma_map_sg() has always been that it may return fewer
> > DMA segments than nents - see Documentation/DMA-API.txt (and otherwise,
> > the return value would surely be a simple success/fail condition).
> > Relying on a particular implementation behaviour has never been strictl=
y
> > correct, even if it does happen to be a very common behaviour.
> >
> >> A quick check of various dma_map_sg() calls in the kernel seems to
> >> indicate checking for 0 for errors and then ignoring the non-zero retu=
rn
> >> is a common pattern. Are you sure it's okay to make the change you're
> >> proposing?
> >
> > Various code uses tricks like just iterating the mapped list until the
> > first segment with zero sg_dma_len(). Others may well simply have bugs.
>
> Thanks for the clarification.
>
> BR,
> Jani.
>
> >
> > Robin.
> >
> >> Anyway, due to the time of year and all, I'd like to ask you to file a
> >> bug against i915 at [1] so this is not forgotten, and please let's not
> >> merge the changes before this is resolved.
> >>
> >>
> >> Thanks,
> >> Jani.
> >>
> >>
> >> [1] https://gitlab.freedesktop.org/drm/intel/issues/new
> >>
> >>
>
> --
> Jani Nikula, Intel Open Source Graphics Center
