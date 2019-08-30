From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/virtio: Use vmalloc for command buffer allocations.
Date: Fri, 30 Aug 2019 13:16:05 +0200
Message-ID: <20190830111605.twzssycagmjhfa45__25675.5485710286$1567163876$gmane$org@sirius.home.kraxel.org>
References: <20190829212417.257397-1-davidriley@chromium.org>
	<20190830060857.tzrzgoi2hrmchdi5@sirius.home.kraxel.org>
	<CAASgrz2v0DYb_5A3MnaWFM4Csx1DKkZe546v7DG7R+UyLOA8og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAASgrz2v0DYb_5A3MnaWFM4Csx1DKkZe546v7DG7R+UyLOA8og@mail.gmail.com>
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

  Hi,

> > > -     kfree(vbuf->data_buf);
> > > +     kvfree(vbuf->data_buf);
> >
> > if (is_vmalloc_addr(vbuf->data_buf)) ...
> >
> > needed here I gues?
> >
> 
> kvfree() handles vmalloc/kmalloc/kvmalloc internally by doing that check.

Ok.

> - videobuf_vmalloc_to_sg in drivers/media/v4l2-core/videobuf-dma-sg.c,
> assumes contiguous array of scatterlist and that the buffer being converted
> is page aligned

Well, vmalloc memory _is_ page aligned.

sg_alloc_table_from_pages() does alot of what you need, you just need a
small loop around vmalloc_to_page() create a struct page array
beforehand.

Completely different approach: use get_user_pages() and don't copy the
execbuffer at all.

cheers,
  Gerd
