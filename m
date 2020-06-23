From: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [RFC v9 02/11] vhost: use batched get_vq_desc version
Date: Tue, 23 Jun 2020 18:45:36 +0200
Message-ID: <CAJaqyWefmaENcnr+qaY3ezE2LoPp3+S_rLby_h1dRn2-N_nWfQ@mail.gmail.com>
References: <20200619182302.850-1-eperezma@redhat.com> <20200619182302.850-3-eperezma@redhat.com>
 <20200623103746-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200623103746-mutt-send-email-mst@kernel.org>
Sender: netdev-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm list <kvm@vger.kernel.org>, Stefano Garzarella <sgarzare@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 23, 2020 at 4:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Jun 19, 2020 at 08:22:53PM +0200, Eugenio P=C3=83=C2=A9rez wrote:
> > From: "Michael S. Tsirkin" <mst@redhat.com>
> >
> > As testing shows no performance change, switch to that now.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Eugenio P=C3=83=C2=A9rez <eperezma@redhat.com>
> > Link: https://lore.kernel.org/r/20200401183118.8334-3-eperezma@redhat.c=
om
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Eugenio P=C3=83=C2=A9rez <eperezma@redhat.com>
> > ---
> >  drivers/vhost/test.c  |   2 +-
> >  drivers/vhost/vhost.c | 314 ++++++++----------------------------------
> >  drivers/vhost/vhost.h |   7 +-
> >  3 files changed, 61 insertions(+), 262 deletions(-)
> >
> > diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
> > index a09dedc79f68..650e69261557 100644
> > --- a/drivers/vhost/test.c
> > +++ b/drivers/vhost/test.c
> > @@ -119,7 +119,7 @@ static int vhost_test_open(struct inode *inode, str=
uct file *f)
> >       dev =3D &n->dev;
> >       vqs[VHOST_TEST_VQ] =3D &n->vqs[VHOST_TEST_VQ];
> >       n->vqs[VHOST_TEST_VQ].handle_kick =3D handle_vq_kick;
> > -     vhost_dev_init(dev, vqs, VHOST_TEST_VQ_MAX, UIO_MAXIOV,
> > +     vhost_dev_init(dev, vqs, VHOST_TEST_VQ_MAX, UIO_MAXIOV + 64,
> >                      VHOST_TEST_PKT_WEIGHT, VHOST_TEST_WEIGHT, true, NU=
LL);
> >
> >       f->private_data =3D n;
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 2d784681b0fa..13021d6986eb 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -304,6 +304,7 @@ static void vhost_vq_reset(struct vhost_dev *dev,
> >  {
> >       vq->num =3D 1;
> >       vq->ndescs =3D 0;
> > +     vq->first_desc =3D 0;
> >       vq->desc =3D NULL;
> >       vq->avail =3D NULL;
> >       vq->used =3D NULL;
> > @@ -372,6 +373,11 @@ static int vhost_worker(void *data)
> >       return 0;
> >  }
> >
> > +static int vhost_vq_num_batch_descs(struct vhost_virtqueue *vq)
> > +{
> > +     return vq->max_descs - UIO_MAXIOV;
> > +}
> > +
> >  static void vhost_vq_free_iovecs(struct vhost_virtqueue *vq)
> >  {
> >       kfree(vq->descs);
>
>
> Batching is enabled if max_descs > UIO_MAXIOV.
>
> So this uses batching for test.
>
> But net is unchanged, so it is still not using the batched version.
> Is that right?
>

vhost_net already called vhost_dev_init with +VHOST_NET_BATCH (64):
vhost_dev_init(dev, vqs, VHOST_NET_VQ_MAX,
               UIO_MAXIOV + VHOST_NET_BATCH,
...

So it should be using batching in the same terms as vhost/test.
However I will double check it.

> I think a better subject would be "vhost/test: use batched get_vq_desc ve=
rsion".
>
> And that explains which testing it refers to: the one executed by vhost t=
est.
>
> I think there was a separate patch to enable that for net separately,
> but it got lost - or did I miss it?
>

Kind of. In V5 there were two separate commits: One adding the batch
version and another one making them the default.

Both of them were squashed in V6 but the result got the wrong commit
message. I will fix this in the next revisions.

But I don't find any specific commit to enable explicitly in net.

Thanks!




> --
> MST
>
