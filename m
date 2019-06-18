From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 3/4] drm/virtio: simplify cursor updates
Date: Tue, 18 Jun 2019 09:41:53 +0200
Message-ID: <20190618074153.355np63i76ee24c7__10185.7686460548$1560843727$gmane$org@sirius.home.kraxel.org>
References: <20190617111406.14765-1-kraxel@redhat.com>
	<20190617111406.14765-4-kraxel@redhat.com>
	<20190617141806.GG12905@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190617141806.GG12905@phenom.ffwll.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

> Even nicer would be to add the fence using
> drm_atomic_set_fence_for_plane() in the prepare_fb hook. Assuming this
> isn't necessary for correctness (but then I kinda have questions about
> races and stuff).

I'll have a look.  Maybe this way I can drop struct
virtio_gpu_framebuffer (where the fence is the only
thing beside struct drm_framebuffer).

cheers,
  Gerd
