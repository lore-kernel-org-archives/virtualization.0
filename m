From: Chia-I Wu <olvaffe@gmail.com>
Subject: Re: [PATCH v4 02/12] drm/virtio: switch virtio_gpu_wait_ioctl() to
	gem helper.
Date: Sun, 30 Jun 2019 11:56:36 -0700
Message-ID: <CAPaKu7QOegd=kzOQMZQcogGSWf1hVqJHuMs-mEX0sRufUhNAcA@mail.gmail.com>
References: <20190620060726.926-1-kraxel@redhat.com>
	<20190620060726.926-3-kraxel@redhat.com>
	<CAPaKu7RWpoRkTkoatdYHz6itHZFvUYgaBcQAXnSC2gDc+dFZxQ@mail.gmail.com>
	<20190628100516.yrtiuxemyt4hvyra@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190628100516.yrtiuxemyt4hvyra@sirius.home.kraxel.org>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 28, 2019 at 3:05 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Wed, Jun 26, 2019 at 04:55:20PM -0700, Chia-I Wu wrote:
> > On Wed, Jun 19, 2019 at 11:07 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >
> > > Use drm_gem_reservation_object_wait() in virtio_gpu_wait_ioctl().
> > > This also makes the ioctl run lockless.
> > The userspace has a BO cache to avoid freeing BOs immediately but to
> > reuse them on next allocations.  The BO cache checks if a BO is busy
> > before reuse, and I am seeing a big negative perf impact because of
> > slow virtio_gpu_wait_ioctl.  I wonder if this helps.
>
> Could help indeed (assuming it checks with NOWAIT).
Yeah, that is the case.
>
> How many objects does userspace check in one go typically?  Maybe it
> makes sense to add an ioctl which checks a list, to reduce the system
> call overhead.
One.  The cache sorts BOs by the time they are freed, and checks only
the first (compatible) BO.  If it is idle, cache hit.  Otherwise,
cache miss.  A new ioctl probably won't help.


>
> > > +       if (args->flags & VIRTGPU_WAIT_NOWAIT) {
> > > +               obj = drm_gem_object_lookup(file, args->handle);
> > Don't we need a NULL check here?
>
> Yes, we do.  Will fix.
>
> thanks,
>   Gerd
>
