From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v4 11/12] drm/virtio: switch from ttm to gem shmem helpers
Date: Fri, 28 Jun 2019 12:49:07 +0200
Message-ID: <20190628104907.vign7lmgftrwfisv__3603.52608129091$1561718972$gmane$org@sirius.home.kraxel.org>
References: <20190620060726.926-1-kraxel@redhat.com>
	<20190620060726.926-12-kraxel@redhat.com>
	<CAPaKu7QXCMMKR50Oiv=CefUA4S+S3KgpJ2FKTd1WA1H2_ORqXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAPaKu7QXCMMKR50Oiv=CefUA4S+S3KgpJ2FKTd1WA1H2_ORqXg@mail.gmail.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

> >  static inline struct virtio_gpu_object*
> >  virtio_gpu_object_ref(struct virtio_gpu_object *bo)

> The last users of these two helpers are removed with this patch.  We
> can remove them.

patch 12/12 does that.

> > +       bo = gem_to_virtio_gpu_obj(&shmem_obj->base);
> > +       bo->base.base.funcs = &virtio_gpu_gem_funcs;
> Move this to virtio_gpu_create_object.

Fixed.

> > +       ret = drm_gem_shmem_pin(&obj->base.base);
> The bo is attached for its entire lifetime, at least currently.  Maybe
> we can use drm_gem_shmem_get_pages_sgt (and get rid of obj->pages).

Already checked this.
We can't due to the iommu quirks.

cheers,
  Gerd
