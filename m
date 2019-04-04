From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Subject: Re: [PATCH] drm/cirrus: rewrite and modernize driver.
Date: Thu, 4 Apr 2019 12:06:10 +0200
Message-ID: <2866e37e-8563-1f1e-8f16-1119f70d52e1__20757.0788262942$1554372385$gmane$org@tronnes.org>
References: <20190403072318.31507-1-kraxel@redhat.com>
	<CAMwc25o=DZSVE5Qf5mow6es06Gk3=+6+8offXPY-JPgUkG_Shw@mail.gmail.com>
	<20190404055056.ddc2bdgjbgjj7tby@sirius.home.kraxel.org>
	<CAKMK7uFbLcziLXrwds9QZBBPFiBDC_O+X9fiuutNjsutaPW+sQ@mail.gmail.com>
	<20190404083034.f7vrvukzqx5v7qju@sirius.home.kraxel.org>
	<CAKMK7uHiWu-kOa6SP0ZRstnrwdYR0MHgtHdHZPLWLXxWaQVPrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAKMK7uHiWu-kOa6SP0ZRstnrwdYR0MHgtHdHZPLWLXxWaQVPrQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Vetter <daniel@ffwll.ch>, Gerd Hoffmann <kraxel@redhat.com>
Cc: David Airlie <airlied@linux.ie>, David Airlie <airlied@redhat.com>, open list <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org



Den 04.04.2019 10.52, skrev Daniel Vetter:
> On Thu, Apr 4, 2019 at 10:30 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>>
>>   Hi,
>>
>>>> Speaking of wayland:  Seems at least gnome-shell insists on using XR24.
>>>
>>> Yeah XR24 is pretty much mandatory. Noralf added a few helpers to
>>> convert XR24 to other formats, for display not supporting anything
>>> else. Because userspace.
>>
>> Have a pointer to these helpers?  grepping around in drm didn't turn up
>> anything so far ...
> 
> tinydrm_xrgb8888_to_*
> 
> imo these could be put into some drm_format_helpers.c to be shared.

I agree, my long term goal is to get rid of tinydrm.ko. Just haven't got
there yet.

Gerd, if you end up using some of those functions, feel free to move
just those you need and I can do the rest later. But if you have time to
spare I wouldn't mind getting all of them moved ;-)

Noralf.

> From a quick look the xrgb8888_to_rgb888 is missing, but for a quick
> hack you can just use rgb565 to get going.
> -Daniel
> 
