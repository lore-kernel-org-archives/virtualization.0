Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21A0199B0
	for <virtualization@lists.linux-foundation.org>; Wed, 14 Feb 2024 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910231; cv=none; b=MVj8H+8UwTEiwAN0dSpygX0lwD7TInSZ3sGzxDGqnspaqtQLniQhz6ZGhINAkdfVFoJi/1edxm9/lGQ4rRgQJqUSMYHYwJTKFfa3WNgbpQSWf7c8vN8S74+D947RSkWyHw/yvBK5QTnlH7eWBw3r5fTd8FspGp06YRwrc8KgHng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910231; c=relaxed/simple;
	bh=wA+l9FLOXe7DpldMydeqojyZQuQ0PE/xvA/Dhu62gk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=oc6NeRuPdQ3a+zkHHZ8jA5Ru4VbW6Oo5IpMsaUU6GS0oKGM8cgXRmBWONktz1Q7gU7ku4pKa1tXFJeMV+DcrTtauuwpZ8YPxie0yg8h0wST/x+DHIgPwENSU9IvnbKVkIHIri8ldm9MEKWaQzA/oxQ75AYenTLinPVUsaXnS5FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JnELTRJR; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JnELTRJR"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 50A5282339
	for <virtualization@lists.linux-foundation.org>; Wed, 14 Feb 2024 11:30:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hxQ70AYqkJxY
	for <virtualization@lists.linux-foundation.org>;
	Wed, 14 Feb 2024 11:30:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5154282335
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5154282335
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JnELTRJR
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5154282335
	for <virtualization@lists.linux-foundation.org>; Wed, 14 Feb 2024 11:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707910226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4+JlxetLqGfgXIuO+M860n27Ubw/CGDuUo/QeS89UmM=;
	b=JnELTRJR7mzqN0jr2uDcOewR+vTV1ZtcwBd8DxJj8/bJg2c30OFCynEIB1DaNoiBedKACP
	wIcNCmfK6ZZ4od0WrRJFKp6QWdCbCLzAyzkkqLhMsZ4HkN5kJpnc/QFdtmmZJKU5O9LFN1
	Mo52ta9kY7XNX+ViSTS59yuvw5HOqlQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-YJkkSsZ_OGaPB7cPmYGP7g-1; Wed, 14 Feb 2024 06:30:25 -0500
X-MC-Unique: YJkkSsZ_OGaPB7cPmYGP7g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33b2238ce45so2548784f8f.1
        for <virtualization@lists.linux-foundation.org>; Wed, 14 Feb 2024 03:30:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707910224; x=1708515024;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4+JlxetLqGfgXIuO+M860n27Ubw/CGDuUo/QeS89UmM=;
        b=ou8uB3FkEOUOsNwwOuuG9+cPafpI1cIaLg9v8ay4u2xz+qiaKvdmJhkNjvJEhXIsBr
         rlgwG3Rq+i2e47bpAVvzTNkqnEUnPAtkkVZ4C/1TKWYER3jh2QL/ilD3IrK8dSRl2MpH
         KMlW8fXzZG4Msdpiv5jWsn97pVuqa4IB1p9+Dr9s8GUYTdCPfcca1sML72Tbg53MzgKD
         /QxbreEK4Fn1GFNWZEXWMEULayQ0c/fLe9lVAxkHs6WzdB6si3I2LrRzdthZwhlvhT6Y
         eKy9LBBum/qS7SFI2tx8LdJAAvJXdv5cvCtKB9AVwus+DHQvu+pz7KMp5O2wh4cDpWxF
         jPFw==
X-Forwarded-Encrypted: i=1; AJvYcCVtrPL3+bUlJ9ZuWgxmopjaEN0fOgoZ8Ff5lUonuouDRJ29J8zStIhtMZiUXjVlm0WO/9Y3XkHBfCtzTUzeiW2n/nDapXDwVpL6LVbMWSwati6P8iik7DBM/w==
X-Gm-Message-State: AOJu0YztznKeAq3DLDfbVqms4dDJFyIqV7ST5AKtn6ra99M1cFaHq51o
	GUQd77AWMgGtHFWqe8XYJt2ykDqaXeeVBqcsB3M/Od8zsOjp1BubLp3RhbPFzX9DuGFx2TO6U8n
	QxMW/JI+tUlVdn+jLCVu2xhaYeSjmcOsxp4wiJEdgMyP2A1ql7Ceyh6m9CfGzy7X20hVuTnokex
	MAUYg=
X-Received: by 2002:a5d:6ac3:0:b0:33c:e323:ce39 with SMTP id u3-20020a5d6ac3000000b0033ce323ce39mr1560148wrw.43.1707910224270;
        Wed, 14 Feb 2024 03:30:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFn/7CRCNOkTTcJ4FiqDJfiAfmidzS77K5Cp7PsBHxs2ygLXQq31lQk0BgMb5mWCWD9xGG0qA==
X-Received: by 2002:a5d:6ac3:0:b0:33c:e323:ce39 with SMTP id u3-20020a5d6ac3000000b0033ce323ce39mr1560128wrw.43.1707910223905;
        Wed, 14 Feb 2024 03:30:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWDnOrhIMIku8GYfeG5v1QLOIsqpsWLfcFAOxVRTDhWd4QHsJdvn9P/TrtDxxxBc5KEnbVU6j3LWFAgjhA1jUcxp0j32JICPff8+5mX7ke+dqKNjuPGzOi0r3t9rXz9ZrkKP3IOSMM73xsEmNcdk3Br2n7mU2CLbwbFwadQowLPHTmDYFMei2PBySartjQ7qVVffGVKBNNspJnDCQA33QhmhyfShe2Ov1Vfv94C3JkXVHYkJUoo5o6VbuKYmi1st5dmbWrMiZI7VJFotHgrnDIO7eG96f7NfrGTNgDZUjUaq49+bDKxHftvXzUS8hK+BGdysLHtSQcnr2WW9PKk4jyacZVONaQ1unbKeGlva3vCkh+/41CY9jyXysZ4BnkrMDIrW3pCazO+tOomCvo47s2hM6OVxxBFtFHMccATLCMXWLYN
Received: from redhat.com ([2.52.26.67])
        by smtp.gmail.com with ESMTPSA id g7-20020a5d5407000000b003392206c808sm12083778wrv.105.2024.02.14.03.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 03:30:23 -0800 (PST)
Date: Wed, 14 Feb 2024 06:30:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Aiswarya Cyriac <Aiswarya.Cyriac@opensynergy.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
	"perex@perex.cz" <perex@perex.cz>,
	"tiwai@suse.com" <tiwai@suse.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
	coverity-bot <keescook+coverity-bot@chromium.org>,
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>
Subject: Re: [PATCH] ALSA: virtio: Fix "Coverity: virtsnd_kctl_tlv_op():
 Uninitialized variables" warning.
Message-ID: <20240214062348-mutt-send-email-mst@kernel.org>
References: <20240213085131.503569-1-aiswarya.cyriac@opensynergy.com>
 <20240213035806-mutt-send-email-mst@kernel.org>
 <FR3P281MB25272BA9CC886E270EEAE380E64E2@FR3P281MB2527.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <FR3P281MB25272BA9CC886E270EEAE380E64E2@FR3P281MB2527.DEUP281.PROD.OUTLOOK.COM>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Feb 14, 2024 at 09:08:26AM +0000, Aiswarya Cyriac wrote:
> Hi Michael,
> 
> Thank you for reviewing. I have updated my response inline
> 
> On Tue, Feb 13, 2024 at 09:51:30AM +0100, Aiswarya Cyriac wrote:
> >> Fix the following warning when building virtio_snd driver.
> >>
> >> "
> >> *** CID 1583619:  Uninitialized variables  (UNINIT)
> >> sound/virtio/virtio_kctl.c:294 in virtsnd_kctl_tlv_op()
> >> 288
> >> 289         break;
> >> 290       }
> >> 291
> >> 292       kfree(tlv);
> >> 293
> >> vvv     CID 1583619:  Uninitialized variables  (UNINIT)
> >> vvv     Using uninitialized value "rc".
> >> 294       return rc;
> >> 295     }
> >> 296
> >> 297     /**
> >> 298      * virtsnd_kctl_get_enum_items() - Query items for the ENUMERATED element type.
> >> 299      * @snd: VirtIO sound device.
> >> "
> >>
> >> Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> >> Signed-off-by: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
> >> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> >> Addresses-Coverity-ID: 1583619 ("Uninitialized variables")
> >> Fixes: d6568e3de42d ("ALSA: virtio: add support for audio controls")
> 
> >I don't know enough about ALSA to say whether the patch is correct.  But
> >the commit log needs work: please, do not "fix warnings" - analyse the
> >code and explain whether there is a real issue and if yes what is it
> >and how it can trigger. Is an invalid op_flag ever passed?
> >If it's just a coverity false positive it might be ok to
> >work around that but document this.
> 
> This warning is caused by the absence of the "default" branch in the
> switch-block, and is a false positive because the kernel calls
> virtsnd_kctl_tlv_op() only with values for op_flag processed in
> this block.

Well we don't normally have functions validate inputs.
In this case I am not really sure we should bother
with adding dead code. If you really want to, add BUG_ON.



> I will update the fix and send a v2 patch
> 
> >> ---
> >>  sound/virtio/virtio_kctl.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/sound/virtio/virtio_kctl.c b/sound/virtio/virtio_kctl.c
> >> index 0c6ac74aca1e..d7a160c5db03 100644
> >> --- a/sound/virtio/virtio_kctl.c
> >> +++ b/sound/virtio/virtio_kctl.c
> >> @@ -286,6 +286,11 @@ static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
> >>                else
> >>                        rc = virtsnd_ctl_msg_send(snd, msg, &sg, NULL, false);
> >>
> >> +             break;
> >> +     default:
> >> +             virtsnd_ctl_msg_unref(msg);
> >> +             rc = -EINVAL;
> >> +
> 
> >There's already virtsnd_ctl_msg_unref call above.
> >Also don't we need virtsnd_ctl_msg_unref on other error paths
> >such as EFAULT?
> >Unify error handling to fix it all then?
> 
> This also need to be handled and virtsnd_ctl_msg_unref needed in case of EFAULT as well.
> I will update the patch.
> 
> 
> Thanks,
> Aiswarya Cyriac
> Software Engineer
> ​
> OpenSynergy GmbH
> Rotherstr. 20, 10245 Berlin
> 
> EMail: aiswarya.cyriac@opensynergy.com
> 
> www.opensynergy.com
> Handelsregister/Commercial Registry: Amtsgericht Charlottenburg, HRB 108616B
> Geschäftsführer/Managing Director: Régis Adjamah
> 
> ________________________________________
> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, February 13, 2024 10:06 AM
> To: Aiswarya Cyriac
> Cc: jasowang@redhat.com; perex@perex.cz; tiwai@suse.com; linux-kernel@vger.kernel.org; alsa-devel@alsa-project.org; virtualization@lists.linux-foundation.org; virtio-dev@lists.oasis-open.org; Anton Yakovlev; coverity-bot
> Subject: Re: [PATCH] ALSA: virtio: Fix "Coverity: virtsnd_kctl_tlv_op(): Uninitialized variables" warning.
> 
> On Tue, Feb 13, 2024 at 09:51:30AM +0100, Aiswarya Cyriac wrote:
> > Fix the following warning when building virtio_snd driver.
> >
> > "
> > *** CID 1583619:  Uninitialized variables  (UNINIT)
> > sound/virtio/virtio_kctl.c:294 in virtsnd_kctl_tlv_op()
> > 288
> > 289         break;
> > 290       }
> > 291
> > 292       kfree(tlv);
> > 293
> > vvv     CID 1583619:  Uninitialized variables  (UNINIT)
> > vvv     Using uninitialized value "rc".
> > 294       return rc;
> > 295     }
> > 296
> > 297     /**
> > 298      * virtsnd_kctl_get_enum_items() - Query items for the ENUMERATED element type.
> > 299      * @snd: VirtIO sound device.
> > "
> >
> > Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> > Signed-off-by: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
> > Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> > Addresses-Coverity-ID: 1583619 ("Uninitialized variables")
> > Fixes: d6568e3de42d ("ALSA: virtio: add support for audio controls")
> 
> I don't know enough about ALSA to say whether the patch is correct.  But
> the commit log needs work: please, do not "fix warnings" - analyse the
> code and explain whether there is a real issue and if yes what is it
> and how it can trigger. Is an invalid op_flag ever passed?
> If it's just a coverity false positive it might be ok to
> work around that but document this.
> 
> 
> > ---
> >  sound/virtio/virtio_kctl.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/sound/virtio/virtio_kctl.c b/sound/virtio/virtio_kctl.c
> > index 0c6ac74aca1e..d7a160c5db03 100644
> > --- a/sound/virtio/virtio_kctl.c
> > +++ b/sound/virtio/virtio_kctl.c
> > @@ -286,6 +286,11 @@ static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
> >               else
> >                       rc = virtsnd_ctl_msg_send(snd, msg, &sg, NULL, false);
> >
> > +             break;
> > +     default:
> > +             virtsnd_ctl_msg_unref(msg);
> > +             rc = -EINVAL;
> > +
> 
> There's already virtsnd_ctl_msg_unref call above.
> Also don't we need virtsnd_ctl_msg_unref on other error paths
> such as EFAULT?
> Unify error handling to fix it all then?
> 
> >               break;
> >       }
> >
> > --
> > 2.43.0
> 
> 

