From: Chia-I Wu <olvaffe@gmail.com>
Subject: Re: [PATCH v6 06/18] drm/virtio: remove ttm calls from in
	virtio_gpu_object_{reserve, unreserve}
Date: Thu, 4 Jul 2019 12:17:48 -0700
Message-ID: <CAPaKu7S4Og7kda2ZjFtuRv=_W8gpFbD5y7s==0JB5Z34S4Hsjw__629.842006468095$1562267893$gmane$org@mail.gmail.com>
References: <20190702141903.1131-1-kraxel@redhat.com>
	<20190702141903.1131-7-kraxel@redhat.com>
	<CAPaKu7RfLoB=K__wQd92=S20Mt0uqsfyU9oigr8CQ-=gH6OUuA@mail.gmail.com>
	<20190704111043.5ubc2yjrjphj2iec@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190704111043.5ubc2yjrjphj2iec@sirius.home.kraxel.org>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, Gurchetan Singh <gurchetansingh@chromium.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 4, 2019 at 4:10 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > -       r = ttm_bo_reserve(&bo->tbo, true, false, NULL);
> > > +       r = reservation_object_lock_interruptible(bo->gem_base.resv, NULL);
> > Can you elaborate a bit about how TTM keeps the BOs alive in, for
> > example, virtio_gpu_transfer_from_host_ioctl?  In that function, only
> > three TTM functions are called: ttm_bo_reserve, ttm_bo_validate, and
> > ttm_bo_unreserve.  I am curious how they keep the BO alive.
>
> It can't go away between reserve and unreserve, and I think it also
> can't be evicted then.  Havn't checked how ttm implements that.
Hm, but the vbuf using the BO outlives the reserve/unreserve section.
The NO_EVICT flag applies only when the BO is still alive.  Someone
needs to hold a reference to the BO to keep it alive, otherwise the BO
can go away before the vbuf is retired.

I can be wrong, but on the other hand, it seems fine for a BO to go
away before the vbuf using it is retired.  When that happens, the
driver emits a RESOURCE_UNREF vbuf which is *after* the original vbuf.


>
> cheers,
>   Gerd
>
