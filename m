Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1848C77B7D
	for <virtualization@archiver.kernel.org>; Fri,  5 May 2023 18:22:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A9E641F24;
	Fri,  5 May 2023 18:22:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2A9E641F24
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=iJC23qAX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LW3aMiEvI4fc; Fri,  5 May 2023 18:22:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8CE4E41F0A;
	Fri,  5 May 2023 18:22:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8CE4E41F0A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71332C0037;
	Fri,  5 May 2023 18:22:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1CAEC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 May 2023 18:22:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7ECE1405C6
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 May 2023 18:22:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7ECE1405C6
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=linux-foundation.org
 header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google
 header.b=iJC23qAX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TRFuHy1Cm4IO
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 May 2023 18:22:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B845040558
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B845040558
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 May 2023 18:22:30 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-965ab8ed1fcso371319766b.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 05 May 2023 11:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1683310949; x=1685902949;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=niEyfzemTkaSRMh1nlyeJEnYlz7/sxOKWncwH1LouFI=;
 b=iJC23qAXTnZu1/hs2pR00TxU+pl1QsxCHv+6emnZaN2mDWfpYdOYzNJ/xOlGwUx0zZ
 svSOlma0QzDDLYz5p6+511G5/ZEQ2kzaVYMRIzYosYCatwbtboe0RMI8ByPcyJZ2ILT9
 OY0sXzt4j8OfP64qVB3e8RC4UCuLfxsD7G2Q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683310949; x=1685902949;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=niEyfzemTkaSRMh1nlyeJEnYlz7/sxOKWncwH1LouFI=;
 b=DOvyiik8WzBBZ3UvNonwiLKVdfTg26qKvOf5AcXKJt63Utjv5CvyY8yQ8FCV7rPfIg
 ymXqYoJDAI0fXQlTdnL3wBT/KeApbvl28vW9pHlz949bXlKJDaJupaLAeTDFmZTLUl7Y
 Rp5JaKh4LEAnHu5J7+aZMyVItL2ld/hRLoFOkaVwrcM1qQs3CdSN/fMnCjUnkO1gmscO
 wL6LSI7reay0NzTcsjjCGcu7BUs/h35ejjq+XrKIIPgoA/ygdt6PdnTPN7JaoqKkMRzV
 f/2whtZrRP8RhjLZl7AZ2VDykJMlJRF//SzPc7MpAH1RZJ+tIgMETFM/ADUyhxvLyTGv
 MBEQ==
X-Gm-Message-State: AC+VfDwvSAEiGIcuWnpzm5YdCAlFZ9LeuHxgaKFycOUqrqG6vpV6V+vQ
 Wl1UM6wjQ7WIC3qHW7F/Qji1sWOpBX3k8RHFoMTDtoLt
X-Google-Smtp-Source: ACHHUZ4gXg/4pMG7hYA8AZ707Xzmciigxy3ciTenV7KT8in0eBTt1OgbtgZM91nY+KuKMyU282bupQ==
X-Received: by 2002:a17:907:8692:b0:94f:39b4:e32c with SMTP id
 qa18-20020a170907869200b0094f39b4e32cmr2390950ejc.43.1683310948543; 
 Fri, 05 May 2023 11:22:28 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com.
 [209.85.218.54]) by smtp.gmail.com with ESMTPSA id
 i19-20020a17090685d300b0094ebc041e20sm1220856ejy.46.2023.05.05.11.22.26
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 May 2023 11:22:26 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-95f4c5cb755so372817766b.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 05 May 2023 11:22:26 -0700 (PDT)
X-Received: by 2002:a17:907:720f:b0:933:1134:be1e with SMTP id
 dr15-20020a170907720f00b009331134be1emr2160145ejc.53.1683310946183; Fri, 05
 May 2023 11:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com>
 <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
In-Reply-To: <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 May 2023 11:22:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com>
Message-ID: <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com>
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
To: nicolas.dichtel@6wind.com, Christian Brauner <brauner@kernel.org>
Cc: mst@redhat.com, konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 ebiederm@xmission.com, stefanha@redhat.com
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

T24gRnJpLCBNYXkgNSwgMjAyMyBhdCA2OjQw4oCvQU0gTmljb2xhcyBEaWNodGVsCjxuaWNvbGFz
LmRpY2h0ZWxANndpbmQuY29tPiB3cm90ZToKPgo+IElzIHRoaXMgYW4gaW50ZW5kZWQgYmVoYXZp
b3I/Cj4gVGhpcyBicmVha3Mgc29tZSBvZiBvdXIgc2NyaXB0cy4KCkl0IGRvZXNuJ3QganVzdCBi
cmVhayB5b3VyIHNjcmlwdHMgKHdoaWNoIGNvdW50cyBhcyBhIHJlZ3Jlc3Npb24pLCBJCnRoaW5r
IGl0J3MgcmVhbGx5IHdyb25nLgoKVGhlIHdvcmtlciB0aHJlYWRzIHNob3VsZCBzaG93IHVwIGFz
IHRocmVhZHMgb2YgdGhlIHRoaW5nIHRoYXQgc3RhcnRlZAp0aGVtLCBub3QgYXMgcHJvY2Vzc2Vz
LgoKU28gdGhleSBzaG91bGQgc2hvdyB1cCBpbiAncHMnIG9ubHkgd2hlbiBvbmUgb2YgdGhlICJz
aG93IHRocmVhZHMiIGZsYWcgaXMgc2V0LgoKQnV0IEkgc3VzcGVjdCB0aGUgZml4IGlzIHRyaXZp
YWw6ICB0aGUgdmlydGlvIGNvZGUgc2hvdWxkIGxpa2VseSB1c2UKQ0xPTkVfVEhSRUFEIGZvciB0
aGUgY29weV9wcm9jZXNzKCkgaXQgZG9lcy4KCkl0IHNob3VsZCBsb29rIG1vcmUgbGlrZSAiY3Jl
YXRlX2lvX3RocmVhZCgpIiB0aGFuICJjb3B5X3Byb2Nlc3MoKSIsIEkgdGhpbmsuCgpGb3IgZXhh
bXBsZSwgZG8gdmlydGlvIHdvcmtlciB0aHJlYWRzIHJlYWxseSB3YW50IHRoZWlyIG93biBzaWdu
YWxzCmFuZCBmaWxlcz8gVGhhdCBzb3VuZHMgd3JvbmcuIGNyZWF0ZV9pb190aHJlYWQoKSB1c2Vz
IGFsbCBvZgoKIENMT05FX0ZTfENMT05FX0ZJTEVTfENMT05FX1NJR0hBTkR8Q0xPTkVfVEhSRUFE
fENMT05FX0lPCgp0byBzaGFyZSBtdWNoIG1vcmUgb2YgdGhlIGNvbnRleHQgd2l0aCB0aGUgcHJv
Y2VzcyBpdCBpcyBhY3R1YWxseSBydW4gd2l0aGluLgoKQ2hyaXN0aWFuPyBNaWtlPwoKICAgICAg
ICAgICAgICAgIExpbnVzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
