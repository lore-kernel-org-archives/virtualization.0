From: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH 00/15] Share TTM code among framebuffer drivers
Date: Tue, 16 Apr 2019 11:10:18 +0000
Message-ID: <0d45da9d-9354-58c8-e303-51e653d33503@amd.com>
References: <20190408092144.4548-1-tzimmermann@suse.de>
	<d69e0b34-c586-2338-b063-fb758b6465d8@amd.com>
	<096a70a7-ed24-2161-29e9-1907221b8a64@suse.de>
	<20190409071249.ngzarvjlztx4jwbh@sirius.home.kraxel.org>
	<a2f778c3-904b-5ee2-215e-df534f14b928@suse.de>
	<20190415155430.GB2665@phenom.ffwll.local>
	<b9ba305f-8140-faf9-3954-464d9f38852a@suse.de>
	<CAKMK7uG+E1uTwSifSu5TrXwQXqu0Cpr30B02_S9bf95HEyqY_g@mail.gmail.com>
	<9a3af097-d907-30da-73db-bcf00223e70b@amd.com>
	<CAKMK7uGKK2gP-1Oht7ARAqPs4ccUeAh9EPPke+wX1JWLeT_S7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAKMK7uGKK2gP-1Oht7ARAqPs4ccUeAh9EPPke+wX1JWLeT_S7Q@mail.gmail.com>
Content-Language: en-US
Content-ID: <09FEA32BDB951846BA6128972D4AC45A@namprd12.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Vetter <daniel@ffwll.ch>
Cc: "airlied@linux.ie" <airlied@linux.ie>, "puck.chen@hisilicon.com" <puck.chen@hisilicon.com>, "Zhang,
	Jerry" <Jerry.Zhang@amd.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "z.liuxinliang@hisilicon.com" <z.liuxinliang@hisilicon.com>, "hdegoede@redhat.com" <hdegoede@redhat.com>, "kong.kongxinwei@hisilicon.com" <kong.kongxinwei@hisilicon.com>, "Huang, Ray" <Ray.Huang@amd.com>, Thomas Zimmermann <tzimmermann@suse.de>, "zourongrong@gmail.com" <zourongrong@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Am 16.04.19 um 13:03 schrieb Daniel Vetter:
> On Tue, Apr 16, 2019 at 12:05 PM Koenig, Christian
> <Christian.Koenig@amd.com> wrote:
>> Am 15.04.19 um 21:17 schrieb Daniel Vetter:
>>> On Mon, Apr 15, 2019 at 6:21 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>>> Hi
>>>>
>>>> Am 15.04.19 um 17:54 schrieb Daniel Vetter:
>>>>> On Tue, Apr 09, 2019 at 09:50:40AM +0200, Thomas Zimmermann wrote:
>>>>>> Hi
>>>>>>
>>>>>> Am 09.04.19 um 09:12 schrieb kraxel@redhat.com:
>>>>>> [SNIP]
>>>>>>> I'd expect the same applies to the vbox driver.
>>>>>>>
>>>>>>> Dunno about the other drm drivers and the fbdev drivers you plan to
>>>>>>> migrate over.
>>>>>> The AST HW can support up to 512 MiB, but 32-64 MiB seems more realistic
>>>>>> for a server. It's similar with mgag200 HW. The old fbdev-supported
>>>>>> device are all somewhere in the range between cirrus and bochs. Some
>>>>>> drivers would probably benefit from the cirrus approach, some could use
>>>>>> VRAM directly.
>>>>> I think for dumb scanout with vram all we need is:
>>>>> - pin framebuffers, which potentially moves the underlying bo into vram
>>>>> - unpin framebuffers (which is just accounting, we don't want to move the
>>>>>     bo on every flip!)
>>>>> - if a pin doesn't find enough space, move one of the unpinned bo still
>>>>>     resident in vram out
>>>> For dumb buffers, I'd expect userspace to have a working set of only a
>>>> front and back buffer (plus maybe a third one). This working set has to
>>>> reside in VRAM for performance reasons; non-WS BOs from other userspace
>>>> programs don't have to be.
>>>>
>>>> So we could simplify even more: if there's not enough free space in
>>>> vram, remove all unpinned BO's. This would avoid the need to implement
>>>> an LRU algorithm or another eviction strategy. Userspace with a WS
>>>> larger than the absolute VRAM would see degraded performance but
>>>> otherwise still work.
>>> You still need a list of unpinned bo, and the lru scan algorithm is
>>> just a few lines of code more than unpinning everything. Plus it'd be
>>> a neat example of the drm_mm scan logic. Given that some folks might
>>> think that not having lru evict si a problem and get them to type
>>> their own, I'd just add it. But up to you. Plus with ttm you get it no
>>> matter what.
>> Well how about making an drm_lru component which just does the following
>> (and nothing else, please :):
>>
>> 1. Keep a list of objects and a spinlock protecting the list.
>>
>> 2. Offer helpers for adding/deleting/moving stuff from the list.
>>
>> 3. Offer a functionality to do the necessary dance of picking the first
>> entry where we can trylock it's reservation object.
>>
>> 4. Offer bulk move functionality similar to what TTM does at the moment
>> (can be implemented later on).
> At a basic level, this is list_head of drm_gem_object. Not sure that's
> all that useful (outside of the fairly simplistic vram helpers we're
> discussing here). Reasons for that is that there's a lot of trickery
> in selecting which is the best object to pick in any given case (e.g.
> do you want to use drm_mm scanning, or is there a slab of objects you
> prefer to throw out because that avoids. Given that I'm not sure
> implementing the entire scanning/drm_lru logic is beneficial.
>
> The magic trylock+kref_get_unless_zero otoh could be worth
> implementing as a helper, together with a note about how to build your
> own custom lru algorithm. Same for some bulk/nonblocking movement
> helpers maybe. Both not really needed for the dumb scanout vram
> helpers we're discussing here.

Yeah, exactly that's what I wanted to get towards as well.

This magic trylock+kref_get is what needs to be handled correctly by all 
drivers which implement an LRU.

LRU bulk move is something which is tricky to get right as well, but so 
far only amdgpu uses it so it only make sense to share when somebody 
else wants the same approach.

Christian.

> -Daniel
>
> -Daniel
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
