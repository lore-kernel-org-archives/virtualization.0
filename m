Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4990C77B75
	for <virtualization@archiver.kernel.org>; Sat,  6 May 2023 01:53:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3FA6E405CD;
	Sat,  6 May 2023 01:53:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3FA6E405CD
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=eP7zF8Jv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ce6RJ08_OemR; Sat,  6 May 2023 01:53:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CE973400D8;
	Sat,  6 May 2023 01:53:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CE973400D8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A15DEC0036;
	Sat,  6 May 2023 01:53:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1482BC002A
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 May 2023 01:53:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CEA36405BD
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 May 2023 01:53:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CEA36405BD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lzKp1VurbtgM
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 May 2023 01:53:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 02B01400D8
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 02B01400D8
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 May 2023 01:53:53 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-50b37f3e664so4365793a12.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 05 May 2023 18:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1683338032; x=1685930032;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=maiOZWo4uY15gUQWerfOM/hHk3V4D/czecwW7zDGBv8=;
 b=eP7zF8JvpJEWwdEy7XvVkJqia2mB+7OOkkYGqPG/L6bxWMZ0NXh7A0mClq91MYEYeT
 G2YhjkJ7BZEhOL5lguyZ48DHvkBzs2W4i2Rqzp0Ky+OuSByrmj05sGMyMVZrPfLRKs+p
 +JFA32F8uyqKGJkH9XeERsVJlc0wJiJ6JE9bM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683338032; x=1685930032;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=maiOZWo4uY15gUQWerfOM/hHk3V4D/czecwW7zDGBv8=;
 b=LQQkAOTSpQXHtZaBhDRcPOC28aQQ8/N4GZu8A8cWYbgGo80Bgm6lg/UIeMG48F7vRK
 ENsYr6IQFBYoswQhnA5DPYlguNd1t0INdEm0ZDNIxlurPNLD9kK3N8n3c+DA0o6aa626
 c0yugU3o+OgQn5TQTtIRngFZRLG4lJ1VFzdPLwJarSQOfwUV3hBhLEgs+j68nGzMnTPk
 briwXDcSgoNcGnl/2eEuWqRoywoJZwqWus8kYFnM+B0d/Wm8ALmqS0HpERAcy9CIzZgW
 xCJ2x8c3ENWWAZ6mqUa3b48k+mgmrGuS2d7ZbHJ4P+ROUS+diyTI/460/YttPYpZDSdi
 2l3Q==
X-Gm-Message-State: AC+VfDxKMoc/Qai1NUhZvKFALSFfl/giQLTnSy47h/6kESsRFCSOExIm
 GqN5bth+FK/RX1jJbfMr0r1rsx8AI9NMNSfZlI+QJSbf
X-Google-Smtp-Source: ACHHUZ7e7GeE+z0BhKjblm6m804alO/eBUcXoADp2XTlUQvtDeXCZKBfPYZyQ8ksuHn+Rr+mpU5eZw==
X-Received: by 2002:a17:907:7f1d:b0:94a:6a7a:52d8 with SMTP id
 qf29-20020a1709077f1d00b0094a6a7a52d8mr3112173ejc.71.1683338031588; 
 Fri, 05 May 2023 18:53:51 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com.
 [209.85.218.46]) by smtp.gmail.com with ESMTPSA id
 v18-20020a1709060b5200b009659c23e78fsm1610700ejg.215.2023.05.05.18.53.49
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 May 2023 18:53:50 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-94a34a14a54so484576066b.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 05 May 2023 18:53:49 -0700 (PDT)
X-Received: by 2002:a17:907:9345:b0:94e:c4b:4d95 with SMTP id
 bv5-20020a170907934500b0094e0c4b4d95mr2455003ejc.69.1683338029657; Fri, 05
 May 2023 18:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com>
 <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
 <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com>
 <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com>
In-Reply-To: <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 May 2023 18:53:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wifMNUnnuqXWjuSq2jM3VOKmKNjyW9FAsi3aEtV5PFcVg@mail.gmail.com>
Message-ID: <CAHk-=wifMNUnnuqXWjuSq2jM3VOKmKNjyW9FAsi3aEtV5PFcVg@mail.gmail.com>
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
To: Mike Christie <michael.christie@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>, mst@redhat.com,
 konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
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

T24gRnJpLCBNYXkgNSwgMjAyMyBhdCAzOjM44oCvUE0gTWlrZSBDaHJpc3RpZQo8bWljaGFlbC5j
aHJpc3RpZUBvcmFjbGUuY29tPiB3cm90ZToKPgo+IElmIGl0J3Mgb2sgdG8gY2hhbmdlIHRoZSBi
ZWhhdmlvciBvZiAicHMgLXUgcm9vdCIsIHRoZW4gd2UgY2FuIGRvIHRoaXMgcGF0Y2g6CgpJIHRo
aW5rIHRoaXMgaXMgdGhlIHJpZ2h0IHRoaW5nIHRvIGRvLgoKTWFraW5nIHRoZSB1c2VyIHdvcmtl
ciB0aHJlYWRzIHNob3cgdXAgYXMgdGhyZWFkcyB3aXRoIHRoZSB2aG9zdApwcm9jZXNzIGFzIHRo
ZSBwYXJlbnQgcmVhbGx5IHNlZW1zIGxpa2UgYSBtdWNoIGJldHRlciBtb2RlbCwgYW5kIG1vcmUK
YWNjdXJhdGUuCgpZZXMsIHRoZXkgdXNlZCB0byBzaG93IHVwIGFzIHJhbmRvbSBrZXJuZWwgdGhy
ZWFkcywgYW5kIHlvdSdkIHNlZSB0aGVtCmFzIHN1Y2ggKG5vdCBqdXN0IGZvciAicHMgLXUgcm9v
dCIsIGJ1dCBzaW1wbHkgYWxzbyB3aXRoIGp1c3QgYSBub3JtYWwKInBzIGF4IiBraW5kIG9mIHRo
aW5nKS4gQnV0IHRoYXQgaXNuJ3QgYWxsIHRoYXQgaGVscGZ1bCwgYW5kIGl0J3MKcmVhbGx5IGp1
c3QgYW5ub3lpbmcgdG8gc2VlIG91ciBrZXJuZWwgdGhyZWFkcyBpbiAicHMgYXgiIG91dHB1dCwg
YW5kCkkndmUgb2Z0ZW4gd2lzaGVkIHdlIGRpZG4ndCBkbyB0aGF0IChpdCB0aGluayBvZiBhbGwg
dGhlIHJhbmRvbQoia3dvcmtlci94eXota2NyeXB0ZCIgZXRjIHRoaW5ncyB0aGF0IHNob3cgdXAp
LgoKU28gSSB0aGluayBzaG93aW5nIHRoZW0gYXMgdGhlIHRocmVhZGVkIGNoaWxkcmVuIG9mIHRo
ZSB2aG9zdCBwcm9jZXNzCmlzIG11Y2ggbmljZXIsIGFuZCBwcm9iYWJseSB0aGUgYmVzdCBvcHRp
b24uCgpCZWNhdXNlIEkgZG9uJ3QgdGhpbiBrYW55dGhpbmcgaXMgZ29pbmcgdG8gZ2V0IHRoZSAq
b2xkKiBiZWhhdmlvciBvZgpzaG93aW5nIHRoZW0gYXMgdGhlICdbdmhvc3QteHl6XScgc3lzdGVt
IHRocmVhZHMgKG9yIHdoYXRldmVyIHRoZSBvbGQKb3V0cHV0IGVuZGVkIHVwIGJlaW5nIGluICdw
cyBheCcpLCBidXQgaG9wZWZ1bGx5IG5vdGhpbmcgd2FudHMgdGhhdApob3Jyb3IgYW55d2F5LgoK
QXQgYSBtaW5pbXVtLCB0aGUgcGFyZW50aW5nIGlzIGZ1bmRhbWVudGFsbHkgZ29pbmcgdG8gbG9v
ayBkaWZmZXJlbnQKaW4gdGhlIG5ldyBtb2RlbC4KCiAgICAgICAgICAgICAgICAgICBMaW51cwpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
