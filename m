From: David Riley <davidriley@chromium.org>
Subject: Re: [PATCH] drm/virtio: Use vmalloc for command buffer allocations.
Date: Fri, 30 Aug 2019 10:49:25 -0700
Message-ID: <CAASgrz0SXc2bEXq4xPCry_oHMXNbau36Q9i20anbFq1X0FsoMQ__21232.3286732257$1567187475$gmane$org@mail.gmail.com>
References: <20190829212417.257397-1-davidriley@chromium.org>
	<20190830060857.tzrzgoi2hrmchdi5@sirius.home.kraxel.org>
	<CAASgrz2v0DYb_5A3MnaWFM4Csx1DKkZe546v7DG7R+UyLOA8og@mail.gmail.com>
	<20190830111605.twzssycagmjhfa45@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190830111605.twzssycagmjhfa45@sirius.home.kraxel.org>
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

Hi Gerd,

On Fri, Aug 30, 2019 at 4:16 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > > -     kfree(vbuf->data_buf);
> > > > +     kvfree(vbuf->data_buf);
> > >
> > > if (is_vmalloc_addr(vbuf->data_buf)) ...
> > >
> > > needed here I gues?
> > >
> >
> > kvfree() handles vmalloc/kmalloc/kvmalloc internally by doing that check.
>
> Ok.
>
> > - videobuf_vmalloc_to_sg in drivers/media/v4l2-core/videobuf-dma-sg.c,
> > assumes contiguous array of scatterlist and that the buffer being converted
> > is page aligned
>
> Well, vmalloc memory _is_ page aligned.

True, but this function gets called for all potential enqueuings (eg
resource_create_3d, resource_attach_backing) and I was concerned that
some other usage in the future might not have that guarantee.  But if
that's overly being paranoid, I'm willing to backtrack on that.

> sg_alloc_table_from_pages() does alot of what you need, you just need a
> small loop around vmalloc_to_page() create a struct page array
> beforehand.

That feels like an extra allocation when under memory pressure and
more work, to not gain much -- there still needs to be a function that
iterates through all the pages.  But I don't feel super strongly about
it and can change it if you think that it will be less maintenance
overhead.

> Completely different approach: use get_user_pages() and don't copy the
> execbuffer at all.

This one I'd rather not do unless we can show that the copy is
actually a problem.  As it stands I expect this to be a fallback
instead of the regular case, and if it's not then the VMs need to
revisit how long the control queue size is.  Right now most
execbuffers end up being copied into a single contiguous buffer which
results in 3 descriptors of the virtio queue.  If vmalloc ends up
being used (which is only a fallback because vmemdup_user tries
kmalloc first still), then there'll be 66 descriptors for a 256KB
buffer.   I think that's fine for exceptional cases, but not ideal if
it was commonplace.

Chia-I suggested that we could have a flag for the ioctl execbuffer
indicating that the buffer is BO to solve that, but again I'd prefer
to see that it's actually a problem.

I'll also be moving the sg table construction out of the critical
section and properly accounting for the required number of descriptors
before entering it in response to his comments.

Thanks,
Dave
