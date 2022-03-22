Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29A7C433F5
	for <virtualization@archiver.kernel.org>; Tue, 22 Mar 2022 01:59:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4EF6C41515;
	Tue, 22 Mar 2022 01:59:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UefKUF7Q8eTC; Tue, 22 Mar 2022 01:59:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D37E841550;
	Tue, 22 Mar 2022 01:59:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 888AFC001A;
	Tue, 22 Mar 2022 01:59:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1ADDCC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 01:59:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 099A041550
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 01:59:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T1CtYohvqClc
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 01:59:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4AF9D41515
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 01:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647914368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sAk9FMAq7G/qGtP6D8AGvXHRXy5lqx/zoAVECLpUuqk=;
 b=jPoQOG0yE5h7LZV78z+QMrgB+m73nxoZECWwZJLvdrJ4qI7aoP1Zt4GBmwXApFZskNLYl2
 k8ZLwHm0muQglKpg+A1jJrIdl1ejNLNQR97Ld5eQRG98ktT5YEyfxmC7P9LAUXLJbtTBkW
 wdZlFb+7Ggx5qfP7/zyqE1ksM3pUyCU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-388-nedBd56aOsSQxFSulyHj1g-1; Mon, 21 Mar 2022 21:59:26 -0400
X-MC-Unique: nedBd56aOsSQxFSulyHj1g-1
Received: by mail-lf1-f70.google.com with SMTP id
 z24-20020a056512371800b0043ea4caa07cso4185087lfr.17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 18:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sAk9FMAq7G/qGtP6D8AGvXHRXy5lqx/zoAVECLpUuqk=;
 b=0paSx6EIHvkx9H4Oefa4uxYgAUZr0Vl2PYOag1oeL0mIhyeqaneHkFbcLHy+68xH64
 eiAs5Cgw3gWCms901+YV0xIcJE4Y1iLL+Qvi5DwDwWkkDMPH2mWc+cyvkxqwXJft3Y1w
 doSSF7zw0Z4f9bzyuArKIIHlhyUPLCcJu2KBHlhbWWZrGLaGZg2nK0aCQWs0q52afaRN
 Sd4gjkZr8LI2EX7myiRIyWQN16qgvneQRLIqcRgRetZP4vWYIR4ML35hrp5XiHrNSoxx
 r4s7h7oK63IceGTT68mopX1oBib4mpdYde1v4SduD7MrXNeW7F+nPy0LRKMiBKBx8nyu
 pUXA==
X-Gm-Message-State: AOAM533HBJCZ39jvbg2vdrrXsHOArFHrxtSD7W72+I3vVroyc+RRHm6B
 eE2spTFSBWz/OjoqKuTfzJp3+dyZZyEicM9mynHB2kgMvJxbCCxsFa/aBTEmyTvpa4XimEjp3gx
 TEYne6k4x/wwO2DEkOt/8yfhLo7Ih+NAfF1CakQ3UWjs4RF/6vo9qGr+e6A==
X-Received: by 2002:a2e:824e:0:b0:249:7e3d:c862 with SMTP id
 j14-20020a2e824e000000b002497e3dc862mr8338200ljh.97.1647914365175; 
 Mon, 21 Mar 2022 18:59:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMrcRoYPcVBF7xK+Ox8ekhMvlc3FPY4gYx4yzyrVWKbXtWn7mI1az1lvn2avR+9/0h4SqQyr0XCODkhTkeqNc=
X-Received: by 2002:a2e:824e:0:b0:249:7e3d:c862 with SMTP id
 j14-20020a2e824e000000b002497e3dc862mr8338187ljh.97.1647914364929; Mon, 21
 Mar 2022 18:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220321060429.10457-1-jasowang@redhat.com>
 <20220321085317.3148-1-hdanton@sina.com>
 <CACGkMEvF80FuU0uD+RZMOrySQ0K2RZVh7Pmn4UhNtz_Exs3c2w@mail.gmail.com>
 <CACGkMEvLqox3QZxpxeQdrjBnM6zRr_wGfddoN45RUSsZEOe=bQ@mail.gmail.com>
 <20220321123420.3207-1-hdanton@sina.com>
In-Reply-To: <20220321123420.3207-1-hdanton@sina.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 22 Mar 2022 09:59:14 +0800
Message-ID: <CACGkMEt-PRCsBQ+EJVGeWGikJfLk-0M1dRPMqnp9YC5R4HYAjQ@mail.gmail.com>
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

On Mon, Mar 21, 2022 at 8:34 PM Hillf Danton <hdanton@sina.com> wrote:
>
> On Mon, 21 Mar 2022 17:00:09 +0800 Jason Wang wrote:
> >
> > Ok, speak too fast.
>
> Frankly I have fun running faster five days a week.

:)

>
> > So you meant to add a cond_resched() in the loop?
>
> Yes, it is one liner.

Yes, there will be no "infinite" loop, but since the loop is triggered
by userspace. It looks to me it will delay the flush/drain of the
workqueue forever which is still suboptimal.

Thanks

>
> Hillf
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
