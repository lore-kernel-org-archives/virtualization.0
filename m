Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34B3C433FE
	for <virtualization@archiver.kernel.org>; Mon, 17 Oct 2022 07:26:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 319F260F30;
	Mon, 17 Oct 2022 07:26:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 319F260F30
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fnpqQp+x
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3BjTToudFUHo; Mon, 17 Oct 2022 07:26:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9AD0A6066D;
	Mon, 17 Oct 2022 07:26:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9AD0A6066D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C8CCC0032;
	Mon, 17 Oct 2022 07:26:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16770C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 07:26:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D1DED8141D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 07:26:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D1DED8141D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fnpqQp+x
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jhd6HPRhStF4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 07:26:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 21AC8813E7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 21AC8813E7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 07:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665991608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jzHHtp1ZSGFjlESMf3eOTJgOagYNRrxl5KAQ7lqLu5A=;
 b=fnpqQp+xGx2v3NVZyHfUyVR8ps8biIIZK4dwuNS63qXs64wLh9rCs0aRTs1H9Ndl3RJYQa
 JSxcjoUyk6EQ6P21BjhQ252R+NryZpGp7l++QMweHF2tvQW8j3F/mvDUgXQqdoZzBDSeVj
 dPPQrQbb0JI62CRbdZsVuizEqfo/29k=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-509-37cSP3xLMEuqUjo6qsiOzQ-1; Mon, 17 Oct 2022 03:26:47 -0400
X-MC-Unique: 37cSP3xLMEuqUjo6qsiOzQ-1
Received: by mail-ot1-f70.google.com with SMTP id
 y25-20020a9d6359000000b00655ffb2ca00so4613194otk.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 00:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jzHHtp1ZSGFjlESMf3eOTJgOagYNRrxl5KAQ7lqLu5A=;
 b=ZBRSaudWfj2EUlfwjazR9hmMvavU98OyNbhRtsGzeMHONVnEw6oEqIJwzVJYfSTC2e
 e8j/Uv3Ohm0BZOXVb+tI6Myl6lR6deWNR8VtmtPdiItMltCh2FsNTzX1sOe9mCnuFPq8
 a6WxjFL8PNEreAzYEo/UN6LcHFsqmgOkKRpl3TA+UCMCYiQHt2WVYmAGw8qsb4toTHSg
 Q5hrM/zOtSZRaB19O3WnQObL25AOdcKetvpkvERqIEZ0fN6ELmUB0G0m+CynRZllqLF8
 20mmLfuImZ5HuHbAlzlkjXE7+uOjPvnnprTv83BGv+YbjjP1UaGUXMgbDuRRuuBQmMLH
 DPuA==
X-Gm-Message-State: ACrzQf1mr9quzflYKTEqXU5Ep/udH8mYMh9p/fi/j+AdzBbG6GZf4LJr
 i9pfGohinff2/+AAm5OMcvVWJqEuD5hTl740aowMnjOglbtoNOw5YmlKsFoED8DGVyJDoUCaoWF
 pFoRrXsJhBUIg+P08hyyAJLuH+INEbQ8YNh5hazNgETDU6XJfbWHYvTrICQ==
X-Received: by 2002:a9d:7dcf:0:b0:661:dc25:ba0 with SMTP id
 k15-20020a9d7dcf000000b00661dc250ba0mr4378750otn.201.1665991606923; 
 Mon, 17 Oct 2022 00:26:46 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5qoY261irP2g1xWJhX8pYqgmVUg3PNamZTqnUNk+l5hxLBm7WYh4D7onTaFKu2hD3ehHnJjnM4GCBENSJGGy8=
X-Received: by 2002:a9d:7dcf:0:b0:661:dc25:ba0 with SMTP id
 k15-20020a9d7dcf000000b00661dc250ba0mr4378738otn.201.1665991606742; Mon, 17
 Oct 2022 00:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1665745877.git.sebastien.boeuf@intel.com>
 <bdbf1921652c93e372b1e283cd9367a9b5f31447.1665745877.git.sebastien.boeuf@intel.com>
In-Reply-To: <bdbf1921652c93e372b1e283cd9367a9b5f31447.1665745877.git.sebastien.boeuf@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Oct 2022 15:26:35 +0800
Message-ID: <CACGkMEvwpt6=hVyZ1aB-oAnt=Wgr158OKvp3_eKqKxJcuJB_7w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] vdpa_sim: Implement resume vdpa op
To: sebastien.boeuf@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: eperezma@redhat.com, mst@redhat.com,
 virtualization@lists.linux-foundation.org
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

On Fri, Oct 14, 2022 at 7:15 PM <sebastien.boeuf@intel.com> wrote:
>
> From: Sebastien Boeuf <sebastien.boeuf@intel.com>
>
> Implement resume operation for vdpa_sim devices, so vhost-vdpa will
> offer that backend feature and userspace can effectively resume the
> device.
>
> Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index b071f0d842fb..195dc60bad3c 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -527,6 +527,17 @@ static int vdpasim_suspend(struct vdpa_device *vdpa)
>         return 0;
>  }
>
> +static int vdpasim_resume(struct vdpa_device *vdpa)
> +{
> +       struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> +
> +       spin_lock(&vdpasim->lock);
> +       vdpasim->running = true;
> +       spin_unlock(&vdpasim->lock);

Do we need to schedule work here? Or the assumption is that the
individual should take care to make sure no kick is lost during a
suspend/resume?

Thanks

> +
> +       return 0;
> +}
> +
>  static size_t vdpasim_get_config_size(struct vdpa_device *vdpa)
>  {
>         struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> @@ -717,6 +728,7 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
>         .set_status             = vdpasim_set_status,
>         .reset                  = vdpasim_reset,
>         .suspend                = vdpasim_suspend,
> +       .resume                 = vdpasim_resume,
>         .get_config_size        = vdpasim_get_config_size,
>         .get_config             = vdpasim_get_config,
>         .set_config             = vdpasim_set_config,
> @@ -750,6 +762,7 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
>         .set_status             = vdpasim_set_status,
>         .reset                  = vdpasim_reset,
>         .suspend                = vdpasim_suspend,
> +       .resume                 = vdpasim_resume,
>         .get_config_size        = vdpasim_get_config_size,
>         .get_config             = vdpasim_get_config,
>         .set_config             = vdpasim_set_config,
> --
> 2.34.1
>
> ---------------------------------------------------------------------
> Intel Corporation SAS (French simplified joint stock company)
> Registered headquarters: "Les Montalets"- 2, rue de Paris,
> 92196 Meudon Cedex, France
> Registration Number:  302 456 199 R.C.S. NANTERRE
> Capital: 5 208 026.16 Euros
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
