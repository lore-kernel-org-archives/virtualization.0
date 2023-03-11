Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11236C6FD1C
	for <virtualization@archiver.kernel.org>; Sat, 11 Mar 2023 17:21:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7566240391;
	Sat, 11 Mar 2023 17:21:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7566240391
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=bq0ksj/O
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W73Lko5rEpY7; Sat, 11 Mar 2023 17:21:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EFA8C400C4;
	Sat, 11 Mar 2023 17:21:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EFA8C400C4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C49C0C0071;
	Sat, 11 Mar 2023 17:21:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19780C0032
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Mar 2023 17:21:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E0F2741B2C
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Mar 2023 17:21:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E0F2741B2C
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=linux-foundation.org
 header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google
 header.b=bq0ksj/O
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GoGdtVPfVyhU
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Mar 2023 17:21:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D8E9E41849
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D8E9E41849
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Mar 2023 17:21:34 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id r15so5773604edq.11
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Mar 2023 09:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1678555292;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PcyIKKidvdnUoalhAwrLa874ozqa2TDtvQ0KGDZ6tLY=;
 b=bq0ksj/OxdNKgwNFgCnMNiOkKhkZK+jlz82BfV8zxQqpNeomWHcelcWvY9ytsvPbcj
 OfwQNwlze5lOq2Fjoj2rsu3oOHMD76HKjE0wTbiys75WBsVoNG1r+50+ZIQQHKKQ36ep
 rW+RyoCNK/+5q3qUsKUT6e4CiDwxlJOoze7f8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678555292;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PcyIKKidvdnUoalhAwrLa874ozqa2TDtvQ0KGDZ6tLY=;
 b=AF8mpw5TAT21nS+gQwL+Zq+qxUljXH1GdoUlgpmmEwwzR2ZlZX0/B0CzkW4ZONs/qQ
 RGQ7ybUMVbjlSanyOYVgW1bMJOjjEA7Sxqyz7MnJryJ9gGEEXZmO4gL8ouqV0OHvu7Sw
 QMbLWt4R4X7YsJgGqBekr/fa6O/2wFP52pHHzvT7AagDk78R5yDgEcLWp6YOHS+FRKP6
 H3Knxbog3sjYnITpfAXUaGvXK+T+G48B8uUnfb+7KOApYGhSGJz3J7ktxR7XMShX1Fyf
 MTKV+kQ0CBd6aXZYghBhbiIMiXb78Aa3cX5iV9SUIPwU6QGkxy2RyDtTBeke3m8qQ99o
 CrDQ==
X-Gm-Message-State: AO0yUKVJ44jvwub8JIy74BIC8e3QDsKmR2PB8OQ+CHPOabsza24L7DZm
 Jg01p07RMkrp/HGcZwsf0Be8iElZwHp8R8RokMPqdGWG
X-Google-Smtp-Source: AK7set/l1EtT3FLwFJ3apvEvZjY2SrMlfpdokSBTVtGejiCTl4kfqzlPQ/TvVWcsO6qWzwX39Glzvg==
X-Received: by 2002:a17:907:9702:b0:8b2:d30:e722 with SMTP id
 jg2-20020a170907970200b008b20d30e722mr37405496ejc.3.1678555292355; 
 Sat, 11 Mar 2023 09:21:32 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com.
 [209.85.208.46]) by smtp.gmail.com with ESMTPSA id
 g14-20020a170906594e00b008be5b97ca49sm1276454ejr.150.2023.03.11.09.21.31
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Mar 2023 09:21:31 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id g10so4090043eda.1
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Mar 2023 09:21:31 -0800 (PST)
X-Received: by 2002:a17:906:4997:b0:877:7480:c75d with SMTP id
 p23-20020a170906499700b008777480c75dmr15142962eju.0.1678555291270; Sat, 11
 Mar 2023 09:21:31 -0800 (PST)
MIME-Version: 1.0
References: <20230310220332.5309-1-michael.christie@oracle.com>
In-Reply-To: <20230310220332.5309-1-michael.christie@oracle.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 11 Mar 2023 09:21:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgenic8Ba1WxNP=9YJXk78k9Sg6R7RLkhduYjtVy2gdkg@mail.gmail.com>
Message-ID: <CAHk-=wgenic8Ba1WxNP=9YJXk78k9Sg6R7RLkhduYjtVy2gdkg@mail.gmail.com>
Subject: Re: [PATCH 00/11] Use copy_process in vhost layer
To: Mike Christie <michael.christie@oracle.com>
Cc: brauner@kernel.org, mst@redhat.com, konrad.wilk@oracle.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 hch@infradead.org, ebiederm@xmission.com, stefanha@redhat.com
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

T24gRnJpLCBNYXIgMTAsIDIwMjMgYXQgMjowNOKAr1BNIE1pa2UgQ2hyaXN0aWUKPG1pY2hhZWwu
Y2hyaXN0aWVAb3JhY2xlLmNvbT4gd3JvdGU6Cj4KPiBUaGUgZm9sbG93aW5nIHBhdGNoZXMgd2Vy
ZSBtYWRlIG92ZXIgTGludXMncyB0cmVlIGFuZCBhcHBseSBvdmVyIG5leHQuIFRoZXkKPiBhbGxv
dyB0aGUgdmhvc3QgbGF5ZXIgdG8gdXNlIGNvcHlfcHJvY2VzcyBpbnN0ZWFkIG9mIHVzaW5nCj4g
d29ya3F1ZXVlX3N0cnVjdHMgdG8gY3JlYXRlIHdvcmtlciB0aHJlYWRzIGZvciBWTSdzIGRldmlj
ZXMuCgpPaywgYWxsIHRoZXNlIHBhdGNoZXMgbG9va2VkIGZpbmUgdG8gbWUgZnJvbSBhIHF1aWNr
IHNjYW4gLSBub3RoaW5nCnRoYXQgSSByZWFjdGVkIHRvIGFzIG9iamVjdGlvbmFibGUsIGFuZCBz
ZXZlcmFsIG9mIHRoZW0gbG9va2VkIGxpa2UKbmljZSBjbGVhbnVwcy4KClRoZSBvbmx5IG9uZSBJ
IHdlbnQgIldoeSBkbyB5b3UgZG8gaXQgdGhhdCB3YXkiIGZvciB3YXMgaW4gMTAvMTEKKGVudGly
ZWx5IGludGVybmFsIHRvIHZob3N0LCBzbyBJIGRvbid0IGZlZWwgdG9vIHN0cm9uZ2x5IGFib3V0
IHRoaXMpCmhvdyB5b3UgbWFkZSAic3RydWN0IHZob3N0X3dvcmtlciIgYmUgYSBwb2ludGVyIGlu
ICJzdHJ1Y3Qgdmhvc3RfZGV2Ii4KCkl0IF9sb29rc18gdG8gbWUgbGlrZSBpdCBjb3VsZCBqdXN0
IGhhdmUgYmVlbiBhbiBlbWJlZGRlZCBzdHJ1Y3R1cmUKcmF0aGVyIHRoYW4gYSBzZXBhcmF0ZSBh
bGxvY2F0aW9uLgoKSU9XLCB3aHkgZG8KCiAgIHZob3N0X2Rldi0+d29ya2VyCgppbnN0ZWFkIG9m
IGRvaW5nCgogIHZob3N0X2Rldi53b3JrZXIKCmFuZCBqdXN0IGhhdmluZyBpdCBhbGwgaW4gdGhl
IHNhbWUgYWxsb2NhdGlvbj8KCk5vdCBhIGJpZyBkZWFsLiBNYXliZSB5b3Ugd2FudGVkIHRoZSAn
dGVzdCBpZiB3b3JrZXIgcG9pbnRlciBpcyBOVUxMJwpjb2RlIHRvIHN0YXkgYXJvdW5kLCBhbmQg
YmFzaWNhbGx5IHVzZSB0aGF0IHBvaW50ZXIgYXMgYSBmbGFnIHRvby4gT3IKbWF5YmUgdGhlcmUg
aXMgc29tZSBvdGhlciByZWFzb24geW91IHdhbnQgdG8ga2VlcCB0aGF0IHNlcGFyYXRlLi4KCiAg
ICAgICAgICAgICAgIExpbnVzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
