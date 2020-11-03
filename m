Return-Path: <SRS0=JeE0=EJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE232C4742C
	for <virtualization@archiver.kernel.org>; Tue,  3 Nov 2020 10:54:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35A9022403
	for <virtualization@archiver.kernel.org>; Tue,  3 Nov 2020 10:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1nxH0jD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A9022403
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2B9672076F;
	Tue,  3 Nov 2020 10:54:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EVSfkdE6o+qd; Tue,  3 Nov 2020 10:54:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CA44D2075B;
	Tue,  3 Nov 2020 10:54:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7BE5C0889;
	Tue,  3 Nov 2020 10:54:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5416FC0051
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 10:54:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3E081860D2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 10:54:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CmBEuLMVeIep
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 10:54:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 98CF3860D1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 10:54:25 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id a200so13842869pfa.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 03 Nov 2020 02:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Pr70uaXWQ5V9OEnpZUw1+PkE5bFME26YS/kMKBh3/j4=;
 b=Z1nxH0jDHYEqq8hm0bVNqvQCGIZiEpIpb3zSwcYXQieBLtra1nCwDJgpu5pP89uJzE
 AkhrBgNlD6HCyN456iYZGK8zXMn2VqjNio/0ngfT65e6vFKeH9P/k+YNx0fz0NX90SQM
 JId+N9RTHwMw0LwsVjrJ0K/iWTlm+/5RRX+O/Qjs6Unhw7bP80fuwGuRg+eAD4HDASkn
 xBbZ2MPC8C7aomhpP8xQDtCO64OoJw54a0Ax1nTLubP8Yh2DLws0e+6UO7/9eRpRrt3U
 p4wJZFBQok7bOE/bbaJc+Lng79kYbok1iizF3WW9gFugdQUddODfxMzleDA0d88pCHQj
 0aaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Pr70uaXWQ5V9OEnpZUw1+PkE5bFME26YS/kMKBh3/j4=;
 b=GkZurH/vQfuJ+C6xrVPS9KQkPxU8cPm3WTg2ZE3/tTOM+kvGUOIBW4JBkm1utnVS1q
 aoFr/BRwlSaWZGm+60beFBXrhvjOc0PbN6wuVjyqbfpmVhVbZw0ImOb0Jq6WzC6dyqSQ
 3fzuOS7qfSavLxFf1tlPw+Yh3U24ZJvitBk0MMQKljUqKfh6ZnCtGkJ44KqELzKgGSjx
 XLih9SV2XdXYFX9zVzT7XRIowBPery98XTyNUZVzr1aAOygDITO3NHoRD5/K833UYCt9
 lh+F+/JUgpibbs+0t+Ab2+GbNVcYsVSL+IVm11fRTrm8/d+c81zOnrBt65XI+vJOzLSa
 tjcA==
X-Gm-Message-State: AOAM533Z1BpY/v3iqKERByxdyFP8sH7OjrGZKBcEEEwfxXYNpHMEZoCC
 nuHSV+hwGFT/X5VViM41mGopM3Lny9Tzt8AdETE=
X-Google-Smtp-Source: ABdhPJzFEjyEEdc+kSmf/T1nHeNhjOJHPnuC+7t9Znx2RJFmaAHHYOf4fCTxwiGuX4v/1cJJtqmJw1ySNSiuUS5bxLE=
X-Received: by 2002:a17:90a:430b:: with SMTP id
 q11mr3222009pjg.129.1604400865170; 
 Tue, 03 Nov 2020 02:54:25 -0800 (PST)
MIME-Version: 1.0
References: <20201102152037.963-1-brgl@bgdev.pl>
 <21d80265fccfcb5d76851c84d1c2d88e0421ab85.camel@perches.com>
 <CAMRc=Me4-4Cmoq3UdpYEEhERP6fvt97bEJsZYhrcFSQf+a_voA@mail.gmail.com>
In-Reply-To: <CAMRc=Me4-4Cmoq3UdpYEEhERP6fvt97bEJsZYhrcFSQf+a_voA@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 3 Nov 2020 12:55:14 +0200
Message-ID: <CAHp75VdpriwuktGrMpcXXQuHgfDL6SzqmQTsGFNKLBb=QiKuGg@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] slab: provide and use krealloc_array()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>,
 "open list:VFIO DRIVER" <kvm@vger.kernel.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>,
 Gustavo Padovan <gustavo@padovan.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
 Jaroslav Kysela <perex@perex.cz>, linux-mm <linux-mm@kvack.org>,
 Christoph Lameter <cl@linux.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 David Rientjes <rientjes@google.com>,
 virtualization@lists.linux-foundation.org,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Robert Richter <rric@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, linaro-mm-sig@lists.linaro.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Borislav Petkov <bp@alien8.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-edac@vger.kernel.org,
 Tony Luck <tony.luck@intel.com>, netdev <netdev@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Pekka Enberg <penberg@kernel.org>, James Morse <james.morse@arm.com>,
 Daniel Vetter <daniel@ffwll.ch>, Joe Perches <joe@perches.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Tue, Nov 3, 2020 at 12:13 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> On Tue, Nov 3, 2020 at 5:14 AM Joe Perches <joe@perches.com> wrote:
> > On Mon, 2020-11-02 at 16:20 +0100, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

> Yeah so I had this concern for devm_krealloc() and even sent a patch
> that extended it to honor __GFP_ZERO before I noticed that regular
> krealloc() silently ignores __GFP_ZERO. I'm not sure if this is on
> purpose. Maybe we should either make krealloc() honor __GFP_ZERO or
> explicitly state in its documentation that it ignores it?

And my voice here is to ignore for the same reasons: respect
realloc(3) and making common sense with the idea of REallocating
(capital letters on purpose).

-- 
With Best Regards,
Andy Shevchenko
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
