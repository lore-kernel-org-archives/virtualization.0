Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED7FC77B7E
	for <virtualization@archiver.kernel.org>; Thu,  1 Jun 2023 12:26:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1099C61364;
	Thu,  1 Jun 2023 12:26:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1099C61364
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=LGLOY87t
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7Q9boMMYx4yE; Thu,  1 Jun 2023 12:26:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A3C33611DE;
	Thu,  1 Jun 2023 12:26:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A3C33611DE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5EA06C0037;
	Thu,  1 Jun 2023 12:26:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D19B9C0029
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jun 2023 12:26:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A388A42445
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jun 2023 12:26:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A388A42445
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=linux-foundation.org
 header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google
 header.b=LGLOY87t
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OUb6kdUQYYSY
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jun 2023 12:26:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C109442440
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C109442440
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jun 2023 12:26:49 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-97392066d04so102163266b.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 01 Jun 2023 05:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1685622407; x=1688214407;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PJAjrSKk1Ndk8NS3+84Nyv09lcJ/qTEF//Jjgbbt0wY=;
 b=LGLOY87tAQB5Ec3Y/8e9bnJnLtd/lGFTHfUqGHlZ1neCaUmqu9e4KFMZ1Q07UdBUiS
 CdiBESxy9kRbLeq0zuqkHlalm6ndly4hQ8f4MQzhITWaxsDa6sOghru+QBRhIC7SPWq9
 XayY6yOukqd5rQWFrGOCL45YmEWSNMjxMMW2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685622407; x=1688214407;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PJAjrSKk1Ndk8NS3+84Nyv09lcJ/qTEF//Jjgbbt0wY=;
 b=EtFIg3k+YQBuxLzJNadCupPAoSz2ANp/IJxVmT8K/lrLVHJ0GrbUGJMsrMYHTfdb+A
 Gwnmyq/MfNKe45qVUkqgntqdG1XSaCsseqfs38SaQNVmH4FezvEByyolGCL5xF7V/Nv2
 jtu+a0k1vUgnXbD8DbLWMhaG0SxlDoUiDBconrOzjNoQHHp3g+eBaR4tDm/yektfQLvS
 /V1aCt1ZPK9sWRlsKgYz6mMe9mVezKMp1T3nkx5aoTjuIsKWVDIUEWL+TqD5rUBkjIcv
 neMlnFQQ0+h/5PkR+Z5UXNdj70e5I0MPdwWd71BbST57CQgghSknFIr6E6u1KKjoDs9d
 a7ww==
X-Gm-Message-State: AC+VfDyasgXXvvnT33cn2LGyEMljgXOdrstry1Pd5Hp8ZGLzt+sq0sCe
 a3t4CZKHMnjga8AGy62x+xVARFClO1hfvnwBZnKluhXiKQU=
X-Google-Smtp-Source: ACHHUZ6sI/NaAH6QAFmPBoafL98pYHgHm1qQJccrkpFEjrBdBkf8NRdlEvADtAuovgltUZzS4JG4vA==
X-Received: by 2002:a17:907:3e1d:b0:94b:ffe9:37fd with SMTP id
 hp29-20020a1709073e1d00b0094bffe937fdmr8401094ejc.5.1685622407690; 
 Thu, 01 Jun 2023 05:26:47 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com.
 [209.85.218.44]) by smtp.gmail.com with ESMTPSA id
 w5-20020aa7dcc5000000b0050d83a39e6fsm7149329edu.4.2023.06.01.05.26.46
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 05:26:46 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-96f5685f902so101859266b.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 01 Jun 2023 05:26:46 -0700 (PDT)
X-Received: by 2002:a17:907:9412:b0:973:daa0:315 with SMTP id
 dk18-20020a170907941200b00973daa00315mr8333457ejc.1.1685622406136; Thu, 01
 Jun 2023 05:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230519-vormittag-dschungel-83607e9d2255@brauner>
 <ab8c9f95-c9e9-de04-4e28-78163a32da80@leemhuis.info>
 <20230601-herzallerliebst-dschungel-4515db351a0c@brauner>
In-Reply-To: <20230601-herzallerliebst-dschungel-4515db351a0c@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 1 Jun 2023 08:26:29 -0400
X-Gmail-Original-Message-ID: <CAHk-=wgQAgHh_rjiFaAO+Y_mRQvp4SJ7SQ7niVKj89hDmh8Q_A@mail.gmail.com>
Message-ID: <CAHk-=wgQAgHh_rjiFaAO+Y_mRQvp4SJ7SQ7niVKj89hDmh8Q_A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] vhost_tasks: Use CLONE_THREAD/SIGHAND
To: Christian Brauner <brauner@kernel.org>
Cc: axboe@kernel.dk,
 Linux kernel regressions list <regressions@lists.linux.dev>, mst@redhat.com,
 linux-kernel@vger.kernel.org, konrad.wilk@oracle.com,
 Thorsten Leemhuis <linux@leemhuis.info>, oleg@redhat.com, hch@infradead.org,
 ebiederm@xmission.com, stefanha@redhat.com, nicolas.dichtel@6wind.com,
 virtualization@lists.linux-foundation.org
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

T24gVGh1LCBKdW4gMSwgMjAyMyBhdCA2OjQ34oCvQU0gQ2hyaXN0aWFuIEJyYXVuZXIgPGJyYXVu
ZXJAa2VybmVsLm9yZz4gd3JvdGU6Cj4KPiBATWlrZSwgZG8geW91IHdhbnQgdG8gcHJlcGFyZSBh
biB1cGRhdGVkIHZlcnNpb24gb2YgdGhlIHRlbXBvcmFyeSBmaXguCj4gSWYgQExpbnVzIHByZWZl
cnMgdG8ganVzdCBhcHBseSBpdCBkaXJlY3RseSBoZSBjYW4ganVzdCBncmFiIGl0IGZyb20gdGhl
Cj4gbGlzdCByYXRoZXIgdGhhbiBkZWxheWluZyBpdC4gTWFrZSBzdXJlIHRvIGdyYWIgYSBDby1k
ZXZlbG9wZWQtYnkgbGluZQo+IG9uIHRoaXMsIEBNaWtlLgoKWWVhaCwgbGV0J3MgYXBwbHkgdGhl
IGtub3duICJmaXggdGhlIGltbWVkaWF0ZSByZWdyZXNzaW9uIiBwYXRjaCB3cnQKdmhvc3QgcHMg
b3V0cHV0IGFuZCB0aGUgZnJlZXplci4gVGhhdCBnZXRzIHJpZCBvZiB0aGUgcmVncmVzc2lvbi4K
CkkgdGhpbmsgdGhhdCB3ZSBjYW4gLSBhbmQgc2hvdWxkIC0gdGhlbiB0cmVhdCB0aGUgcXVlc3Rp
b25zIGFib3V0IGNvcmUKZHVtcGluZyBhbmQgZXhlY3ZlIGFzIHNlcGFyYXRlIGlzc3Vlcy4KCnZo
b3N0IHdvdWxkbid0IGhhdmUgZG9uZSBleGVjdmUgc2luY2UgaXQncyBub25zZW5zaWNhbCBhbmQg
aGFzIG5ldmVyCndvcmtlZCBhbnl3YXkgc2luY2UgaXQgYWx3YXlzIGxlZnQgdGhlIG9sZCBtbSBy
ZWYgYmVoaW5kLCBhbmQKc2ltaWxhcmx5IGNvcmUgZHVtcGluZyBoYXMgbmV2ZXIgYmVlbiBhbiBp
c3N1ZS4KClNvIG9uIHRob3NlIHRoaW5ncyB3ZSBkb24ndCBoYXZlIGFueSAic2VtYW50aWMiIGlz
c3Vlcywgd2UganVzdCBuZWVkCnRvIG1ha2Ugc3VyZSB3ZSBkb24ndCBkbyBjcmF6eSB0aGluZ3Mg
bGlrZSBoYW5nIHVuaW50ZXJydXB0aWJseS4KCiAgICAgICAgICAgIExpbnVzCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
