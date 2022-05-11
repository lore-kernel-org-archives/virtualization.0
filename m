Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A327C433EF
	for <virtualization@archiver.kernel.org>; Wed, 11 May 2022 16:20:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0BF9C83E5A;
	Wed, 11 May 2022 16:20:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SFEUavZYY1K3; Wed, 11 May 2022 16:20:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A659683E58;
	Wed, 11 May 2022 16:20:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7250FC0039;
	Wed, 11 May 2022 16:20:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C810C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 16:20:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8A8C160B75
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 16:20:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux-foundation.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B4-6qFZBrwbL
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 16:20:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C1D3860B61
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 16:20:23 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id p18so3175265edr.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 09:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=svG1L/bGhyxGAlocPxyHJusAcsDTJHaGb4g7JRnLN34=;
 b=SLYn3yafpxhPinrhVN+KvALYpBdGm6IPDJeU17IYRguThw4zYzuAUMO+wgE8mES8b4
 TAvhOMEIzlAjl54FO2fajRhHHQdSYqfX00mqyItYDD3jbYNbNda6kImAMtKkUrF3hSa2
 naE7anfld7oOW69AFhZbUG91usyzFIculkTzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=svG1L/bGhyxGAlocPxyHJusAcsDTJHaGb4g7JRnLN34=;
 b=4KZEIrDWvbIbWxV4pIWlbCt5aNP5gtTuphQzzwl45WC0Wkuy+LWATtNi2HVMA40obk
 zWPkRm7nrTVysTCMzsUSJhPpJJpHijvu16QL/UCkOKSdQ0AtJJDLriJ2nph3XKvrrskJ
 wzLP3bekL73dWAG2HXWQ2NQ6Bq25ZYgaDZ57BwD2k4W+soOj40FZq6gKwneacNfz/Nvj
 vl5+5inVu/mW6IC9U1xlGA78TTo9hMOwl2SPbWm+ThrWSba+GyOqSxPENJcSzaJDOVDg
 xpoqiYSpbYcySlCYvn1BL+0FOv79pIPYFwbOrckUhsYmip/7ceR/KcjjagWXjpwu9DQa
 OByw==
X-Gm-Message-State: AOAM532Y7dHBFwmnPduVgxJj8CfxdyZrzSLK/XgeXH57nEjz15Mwq5RL
 tXEH4dbDu3Qqq+swlN3ACLGFATIIIPuX81UZIrowig==
X-Google-Smtp-Source: ABdhPJyhUmAsSeGwlSQA0yyog5cYPC7TmU42pWeTZ1IBeyBdONtWMR/4Da2lkDTUvXnKeGd356YTfg==
X-Received: by 2002:aa7:d8d2:0:b0:425:e22b:35c0 with SMTP id
 k18-20020aa7d8d2000000b00425e22b35c0mr30223789eds.181.1652286021708; 
 Wed, 11 May 2022 09:20:21 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com.
 [209.85.221.49]) by smtp.gmail.com with ESMTPSA id
 bd23-20020a056402207700b0042617ba63a3sm1345464edb.45.2022.05.11.09.20.20
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 May 2022 09:20:20 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id q23so3735899wra.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 09:20:20 -0700 (PDT)
X-Received: by 2002:a05:6000:2c2:b0:20c:7329:7c10 with SMTP id
 o2-20020a05600002c200b0020c73297c10mr23431402wry.193.1652286020296; Wed, 11
 May 2022 09:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220510082351-mutt-send-email-mst@kernel.org>
 <CAHk-=wjPR+bj7P1O=MAQWXp0Mx2hHuNQ1acn6gS+mRo_kbo5Lg@mail.gmail.com>
 <87czgk8jjo.fsf@mpe.ellerman.id.au>
In-Reply-To: <87czgk8jjo.fsf@mpe.ellerman.id.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 May 2022 09:20:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj9zKJGA_6SJOMPiQEoYke6cKX-FV3X_5zNXOcFJX1kOQ@mail.gmail.com>
Message-ID: <CAHk-=wj9zKJGA_6SJOMPiQEoYke6cKX-FV3X_5zNXOcFJX1kOQ@mail.gmail.com>
Subject: Re: [GIT PULL] virtio: last minute fixup
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Netdev <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, mie@igel.co.jp,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
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

On Wed, May 11, 2022 at 3:12 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Which I read as you endorsing Link: tags :)

I absolutely adore "Link:" tags. They've been great.

But they've been great for links that are *usedful*.

They are wonderful when they link to the original problem.

They are *really* wonderful when they link to some long discussion
about how to solve the problem.

They are completely useless when they link to "this is the patch
submission of the SAME DAMN PATCH THAT THE COMMIT IS".

See the difference?

The two first links add actual new information.

That last link adds absolutely nothing. It's a link to the same email
that was just applied.

                   Linus
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
