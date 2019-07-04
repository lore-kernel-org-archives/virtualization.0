From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v6 08/18] drm/virtio: rework virtio_gpu_execbuffer_ioctl
	fencing
Date: Thu, 4 Jul 2019 13:25:34 +0200
Message-ID: <20190704112534.v7icsuverf7wrbjq__17544.2406952911$1562240116$gmane$org@sirius.home.kraxel.org>
References: <20190702141903.1131-1-kraxel@redhat.com>
	<20190702141903.1131-9-kraxel@redhat.com>
	<CAPaKu7QP=A2kV_kqcT20Pmc831HviaBJN1RpOFoa=V1g6SmE_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAPaKu7QP=A2kV_kqcT20Pmc831HviaBJN1RpOFoa=V1g6SmE_g@mail.gmail.com>
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

  Hi,

> >         if (fence)
> >                 virtio_gpu_fence_emit(vgdev, hdr, fence);
> > +       if (vbuf->objs) {
> > +               virtio_gpu_array_add_fence(vbuf->objs, &fence->f);
> > +               virtio_gpu_array_unlock_resv(vbuf->objs);
> > +       }
> This is with the spinlock held.  Maybe we should move the
> virtio_gpu_array_unlock_resv call out of the critical section.

That would bring back the race ...

> I am actually more concerned about virtio_gpu_array_add_fence, but it
> is also harder to move.  Should we add a kref to the object array?

Yep, refcounting would be the other way to fix the race.

> This bothers me because I recently ran into a CPU-bound game with very
> bad lock contention here.

Hmm.  Any clue where this comes from?  Multiple threads competing for
virtio buffers I guess?  Maybe we should have larger virtqueues?

cheers,
  Gerd
