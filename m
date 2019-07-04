From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v6 06/18] drm/virtio: remove ttm calls from in
	virtio_gpu_object_{reserve,unreserve}
Date: Thu, 4 Jul 2019 13:10:43 +0200
Message-ID: <20190704111043.5ubc2yjrjphj2iec__7772.00455065525$1562238655$gmane$org@sirius.home.kraxel.org>
References: <20190702141903.1131-1-kraxel@redhat.com>
	<20190702141903.1131-7-kraxel@redhat.com>
	<CAPaKu7RfLoB=K__wQd92=S20Mt0uqsfyU9oigr8CQ-=gH6OUuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAPaKu7RfLoB=K__wQd92=S20Mt0uqsfyU9oigr8CQ-=gH6OUuA@mail.gmail.com>
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

> > -       r = ttm_bo_reserve(&bo->tbo, true, false, NULL);
> > +       r = reservation_object_lock_interruptible(bo->gem_base.resv, NULL);
> Can you elaborate a bit about how TTM keeps the BOs alive in, for
> example, virtio_gpu_transfer_from_host_ioctl?  In that function, only
> three TTM functions are called: ttm_bo_reserve, ttm_bo_validate, and
> ttm_bo_unreserve.  I am curious how they keep the BO alive.

It can't go away between reserve and unreserve, and I think it also
can't be evicted then.  Havn't checked how ttm implements that.

cheers,
  Gerd
