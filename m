From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/qxl: drop prime import/export callbacks
Date: Tue, 9 Apr 2019 10:47:19 +0200
Message-ID: <20190409084719.qaiq5pyigfezroni__30855.2845310018$1554799651$gmane$org@sirius.home.kraxel.org>
References: <20190110081750.11358-1-kraxel@redhat.com>
	<CAPM=9tx8N6jxVzsT-RqtQFrFb9qLK4qUUje+d=fpTYZ6+PnYpg@mail.gmail.com>
	<CAPM=9tyEmn2LXhNmPSOi7JAgBc3QZwNtM+8FT8CWebz4GztaJA@mail.gmail.com>
	<20190409060323.xrw3fwj3yvcxsx3t@sirius.home.kraxel.org>
	<CAMwc25q-7rfR=31R=FEVC47z2HvDK5xN+aOKqq00yoXSpudusQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAMwc25q-7rfR=31R=FEVC47z2HvDK5xN+aOKqq00yoXSpudusQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Airlie <airlied@redhat.com>
Cc: David Airlie <airlied@linux.ie>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> > Should we add something like DRM_PRIME_CAP_SAME_DEVICE?
> 
> Yeah I expect we need some sort of same device only capability, so
> that dri3 userspace can work.
> 
> If we just fail importing in these cases what happens? userspace just
> gets confused, I know we used to print a backtrace if we hit the mmap
> path, but if we didn't do that what happens?

Well, we printed a backtrace and returned -EINVAL.  So it looked a bit
scary due to the backtrace which is usually printed for more serious
problems.  But we also returned a proper error code.

Userspace was not happy.  It was wayland (gnome-shell) which ran into it
it, and it didn't came up with a working display.

cheers,
  Gerd
