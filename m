From: Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH 00/15] Share TTM code among framebuffer drivers
Date: Tue, 9 Apr 2019 17:42:07 +1000
Message-ID: <CAPM=9tzg08MU0n7EhV=FVSF0FWN3qway76P5=JX1DegYHrcwvg@mail.gmail.com>
References: <20190408092144.4548-1-tzimmermann@suse.de>
	<d69e0b34-c586-2338-b063-fb758b6465d8@amd.com>
	<096a70a7-ed24-2161-29e9-1907221b8a64@suse.de>
	<20190409071249.ngzarvjlztx4jwbh@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190409071249.ngzarvjlztx4jwbh@sirius.home.kraxel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "kraxel@redhat.com" <kraxel@redhat.com>
Cc: "airlied@linux.ie" <airlied@linux.ie>, "puck.chen@hisilicon.com" <puck.chen@hisilicon.com>, "Zhang,
	Jerry" <Jerry.Zhang@amd.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "z.liuxinliang@hisilicon.com" <z.liuxinliang@hisilicon.com>, "hdegoede@redhat.com" <hdegoede@redhat.com>, "kong.kongxinwei@hisilicon.com" <kong.kongxinwei@hisilicon.com>, "Huang, Ray" <Ray.Huang@amd.com>, Thomas Zimmermann <tzimmermann@suse.de>, "zourongrong@gmail.com" <zourongrong@gmail.com>, "Koenig,
	Christian" <Christian.Koenig@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 9 Apr 2019 at 17:12, kraxel@redhat.com <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > If not for TTM, what would be the alternative? One VMA manager per
> > memory region per device?
>
> Depends pretty much on the device.
>
> The cirrus is a display device with only 4 MB of vram.  You can't fit
> much in there.  A single 1024x768 @ 24bpp framebuffer needs more 50%
> of the video memory already.  Which is why the cirrus driver (before the
> rewrite) had to migrate buffers from/to vram on every page flip[1].  Which
> is one[2] of the reasons why cirrus (after rewrite) doesn't ttm-manage the
> vram any more.  gem objects are managed with the shmem helpers instead
> and the active framebuffer is blitted to vram.
>
> The qemu stdvga (bochs driver) has 16 MB vram by default and can be
> configured to have up to 256 MB.  Plenty of room even for multiple 4k
> framebuffers if needed.  So for the bochs driver all the ttm bo
> migration logic is not needed, it could just store everything in vram.

To clarify I assume you mean it doesn't need the migrate each bo
logic, but it still needs the when VRAM fills up migrate stuff logic.

Dave.
