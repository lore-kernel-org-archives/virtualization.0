From: Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH] drm/virtio: Add window server support
Date: Fri, 12 Jan 2018 14:11:04 +1000
Message-ID: <CAPM=9twT_jtfJteuUpRvu1Xn3nNfxG-5oLfcbHYVnHVeS9TzcA__18090.9829251052$1515730174$gmane$org@mail.gmail.com>
References: <20171228115333.12289-1-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171228115333.12289-1-tomeu.vizoso@collabora.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

>
> this work is based on the virtio_wl driver in the ChromeOS kernel by
> Zach Reizner, currently at:
>
> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.4/drivers/virtio/virtio_wl.c
>
> There's two features missing in this patch when compared with virtio_wl:
>
> * Allow the guest access directly host memory, without having to resort
> to TRANSFER_TO_HOST
>
> * Pass FDs from host to guest (Wayland specifies that the compositor
> shares keyboard data with the guest via a shared buffer)
>
> I plan to work on this next, but I would like to get some comments on
> the general approach so I can better choose which patch to follow.

Shouldn't qemu expose some kind of capability to enable this so we know to
look for the extra vqs?

What happens if you run this on plain qemu, does it fallback correctly?

Are there any scenarios where we don't want to expose this API because there
is nothing to back it.

Dave.
