Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D0B7C433EF
	for <virtualization@archiver.kernel.org>; Thu, 21 Apr 2022 16:14:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 13B8760B17;
	Thu, 21 Apr 2022 16:14:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZsQLk5CZTbA1; Thu, 21 Apr 2022 16:14:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B935660B9C;
	Thu, 21 Apr 2022 16:14:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 684B8C0033;
	Thu, 21 Apr 2022 16:14:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 652F9C002C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 16:14:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3F14660B9C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 16:14:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 05se2aRI8zMw
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 16:14:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 50E7E60B17
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 16:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650557674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1ngZ3ZDY9ywW927Z5RN+MQNpAIO8k9NmG/nkTnk+1Gs=;
 b=D4jkeh8D3DG6ylcdKCfSz7aO0Yk8nKIdM9V5hvGsEvu7+8XGmYHc0pgEI9veMAG62yx+le
 jVLjkDwC46P7Q2HJkea4tbOQIepvGC7DORK2hJ23YKyqFrAnvfzjvmBR53hY4hS5n9OWn1
 7E+8egSguhKwg0u7AWpyMRAVowG+o8c=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-99-UvXKMgH8MDSRRI1cWFbTGA-1; Thu, 21 Apr 2022 12:14:32 -0400
X-MC-Unique: UvXKMgH8MDSRRI1cWFbTGA-1
Received: by mail-lj1-f200.google.com with SMTP id
 s14-20020a2e2c0e000000b0024ee4322c6bso1023366ljs.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 09:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1ngZ3ZDY9ywW927Z5RN+MQNpAIO8k9NmG/nkTnk+1Gs=;
 b=SLfZvgmeWklI82rHSRlWEYl5z8h3Q8xGNrpdHQXQ9KvphReA1lv45Cd7/PiZhRNiKV
 IMuAWBGUCwp13n872tYmDcXy4YkjzAU80cNGWIdxOxQK7NJcCPESVD2KJar57/89/hSJ
 pFbsYfC0JS9px5rFw2X7Y34J0BTLB3WwGAx4YgaFyLLYymWUmH3Ojb2lmsp8ygcCnrzh
 BxIMAoqsEvDNGhjB8LlPXc3lpAwNQe0mOR4/3Yzoi8gqv1dzRryFdTyxar/LcZNTVlNn
 ZHvQnYkbeH/+aKAtccMhIZiqj6+wiT4TtpekJxLHbzELBLI1tzh3FThyyTnRS6/v37t7
 8cfQ==
X-Gm-Message-State: AOAM531ya6XcfUV1KKAczAluuDti09zL0ndL4YoUiGuhr+/7uUJgpt0O
 X2Cy8x4xYcutw1XjP39R/1HwQPJGe+0u1Xw4JyTkJB9VRBMKQbo6c9h5Ywgk+zo4/WmBYgHutHd
 /PEqKTw1CLNi6GCCn38WtZhZc4JAiNo4iPXapitcmuDHqny1grSdC+L0RIA==
X-Received: by 2002:a05:6512:68b:b0:471:d466:979b with SMTP id
 t11-20020a056512068b00b00471d466979bmr145642lfe.519.1650557671049; 
 Thu, 21 Apr 2022 09:14:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyH8/DjjuvvyMkckIHc+m1v/FBNR0YvL8JTrt6ayXJd/rtn7oBKbgJ1GEaT0nlskTay3z63zTKH5i8fe1g198I=
X-Received: by 2002:a05:6512:68b:b0:471:d466:979b with SMTP id
 t11-20020a056512068b00b00471d466979bmr145622lfe.519.1650557670855; Thu, 21
 Apr 2022 09:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220420200720.434717-1-parri.andrea@gmail.com>
 <20220420200720.434717-4-parri.andrea@gmail.com>
 <20220421140805.qg4cwqhsq5vuqkut@sgarzare-redhat>
 <20220421152827.GB4679@anparri>
In-Reply-To: <20220421152827.GB4679@anparri>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 21 Apr 2022 18:14:19 +0200
Message-ID: <CAGxU2F6UCiFQrXu4Nn=jNPbuE8i5hYe=Hkwak43kTMQoCQQy2A@mail.gmail.com>
Subject: Re: [PATCH 3/5] hv_sock: Add validation for untrusted Hyper-V values
To: Andrea Parri <parri.andrea@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Wei Liu <wei.liu@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, netdev <netdev@vger.kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 linux-hyperv@vger.kernel.org, Michael Kelley <mikelley@microsoft.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 David Miller <davem@davemloft.net>, kernel list <linux-kernel@vger.kernel.org>
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

On Thu, Apr 21, 2022 at 5:30 PM Andrea Parri <parri.andrea@gmail.com> wrote:
>
> > > @@ -577,12 +577,19 @@ static bool hvs_dgram_allow(u32 cid, u32 port)
> > > static int hvs_update_recv_data(struct hvsock *hvs)
> > > {
> > >     struct hvs_recv_buf *recv_buf;
> > > -   u32 payload_len;
> > > +   u32 pkt_len, payload_len;
> > > +
> > > +   pkt_len = hv_pkt_len(hvs->recv_desc);
> > > +
> > > +   /* Ensure the packet is big enough to read its header */
> > > +   if (pkt_len < HVS_HEADER_LEN)
> > > +           return -EIO;
> > >
> > >     recv_buf = (struct hvs_recv_buf *)(hvs->recv_desc + 1);
> > >     payload_len = recv_buf->hdr.data_size;
> > >
> > > -   if (payload_len > HVS_MTU_SIZE)
> > > +   /* Ensure the packet is big enough to read its payload */
> > > +   if (payload_len > pkt_len - HVS_HEADER_LEN || payload_len > HVS_MTU_SIZE)
> >
> > checkpatch warns that we exceed 80 characters, I do not have a strong
> > opinion on this, but if you have to resend better break the condition into 2
> > lines.
>
> Will break if preferred.  (but does it really warn??  I understand that
> the warning was deprecated and the "limit" increased to 100 chars...)

I see the warn here:
https://patchwork.kernel.org/project/netdevbpf/patch/20220420200720.434717-4-parri.andrea@gmail.com/

in the kernel doc [1] we still say we prefer 80 columns, so I try to
follow, especially when it doesn't make things worse.

[1] https://docs.kernel.org/process/coding-style.html#breaking-long-lines-and-strings

>
>
> > Maybe even update or remove the comment? (it only describes the first
> > condition, but the conditions are pretty clear, so I don't think it adds
> > much).
>
> Works for me.  (taking it as this applies to the previous comment too.)

Yep.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
