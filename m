From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v6 07/18] drm/virtio: add virtio_gpu_object_array & helpers
Date: Thu, 4 Jul 2019 13:19:27 +0200
Message-ID: <20190704111927.u34xaaqeeiwrwrtb__11639.7135121346$1562239190$gmane$org@sirius.home.kraxel.org>
References: <20190702141903.1131-1-kraxel@redhat.com>
	<20190702141903.1131-8-kraxel@redhat.com>
	<CAPaKu7TJ1RgL_CjGnieE1hOOXnT-ECRk67ntRCPTFiv+EmrX4Q@mail.gmail.com>
	<CAPaKu7RFd4EVsV8VbNtNbVv2cPmSbpQ7pkBPpbbeUDz+i=nEfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAPaKu7RFd4EVsV8VbNtNbVv2cPmSbpQ7pkBPpbbeUDz+i=nEfQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chia-I Wu <olvaffe@gmail.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, Gurchetan Singh <gurchetansingh@chromium.org>
List-Id: virtualization@lists.linuxfoundation.org

> > > +int virtio_gpu_array_lock_resv(struct virtio_gpu_object_array *objs)
> > > +{
> > > +       return drm_gem_lock_reservations(objs->objs, objs->nents,
> > > +                                        &objs->ticket);
> Unlike in other drivers where an "object array" is only needed in
> execbuffer, we will use this in several places, and often with only 1
> object in the array.  Can we special case that and do a quick
> reservation_object_lock?

Yes, done.

> > > +void virtio_gpu_array_unlock_resv(struct virtio_gpu_object_array *objs)
> > > +{
> > > +       drm_gem_unlock_reservations(objs->objs, objs->nents,
> > > +                                   &objs->ticket);
> > > +}
> > > +

Likewise here.

cheers,
  Gerd
