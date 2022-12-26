Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE368C3DA79
	for <virtualization@archiver.kernel.org>; Mon, 26 Dec 2022 03:46:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 91D1E607B0;
	Mon, 26 Dec 2022 03:46:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 91D1E607B0
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bd0PPmIK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eglg8Un7yPti; Mon, 26 Dec 2022 03:46:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3C00D60769;
	Mon, 26 Dec 2022 03:46:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3C00D60769
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23B79C0035;
	Mon, 26 Dec 2022 03:46:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18FFEC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 03:45:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DA3ED40276
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 03:45:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DA3ED40276
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bd0PPmIK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9tn2hu8OZVk7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 03:45:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E974240273
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E974240273
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 03:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672026356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LPML0T2odU1efvKA6TB4e9nlnB9KljoL+oggFMgoV7U=;
 b=Bd0PPmIKtPu7Hm7bx+bwy17NkIWs7huashIK5Dv6St1uwIzGSbpX9R+Z1qH5BJvqMbYmCa
 opBOkqbX4d6CsRbCnJmwhBAvZ2aUqXtTdTw2DAv8jS/Ie/9Xqb2KmXhZ10ljysDiP1HSWt
 dc/uZu7Az2qZ86LUwBSc/mnWd0YCaAU=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-611-Y9XKMekqPmK6aZ3DMZdwHw-1; Sun, 25 Dec 2022 22:45:55 -0500
X-MC-Unique: Y9XKMekqPmK6aZ3DMZdwHw-1
Received: by mail-ot1-f72.google.com with SMTP id
 bv12-20020a0568300d8c00b0066d2c98ca10so5799289otb.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Dec 2022 19:45:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LPML0T2odU1efvKA6TB4e9nlnB9KljoL+oggFMgoV7U=;
 b=IBDN6UD/3N62x4JNFrhaOKv/FuNGqxguduTfJ2kqrPoVLJPCCFB7WzOZ2qSXEQO/tQ
 xJhD2BAksaBNv9NVusO7p+urgWjD6NhwpEkegfYf9Dr2iFCjPUsw6V8jHHDYaHwSB1Ny
 Jfpq3uV4ovWRBlXHFiUiDCBCDoacVGSapj/lBzOuAi0QbF26dCig9S+dtjiis7goHYwx
 dsfBaBe3FN1wzZZzYexx/crx1sQssiw0KDr7/8leCXNCAho8a7VDP0odGI4hV6Y6EK2h
 IEfQkgWAb4LH6DpB8T+rJuH03601uUZCRT+aHNyOePf79SPOxPmzjcBw1ZuXc4daHAi/
 B7Ng==
X-Gm-Message-State: AFqh2kociHNb+t8eMagveUc5L+VV3uHMUwFSnct9km0drtD7lqc4uupt
 4dBNwOHwQNlwxk8cfmCofa2lR9avbltB3Nuv/5ShpM7tSq3glQjLPQb3AQE5FmfqSuPh2syWUfl
 jF2j9EkF8/pQqh6Su44+y5b4jSCIw97PdxVq/e9hlp2vqxNOCJnqfqYvcsw==
X-Received: by 2002:a05:6830:4a3:b0:670:8334:ccf2 with SMTP id
 l3-20020a05683004a300b006708334ccf2mr1092687otd.201.1672026354894; 
 Sun, 25 Dec 2022 19:45:54 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv4l8sal78jwmSmfNpp5adoBH8DFpxNZ4rOpa5yo3+kGZLSJd99jDWK2hJIcSUrI33x/vEuSXvdG0zyZB3QQ+8=
X-Received: by 2002:a05:6830:4a3:b0:670:8334:ccf2 with SMTP id
 l3-20020a05683004a300b006708334ccf2mr1092684otd.201.1672026354707; Sun, 25
 Dec 2022 19:45:54 -0800 (PST)
MIME-Version: 1.0
References: <20221222060427.21626-1-jasowang@redhat.com>
 <20221222060427.21626-5-jasowang@redhat.com>
 <CAJs=3_D6sug80Bb9tnAw5T0_NaL_b=u8ZMcwZtd-dy+AH_yqzQ@mail.gmail.com>
 <CACGkMEv4YxuqrSx_HW2uWgXXSMOFCzTJCCD_EVhMwegsL8SoCg@mail.gmail.com>
 <CAJs=3_Akv1zoKy_HARjnqMdNsy_n34TzzGA6a25xrkF2rCnqwg@mail.gmail.com>
 <CACGkMEvtgr=pDpcZeE4+ssh+PiL0k2B2+3kzdDmEvxxe=2mtGA@mail.gmail.com>
 <CAJs=3_BqDqEoXGiU9zCNfGNqEjd1eijqkE_8_mb3nC=GwQoxHA@mail.gmail.com>
In-Reply-To: <CAJs=3_BqDqEoXGiU9zCNfGNqEjd1eijqkE_8_mb3nC=GwQoxHA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 Dec 2022 11:45:43 +0800
Message-ID: <CACGkMEs=YrtP-GT_MKoZdORtYCD09QdmZGpgQUHMOMLG_eX-FA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] virtio-net: sleep instead of busy waiting for cvq
 command
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 edumazet@google.com, maxime.coquelin@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
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

On Fri, Dec 23, 2022 at 3:39 PM Alvaro Karsz <alvaro.karsz@solid-run.com> wrote:
>
> > This needs to be proposed to the virtio spec first. And actually we
> > need more than this:
> >
> > 1) we still need a way to deal with the device without this feature
> > 2) driver can't depend solely on what is advertised by the device (e.g
> > device can choose to advertise a very long timeout)
>
> I think that I wasn't clear, sorry.
> I'm not talking about a new virtio feature, I'm talking about a situation when:
> * virtio_net issues a control command.
> * the device gets the command, but somehow, completes the command
> after timeout.
> * virtio_net assumes that the command failed (timeout), and issues a
> different control command.
> * virtio_net will then call virtqueue_wait_for_used, and will
> immediately get the previous response (If I'm not wrong).
>
> So, this is not a new feature that I'm proposing, just a situation
> that may occur due to cvq timeouts.
>
> Anyhow, your solution calling BAD_RING if we reach a timeout should
> prevent this situation.

Right, that is the goal.

Thanks

>
> Thanks
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
