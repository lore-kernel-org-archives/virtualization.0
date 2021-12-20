Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17E5C43217
	for <virtualization@archiver.kernel.org>; Mon, 20 Dec 2021 15:35:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 55C1E409B2;
	Mon, 20 Dec 2021 15:35:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SDBOxqP5iAKF; Mon, 20 Dec 2021 15:35:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DCD01402D2;
	Mon, 20 Dec 2021 15:35:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B490CC001E;
	Mon, 20 Dec 2021 15:35:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 262C6C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 15:35:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1280640936
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 15:35:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1fYB1ENYSj2z
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 15:35:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2D4BA40643
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 15:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1640014515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gdAKE7AYio9k8Fn74B3MejAzlS0bLe3U5EfQ2P/VNeg=;
 b=KS0SEEAUouCZ20HBqVxAy+zLnrIUlDfw3i14KiL7eFInt7MEVues08XgFWI3uGDwJSE+WZ
 Q6CJVJC//qzwScCjuLJl1uP3RdGHtRB9/h5OMwXOV6Qjy3eOnf3ZhbG7PiuKvzPN0zHoTW
 Ai9sBwR7g0BRp3iAXXwCvNEwxZ5/PwI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-463-stid1RQNPo-gOzYZrzPaaQ-1; Mon, 20 Dec 2021 10:35:14 -0500
X-MC-Unique: stid1RQNPo-gOzYZrzPaaQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 e19-20020a05600c4e5300b003458be97976so76725wmq.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 07:35:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gdAKE7AYio9k8Fn74B3MejAzlS0bLe3U5EfQ2P/VNeg=;
 b=RCrZ6ZmFshSd4Yt6l8TprJK6IJIeWgcsbs0uMMhAz0w2LTRuGCbqv5d5GHCjsWekbG
 DscNgxNvs6Ba8nvgZh8oBBDG8sC5GJ2pHh24ZdW4IJ23Pc8sEa9MQ+NhOA9+2NmeDQ/A
 9sa1Lbstexsb6c9qtU/IuWLvxir0IeO9rteMxOPQ3G+SHglxnssBJQqvo9/LdBTDNVNP
 37kTUoQC+efaGnxb61ZWfhg6IVt3cCgHliv8rqHcPpBWqJdl7LM3egNtTak8V8c1h8+L
 d80ZkdM/j/c/c3OVkpgrcADq6ZomQD6A4JDRE4r4OIq/qF6nHuUJNB2zdwituczflQUm
 aEjQ==
X-Gm-Message-State: AOAM530ve1RRlDINot/LBEIlZZn03BmLlbroSMwfNhEJw+R6GLmOwAM+
 Cdu5kX7Rrv+7jVh8ZDAAizgll9uHzdKIcjVLBv20+Bzszho29U/S+xfpVhCzsoZkpGiDbrGrVR0
 ut63cXxNprcbTFntcYPY4KXP0g7SfEphgr9vO+vCRdg==
X-Received: by 2002:adf:e0c7:: with SMTP id m7mr13526821wri.530.1640014513236; 
 Mon, 20 Dec 2021 07:35:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwY85XN14lZIx//9XWyWKXq9VFYx9aU4mVKF0Hv69ur1LO8PZVlFRSmrdNUnFmEaoz9rSr1vg==
X-Received: by 2002:adf:e0c7:: with SMTP id m7mr13526807wri.530.1640014513055; 
 Mon, 20 Dec 2021 07:35:13 -0800 (PST)
Received: from redhat.com ([2.55.19.224])
 by smtp.gmail.com with ESMTPSA id o7sm1473124wrc.89.2021.12.20.07.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Dec 2021 07:35:12 -0800 (PST)
Date: Mon, 20 Dec 2021 10:35:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH] gpio: virtio: remove timeout
Message-ID: <20211220103435-mutt-send-email-mst@kernel.org>
References: <20211220130656.16900-1-vincent.whitchurch@axis.com>
 <CAMRc=MeEnSvSxQe-DdLSujSLpzxa-bacJ590BW+tt8awAJq3_w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMRc=MeEnSvSxQe-DdLSujSLpzxa-bacJ590BW+tt8awAJq3_w@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, kernel@axis.com,
 Viresh Kumar <viresh.kumar@linaro.org>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>
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

On Mon, Dec 20, 2021 at 03:54:56PM +0100, Bartosz Golaszewski wrote:
> On Mon, Dec 20, 2021 at 2:07 PM Vincent Whitchurch
> <vincent.whitchurch@axis.com> wrote:
> >
> > The driver imposes an arbitrary one second timeout on virtio requests,
> > but the specification doesn't prevent the virtio device from taking
> > longer to process requests, so remove this timeout to support all
> > systems and device implementations.
> >
> > Fixes: 3a29355a22c0275fe86 ("gpio: Add virtio-gpio driver")
> > Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> > ---
> >  drivers/gpio/gpio-virtio.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
> > index 84f96b78f32a..9f4941bc5760 100644
> > --- a/drivers/gpio/gpio-virtio.c
> > +++ b/drivers/gpio/gpio-virtio.c
> > @@ -100,11 +100,7 @@ static int _virtio_gpio_req(struct virtio_gpio *vgpio, u16 type, u16 gpio,
> >         virtqueue_kick(vgpio->request_vq);
> >         mutex_unlock(&vgpio->lock);
> >
> > -       if (!wait_for_completion_timeout(&line->completion, HZ)) {
> > -               dev_err(dev, "GPIO operation timed out\n");
> > -               ret = -ETIMEDOUT;
> > -               goto out;
> > -       }
> > +       wait_for_completion(&line->completion);
> >
> >         if (unlikely(res->status != VIRTIO_GPIO_STATUS_OK)) {
> >                 dev_err(dev, "GPIO request failed: %d\n", gpio);
> > --
> > 2.33.1
> >
> 
> My knowledge of virtio is limited, I hope this is not a stupid question.
> 
> Does this mean the operation can get stuck indefinitely?
> 
> Bart

Only if the device is broken. which given it's part of the
hypervisor, is par for the course.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
