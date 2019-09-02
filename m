From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/virtio: Use vmalloc for command buffer allocations.
Date: Mon, 2 Sep 2019 07:28:52 +0200
Message-ID: <20190902052852.vqejjqrib6tvv2v5__21222.2959891491$1567402149$gmane$org@sirius.home.kraxel.org>
References: <20190829212417.257397-1-davidriley@chromium.org>
	<20190830060857.tzrzgoi2hrmchdi5@sirius.home.kraxel.org>
	<CAASgrz2v0DYb_5A3MnaWFM4Csx1DKkZe546v7DG7R+UyLOA8og@mail.gmail.com>
	<20190830111605.twzssycagmjhfa45@sirius.home.kraxel.org>
	<CAASgrz0SXc2bEXq4xPCry_oHMXNbau36Q9i20anbFq1X0FsoMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAASgrz0SXc2bEXq4xPCry_oHMXNbau36Q9i20anbFq1X0FsoMQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Riley <davidriley@chromium.org>
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Gurchetan Singh <gurchetansingh@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Aug 30, 2019 at 10:49:25AM -0700, David Riley wrote:
> Hi Gerd,
> 
> On Fri, Aug 30, 2019 at 4:16 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> >   Hi,
> >
> > > > > -     kfree(vbuf->data_buf);
> > > > > +     kvfree(vbuf->data_buf);
> > > >
> > > > if (is_vmalloc_addr(vbuf->data_buf)) ...
> > > >
> > > > needed here I gues?
> > > >
> > >
> > > kvfree() handles vmalloc/kmalloc/kvmalloc internally by doing that check.
> >
> > Ok.
> >
> > > - videobuf_vmalloc_to_sg in drivers/media/v4l2-core/videobuf-dma-sg.c,
> > > assumes contiguous array of scatterlist and that the buffer being converted
> > > is page aligned
> >
> > Well, vmalloc memory _is_ page aligned.
> 
> True, but this function gets called for all potential enqueuings (eg
> resource_create_3d, resource_attach_backing) and I was concerned that
> some other usage in the future might not have that guarantee.

The vmalloc_to_sg call is wrapped into "if (is_vmalloc())", so this
should not be a problem.

> > sg_alloc_table_from_pages() does alot of what you need, you just need a
> > small loop around vmalloc_to_page() create a struct page array
> > beforehand.
> 
> That feels like an extra allocation when under memory pressure and
> more work, to not gain much -- there still needs to be a function that
> iterates through all the pages.  But I don't feel super strongly about
> it and can change it if you think that it will be less maintenance
> overhead.

Lets see how vmalloc_to_sg looks like when it assumes page-aligned
memory.  It's probably noticeable shorter then.

cheers,
  Gerd
