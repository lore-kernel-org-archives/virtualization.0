From: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH RFC v8 02/11] vhost: use batched get_vq_desc version
Date: Tue, 23 Jun 2020 09:00:57 +0200
Message-ID: <CAJaqyWc3C_Td_SpV97CuemkQH9vH+EL3sGgeWGE82E5gYxZNCA@mail.gmail.com>
References: <20200611113404.17810-1-mst@redhat.com> <20200611113404.17810-3-mst@redhat.com>
 <0332b0cf-cf00-9216-042c-e870efa33626@redhat.com> <20200622115946-mutt-send-email-mst@kernel.org>
 <c56cc86d-a420-79ca-8420-e99db91980fa@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c56cc86d-a420-79ca-8420-e99db91980fa@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, kvm list <kvm@vger.kernel.org>, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 23, 2020 at 4:51 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/6/23 =E4=B8=8A=E5=8D=8812:00, Michael S. Tsirkin wrote:
> > On Wed, Jun 17, 2020 at 11:19:26AM +0800, Jason Wang wrote:
> >> On 2020/6/11 =E4=B8=8B=E5=8D=887:34, Michael S. Tsirkin wrote:
> >>>    static void vhost_vq_free_iovecs(struct vhost_virtqueue *vq)
> >>>    {
> >>>     kfree(vq->descs);
> >>> @@ -394,6 +400,9 @@ static long vhost_dev_alloc_iovecs(struct vhost_d=
ev *dev)
> >>>     for (i =3D 0; i < dev->nvqs; ++i) {
> >>>             vq =3D dev->vqs[i];
> >>>             vq->max_descs =3D dev->iov_limit;
> >>> +           if (vhost_vq_num_batch_descs(vq) < 0) {
> >>> +                   return -EINVAL;
> >>> +           }
> >> This check breaks vdpa which set iov_limit to zero. Consider iov_limit=
 is
> >> meaningless to vDPA, I wonder we can skip the test when device doesn't=
 use
> >> worker.
> >>
> >> Thanks
> > It doesn't need iovecs at all, right?
> >
> > -- MST
>
>
> Yes, so we may choose to bypass the iovecs as well.
>
> Thanks
>

I think that the kmalloc_array returns ZERO_SIZE_PTR for all of them
in that case, so I didn't bother to skip the kmalloc_array parts.
Would you prefer to skip them all and let them NULL? Or have I
misunderstood what you mean?

Thanks!
