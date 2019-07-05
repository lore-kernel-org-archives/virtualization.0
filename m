From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v6 15/18] drm/virtio: rework
	virtio_gpu_transfer_to_host_ioctl fencing
Date: Fri, 5 Jul 2019 16:07:46 +0200
Message-ID: <20190705140746.czs2e5ffryx2slxf@sirius.home.kraxel.org>
References: <20190702141903.1131-1-kraxel@redhat.com>
	<20190702141903.1131-16-kraxel@redhat.com>
	<CAPaKu7S0n=E7g0o2e6fEk1YjP+u=tsoV8upw7J=noSx88PgP+A@mail.gmail.com>
	<20190704115138.ou77sb3rlrex67tj@sirius.home.kraxel.org>
	<CAPaKu7SDwR1TgFQK2XGEbRqSkCO0XZYxGhcjzsAwOH42aOHEEw@mail.gmail.com>
	<20190705090553.jx5zcdoxeimojq2i@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190705090553.jx5zcdoxeimojq2i@sirius.home.kraxel.org>
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

> > > ... 3d case passes the objs list to virtio_gpu_cmd_transfer_to_host_3d,
> > > so it gets added to the vbuf and released when the command is finished.
> > Why doesn't this apply to virtio_gpu_cmd_transfer_to_host_2d?
> 
> Hmm, yes, makes sense to handle both the same way.
> 
> With virgl=off qemu processes the commands from the guest
> synchronously, so it'll work fine as-is.  So you can't hit
> the theoretical race window in practice.  But depending
> on that host-side implementation detail isn't a good idea
> indeed.

Branch with incremental fixes:
https://git.kraxel.org/cgit/linux/log/?h=drm-virtio-kill-ttm

I'll be offline three weeks now, will resume this when I'm back.

cheers,
  Gerd
