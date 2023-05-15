Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1E2C7EE23
	for <virtualization@archiver.kernel.org>; Mon, 15 May 2023 17:23:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2A93408C8;
	Mon, 15 May 2023 17:23:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C2A93408C8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=e5qRkzpa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NJ5TAVjUGExC; Mon, 15 May 2023 17:23:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1F452408AB;
	Mon, 15 May 2023 17:23:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1F452408AB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3559C0036;
	Mon, 15 May 2023 17:23:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6D4BC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 17:23:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B04B6408AB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 17:23:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B04B6408AB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dnkqwf-95fbf
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 17:23:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C15FF408A6
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C15FF408A6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 17:23:49 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-50bd2d7ba74so113739550a12.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 10:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1684171427; x=1686763427;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fd5dtKhNyHGq8Bf62oHV9wGTTQyA1cr8VVarKwpvWbY=;
 b=e5qRkzpa/8VhhbJMscvnEGPfw9W/cHLNrZpKiq1kf0sBmFTuOrX9Cjdss75ibaWvbt
 bAL5jDYyd6tNCBVwIdUi37T5zTW0UxOTXjR+ICuXYCwlL/KlrZpsDAbpKw+B05YZdYE0
 yc3ak/7suJI3mRtUCZ2YAnAAleqka2hNCWblU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684171427; x=1686763427;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fd5dtKhNyHGq8Bf62oHV9wGTTQyA1cr8VVarKwpvWbY=;
 b=ikX7eVYLwsPj4tdmeD18FE/4wXU2xbwJBJdXfaSSDgdMnmSrDz+BjeZ37jKl6E6ifw
 jVoKpD3Kn8WHchcnsraTX6bMkiCz5nTp4WF33bsa0XLC7PGdtJTE6D94diflZCHA7ylW
 2KVW8iLZFGkAJYwN/Sr57MBGL+4BjJ3qnin43ibOrJPKtakH4+N/hoZm2I1MULOBmuQL
 HdrMnbnsy3QuDt25DcaVk/DKjtbFNjs2eU/i2dVzlQQWC+vcRg3ByhbyJjBUFV3KntBh
 JYnkFgKtNIXmsy6z23oeIHrvVYNnNrClWHo9ezQMLwx6KatMH+oj5dWZ4teEq5a5zedb
 GN0w==
X-Gm-Message-State: AC+VfDyDF+mDyQcNwPD70Ew1AwQVCU9ZimoB3Hg24ODgyH1nmqtnF6u7
 iPas8xSmsNE+mwdLS1j6aCb8rD5U5tRSr4O3YqLRng9e/PM=
X-Google-Smtp-Source: ACHHUZ6EILuD79kbQm/BFsgelYiJqJMFgt4LH6Ejp1pSdL3kHrtkpRMr5pv51/XLX2BHsy69aEoFbA==
X-Received: by 2002:a17:907:970d:b0:96a:2dd7:2ee0 with SMTP id
 jg13-20020a170907970d00b0096a2dd72ee0mr17160378ejc.5.1684171427322; 
 Mon, 15 May 2023 10:23:47 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com.
 [209.85.208.44]) by smtp.gmail.com with ESMTPSA id
 a10-20020a170906368a00b0096b275e19cbsm2147953ejc.115.2023.05.15.10.23.46
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 May 2023 10:23:46 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-50bd2d7ba74so113739344a12.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 10:23:46 -0700 (PDT)
X-Received: by 2002:a17:907:6e11:b0:96a:2210:7dd8 with SMTP id
 sd17-20020a1709076e1100b0096a22107dd8mr16414147ejc.38.1684171426288; Mon, 15
 May 2023 10:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com>
 <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
 <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com>
 <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com>
 <48842e92-835e-bc3f-7118-48b8f415f532@leemhuis.info>
 <CAHk-=wicXCNR1bBioaAiBqEDgv-CoQD9z2RsM2VOTPzkK0xr8g@mail.gmail.com>
 <20230515-vollrausch-liebgeworden-2765f3ca3540@brauner>
 <CAHk-=wgXJ5VS1iBkfsG=HDjsyhn5XYDKt5xhQcNuz-e7VKyg8A@mail.gmail.com>
 <33b84605-1d0c-1b0e-7927-7ffa96b3c308@kernel.dk>
 <CAHk-=wiDqe+H7UnhD0qLbL8K8hnWUEdsRqcM4QnY=gZ3GytBRQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiDqe+H7UnhD0qLbL8K8hnWUEdsRqcM4QnY=gZ3GytBRQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 15 May 2023 10:23:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjudDcq+TSaxOVX03iMTAhBDf6fup-tDhDpdQjGnKXgTw@mail.gmail.com>
Message-ID: <CAHk-=wjudDcq+TSaxOVX03iMTAhBDf6fup-tDhDpdQjGnKXgTw@mail.gmail.com>
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
To: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>, mst@redhat.com,
 linux-kernel@vger.kernel.org, konrad.wilk@oracle.com,
 Thorsten Leemhuis <linux@leemhuis.info>,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 ebiederm@xmission.com, stefanha@redhat.com, nicolas.dichtel@6wind.com
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gTW9uLCBNYXkgMTUsIDIwMjMgYXQgODo1NOKAr0FNIExpbnVzIFRvcnZhbGRzCjx0b3J2YWxk
c0BsaW51eC1mb3VuZGF0aW9uLm9yZz4gd3JvdGU6Cj4KPiBCbHVzaC4gSSBkZWNpZGVkIHRvIGJ1
aWxkLXRlc3QgaXQsIGFuZCB0aGVuIGZvcmdvdCB0byBhdHRhY2ggaXQuIEhlcmUuCgpCdHcsIGlm
IHRoaXMgdGVzdHMgb3V0IGdvb2QgYW5kIHdlIGVuZCB1cCBkb2luZyB0aGlzLCBJIHRoaW5rIHdl
CnNob3VsZCBhbHNvIGp1c3QgcmVuYW1lIHRoYXQgJy5pZ25vcmVfc2lnbmFscycgYml0ZmllbGQg
dG8KJy5ibG9ja19zaWduYWxzJyB0byBhY3R1YWxseSBtYXRjaCB3aGF0IGl0IGRvZXMuCgpCdXQg
dGhhdCdzIGFuIGVudGlyZWx5IGNvc21ldGljIHRoaW5nIGp1c3QgdG8gY2xhcmlmeSB0aGluZ3Mu
IFRoZQpwYXRjaCB3b3VsZCBsb29rIGFsbW9zdCBpZGVudGljYWwsIGFwYXJ0IGZyb20gdGhlIG5l
dyBuYW1lIChhbmQgdGhlCnNtYWxsIGFkZGl0aW9uYWwgcGFydHMgdG8gcmVuYW1lIHRoZSB0d28g
ZXhpc3RpbmcgdXNlcnMgdGhhdCB3ZXJlbid0CnRvdWNoZWQgYnkgdGhhdCBwYXRjaCAtIHRoZSBo
ZWFkZXIgZmlsZSBhbmQgdGhlIHZob3N0IHVzZS1jYXNlKS4KCiAgICAgICAgICAgICAgICAgICBM
aW51cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
