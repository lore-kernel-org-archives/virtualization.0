From: David Riley <davidriley@chromium.org>
Subject: Re: [PATCH v2] drm/virtio: Use vmalloc for command buffer allocations.
Date: Mon, 9 Sep 2019 10:12:09 -0700
Message-ID: <CAASgrz2tPPEiArFb=HaTJwoshrdS9xaOaLYtG1Ah43Rfcb=iSA__47507.509582077$1568049162$gmane$org@mail.gmail.com>
References: <20190829212417.257397-1-davidriley@chromium.org>
	<20190905220008.75488-1-davidriley@chromium.org>
	<20190906051847.75mj4772nqwdper6@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190906051847.75mj4772nqwdper6@sirius.home.kraxel.org>
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

On Thu, Sep 5, 2019 at 10:18 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> > +/* How many bytes left in this page. */
> > +static unsigned int rest_of_page(void *data)
> > +{
> > +     return PAGE_SIZE - offset_in_page(data);
> > +}
>
> Not needed.
>
> > +/* Create sg_table from a vmalloc'd buffer. */
> > +static struct sg_table *vmalloc_to_sgt(char *data, uint32_t size, int *sg_ents)
> > +{
> > +     int nents, ret, s, i;
> > +     struct sg_table *sgt;
> > +     struct scatterlist *sg;
> > +     struct page *pg;
> > +
> > +     *sg_ents = 0;
> > +
> > +     sgt = kmalloc(sizeof(*sgt), GFP_KERNEL);
> > +     if (!sgt)
> > +             return NULL;
> > +
> > +     nents = DIV_ROUND_UP(size, PAGE_SIZE) + 1;
>
> Why +1?

This is part of handling offsets within the vmalloc buffer and to
maintain parity with the !is_vmalloc_addr/existing case (sg_init_one
handles offsets within pages internally).  I had left it in because
this is being used for all sg/descriptor generation and I wasn't sure
if someone in the future might do something like:
buf = vmemdup_user()
offset = find_interesting(buf)
queue(buf + offset)

To respond specifically to your question, if we handle offsets, a
vmalloc_to_sgt(size = PAGE_SIZE + 2) could end up with 3 sg_ents with
the +1 being to account for that extra page.

I'll just remove all support for offsets in v3 of the patch and
comment that functionality will be different based on where the buffer
was originally allocated from.

>
> > +     ret = sg_alloc_table(sgt, nents, GFP_KERNEL);
> > +     if (ret) {
> > +             kfree(sgt);
> > +             return NULL;
> > +     }
> > +
> > +     for_each_sg(sgt->sgl, sg, nents, i) {
> > +             pg = vmalloc_to_page(data);
> > +             if (!pg) {
> > +                     sg_free_table(sgt);
> > +                     kfree(sgt);
> > +                     return NULL;
> > +             }
> > +
> > +             s = rest_of_page(data);
> > +             if (s > size)
> > +                     s = size;
>
> vmalloc memory is page aligned, so:

As per above, will remove with v3.

>
>                 s = min(PAGE_SIZE, size);
>
> > +             sg_set_page(sg, pg, s, offset_in_page(data));
>
> Offset is always zero.

As per above, will remove with v3.
>
> > +
> > +             size -= s;
> > +             data += s;
> > +             *sg_ents += 1;
>
> sg_ents isn't used anywhere.

It's used for outcnt.

>
> > +
> > +             if (size) {
> > +                     sg_unmark_end(sg);
> > +             } else {
> > +                     sg_mark_end(sg);
> > +                     break;
> > +             }
>
> That looks a bit strange.  I guess you need only one of the two because
> the other is the default?

I was being overly paranoid and not wanting to make assumptions about
the initial state of the table.  I'll simplify.
>
> >  static int virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
> >                                              struct virtio_gpu_vbuffer *vbuf,
> >                                              struct virtio_gpu_ctrl_hdr *hdr,
> >                                              struct virtio_gpu_fence *fence)
> >  {
> >       struct virtqueue *vq = vgdev->ctrlq.vq;
> > +     struct scatterlist *vout = NULL, sg;
> > +     struct sg_table *sgt = NULL;
> >       int rc;
> > +     int outcnt = 0;
> > +
> > +     if (vbuf->data_size) {
> > +             if (is_vmalloc_addr(vbuf->data_buf)) {
> > +                     sgt = vmalloc_to_sgt(vbuf->data_buf, vbuf->data_size,
> > +                                          &outcnt);
> > +                     if (!sgt)
> > +                             return -ENOMEM;
> > +                     vout = sgt->sgl;
> > +             } else {
> > +                     sg_init_one(&sg, vbuf->data_buf, vbuf->data_size);
> > +                     vout = &sg;
> > +                     outcnt = 1;
>
> outcnt must be set in both cases.

outcnt is set by vmalloc_to_sgt.

>
> > +static int virtio_gpu_queue_ctrl_buffer(struct virtio_gpu_device *vgdev,
> > +                                     struct virtio_gpu_vbuffer *vbuf)
> > +{
> > +     return virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, NULL, NULL);
> > +}
>
> Changing virtio_gpu_queue_ctrl_buffer to call
> virtio_gpu_queue_fenced_ctrl_buffer should be done in a separate patch.

Will do.

Thanks,
David
