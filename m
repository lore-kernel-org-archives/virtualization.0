Return-Path: <SRS0=8N1b=MT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28918C4338F
	for <virtualization@archiver.kernel.org>; Tue, 27 Jul 2021 05:09:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7F6B610A7
	for <virtualization@archiver.kernel.org>; Tue, 27 Jul 2021 05:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C7F6B610A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8555A82DD9;
	Tue, 27 Jul 2021 05:09:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id te7uW5UXRckq; Tue, 27 Jul 2021 05:09:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 325AF82CD4;
	Tue, 27 Jul 2021 05:09:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B610C001A;
	Tue, 27 Jul 2021 05:09:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BEB0DC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 05:09:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9850C4046D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 05:09:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G0lqkXwHeqKw
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 05:09:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 87B744045F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 05:09:12 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id t21so14301873plr.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 22:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=jMb1KRUbiUlacJfAVD1/R8vrh+6l8zpcFNirbTWr1q4=;
 b=Yso/kk9zDSFsGRMyC/gs/cauJC8vGbPr+iUqMihO+rX6CTMTtNIqua+TvNUgtPbfYu
 KvqSzFhXJEijB4imj9I7mYJ54IITie8MTKgenGgW8uSXn1FBoxSqa0hebxLHjuFL9IaR
 MQZUY+2fd02tmll4YscUDlDhIP74HMLuip0H9/rKf5H+FFKWpRMv8NRfTHj1k/PVPVyy
 etRR4bWUS9hhtQJUF8eZsqavNk+oeWwPgbyAsmGECaxt2EL7+Hxr4QM8aoyTQP0SbA9T
 52D8/j9xLTXXhhGFygFrHx0rttkO5HtvR4Mt1+A4TnOxRx2YltlK50yNtaf1/VFprP0S
 hZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=jMb1KRUbiUlacJfAVD1/R8vrh+6l8zpcFNirbTWr1q4=;
 b=XdxONltUz449MjnsUJ492eI+h7YJEw17sDtr6h4A4KzjwC0ouM0tgA9B5k9DpmHhm+
 T7pz9iGpeXieNarhQJbEos1xRWX89NmyRv3kiepatGy+gWpCLxoYhqSD4q8iwQArOJgS
 EYVaVncC+TXsRVswgS+/O0YuzlP/9eFNf2yBdIY6bfKtWIwmGV4/fXzNPKeSXUsRyBrW
 GMaXZs+QGekYYojwBDVga8F1dLXbfu+tJTyBW0jm9VSnv/Wy7xED7JPzSzFtfxzaB9Hb
 v/hUxBXmBuzi6B15oIgUOO+ZhLkrqvUdMVAsvfHUMn2aoh8suQKKWbA11/FmwtSUWpvd
 MMIQ==
X-Gm-Message-State: AOAM533eHnljbr67fyNKdB159EM1ZWENQoqk8svzP0izXH8xD0g5hcPQ
 OQf2a915dKhX7LAOR26EpsKusA==
X-Google-Smtp-Source: ABdhPJwI0o/AFZSBs2tCGBCeJzWBzREp/9JaTjCOKUT78rlQB8bhoLyrYx24q4Coul5PQQhvFydbIQ==
X-Received: by 2002:a65:40cc:: with SMTP id u12mr17863936pgp.18.1627362551965; 
 Mon, 26 Jul 2021 22:09:11 -0700 (PDT)
Received: from localhost ([122.172.201.85])
 by smtp.gmail.com with ESMTPSA id q4sm1913130pfn.23.2021.07.26.22.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jul 2021 22:09:06 -0700 (PDT)
Date: Tue, 27 Jul 2021 10:39:03 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH V3 1/5] dt-bindings: virtio: Add binding for virtio devices
Message-ID: <20210727050903.io6kbeotsyplt2lx@vireshk-i7>
References: <cover.1627273794.git.viresh.kumar@linaro.org>
 <fced2f2b9dcf3f32f16866d7d104f46171316396.1627273794.git.viresh.kumar@linaro.org>
 <CAL_Jsq+XXhe2g0Rmda1v_Ws4-E_-UE6X5HUsSk-GcAETqQZiCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+XXhe2g0Rmda1v_Ws4-E_-UE6X5HUsSk-GcAETqQZiCQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Arnd Bergmann <arnd@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE"
 <virtualization@lists.linux-foundation.org>, devicetree@vger.kernel.org,
 Bill Mills <bill.mills@linaro.org>
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

On 26-07-21, 08:57, Rob Herring wrote:
> On Sun, Jul 25, 2021 at 10:52 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > +    description: |
> > +      Exactly one node describing the virtio device. The name of the node isn't
> > +      significant but its phandle can be used to by a user of the virtio device.
> > +
> > +  compatible:
> > +    pattern: "^virtio,[0-9a-f]+$"
> 
> DID is only 4 chars? If so, "^virtio,[0-9a-f]{1,4}$"

It is 32 bit actually, so making this {1,8}.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
