From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Subject: Re: [PATCH v3 14/15] drm/bochs: drop old fbdev emulation code
Date: Thu, 10 Jan 2019 12:09:59 +0100
Message-ID: <c9190d7a-6549-2a10-9fbe-a2080a689686__38211.9633759887$1547118483$gmane$org@tronnes.org>
References: <20190110082845.3453-1-kraxel@redhat.com>
	<20190110082845.3453-15-kraxel@redhat.com>
	<faf265e5-8f47-f652-5b19-d55fd4ed7d67@tronnes.org>
	<20190110101613.yo4ewkhy3nxs3do3@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190110101613.yo4ewkhy3nxs3do3@sirius.home.kraxel.org>
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
Cc: andr2000@gmail.com, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, David Airlie <airlied@linux.ie>, David Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org



Den 10.01.2019 11.16, skrev Gerd Hoffmann:
>   Hi,
> 
>>> -	drm_fb_helper_set_suspend_unlocked(&bochs->fb.helper, 1);
>>
>> The generic fbdev emulation doesn't take care of suspend/resume. You
>> could do this:
>> drm_fb_helper_set_suspend_unlocked(drm_dev->fb_helper, 1);
> 
> Additional to drm_mode_config_helper_suspend() I assume?

No, sorry for the confusion. I didn't know if you could use
drm_mode_config_helper_suspend() or not. That function takes care of
fbdev suspend as well:

int drm_mode_config_helper_suspend(struct drm_device *dev)
{
<...>
	drm_kms_helper_poll_disable(dev);
	drm_fb_helper_set_suspend_unlocked(dev->fb_helper, 1);
	state = drm_atomic_helper_suspend(dev);
<...>
}


> Does the call order matter?
> 
>>>  	drm_helper_resume_force_mode(drm_dev);
>>
>> The docs for this function has this to say:
>> * This function is deprecated. New drivers should implement atomic mode-
>> * setting and use the atomic suspend/resume helpers.
>>
>> Maybe you can use drm_mode_config_helper_suspend/resume() instead like
>> suggested in the drm_fbdev_generic_setup() docs.
> 
> That should work, yes.  The driver is simple enough ;)
> 
> cheers,
>   Gerd
> 
