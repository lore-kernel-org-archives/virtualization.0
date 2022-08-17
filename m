Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DF0C25B08
	for <virtualization@archiver.kernel.org>; Wed, 17 Aug 2022 15:58:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0ED0F40BE1;
	Wed, 17 Aug 2022 15:58:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0ED0F40BE1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=DAPJSc/u
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zIW2RRf6nLu2; Wed, 17 Aug 2022 15:58:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AD239405FB;
	Wed, 17 Aug 2022 15:58:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AD239405FB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 306B3C0033;
	Wed, 17 Aug 2022 15:58:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4729C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 15:58:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7F809812D1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 15:58:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7F809812D1
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=linux-foundation.org
 header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google
 header.b=DAPJSc/u
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vsOI86Htmmtn
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 15:58:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CC34F812CC
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CC34F812CC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 15:58:40 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id y13so25246591ejp.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 08:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=U5jw3QHa+iaIPk1CEpZnETysV2acYZOZO5IcpVoLmmM=;
 b=DAPJSc/u2ev6bYXSBrTqwGZ4PaTl8WKl6DiAoyMnKBgA+8zqmrgKU4aVMESdOKZMZT
 SYoGZEdZ4zKG6vHrMZHRGM9k/zEgGqHhynaxUWM7PoNiqiL3sqU34A1ORMMSy9lm01+p
 xih4rucikfbN8PfPcI3ROoqXZHnqdlxXa7TQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=U5jw3QHa+iaIPk1CEpZnETysV2acYZOZO5IcpVoLmmM=;
 b=VjHMVqzs3YsU+9/EwQHSyZ8bamVjoPcZcO9mkRI+O1XdQHq4YdkNmV973/t1I9aK11
 +AHVu0mGiKyk0vJOSshnnIiIvGAaMrGKDGvG111I7ZcBySW4kwA6d8QzIQnkH0h43YWl
 MhvOf4O2K7rAj4c4a4aCSOpJVByyerY0kIh5cvj5U34EWb97jgl0qjX0tN5P5mHqPJwh
 kTTcz+kMSsHmIuDmdHCxVdZ8TFpzWknuLh/Co2qouVajOOqgAI5JrWgZiJEI0Rgwrp/1
 IFJ6gLjP4MzhZCeXrBXONoXuxmRMYqspYZabrnzX/HvCk0A5XICwNJ4FSeXdXzaxzqTB
 MAtA==
X-Gm-Message-State: ACgBeo2kZlZzBk8x7itz8JiR+nbehTVrnUu2Sm8n7d1m20yjQLY3oFWD
 jJXW/NrEOWyjvZWjuS1GvlHed/aBB32pwbZU8kZ3hQ==
X-Google-Smtp-Source: AA6agR5BGZYebeyhmbgojZcj/e7vBijaRaiAmd0t20dZVhxleWziOvi8KEvT2XVBCycKyGX+ZQH8Lw==
X-Received: by 2002:a17:907:a068:b0:731:366a:6005 with SMTP id
 ia8-20020a170907a06800b00731366a6005mr17363795ejc.344.1660751918856; 
 Wed, 17 Aug 2022 08:58:38 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com.
 [209.85.128.47]) by smtp.gmail.com with ESMTPSA id
 e11-20020aa7d7cb000000b0043cd06bef33sm10954871eds.97.2022.08.17.08.58.36
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Aug 2022 08:58:37 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id k17so6885494wmr.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 08:58:36 -0700 (PDT)
X-Received: by 2002:a05:600c:2195:b0:3a6:b3c:c100 with SMTP id
 e21-20020a05600c219500b003a60b3cc100mr2523659wme.8.1660751916369; Wed, 17 Aug
 2022 08:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220815113729-mutt-send-email-mst@kernel.org>
 <20220815164503.jsoezxcm6q4u2b6j@awork3.anarazel.de>
 <20220815124748-mutt-send-email-mst@kernel.org>
 <20220815174617.z4chnftzcbv6frqr@awork3.anarazel.de>
 <20220815161423-mutt-send-email-mst@kernel.org>
 <20220815205330.m54g7vcs77r6owd6@awork3.anarazel.de>
 <20220815170444-mutt-send-email-mst@kernel.org>
 <20220817061359.200970-1-dvyukov@google.com>
 <1660718191.3631961-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1660718191.3631961-1-xuanzhuo@linux.alibaba.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Aug 2022 08:58:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wghjyi5cyDY96m4LtQ_i8Rdgt9Rsmd028XoU6RU=bsy_w@mail.gmail.com>
Message-ID: <CAHk-=wghjyi5cyDY96m4LtQ_i8Rdgt9Rsmd028XoU6RU=bsy_w@mail.gmail.com>
Subject: Re: upstream kernel crashes
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, mst@redhat.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, virtualization@lists.linux-foundation.org,
 James.Bottomley@hansenpartnership.com, edumazet@google.com, linux@roeck-us.net,
 netdev@vger.kernel.org, c@redhat.com, kuba@kernel.org, pabeni@redhat.com,
 andres@anarazel.de, davem@davemloft.net, Dmitry Vyukov <dvyukov@google.com>
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

On Tue, Aug 16, 2022 at 11:47 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> +       BUG_ON(num != virtqueue_get_vring_size(vq));
> +

Please, no more BUG_ON.

Add a WARN_ON_ONCE() and return an  error.

           Linus
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
