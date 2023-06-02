Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABE2C77B7A
	for <virtualization@archiver.kernel.org>; Fri,  2 Jun 2023 20:07:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C0AE4284E;
	Fri,  2 Jun 2023 20:07:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4C0AE4284E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=RJHoYPzt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7BMwJSsI6xHr; Fri,  2 Jun 2023 20:07:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A074F427F0;
	Fri,  2 Jun 2023 20:07:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A074F427F0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 756AEC0037;
	Fri,  2 Jun 2023 20:07:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7F75C0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 20:07:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CF986616BA
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 20:07:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CF986616BA
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=linux-foundation.org
 header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google
 header.b=RJHoYPzt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9tI0JvnX2WB9
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 20:07:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 273EE6168F
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 273EE6168F
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 20:07:31 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9745baf7c13so220099866b.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 02 Jun 2023 13:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1685736449; x=1688328449;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZoYDuNxotwnFxac4y25CGImQkh46PA2DrNp3JmQw+ro=;
 b=RJHoYPzt0STSrA9VtoFl1a/42f/RSs4wsHaEGMPKMRAWYLtMuC8xF/Jr8qr4ExL5wq
 M5CgJfYWrMKRpx9HzwPc6Yg/awdn+Wy5xbGjBTK+3DRKBXjRgRgjq+YobTVezNHdhqWV
 DmB0LkrgmwyRqt7Wak/IbgEcDwTOFsAg6DHl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685736449; x=1688328449;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZoYDuNxotwnFxac4y25CGImQkh46PA2DrNp3JmQw+ro=;
 b=ehopB7vqMx7IIjOndnjDwIaGpCkyuFpEtEmiYy5U3wK9SLIhenLZz3up4McMp8DENu
 hGr6Npy6vYBoJckqZ6OmOCD9nn4IOb5CpUGLUnr5Gvlr6+fpTbRFs4b/Xgjq/V7FvA4k
 QcRUvnA0X6wavOhqMJMkYn/aLs7ty12w+ZxeW7gGcCWL5XBIpKO3WgRieZ8l6q68bKbk
 aR4cxuLbcS2km4M3IAxfMPsZzBhhWrJCelN1ngFc+WKXfgeaPC+vKJVJwlzmqWcoVhk0
 e+aY/tAiaLCEZA/c8zkK2YzWHWc2QB4nWhUFSUX5TMRkP8nbwFfeaw4z6ENETweF1iWr
 7n8w==
X-Gm-Message-State: AC+VfDwWinIER930nTvY6t5TS63Ffhz2f5oBLMN2QThrTAE4IQXWAggZ
 qQu5NcPE2YH00/O9LeKWNVSyf2o1uW7+mr7oRGNDULnz6hU=
X-Google-Smtp-Source: ACHHUZ48OrMVj2TK+x/lOmfXDPVOMzM7k3+6qBSE6Dvu6FyJoqQElX/RxKJK8/93Dtq8IAA8oKS3fg==
X-Received: by 2002:a17:906:6a27:b0:96f:6c70:c012 with SMTP id
 qw39-20020a1709066a2700b0096f6c70c012mr12858472ejc.45.1685736449054; 
 Fri, 02 Jun 2023 13:07:29 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com.
 [209.85.208.49]) by smtp.gmail.com with ESMTPSA id
 l14-20020a170906a40e00b0095807ab4b57sm1129874ejz.178.2023.06.02.13.07.27
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 13:07:27 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-514953b3aa6so3360406a12.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 02 Jun 2023 13:07:27 -0700 (PDT)
X-Received: by 2002:aa7:d657:0:b0:510:487a:ca3d with SMTP id
 v23-20020aa7d657000000b00510487aca3dmr2782770edr.23.1685736447307; Fri, 02
 Jun 2023 13:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com>
 <20230522174757.GC22159@redhat.com> <20230523121506.GA6562@redhat.com>
 <26c87be0-8e19-d677-a51b-e6821e6f7ae4@redhat.com>
 <20230531072449.GA25046@redhat.com>
 <CACGkMEv2kB9J1qGYkGkywk1YHV2gU2fMr7qx4vEv9L5f6qL5mg@mail.gmail.com>
 <20230531091432.GB25046@redhat.com>
 <CACGkMEvNrC5gc4ppp0QG-SNSbs_snrqwPkNBotffRRDJA1VJjQ@mail.gmail.com>
 <20230601074315.GA13133@redhat.com>
 <CACGkMEss2LkUiUKaEkhBWwFDBBz31T3N94a0=zSD1d+Fhb1zyQ@mail.gmail.com>
 <20230602175846.GC555@redhat.com>
In-Reply-To: <20230602175846.GC555@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 Jun 2023 16:07:10 -0400
X-Gmail-Original-Message-ID: <CAHk-=whKyWvzg=7_m1o_KLC3zb9FjTBHftc36-5M9X78AxwRXg@mail.gmail.com>
Message-ID: <CAHk-=whKyWvzg=7_m1o_KLC3zb9FjTBHftc36-5M9X78AxwRXg@mail.gmail.com>
Subject: Re: [PATCH 3/3] fork,
 vhost: Use CLONE_THREAD to fix freezer/ps regression
To: Oleg Nesterov <oleg@redhat.com>
Cc: axboe@kernel.dk, brauner@kernel.org, mst@redhat.com, linux@leemhuis.info,
 linux-kernel@vger.kernel.org, ebiederm@xmission.com, stefanha@redhat.com,
 nicolas.dichtel@6wind.com, virtualization@lists.linux-foundation.org
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

T24gRnJpLCBKdW4gMiwgMjAyMyBhdCAxOjU54oCvUE0gT2xlZyBOZXN0ZXJvdiA8b2xlZ0ByZWRo
YXQuY29tPiB3cm90ZToKPgo+IEFzIEkgc2FpZCBmcm9tIHRoZSB2ZXJ5IGJlZ2lubmluZywgdGhp
cyBjb2RlIGlzIGZpbmUgb24geDg2IGJlY2F1c2UKPiBhdG9taWMgb3BzIGFyZSBmdWxseSBzZXJp
YWxpc2VkIG9uIHg4Ni4KClllcy4gT3RoZXIgYXJjaGl0ZWN0dXJlcyByZXF1aXJlIF9fc21wX21i
X197YmVmb3JlLGFmdGVyfV9hdG9taWMgZm9yCnRoZSBiaXQgc2V0dGluZyBvcHMgdG8gYWN0dWFs
bHkgYmUgbWVtb3J5IGJhcnJpZXJzLgoKV2UgKnNob3VsZCogcHJvYmFibHkgaGF2ZSBhY3F1aXJl
L3JlbGVhc2UgdmVyc2lvbnMgb2YgdGhlIGJpdCB0ZXN0L3NldApoZWxwZXJzLCBidXQgd2UgZG9u
J3QsIHNvIHRoZXkgZW5kIHVwIGJlaW5nIGZ1bGwgbWVtb3J5IGJhcnJpZXJzIHdpdGgKdGhvc2Ug
dGhpbmdzLiBXaGljaCBpc24ndCBvcHRpbWFsLCBidXQgSSBkb3VidCBpdCBtYXR0ZXJzIG9uIG1v
c3QKYXJjaGl0ZWN0dXJlcy4KClNvIG1heWJlIHdlJ2xsIHNvbWUgZGF5IGhhdmUgYSAidGVzdF9i
aXRfYWNxdWlyZSgpIiBhbmQgYQoic2V0X2JpdF9yZWxlYXNlKCkiIGV0Yy4KCiAgICAgICAgICAg
IExpbnVzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
