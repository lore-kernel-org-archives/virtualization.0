From: Chia-I Wu <olvaffe@gmail.com>
Subject: Re: [PATCH v3 08/12] drm/virtio: rework virtio_gpu_execbuffer_ioctl
	fencing
Date: Wed, 26 Jun 2019 22:24:20 -0700
Message-ID: <CAPaKu7SZr+wvoM8JgB=d4kHOJioPiG-hQbfU5mmT4iB9Kn4DgA@mail.gmail.com>
References: <20190619090420.6667-1-kraxel@redhat.com>
	<20190619090420.6667-9-kraxel@redhat.com>
	<20190619110902.GO12905@phenom.ffwll.local>
	<20190620060107.tdz3nrnsczkkv2a6@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190620060107.tdz3nrnsczkkv2a6@sirius.home.kraxel.org>
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>
List-Id: virtualization@lists.linuxfoundation.org

I tried my best to review this series.  I am not really a kernel dev
so please take that with a grain of salt.

On Wed, Jun 19, 2019 at 11:01 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > Also, I strongly recommend you do a very basic igt to exercise this, i.e.
> > allocate some buffers, submit them in a dummby op, then close the entire
> > drmfd. The old version should at least have tripped over kasan, maybe even
> > oopses somewhere.
>
> Hmm, I suspect I have to extend igt for that (adding support for
> virtio ioctls), right?
>
> A quick and dirty test (run webgl demo in firefox, then kill -9 both
> firefox and Xorg) didn't show any nasty surprises.
>
> cheers,
>   Gerd
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
