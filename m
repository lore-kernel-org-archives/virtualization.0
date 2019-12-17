From: Daniel Verkamp <dverkamp@chromium.org>
Subject: Re: [PATCH] virtio-balloon: request nvqs based on features
Date: Tue, 17 Dec 2019 11:04:14 -0800
Message-ID: <CABVzXAkvGptpY0T_uUEWa1=LjVfXYNAebbdq=P-AMuEioD+x=g@mail.gmail.com>
References: <20191216231429.38202-1-dverkamp@chromium.org>
 <20191217101108.7bf5018d.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191217101108.7bf5018d.cohuck@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Liang Li <liang.z.li@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 17, 2019 at 1:11 AM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Mon, 16 Dec 2019 15:14:29 -0800
> Daniel Verkamp <dverkamp@chromium.org> wrote:
>
> > After 86a559787e6f ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT"),
> > the virtio-balloon device unconditionally specifies 4 virtqueues as the
> > argument to find_vqs(), which means that 5 MSI-X vectors are required in
> > order to assign one vector per VQ plus one for configuration changes.
> >
> > However, in cases where the virtio device only provides exactly as many
> > MSI-X vectors as required for the features it implements (e.g. 3 for the
> > basic configuration of inflate + deflate + config), this results in the
> > selection of the fallback configuration where one interrupt vector is
> > used for all VQs instead of having one VQ per vector.
> >
> > Restore the logic that chose nvqs conditionally based on enabled
> > features, which was removed as part of the aforementioned commit.
> > This is slightly more complex than just incrementing a counter of the
> > number of VQs, since the queue for a given feature is assigned a fixed
> > index.
>
> As Wei already said, this should not be necessary, but see below.
>
> >
> > Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
> > ---
> >  drivers/virtio/virtio_balloon.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> > index 93f995f6cf36..67c6318d77c7 100644
> > --- a/drivers/virtio/virtio_balloon.c
> > +++ b/drivers/virtio/virtio_balloon.c
> > @@ -465,6 +465,7 @@ static int init_vqs(struct virtio_balloon *vb)
> >       vq_callback_t *callbacks[VIRTIO_BALLOON_VQ_MAX];
> >       const char *names[VIRTIO_BALLOON_VQ_MAX];
> >       int err;
> > +     unsigned nvqs;
> >
> >       /*
> >        * Inflateq and deflateq are used unconditionally. The names[]
> > @@ -475,20 +476,24 @@ static int init_vqs(struct virtio_balloon *vb)
> >       names[VIRTIO_BALLOON_VQ_INFLATE] = "inflate";
> >       callbacks[VIRTIO_BALLOON_VQ_DEFLATE] = balloon_ack;
> >       names[VIRTIO_BALLOON_VQ_DEFLATE] = "deflate";
> > +     nvqs = VIRTIO_BALLOON_VQ_DEFLATE + 1;
> > +
> >       names[VIRTIO_BALLOON_VQ_STATS] = NULL;
> >       names[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
>
> Note that we set names[q] to NULL, but not callbacks[q].

Indeed, good catch - this looks like the root cause of the problem,
since callbacks for unavailable features are left uninitialized.

> >
> >       if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
> >               names[VIRTIO_BALLOON_VQ_STATS] = "stats";
> >               callbacks[VIRTIO_BALLOON_VQ_STATS] = stats_request;
> > +             nvqs = VIRTIO_BALLOON_VQ_STATS + 1;
> >       }
> >
> >       if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
> >               names[VIRTIO_BALLOON_VQ_FREE_PAGE] = "free_page_vq";
> >               callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
> > +             nvqs = VIRTIO_BALLOON_VQ_FREE_PAGE + 1;
> >       }
> >
> > -     err = vb->vdev->config->find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX,
> > +     err = vb->vdev->config->find_vqs(vb->vdev, nvqs,
> >                                        vqs, callbacks, names, NULL, NULL);
>
> This will end up in vp_find_vqs_msix() eventually, which will try to
> determine the number of needed vectors based upon whether callbacks[q]
> is !NULL. That's probably the reason you end up trying to use more
> vectors than needed. (Further down in that function, the code will skip
> any queue with names[q] == NULL, but that's too late for determining
> the number of vectors.)
>
> So I think that either (a) virtio-pci should avoid trying to allocate a
> vector for queues with names[q] == NULL, or (b) virtio-balloon should
> clean out callbacks[q] for unused queues as well. Maybe both?

I've tested a patch for (b), which resolves the problem I was seeing
as well; this looks like a clear undefined behavior fix, so I'll send
at least that one.

I will also put together a patch for (a), although now that I
understand the find_vqs logic better, I think this mostly shouldn't be
necessary assuming virtio drivers correctly initialize the parameters
they pass to it.

Thanks,
-- Daniel
