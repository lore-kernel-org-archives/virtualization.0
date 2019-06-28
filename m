From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v4 02/12] drm/virtio: switch virtio_gpu_wait_ioctl() to
	gem helper.
Date: Fri, 28 Jun 2019 12:05:16 +0200
Message-ID: <20190628100516.yrtiuxemyt4hvyra__7514.06392534904$1561716346$gmane$org@sirius.home.kraxel.org>
References: <20190620060726.926-1-kraxel@redhat.com>
	<20190620060726.926-3-kraxel@redhat.com>
	<CAPaKu7RWpoRkTkoatdYHz6itHZFvUYgaBcQAXnSC2gDc+dFZxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAPaKu7RWpoRkTkoatdYHz6itHZFvUYgaBcQAXnSC2gDc+dFZxQ@mail.gmail.com>
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

On Wed, Jun 26, 2019 at 04:55:20PM -0700, Chia-I Wu wrote:
> On Wed, Jun 19, 2019 at 11:07 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > Use drm_gem_reservation_object_wait() in virtio_gpu_wait_ioctl().
> > This also makes the ioctl run lockless.
> The userspace has a BO cache to avoid freeing BOs immediately but to
> reuse them on next allocations.  The BO cache checks if a BO is busy
> before reuse, and I am seeing a big negative perf impact because of
> slow virtio_gpu_wait_ioctl.  I wonder if this helps.

Could help indeed (assuming it checks with NOWAIT).

How many objects does userspace check in one go typically?  Maybe it
makes sense to add an ioctl which checks a list, to reduce the system
call overhead.

> > +       if (args->flags & VIRTGPU_WAIT_NOWAIT) {
> > +               obj = drm_gem_object_lookup(file, args->handle);
> Don't we need a NULL check here?

Yes, we do.  Will fix.

thanks,
  Gerd
