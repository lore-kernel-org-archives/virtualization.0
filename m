Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F224DC32771
	for <virtualization@archiver.kernel.org>; Sun, 18 Sep 2022 16:08:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8DB0860B08;
	Sun, 18 Sep 2022 16:08:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8DB0860B08
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=lpYB/TsE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q8HvbyB8soi4; Sun, 18 Sep 2022 16:08:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 31F1360B57;
	Sun, 18 Sep 2022 16:08:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 31F1360B57
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13843C0032;
	Sun, 18 Sep 2022 16:08:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65B32C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Sep 2022 16:08:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 367FA60BF8
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Sep 2022 16:08:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 367FA60BF8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4y9PRGAkKI91
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Sep 2022 16:08:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7B612607B0
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7B612607B0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Sep 2022 16:08:12 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 o70-20020a17090a0a4c00b00202f898fa86so3950171pjo.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Sep 2022 09:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=SQeIEeTKzz2tge7ucOzZuMOMyPFYP+yglUJ/2B+K+z4=;
 b=lpYB/TsEbGNl8LtsT4Wx3Pjp5E/hR295wLjM4slCKBpcwzKNTGcNlR2xEcCsjHqhGw
 mpymbHP6ykvuiuqo+AQq32db7sqay5QUeWTyTMf/H65Ug/vKSfK3btKMbADoZGuXPkha
 GTvCj78XI6RPtYXwbpnygD6vg/5tHxeF+AXtlONwKRr1GpliYTOyZcenehuiaz8KUdUa
 A1CDyRYD8tdd1CvpAau54T8pBnUh7F00nFGkHUk7Is3FlSBCssjCQanH7tX5oAp5X+aJ
 ifyl1KK6TiR+o3PPhi45kBtByUIhydMqvuZOK4ifHQwKmXIF/gvTHJAuqmKCcdZWrOUe
 SrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=SQeIEeTKzz2tge7ucOzZuMOMyPFYP+yglUJ/2B+K+z4=;
 b=sZRcCV8zUCCIWqPTI+UObwH370YpiAhpnNVrlNbZbZwmS56YXt3rq8pP57IrJsPKlL
 XPeUsLnlGb+5lQRpXbvSQJj/Gu0M7S6zDDs6gDWwfRljkkjV6DDQBQZ/o9gPhoYto9tv
 1FFcQD24ZP1pWpB08Tm0ettCuo6BM6N5+0e1v3guSKaKB2DQGOdIp36bDE+LeifXtoSA
 CY7Z/PGi6ZX3t/xGPKBcT0sNQLLnPwlUpckDM3YGpvXx8pGDneAGkp60NWsd0+WZm/Nm
 fLIEItQ8t1znfP1p/EvUanVZqJBo9iQ+UF9jc7EZsO0YM9WED1k8G02XWxHh7CUA6bIV
 h7sQ==
X-Gm-Message-State: ACgBeo0b4g+nxs6S1dr6tF1z1rIkuv1TAYOhuZiMBA5u3ug41dm1z4yM
 MGgoEU4b4IUq7IL/SjeHqcSQ9heBE3x5RuOWMiiqTA==
X-Google-Smtp-Source: AMsMyM4cGjqrHEgYSVxRRyEyeNLBA+1SBShRDGstzVYHntvQWs6WFG8qLgUYFUEFO0prsiLv7ae087hHJruZsI7ZWCg=
X-Received: by 2002:a17:90a:ba01:b0:200:8769:1c34 with SMTP id
 s1-20020a17090aba0100b0020087691c34mr26381060pjr.0.1663517291794; Sun, 18 Sep
 2022 09:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220829082313.419220-1-alvaro.karsz@solid-run.com>
 <20220918091848-mutt-send-email-mst@kernel.org>
 <CAJs=3_B4sTo-X9ZkqAZjzLi0EGRNW_jwUtgUBj17p907qVkNoQ@mail.gmail.com>
 <20220918110951-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220918110951-mutt-send-email-mst@kernel.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Sun, 18 Sep 2022 19:07:34 +0300
Message-ID: <CAJs=3_AdHBZZKXypXh=wZDB58jADyoec6RnH42b_-UphPqFGSA@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_blk: add SECURE ERASE command support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 stefanha@redhat.com, virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

> sounds good. Add a code comment?

I will.

>  yes but I now see two places that seem to include this logic.


Yes, this is because the same logic is applied on 2 different pairs.

* secure_erase_sector_alignment and discard_sector_alignment are used
to calculate  q->limits.discard_granularity.
* max_discard_seg and max_secure_erase_seg are used to calculate
max_discard_segments.

> I am not 100% sure. Two options:
> 1- Add a validate callback and clear VIRTIO_BLK_F_SECURE_ERASE.
> 2- Alternatively, fail probe.


Good ideas.
2- Do you think that something like that should be mentioned in the
spec? or should be implementation specific?

How about setting the value to 1? (which is the minimum usable value)

> which is preferable depends on how bad is it if host sets
> VIRTIO_BLK_F_SECURE_ERASE but guest does not use it.


I'm not sure if it is that bad.
If the value is 0, sg_elems is used.
sg_elems is either 1 (if VIRTIO_BLK_F_SEG_MAX is not negotiated), or
seg_max (virtio config).

"""
err = virtio_cread_feature(vdev, VIRTIO_BLK_F_SEG_MAX,
                                          struct virtio_blk_config, seg_max,
                                          &sg_elems);
/* We need at least one SG element, whatever they say. */
if (err || !sg_elems)
         sg_elems = 1;
"""

So the only "danger" that I can think of is if a device negotiates
VIRTIO_BLK_F_SEG_MAX and  VIRTIO_BLK_F_SECURE_ERASE, sets
max_secure_erase_seg to 0 (I'm not sure what is the purpose, since
this is meaningless), and can't handle secure erase commands with
seg_max segments.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
