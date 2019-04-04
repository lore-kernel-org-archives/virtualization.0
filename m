From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Subject: Re: [PATCH] drm/cirrus: rewrite and modernize driver.
Date: Thu, 4 Apr 2019 13:45:15 +0200
Message-ID: <5ad479ea-a95f-b66b-20b6-5da41e2cee9a__39279.6117974044$1554378331$gmane$org@tronnes.org>
References: <20190403072318.31507-1-kraxel@redhat.com>
	<CAMwc25o=DZSVE5Qf5mow6es06Gk3=+6+8offXPY-JPgUkG_Shw@mail.gmail.com>
	<20190404055056.ddc2bdgjbgjj7tby@sirius.home.kraxel.org>
	<CAKMK7uFbLcziLXrwds9QZBBPFiBDC_O+X9fiuutNjsutaPW+sQ@mail.gmail.com>
	<20190404083034.f7vrvukzqx5v7qju@sirius.home.kraxel.org>
	<CAKMK7uHiWu-kOa6SP0ZRstnrwdYR0MHgtHdHZPLWLXxWaQVPrQ@mail.gmail.com>
	<2866e37e-8563-1f1e-8f16-1119f70d52e1@tronnes.org>
	<20190404102722.w6c7aoxzcrhn5xhi@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190404102722.w6c7aoxzcrhn5xhi@sirius.home.kraxel.org>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org



Den 04.04.2019 12.27, skrev Gerd Hoffmann:
>   Hi,
> 
>>> tinydrm_xrgb8888_to_*
>>>
>>> imo these could be put into some drm_format_helpers.c to be shared.
>>
>> I agree, my long term goal is to get rid of tinydrm.ko. Just haven't got
>> there yet.
>>
>> Gerd, if you end up using some of those functions, feel free to move
>> just those you need and I can do the rest later. But if you have time to
>> spare I wouldn't mind getting all of them moved ;-)
> 
> For now I just promoted cirrus to be a tinydrm driver ;)
> 
> Noticed that those helpers (including tinydrm_memcpy for the
> non-converting case) apply clipping on the source but not on
> the destination.  So, for fullscreen updates that works ok,
> but for updating sub-rectangles it doesn't ...

Ah yes, these MIPI type controllers support setting the destination
window in controller RAM for the incoming buffer so there has been no
need for clipping on the destination buffer.

> 
> So I guess I have to add a dest_clip bool parameter when moving them.
> /me looks for a good place.  drm_fb_helpers.c I think.
> 
> cheers,
>   Gerd
> 
