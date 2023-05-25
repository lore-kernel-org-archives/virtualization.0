Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF0BC77B7A
	for <virtualization@archiver.kernel.org>; Thu, 25 May 2023 16:20:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7384642779;
	Thu, 25 May 2023 16:20:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7384642779
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=cyBtGGgX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qUtTtiJfIZ0p; Thu, 25 May 2023 16:20:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AA331426FB;
	Thu, 25 May 2023 16:20:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AA331426FB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 830BFC0035;
	Thu, 25 May 2023 16:20:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A11EAC002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 16:20:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6ED7484288
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 16:20:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6ED7484288
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=linux-foundation.org
 header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google
 header.b=cyBtGGgX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EbmHfzikllYP
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 16:20:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7FC3584290
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7FC3584290
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 16:20:39 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-50db91640d3so4192683a12.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 09:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1685031637; x=1687623637;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ku5sOb6PtVoCvGfeJzKGQIZVhFagEKIux+ec1ZmkO4g=;
 b=cyBtGGgXTlKq/fWMHAYSy9t4ttd9b0HjwhBbN5daA/ji2b6U758HkOD8HYB0IbMbbN
 6FtT3nfQnF6RdFfDrAiG5nEfocW+C/buJa2gerWcgrnKXIxCgu7f/Be5+76FMRKJwX6Q
 108hgY23w2a0YeltknoI1aadc9bfeAa47r32c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685031637; x=1687623637;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ku5sOb6PtVoCvGfeJzKGQIZVhFagEKIux+ec1ZmkO4g=;
 b=ROhtCxHcj973t2twI5ZzBjlpojcFoHA1IeK+oTAb54jYUpPGyqQPgqIEWIclqrtSUR
 0/ZoXuDaeUyDEze30WWnNfexDP34hgv1fT2f1lyYcOXdp9Pm0fDFPpkmY/w8U/ZLebWh
 GDVBGNMXMXHK26oN0v74hdsDwbbvXyfLQ6HIndPFoNILdieOLn6n/WitijAtwqkdOPrD
 x1KdW19uKt6HC++xiBSdP4C3XTJE9dzq50wTXTxiPEGL82eY7W8sJnVtYauUxKPdtZ6V
 AAubnMWkJ2OcsNooCD9qegPsmb4UPqGk34edjP7InjqWtlrPcKul8gEsHBvvaXlEYmr4
 vw9Q==
X-Gm-Message-State: AC+VfDw50sfBvDTJDwuWz0iTT0yj8oUbRrgpyWOm2S4YlDvsGpkORKnY
 mShisKEKWkpRL0kQVLlICBokiv6wyo2B1adbMqUpD8wP7ok=
X-Google-Smtp-Source: ACHHUZ5TifxWvJ2ZtA78agzjYN/WYBi2CHRRpao15Z0CP/oosALNnvbNszGBnouP3lnwMSWLDRJaZw==
X-Received: by 2002:a17:906:58cf:b0:966:eb8:2f12 with SMTP id
 e15-20020a17090658cf00b009660eb82f12mr2426711ejs.11.1685031637510; 
 Thu, 25 May 2023 09:20:37 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com.
 [209.85.208.52]) by smtp.gmail.com with ESMTPSA id
 g6-20020a170906394600b0096f8ec46498sm1025940eje.2.2023.05.25.09.20.36
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 May 2023 09:20:37 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-510ede0f20aso4142824a12.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 09:20:36 -0700 (PDT)
X-Received: by 2002:a17:907:7207:b0:96f:7e14:3084 with SMTP id
 dr7-20020a170907720700b0096f7e143084mr2270332ejc.44.1685031636699; Thu, 25
 May 2023 09:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230522025124.5863-1-michael.christie@oracle.com>
 <20230522025124.5863-4-michael.christie@oracle.com>
 <20230522123029.GA22159@redhat.com>
 <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com>
 <20230522174757.GC22159@redhat.com>
 <20230523121506.GA6562@redhat.com>
 <87bkib6nxr.fsf@email.froward.int.ebiederm.org>
 <20230524141022.GA19091@redhat.com>
 <87ttw1zt4i.fsf@email.froward.int.ebiederm.org>
 <20230525115512.GA9229@redhat.com>
 <87y1lcxwcj.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87y1lcxwcj.fsf@email.froward.int.ebiederm.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 May 2023 09:20:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj4DS=2F5mW+K2P7cVqrsuGd3rKE_2k2BqnnPeeYhUCvg@mail.gmail.com>
Message-ID: <CAHk-=wj4DS=2F5mW+K2P7cVqrsuGd3rKE_2k2BqnnPeeYhUCvg@mail.gmail.com>
Subject: Re: [PATCH 3/3] fork,
 vhost: Use CLONE_THREAD to fix freezer/ps regression
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: axboe@kernel.dk, brauner@kernel.org, mst@redhat.com,
 linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
 stefanha@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
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

T24gVGh1LCBNYXkgMjUsIDIwMjMgYXQgODozMOKAr0FNIEVyaWMgVy4gQmllZGVybWFuIDxlYmll
ZGVybUB4bWlzc2lvbi5jb20+IHdyb3RlOgo+Cj4gQmFzaWNhbGx5IHdpdGggbm8gcGF0Y2hlcyB0
aGF0IGlzIHdoZXJlIExpbnVzJ3Mga2VybmVsIGlzLgo+Cj4gVXNlciBjb21wbGFpbmVkIGFib3V0
IHRoZSBuZXcgdGhyZWFkIHNob3dpbmcgdXAgaW4gcHMuCgpXZWxsLCBub3Qgb25seSB0aGF0LCBi
dXQgaXQgYWN0aXZlbHkgYnJva2UgZXhpc3Rpbmcgd29ya2Zsb3dzIGZvcgptYW5hZ2luZyB0aGlu
Z3MuIFNob3dpbmcgdXAgaW4gJ3BzJyB3YXNuJ3QganVzdCBzb21lIHB1cmVseSBjb3NtZXRpYwpp
c3N1ZSwgYnV0IGhhZCBzZW1hbnRpYyBtZWFuaW5nLgoKQW5kIGhvbmVzdGx5LCBJIHRoaW5rIHRo
ZSBjb3JlIGlzc3VlIGlzIHRoYXQgd2Ugc2hvdWxkIGp1c3QgbWFrZSB0aGlzCndvcmsuIEtlcm5l
bCB0aHJlYWRzIHJhbmRvbWx5IHN3aXRjaGluZyB0byB1c2VyIG1lbW9yeSB0aHJlYWRzIHdhcwp3
cm9uZywgc28gQ0xPTkVfVk0gaXMgYWJzb2x1dGVseSB0aGUgcmlnaHQgdGhpbmcgdG8gZG8uCgpC
dXQgd2hpbGUgIkNMT05FX1ZNIHdpdGhvdXQgcmVhbCB0aHJlYWRpbmciIGlzIGEgdmVyeSB0cmFk
aXRpb25hbAp0aGluZyBpbiBMaW51eCAtIGl0IHdhcyB0aGUgb3JpZ2luYWwgbW9kZWwgZm9yIGNs
b25lKCksIGFmdGVyIGFsbCAtIEkKZG9uJ3QgYmVsaWV2ZSBpdCBpcyB0aGUgKmNvcnJlY3QqIG1v
ZGVsLiBUaGVyZSB3YXMgYSB2ZXJ5IHJlYWwgcmVhc29uCmNsb25lKCkgaGFzIGdyb3duIENMT05F
X1RIUkVBRCBhbmQgZnJpZW5kcy4KClNvIGhvbmVzdGx5LCBJIHJlYWxseSB0aGluayB3ZSB3YW50
IHRvIGNvbXBsZXRlIHRoZSB2aG9zdCBtb3ZlIHRvCkNMT05FX1RIUkVBRCAoYW5kIHRodXMgQ0xP
TkVfU0lHTkFMKS4KCk5vdCBiZWNhdXNlIHRoZSBvbGQga3RocmVhZCBtb2RlbCBkaWRuJ3QgX3dv
cmtfLCBidXQgYmVjYXVzZSBpdCdzCnJlYWxseSByZWFsbHkgd3JvbmcgdG8gdHJ5IHRvIHJhbmRv
bWx5IHRha2Ugb24gdXNlci1zcGFjZSBhdHRyaWJ1dGVzCmF0IHJ1bi10aW1lLgoKQW5kIG9uY2Ug
eW91IGRvIHRoZSAidXNlciB0aHJlYWRzIGluIGtlcm5lbCBzcGFjZSIgbW9kZWwsIGF0IHRoYXQK
cG9pbnQgeW91IHJlYWxseSBkbyB3YW50IHRvIGFjdCBsaWtlIGEgcHJvcGVyIHRocmVhZC4gQm90
aCBiZWNhdXNlIG9mCnRoYXQgJ3BzJyBpc3N1ZSAod2hpY2ggaXMgcmVhbGx5IGp1c3QgInNob3cg
dGhlIHdvcmxkIHdoYXQgeW91cgpyZWxhdGlvbnNoaXAgaXMpLCBidXQgc2ltcGx5IGJlY2F1c2Ug
dGhhdCBpcyB0aGUgbW9kZXJuIHRocmVhZGluZwptb2RlbCB0aGF0IHdlIHVzZSBmb3IgZXZlcnl0
aGluZyBlbHNlLCBhbmQgc3BlY2lhbCBjYXNlcyBhcmUgYmFkLgoKU28gSSdkIHJlYWxseSBsaWtl
IHRvIGZpbmlzaCB0aGlzLiBFdmVuIGlmIHdlIGVuZCB1cCB3aXRoIGEgaGFjayBvcgp0d28gaW4g
c2lnbmFsIGhhbmRsaW5nIHRoYXQgd2UgY2FuIGhvcGVmdWxseSBmaXggdXAgbGF0ZXIgYnkgaGF2
aW5nCnZob3N0IGZpeCB1cCBzb21lIG9mIGl0cyBjdXJyZW50IGFzc3VtcHRpb25zLgoKSXQgaGFz
IHdvcmtlZCB3b25kZXJmdWxseSB3ZWxsIGZvciBpb191cmluZyAtIGJ1dCB3ZSAqZGlkKiBoYXZl
IHF1aXRlCmEgYml0IG9mIGNvbnZlcnNpb24gcGF0Y2hlcyBvdmVyIHNvbWUgdGltZSBhcyBwZW9w
bGUgZm91bmQgaXNzdWVzLgpXaGljaCBpcyB3aHkgSSBkb24ndCBleHBlY3QgdGhlIHZob3N0IGNv
bmV2cnNpb24gdG8gYmUgZW50aXJlbHkKcGFpbi1mcmVlIGVpdGhlciwgYW5kIEkgZG9uJ3QgdGhp
bmsgd2UgbmVjZXNzYXJpbHkgaGF2ZSB0byBnZXQgdG8gYQoicGVyZmVjdCBhbmQgY2xlYW4iIHN0
YXRlIGltbWVkaWF0ZWx5LCBqdXN0IGEgIndvcmtpbmcgYW5kCmNvbmNlcHR1YWxseSBpbiB0aGUg
cmlnaHQgZGlyZWN0aW9uIiBzdGF0ZS4KCiAgICAgICAgICAgICBMaW51cwpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
