Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E86EC433F5
	for <virtualization@archiver.kernel.org>; Thu, 24 Mar 2022 02:34:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2791B60A6B;
	Thu, 24 Mar 2022 02:34:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yJJ_yeE9oeKr; Thu, 24 Mar 2022 02:34:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C72AA60A70;
	Thu, 24 Mar 2022 02:34:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82271C0012;
	Thu, 24 Mar 2022 02:34:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E544C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 02:34:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 18946400C6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 02:34:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tVoQggJbZYx9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 02:34:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AA3A7400C1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 02:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648089263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wZgZoSoq2Ajh3ptSZyqEaLy0ew178lVliWAwMQIyGhQ=;
 b=cXjVBGwMv7vKbb3zUtHISghkILdKHR7FrkbyJWDLcBeZSaLMy2R88ODB9ofC+AtkbaEUyM
 kWZ1R79NhMu3mlfEMbDw3eEseBd8JlJmhrQRDNAXWwylPoxLqIl9LCDaBE6JQ0tXnAJMMV
 kRSXpgtLTNKTnk2w+1kVTOMjuUGY4JU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-347-5dfSTc-gOYuIqhbz-wdGQw-1; Wed, 23 Mar 2022 22:34:22 -0400
X-MC-Unique: 5dfSTc-gOYuIqhbz-wdGQw-1
Received: by mail-lf1-f71.google.com with SMTP id
 w25-20020a05651234d900b0044023ac3f64so1228694lfr.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 19:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wZgZoSoq2Ajh3ptSZyqEaLy0ew178lVliWAwMQIyGhQ=;
 b=NyTRMBsSMKo+O8UhFBpW8cSrkDcqQTIDSIux0/iDjrVQCdvqnnsOSaiipVpEXjqWRf
 3FnB6GqTwXtNheY7+qOwW/7FVaHWRwUsoMfp0+ZUJJbg9MmbcHTqdOTKEgd2+n2eMgdV
 BY8c4XJ3kKy2V81DUQfuC8Vt3EYJYQzEcnFAT5yeOlnLLSvZ/+YYlyEFWGOCOyP5t24r
 34fNmBLGp6TQtL4NuvBUKreqoZYHHxrC5YYhlEtv06AwyNz0xq3O99cuCrg5xMRafBRd
 q4lrxUqQTleYikuiemTdjFkghDmALGP/awnVrr8K9DQo+JPEbJj8VT6zGpeC4Df2H/jB
 NJLw==
X-Gm-Message-State: AOAM531TpBzJK8nlElDgrWNUBXn4RrwejSGhfVBZ0Vqfb0W0GBn1rs5x
 xfwEcZXGquyBodf6WZiVYF5Wu2NSTrK+OeAXcVz8CJ4M6KsxLFV6PECVUrcuV1pO9QZ3E4cfRzA
 GlSpjiD25KaE+PUp0WyrkZABksts6YaY/5aq3ob5wWyxuMCD/JXEIKVwChQ==
X-Received: by 2002:a05:6512:3341:b0:433:b033:bd22 with SMTP id
 y1-20020a056512334100b00433b033bd22mr2163472lfd.190.1648089260755; 
 Wed, 23 Mar 2022 19:34:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgjxViUv3QZ02fLzvUCLI93q8I4pGTbyS8uaLbqsbMnU9Ozt3C8qezHbBI6I2b8SkXRulI8T1pzOsiVyRVteM=
X-Received: by 2002:a05:6512:3341:b0:433:b033:bd22 with SMTP id
 y1-20020a056512334100b00433b033bd22mr2163460lfd.190.1648089260578; Wed, 23
 Mar 2022 19:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220321060429.10457-1-jasowang@redhat.com>
 <20220321085317.3148-1-hdanton@sina.com>
 <CACGkMEvF80FuU0uD+RZMOrySQ0K2RZVh7Pmn4UhNtz_Exs3c2w@mail.gmail.com>
 <CACGkMEvLqox3QZxpxeQdrjBnM6zRr_wGfddoN45RUSsZEOe=bQ@mail.gmail.com>
 <20220321123420.3207-1-hdanton@sina.com>
 <CACGkMEt-PRCsBQ+EJVGeWGikJfLk-0M1dRPMqnp9YC5R4HYAjQ@mail.gmail.com>
 <20220324005345.3623-1-hdanton@sina.com>
In-Reply-To: <20220324005345.3623-1-hdanton@sina.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 24 Mar 2022 10:34:09 +0800
Message-ID: <CACGkMEt7i3aA+qnsBjyvoZLFBsmbg3vDvvjd_N2MnJeJ8DuY4g@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa: mlx5: prevent cvq work from hogging CPU
To: Hillf Danton <hdanton@sina.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Eli Cohen <elic@nvidia.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, mst <mst@redhat.com>
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

On Thu, Mar 24, 2022 at 8:54 AM Hillf Danton <hdanton@sina.com> wrote:
>
> On Tue, 22 Mar 2022 09:59:14 +0800 Jason Wang wrote:
> >
> > Yes, there will be no "infinite" loop, but since the loop is triggered
> > by userspace. It looks to me it will delay the flush/drain of the
> > workqueue forever which is still suboptimal.
>
> Usually it is barely possible to shoot two birds using a stone.
>
> Given the "forever", I am inclined to not running faster, hehe, though
> another cobble is to add another line in the loop checking if mvdev is
> unregistered, and for example make mvdev->cvq unready before destroying
> workqueue.
>
> static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *dev)
> {
>         struct mlx5_vdpa_mgmtdev *mgtdev = container_of(v_mdev, struct mlx5_vdpa_mgmtdev, mgtdev);
>         struct mlx5_vdpa_dev *mvdev = to_mvdev(dev);
>         struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>
>         mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
>         destroy_workqueue(mvdev->wq);
>         _vdpa_unregister_device(dev);
>         mgtdev->ndev = NULL;
> }
>

Yes, so we had

1) using a quota for re-requeue
2) using something like

while (READ_ONCE(cvq->ready)) {
        ...
        cond_resched();
}

There should not be too much difference except we need to use
cancel_work_sync() instead of flush_work for 1).

I would keep the code as is but if you stick I can change.

Thanks

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
