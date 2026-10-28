Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793189740;
	b=j4vzI9oz78F+aBY2evsK9XXXNN4SvvVHMT1hRBQJ2b+o9pqqbH+ozUBBjDeX2x3w0ejG
	 F3x328yomsmuLW8J6kpbosJyaYgXGym8wdOzMfY6RCd1TDVs/FQ8Esh6vcbJCCsgkQnXy
	 LGvXVxEBzP/RFBSdsEd9ayBEsnL7eeIA0ugb3A/N5VyeA+i+soNkICOiCg3yAIkD0yuMP
	 XyOC68WlisFmKbAQY/OYYQgJplx0X3yx0Gmi1F7hegwGljZtkxqwkjNm1fAnd6SOIgJ//
	 eR3kbqzoSJjelycVh2C6O1hw4arfS+0VCgJlwrh+OdDFffK4lCoiQ9nG4okrML/u/rQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793189740;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ZohoMailClient;
	bh=/2akYOy6YGKaOEXw/VkGTrsyV1hy65TQgDziu2YpSXU=;
	b=foRjdprFa3r+T8n1hZtCSb3cKXs4bTawU9//ydX5Z60p702oBLLj6ieo9viooMhzbXsv
	 wm+J6L4ZkoFGBxC7Uu6aB0pjvjNPgXYQL1bj052U06cdp7UpTXw2cXDSc09aCfsec4DVv
	 bg6KVx8zMJn1wrn7trrsjrYbFRvwVTh1+NtczevtQFRzWWuRXbekFoV4rLlb7B5Za9yqa
	 5izRBxx0GNlYh/lhjLmZlg+nfgj6zGNXMmNwyxlow3NKCLBnJRB4OqDN9mYbnLm6tg/am
	 E+G2GlkVCUU9E4VNASryS6pGLemorgwWZhNYMKhoBnWX7FN0dLqrW4EETmJOX3YbIzA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=CstQy5S5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19215606A31A;
	Wed, 28 Oct 2026 12:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19215606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=CstQy5S5
ARC-Seal: i=1; a=rsa-sha256; t=1793189725; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=K9TxSEmnVHlVNBFEZUEqAaaoF57hHY576AksdpUvZHycTE/nB0qnd/cjN3FI0LH13ERpLv7jf4VzVc+y8JVYQC6SXLSLQ26UNe4QSCgIbr7A0fgLnwtymh+ddUXOJBJwbG26qnN8tcRG42aN6g5u0HwYL0xOsSZCrk2EFiWGAJk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793189725; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/2akYOy6YGKaOEXw/VkGTrsyV1hy65TQgDziu2YpSXU=; 
	b=DlzXHruOLBPUsROpYRNZ810mQdOt2ezz1cho8qyKgQGOj0cILjS2cgUdBA2tagLKwcjctRD66KAK3jd2UwTSIBjPXAowJMteIqml8sjlGj2NqH/IhWPjLXAKZjUXHoQ63MCRJMxXq2UjhIT4pIfrmqJ3JKSRPFRc6laS6XH63SY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1793189725;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=/2akYOy6YGKaOEXw/VkGTrsyV1hy65TQgDziu2YpSXU=;
	b=CstQy5S5LsWpJc29h1knK3jXQrccC4lZT1z5WvyCOpwHp/OaBReYJZ8oD5CLrsP6
	V/A4k9C3MtXUy70f96hOTk5puWg0ZGnVzC/0KZyCAemePncvcn3lJ1koz7fwqRsHNHv
	7FYy7JPq1q7I7C3hoa8cwKwLZd5u5I6pmL4uLGO4=
Received: by smtp.zohomail.com with SMTPS id 1793189721376354.21165480845355;
	Wed, 28 Oct 2026 05:15:21 -0700 (PDT)
Message-ID: <104e0ffd-4c87-4727-b510-cd80ba8c9eb2@collabora.com>
Date: Wed, 28 Oct 2026 15:15:14 +0300
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/vblank: Don't arm vblank timer with invalid frame
 duration
To: Thomas Zimmermann <tzimmermann@suse.de>, me@romanilin.is,
 louis.chauvet@bootlin.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch, javierm@redhat.com,
 ville.syrjala@linux.intel.com, regressions@leemhuis.info,
 peter.m.arnesen@gmail.com
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 sashiko-reviews@lists.linux.dev
References: <20260914110004.211027-1-tzimmermann@suse.de>
 <bd3c0c3a-1452-4667-b99d-96af0087af3f@suse.de>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <bd3c0c3a-1452-4667-b99d-96af0087af3f@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 10/28/26 10:29, Thomas Zimmermann wrote:
> 
> Ping. Please review!
> 
> Am 14.09.26 um 12:57 schrieb Thomas Zimmermann:
>> From: Roman Ilin <me@romanilin.is>
>>
>> When a CRTC's display mode carries a too small pixel clock,
>> drm_calc_timestamping_constants() computes a frame duration that
>> exceeds INT_MAX. drm_vblank_crtc.framedur_ns becomes negative.
>> drm_crtc_vblank_start_timer() then arms the vblank hrtimer with this
>> interval, after which vblank events are no longer delivered. Pending
>> page flips never complete and the display appears frozen.
>>
>> This could be triggered on virtio-gpu guests that have dynamic resolution
>> enabled: when the SPICE agent or the X server resizes the output, it
>> submits a mode whose pixel clock is off by a factor of 1000, e.g.:
>>
>>      clock = 406 kHz, htotal = 3152, vtotal = 2148
>>
>>      framedur_ns = 3152 * 2148 * 1000000 / 406 = 16675852216 ns (~16.7 s)
>>
>> 16675852216 does not fit into an int and wraps to roughly -504000000.
>> ns_to_ktime() then yields a negative interval and the timer stops
>> working.
>>
>> Found by bisection, which pointed at commit a036f5fceedb ("drm/virtgpu:
>> Use vblank timer"). That commit merely made virtio-gpu use the vblank
>> timer and thereby exposed the pre-existing problem in the timer setup
>> added by commit 74afeb812850 ("drm/vblank: Add vblank timer").
>>
>> To fix this, modify drm_calc_timestamping_constants() to use u64 for
>> calculations, check for INT_MAX overflows, and return an error code.
>> drm_crtc_vblank_start_timer() will then propagate the error, enabling
>> the driver to fall back to immediate vblank events. Valid modes are
>> unaffected, and the timer self-heals on the next mode with a sane clock.
>>
>> v4:
>> - avoid log spamming with drm_warn_once()
>>
>> Fixes: 74afeb812850 ("drm/vblank: Add vblank timer")
>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Signed-off-by: Roman Ilin <me@romanilin.is>
>> ---
>> I took Roman's patch from [1] and replaced the error messages with
>> warn_once, as suggestde in my review.
>>
>> [1] https://lore.kernel.org/dri-devel/20260702181027.98526-1-
>> me@romanilin.is/
>> ---
>>   drivers/gpu/drm/drm_vblank.c | 73 +++++++++++++++++++++++-------------
>>   include/drm/drm_vblank.h     |  4 +-
>>   2 files changed, 49 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
>> index f90fb2d13e42..72b543bca9e3 100644
>> --- a/drivers/gpu/drm/drm_vblank.c
>> +++ b/drivers/gpu/drm/drm_vblank.c
>> @@ -631,45 +631,54 @@ EXPORT_SYMBOL(drm_crtc_vblank_waitqueue);
>>    * drm_crtc_vblank_helper_get_vblank_timestamp(). They are derived from
>>    * CRTC's true scanout timing, so they take things like panel
>> scaling or
>>    * other adjustments into account.
>> + *
>> + * Returns:
>> + * 0 on success, or a negative errno code otherwise.
>>    */
>> -void drm_calc_timestamping_constants(struct drm_crtc *crtc,
>> -                     const struct drm_display_mode *mode)
>> +int drm_calc_timestamping_constants(struct drm_crtc *crtc,
>> +                    const struct drm_display_mode *mode)
>>   {
>>       struct drm_device *dev = crtc->dev;
>>       unsigned int pipe = drm_crtc_index(crtc);
>>       struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
>> -    int linedur_ns = 0, framedur_ns = 0;
>> +    u64 linedur_ns, framedur_ns;
>>       int dotclock = mode->crtc_clock;
>> +    unsigned int frame_size;
>>         if (!drm_dev_has_vblank(dev))
>> -        return;
>> +        return 0;
>>         if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
>> -        return;
>> +        return -EINVAL;
>>   -    /* Valid dotclock? */
>> -    if (dotclock > 0) {
>> -        int frame_size = mode->crtc_htotal * mode->crtc_vtotal;
>> +    if (dotclock <= 0) {
>> +        drm_err_once(dev, "crtc %u: Can't calculate constants,
>> dotclock = %d!\n",
>> +                 crtc->base.id, dotclock);
>> +        goto error;
>> +    }
>>   -        /*
>> -         * Convert scanline length in pixels and video
>> -         * dot clock to line duration and frame duration
>> -         * in nanoseconds:
>> -         */
>> -        linedur_ns  = div_u64((u64) mode->crtc_htotal * 1000000,
>> dotclock);
>> -        framedur_ns = div_u64((u64) frame_size * 1000000, dotclock);
>> +    frame_size = (unsigned int)mode->crtc_htotal * (unsigned
>> int)mode->crtc_vtotal;
>>   -        /*
>> -         * Fields of interlaced scanout modes are only half a frame
>> duration.
>> -         */
>> -        if (mode->flags & DRM_MODE_FLAG_INTERLACE)
>> -            framedur_ns /= 2;
>> -    } else {
>> -        drm_err(dev, "crtc %u: Can't calculate constants, dotclock =
>> 0!\n",
>> -            crtc->base.id);
>> +    /*
>> +     * Convert scanline length in pixels and video dot clock to line
>> duration
>> +     * and frame duration in nanoseconds.
>> +     */
>> +    linedur_ns  = div_u64((u64)mode->crtc_htotal * 1000000, dotclock);
>> +    framedur_ns = div_u64((u64)frame_size * 1000000, dotclock);
>> +
>> +    /*
>> +     * Fields of interlaced scanout modes are only half a frame
>> duration.
>> +     */
>> +    if (mode->flags & DRM_MODE_FLAG_INTERLACE)
>> +        framedur_ns /= 2;
>> +
>> +    if (linedur_ns > INT_MAX || framedur_ns > INT_MAX) {
>> +        drm_err_once(dev, "crtc %u: Can't calculate constants, mode
>> clock too small!\n",
>> +                 crtc->base.id);
>> +        goto error;
>>       }
>>   -    vblank->linedur_ns  = linedur_ns;
>> +    vblank->linedur_ns = linedur_ns;
>>       vblank->framedur_ns = framedur_ns;
>>       drm_mode_copy(&vblank->hwmode, mode);
>>   @@ -678,7 +687,16 @@ void drm_calc_timestamping_constants(struct
>> drm_crtc *crtc,
>>                crtc->base.id, mode->crtc_htotal,
>>                mode->crtc_vtotal, mode->crtc_vdisplay);
>>       drm_dbg_core(dev, "crtc %u: clock %d kHz framedur %d linedur %d\n",
>> -             crtc->base.id, dotclock, framedur_ns, linedur_ns);
>> +             crtc->base.id, dotclock,
>> +             vblank->framedur_ns, vblank->linedur_ns);
>> +
>> +    return 0;
>> +
>> +error:
>> +    vblank->linedur_ns = 0;
>> +    vblank->framedur_ns = 0;
>> +    drm_mode_copy(&vblank->hwmode, mode);
>> +    return -EINVAL;
>>   }
>>   EXPORT_SYMBOL(drm_calc_timestamping_constants);
>>   @@ -2221,6 +2239,7 @@ int drm_crtc_vblank_start_timer(struct
>> drm_crtc *crtc)
>>       struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
>>       struct drm_vblank_crtc_timer *vtimer = &vblank->vblank_timer;
>>       unsigned long flags;
>> +    int ret;
>>         if (!vtimer->crtc) {
>>           /*
>> @@ -2239,7 +2258,9 @@ int drm_crtc_vblank_start_timer(struct drm_crtc
>> *crtc)
>>               hrtimer_try_to_cancel(&vtimer->timer);
>>       }
>>   -    drm_calc_timestamping_constants(crtc, &crtc->mode);
>> +    ret = drm_calc_timestamping_constants(crtc, &crtc->mode);
>> +    if (ret)
>> +        return ret;
>>         spin_lock_irqsave(&vtimer->interval_lock, flags);
>>       vtimer->interval = ns_to_ktime(vblank->framedur_ns);
>> diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
>> index 2fcef9c0f5b1..d99772dfa034 100644
>> --- a/include/drm/drm_vblank.h
>> +++ b/include/drm/drm_vblank.h
>> @@ -311,8 +311,8 @@ void drm_crtc_vblank_on(struct drm_crtc *crtc);
>>   u64 drm_crtc_accurate_vblank_count(struct drm_crtc *crtc);
>>   void drm_crtc_vblank_restore(struct drm_crtc *crtc);
>>   -void drm_calc_timestamping_constants(struct drm_crtc *crtc,
>> -                     const struct drm_display_mode *mode);
>> +int drm_calc_timestamping_constants(struct drm_crtc *crtc,
>> +                    const struct drm_display_mode *mode);
>>   wait_queue_head_t *drm_crtc_vblank_waitqueue(struct drm_crtc *crtc);
>>   void drm_crtc_set_max_vblank_count(struct drm_crtc *crtc,
>>                      u32 max_vblank_count);
>>
>> base-commit: 06576c2b43750d990297b8ff1989b94ac72e855f
>> prerequisite-patch-id: 6729bb10d5e338678e78ccda2dd24f232a13cd22
>> prerequisite-patch-id: 9d94d20bd45967493b4dc339b58082e1c8da0f4f
>> prerequisite-patch-id: 6ac8d22df34db9e7d467b1ab95ad30f94841d5db
>> prerequisite-patch-id: f548dbde3f944ca3415c808be628719acebe898a
>> prerequisite-patch-id: 2ae91ee8e2bbcd33b8325be046e7214185aba6aa
>> prerequisite-patch-id: f97bbde08a9996d7c62ca3e3ebfcd387e50bc5c3
>> prerequisite-patch-id: ecc3c825277bc9978c6979455517249a074c0cb1
>> prerequisite-patch-id: 0449925cca36664b566f614bfb7d573a11f0575f
>> prerequisite-patch-id: 9fb2c2787244e9621847af09bea03e575e6276c7
>> prerequisite-patch-id: eb4384d581805e1178d22e7df45f134223c38305
>> prerequisite-patch-id: 1a7a529e4b2864abe8071aa44598d28ce72483f4
>> prerequisite-patch-id: 844a85f4c2fe2f72209b82d46614004c3cfe4123
>> prerequisite-patch-id: 13f7cb22114c648d35f8c9fa74e9165656ce31eb
>> prerequisite-patch-id: 20ee46bd6fdd91e39f71d22f52ef6682a4e41512
>> prerequisite-patch-id: 1d26c0ff91796ff1e62d3831d00bee18723788ef
>> prerequisite-patch-id: 007f6ea0d09bef54b689bae0eb5abeb497bdfaad
>> prerequisite-patch-id: 2d89c1507c909520adf9bfb1a137d458a819ae8f
>> prerequisite-patch-id: d90dc4134468870ab8ccbd71547c9552dff74fbd
>> prerequisite-patch-id: c67e5d886a47b7d0266d81100837557fda34cb24
>> prerequisite-patch-id: a5a973e527c88a5b47053d7a72aefe0b550197cb
>> prerequisite-patch-id: b9adc9622920a3e70168e672c2c92795b3e3a106
>> prerequisite-patch-id: 5030de433a01c2e99056cadb676a8e2ba35f055a
> 

The patch looks correct, though will be better to have a smaller diff 
that doesn't require LLM for a review.


-void drm_calc_timestamping_constants(struct drm_crtc *crtc,
-				     const struct drm_display_mode *mode)
+int drm_calc_timestamping_constants(struct drm_crtc *crtc,
+				    const struct drm_display_mode *mode)
  {
  	struct drm_device *dev = crtc->dev;
  	unsigned int pipe = drm_crtc_index(crtc);
  	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
-	int linedur_ns = 0, framedur_ns = 0;
+	u64 linedur_ns = 0, framedur_ns = 0;
  	int dotclock = mode->crtc_clock;

  	if (!drm_dev_has_vblank(dev))
-		return;
+		return 0;

  	if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
-		return;
+		return -EINVAL;

  	/* Valid dotclock? */
  	if (dotclock > 0) {
-		int frame_size = mode->crtc_htotal * mode->crtc_vtotal;
+		u64 frame_size = (u64)mode->crtc_htotal * mode->crtc_vtotal;

  		/*
  		 * Convert scanline length in pixels and video
  		 * dot clock to line duration and frame duration
  		 * in nanoseconds:
  		 */
  		linedur_ns  = div_u64((u64) mode->crtc_htotal * 1000000, dotclock);
-		framedur_ns = div_u64((u64) frame_size * 1000000, dotclock);
+		framedur_ns = div_u64(frame_size * 1000000, dotclock);

  		/*
  		 * Fields of interlaced scanout modes are only half a frame duration.
  		 */
  		if (mode->flags & DRM_MODE_FLAG_INTERLACE)
  			framedur_ns /= 2;
+
+		if (linedur_ns > INT_MAX || framedur_ns > INT_MAX) {
+			drm_err_once(dev, "crtc %u: Can't calculate constants, mode clock 
too small!\n",
+				     crtc->base.id);
+			linedur_ns = 0;
+			framedur_ns = 0;
+			dotclock = 0; /* reuse the existing error-logging branch below */
+		}
  	} else {
-		drm_err(dev, "crtc %u: Can't calculate constants, dotclock = 0!\n",
-			crtc->base.id);
+		drm_err_once(dev, "crtc %u: Can't calculate constants, dotclock = %d!\n",
+			     crtc->base.id, dotclock);
  	}

-- 
Best regards,
Dmitry
