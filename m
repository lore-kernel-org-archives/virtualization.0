Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2052CC7EE22
	for <virtualization@archiver.kernel.org>; Mon, 15 May 2023 16:05:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 88A2B41C1F;
	Mon, 15 May 2023 16:05:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 88A2B41C1F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Wk8cyGcx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KVYu0LCdtSnD; Mon, 15 May 2023 16:05:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BDFD241BDB;
	Mon, 15 May 2023 16:05:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BDFD241BDB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85F4EC0036;
	Mon, 15 May 2023 16:05:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85291C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 16:05:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5286983AF3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 16:05:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5286983AF3
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=linux-foundation.org
 header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google
 header.b=Wk8cyGcx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qDkqs62a5AZV
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 16:05:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 744A180E42
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 744A180E42
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 16:05:06 +0000 (UTC)
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-4f00d41df22so67205221e87.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 09:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1684166704; x=1686758704;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WgkXNey1qqkRYDn0ndFfina8YyIW2oFgV1/nBHyisSM=;
 b=Wk8cyGcxR5vnlFmwyWWlpiqDZ25V8iMJai5lzzp7LWAjxEF4lIZsMGSeQwGRuLPQXL
 iqrNl6oWE67Qc9zJeh+zpjHRO5VqCHcvIwKnJiRTmcbwRngVL4dXm/yd96IdMPimUclG
 60g72H/xfO2NUoGNuwxepICDRWHBD1wzrV/sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684166704; x=1686758704;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WgkXNey1qqkRYDn0ndFfina8YyIW2oFgV1/nBHyisSM=;
 b=jisj8+HF6WNPy1PWhy7kkh3E44dQ/OwF9FTS7nWo9n3lmalKxELjyUFrCsTI7VuJMO
 Oeu3jRJwjVjCSP1ki+RKd24PO+z0Lr1CULAglYGAo1KO5BV/hhhBb6uXLtLky/KGPxLj
 z2A+FX0KgL/iHHHhaHZmWig6ji8ubnms4xDHd9nD0680EWBZNc52r/49TRuVOdq+AFPW
 7TEgzApRGdWQ3J0n/CHDEhlcEmGdgNHkAxj5yzhZm8+tzDjR4qoL4g65DEDAuX/MQTfJ
 JBXuZ2ExYfzyr9NC7r/IZvdz1OPi0VaxQnbh56fUJ5d4jlrWbYwgIt+EBwhcBA72oFr9
 MmbA==
X-Gm-Message-State: AC+VfDysCRrAZWCygreNP7GYdKeC/x+3CfydgSPimgfC5a1bQf1tXpBa
 3pn8MBU8v4RUKY0Jh9YWczU36LQPUWCmCkw95QCKH3gVMEw=
X-Google-Smtp-Source: ACHHUZ5/Azv+0PusRvVq3blVtqocQ0OpPytOAw6rovuOyLhvK1ymQ00jj4LXsCtoF8sh7CxOvB1mgg==
X-Received: by 2002:a05:6512:33d4:b0:4f0:3e1:9ada with SMTP id
 d20-20020a05651233d400b004f003e19adamr7244508lfg.31.1684166704084; 
 Mon, 15 May 2023 09:05:04 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com.
 [209.85.167.46]) by smtp.gmail.com with ESMTPSA id
 q22-20020ac246f6000000b004f37aca1aa3sm809631lfo.113.2023.05.15.09.05.03
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 May 2023 09:05:03 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-4f00d41df22so67204997e87.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 09:05:03 -0700 (PDT)
X-Received: by 2002:a17:907:97c4:b0:966:4669:7e8d with SMTP id
 js4-20020a17090797c400b0096646697e8dmr27235914ejc.16.1684166217079; Mon, 15
 May 2023 08:56:57 -0700 (PDT)
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
In-Reply-To: <33b84605-1d0c-1b0e-7927-7ffa96b3c308@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 15 May 2023 08:56:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=whmN7cxAgmhDBqiE=c67Q2pp2+SqCknNcj3K+QNKivaSg@mail.gmail.com>
Message-ID: <CAHk-=whmN7cxAgmhDBqiE=c67Q2pp2+SqCknNcj3K+QNKivaSg@mail.gmail.com>
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

T24gTW9uLCBNYXkgMTUsIDIwMjMgYXQgODo1MuKAr0FNIEplbnMgQXhib2UgPGF4Ym9lQGtlcm5l
bC5kaz4gd3JvdGU6Cj4KPiBPbmx5IHBvdGVudGlhbCBkb3duc2lkZSBpcyB0aGF0IGl0IGRvZXMg
bWFrZSBmaWxlIHJlZmVyZW5jZXMgbW9yZQo+IGV4cGVuc2l2ZSBmb3Igb3RoZXIgc3lzY2FsbHMs
IHNpbmNlIHlvdSBub3cgaGF2ZSBhIHNoYXJlZCBmaWxlIHRhYmxlLgo+IEJ1dCBwcm9iYWJseSBu
b3Qgc29tZXRoaW5nIHRvIHdvcnJ5IGFib3V0IGhlcmU/CgpXb3VsZCB0aGUgdmhvc3QgdXNlciB3
b3JrZXIgdXNlciBwcm9jZXNzZXMgZXZlciBiZSBvdGhlcndpc2Ugc2luZ2xlLXRocmVhZGVkPwoK
SSdkICphc3N1bWUqIHRoYXQgYSB2aG9zdCB1c2VyIGlzIGFscmVhZHkgZG9pbmcgaXRzIG93biB0
aHJlYWRzLiBCdXQKbWF5YmUgdGhhdCdzIGEgY29tcGxldGVseSBib2d1cyBhc3N1bXB0aW9uLiBJ
IGRvbid0IGFjdHVhbGx5IHVzZSBhbnkKb2YgdGhpcywgc28uLi4KCkJlY2F1c2UgeW91IGFyZSBv
YnZpb3VzbHkgMTAwJSByaWdodCB0aGF0IGlmIHlvdSdyZSBvdGhlcndpc2UKc2luZ2xlLXRocmVh
ZGVkLCB0aGVuIGEgQ0xPTkVfRklMRVMga2VybmVsIGhlbHBlciB0aHJlYWQgd2lsbCBjYXVzZQp0
aGUgZXh0cmEgY29zdCBmb3IgZmlsZSBkZXNjcmlwdG9yIGxvb2t1cC9mcmVlIGR1ZSB0byBhbGwg
dGhlIHJhY2UKcHJldmVudGlvbi4KCiAgICAgICAgICAgICAgICAgTGludXMKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
