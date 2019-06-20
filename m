From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 08/12] drm/virtio: rework virtio_gpu_execbuffer_ioctl
	fencing
Date: Thu, 20 Jun 2019 08:01:07 +0200
Message-ID: <20190620060107.tdz3nrnsczkkv2a6__46127.9305209004$1561010498$gmane$org@sirius.home.kraxel.org>
References: <20190619090420.6667-1-kraxel@redhat.com>
	<20190619090420.6667-9-kraxel@redhat.com>
	<20190619110902.GO12905@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190619110902.GO12905@phenom.ffwll.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dri-devel@lists.freedesktop.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> Also, I strongly recommend you do a very basic igt to exercise this, i.e.
> allocate some buffers, submit them in a dummby op, then close the entire
> drmfd. The old version should at least have tripped over kasan, maybe even
> oopses somewhere.

Hmm, I suspect I have to extend igt for that (adding support for
virtio ioctls), right?

A quick and dirty test (run webgl demo in firefox, then kill -9 both
firefox and Xorg) didn't show any nasty surprises.

cheers,
  Gerd
