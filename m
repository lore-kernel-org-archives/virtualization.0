From: David Riley <davidriley@chromium.org>
Subject: Re: [PATCH] drm/virtio: Use vmalloc for command buffer allocations.
Date: Tue, 3 Sep 2019 13:27:37 -0700
Message-ID: <CAASgrz1GKRGncD_6aDUKnDuBiZpZOjkP0P62Ukmk+DN6csKm7w__48431.0195710108$1567542485$gmane$org@mail.gmail.com>
References: <20190829212417.257397-1-davidriley@chromium.org>
	<20190830060857.tzrzgoi2hrmchdi5@sirius.home.kraxel.org>
	<CAASgrz2v0DYb_5A3MnaWFM4Csx1DKkZe546v7DG7R+UyLOA8og@mail.gmail.com>
	<20190830111605.twzssycagmjhfa45@sirius.home.kraxel.org>
	<CAASgrz0SXc2bEXq4xPCry_oHMXNbau36Q9i20anbFq1X0FsoMQ@mail.gmail.com>
	<20190902052852.vqejjqrib6tvv2v5@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190902052852.vqejjqrib6tvv2v5@sirius.home.kraxel.org>
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
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Gurchetan Singh <gurchetansingh@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Sep 1, 2019 at 10:28 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Fri, Aug 30, 2019 at 10:49:25AM -0700, David Riley wrote:
> > Hi Gerd,
> >
> > On Fri, Aug 30, 2019 at 4:16 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >
> > >   Hi,
> > >
> > > > > > -     kfree(vbuf->data_buf);
> > > > > > +     kvfree(vbuf->data_buf);
> > > > >
> > > > > if (is_vmalloc_addr(vbuf->data_buf)) ...
> > > > >
> > > > > needed here I gues?
> > > > >
> > > >
> > > > kvfree() handles vmalloc/kmalloc/kvmalloc internally by doing that check.
> > >
> > > Ok.
> > >
> > > > - videobuf_vmalloc_to_sg in drivers/media/v4l2-core/videobuf-dma-sg.c,
> > > > assumes contiguous array of scatterlist and that the buffer being converted
> > > > is page aligned
> > >
> > > Well, vmalloc memory _is_ page aligned.
> >
> > True, but this function gets called for all potential enqueuings (eg
> > resource_create_3d, resource_attach_backing) and I was concerned that
> > some other usage in the future might not have that guarantee.
>
> The vmalloc_to_sg call is wrapped into "if (is_vmalloc())", so this
> should not be a problem.
>
> > > sg_alloc_table_from_pages() does alot of what you need, you just need a
> > > small loop around vmalloc_to_page() create a struct page array
> > > beforehand.
> >
> > That feels like an extra allocation when under memory pressure and
> > more work, to not gain much -- there still needs to be a function that
> > iterates through all the pages.  But I don't feel super strongly about
> > it and can change it if you think that it will be less maintenance
> > overhead.
>
> Lets see how vmalloc_to_sg looks like when it assumes page-aligned
> memory.  It's probably noticeable shorter then.

It's not really.  The allocation of the table is one unit less, and
doesn't need to take into account that data might be an offset within
the page.  It still needs error handling, partial final page handling,
and marking of the end of the scatterlist.  Things could be slightly
simplified to assume that you can always get a contiguous allocation
of the table instead of using sg_alloc_table/for_each_sg, but given
that we're only going down this path when memory is fragmented and in
a fallback, doesn't seem worthwhile to make that trade-off.

I've written a different version of vmalloc_to_sgt which uses
sg_alloc_table_from_pages under the covers and it comes in slightly
shorter (39 lines vs 55 lines), but incurs another allocation as
previously so I'm personally in favour of things as written.
fpga_mgr_buf_load is another function which roughly does the same sort
of operation and it's a bit longer.

I'll post a v2 shortly, but if you think it's worth making the extra
allocation of the pages array to use, I can post that instead.

> cheers,
>   Gerd
>
