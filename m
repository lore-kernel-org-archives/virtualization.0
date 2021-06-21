Return-Path: <SRS0=vACO=LP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA15C4743C
	for <virtualization@archiver.kernel.org>; Mon, 21 Jun 2021 17:22:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24FD46108E
	for <virtualization@archiver.kernel.org>; Mon, 21 Jun 2021 17:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24FD46108E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E2F486085F;
	Mon, 21 Jun 2021 17:21:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QIdYko__ZBXI; Mon, 21 Jun 2021 17:21:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7B6A36078F;
	Mon, 21 Jun 2021 17:21:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24C79C0010;
	Mon, 21 Jun 2021 17:21:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 396E3C000C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 17:21:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 208614015C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 17:21:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VAi4bYBxffiO
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 17:21:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C40D4400DD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 17:21:55 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 j11-20020a9d738b0000b02903ea3c02ded8so18468657otk.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 10:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=paxY+fK5EQubdG5RnsC1ZjKOzBaYyvh9aKCTbSxMuIg=;
 b=k9buZCcFK0A+YKxBKhQDRwPnvJ6wigsxT9C6bDyDXq8dj2ynEUKWmKZFsOsnuA18HC
 rYtI+2h+b9ji7c8K5vFsn9QrHGveinDiGlw9eb0j4iN7qx8bALUWTTxIxQ1rHoDFZ4uO
 aAKW0fK9+VH3MzQtTPWra2jMjzTu1BqwU60/khH00QVSvbionUl1Xl/Ez9IPysCHWFa2
 z+7HAdoi/U4x1jiCsR2cBXpAnNqJI+kGww19eWWa6UlY02Vhvu3ht1dE6TpsJuyaom20
 bSn6Zd5WBhn8AFmhK43lJ+HKOpUnqEkZAj/pzO/7JD2m3CpX0cJWEWMP9a9s9yBsk/AX
 kG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=paxY+fK5EQubdG5RnsC1ZjKOzBaYyvh9aKCTbSxMuIg=;
 b=FQhetykEPxYdj4b2s9UGyNWQq1isVFuA1mJyDkS7mBt83PEOZo7AyXdP04jOKO5LU0
 SRXxn3XzSnDKlvzDx7+Ei5XSDAuQ2BG0JqnN6Df2zfA5E2F+wY4WYJ+Z8VTEX8M1W2yd
 QJGIYOeyBCLS9nrY9MjvA/UDd+/3KmUmZtxSijguln1+VILWImfuWtfzhnabUKcbaHDK
 F5Sa6h2J1/g0EPY0T7kcYpHiZtxh6T1lnzChshNs8fSGynJHTqKOBMKGnlen1DSc6zo0
 j2SxiRmTrZ+3ATorMAsrK58KPFZjnj9ZlOWNCLh9yBavBhAU9pVKhCCyHzjtwNLwGB25
 8A9w==
X-Gm-Message-State: AOAM530fRaoLzG0gRFnzTAG6vKK61NVBQb0N0tJ38tZTkxzP4thJhGpg
 6zjmGRs0nZ/17DBQcU+pYTktPgf+BUTdZDpl7DkG2A==
X-Google-Smtp-Source: ABdhPJxGojkpA2l7BCxHo9kpNZ9FXYKuDj+k3zc4HUOf31x6t7qgIV3GxRTh6g4MFvdh7h/NMtkZe6pExwiORl8Q9Jc=
X-Received: by 2002:a05:6830:1e99:: with SMTP id
 n25mr21556467otr.279.1624296114776; 
 Mon, 21 Jun 2021 10:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210609232501.171257-1-jiang.wang@bytedance.com>
 <20210618093529.bxsv4qnryccivdsd@steredhat.lan>
In-Reply-To: <20210618093529.bxsv4qnryccivdsd@steredhat.lan>
From: "Jiang Wang ." <jiang.wang@bytedance.com>
Date: Mon, 21 Jun 2021 10:21:44 -0700
Message-ID: <CAP_N_Z-LmZYUMY+TyB2E9E00AisnZXcFyD_SM8SeZLB0G2u1ig@mail.gmail.com>
Subject: Re: [External] Re: [RFC v1 0/6] virtio/vsock: introduce SOCK_DGRAM
 support
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: cong.wang@bytedance.com, Andra Paraschiv <andraprs@amazon.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Norbert Slusarek <nslusarek@gmx.net>,
 Xiongchun Duan <duanxiongchun@bytedance.com>,
 Yongji Xie <xieyongji@bytedance.com>, Ingo Molnar <mingo@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexander Popov <alex.popov@linux.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 =?UTF-8?B?5p+056iz?= <chaiwen.cc@bytedance.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Networking <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org, Lu Wei <luwei32@huawei.com>,
 Colin Ian King <colin.king@canonical.com>,
 Arseny Krasnov <arseny.krasnov@kaspersky.com>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
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

T24gRnJpLCBKdW4gMTgsIDIwMjEgYXQgMjozNSBBTSBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6
YXJlQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gV2VkLCBKdW4gMDksIDIwMjEgYXQgMTE6MjQ6
NTJQTSArMDAwMCwgSmlhbmcgV2FuZyB3cm90ZToKPiA+VGhpcyBwYXRjaHNldCBpbXBsZW1lbnRz
IHN1cHBvcnQgb2YgU09DS19ER1JBTSBmb3IgdmlydGlvCj4gPnRyYW5zcG9ydC4KPiA+Cj4gPkRh
dGFncmFtIHNvY2tldHMgYXJlIGNvbm5lY3Rpb25sZXNzIGFuZCB1bnJlbGlhYmxlLiBUbyBhdm9p
ZCB1bmZhaXIgY29udGVudGlvbgo+ID53aXRoIHN0cmVhbSBhbmQgb3RoZXIgc29ja2V0cywgYWRk
IHR3byBtb3JlIHZpcnRxdWV1ZXMgYW5kCj4gPmEgbmV3IGZlYXR1cmUgYml0IHRvIGluZGljYXRl
IGlmIHRob3NlIHR3byBuZXcgcXVldWVzIGV4aXN0IG9yIG5vdC4KPiA+Cj4gPkRncmFtIGRvZXMg
bm90IHVzZSB0aGUgZXhpc3RpbmcgY3JlZGl0IHVwZGF0ZSBtZWNoYW5pc20gZm9yCj4gPnN0cmVh
bSBzb2NrZXRzLiBXaGVuIHNlbmRpbmcgZnJvbSB0aGUgZ3Vlc3QvZHJpdmVyLCBzZW5kaW5nIHBh
Y2tldHMKPiA+c3luY2hyb25vdXNseSwgc28gdGhlIHNlbmRlciB3aWxsIGdldCBhbiBlcnJvciB3
aGVuIHRoZSB2aXJ0cXVldWUgaXMgZnVsbC4KPiA+V2hlbiBzZW5kaW5nIGZyb20gdGhlIGhvc3Qv
ZGV2aWNlLCBzZW5kIHBhY2tldHMgYXN5bmNocm9ub3VzbHkKPiA+YmVjYXVzZSB0aGUgZGVzY3Jp
cHRvciBtZW1vcnkgYmVsb25ncyB0byB0aGUgY29ycmVzcG9uZGluZyBRRU1VCj4gPnByb2Nlc3Mu
Cj4gPgo+ID5UaGUgdmlydGlvIHNwZWMgcGF0Y2ggaXMgaGVyZToKPiA+aHR0cHM6Ly93d3cuc3Bp
bmljcy5uZXQvbGlzdHMvbGludXgtdmlydHVhbGl6YXRpb24vbXNnNTAwMjcuaHRtbAo+ID4KPiA+
Rm9yIHRob3NlIHdobyBwcmVmZXIgZ2l0IHJlcG8sIGhlcmUgaXMgdGhlIGxpbmsgZm9yIHRoZSBs
aW51eCBrZXJuZWzvvJoKPiA+aHR0cHM6Ly9naXRodWIuY29tL0ppYW5nMTE1NS9saW51eC90cmVl
L3Zzb2NrLWRncmFtLXYxCj4gPgo+ID5xZW11IHBhdGNoIGxpbms6Cj4gPmh0dHBzOi8vZ2l0aHVi
LmNvbS9KaWFuZzExNTUvcWVtdS90cmVlL3Zzb2NrLWRncmFtLXYxCj4gPgo+ID4KPiA+VG8gZG86
Cj4gPjEuIHVzZSBza2Igd2hlbiByZWNlaXZpbmcgcGFja2V0cwo+ID4yLiBzdXBwb3J0IG11bHRp
cGxlIHRyYW5zcG9ydAo+ID4zLiBzdXBwb3J0IG1lcmdlYWJsZSByeCBidWZmZXIKPgo+IEppYW5n
LCBJJ2xsIGRvIGEgZmFzdCByZXZpZXcsIGJ1dCBJIHRoaW5rIGlzIGJldHRlciB0byByZWJhc2Ug
b24KPiBuZXQtbmV4dCBzaW5jZSBTRVFQQUNLRVQgc3VwcG9ydCBpcyBub3cgbWVyZ2VkLgo+Cj4g
UGxlYXNlIGFsc28gcnVuIC4vc2NyaXB0cy9jaGVja3BhdGNoLnBsLCB0aGVyZSBhcmUgYSBsb3Qg
b2YgaXNzdWVzLgo+Cj4gSSdsbCBsZWF2ZSBzb21lIHNpbXBsZSBjb21tZW50cyBpbiB0aGUgcGF0
Y2hlcywgYnV0IEkgcHJlZmVyIHRvIGRvIGEKPiBkZWVwIHJldmlldyBhZnRlciB0aGUgcmViYXNl
IGFuZCB0aGUgZHluYW1pYyBoYW5kbGluZyBvZiBER1JBTS4KCkhpIFN0ZWZhbm8sCgpTdXJlLiBJ
IHdpbGwgcmViYXNlIGFuZCBhZGQgZHluYW1pYyBoYW5kbGluZyBvZiBER1JBTS4gSSBydW4gY2hl
Y2twYXRjaC5wbAphdCBzb21lIHBvaW50IGJ1dCBJIHdpbGwgbWFrZSBzdXJlIHRvIHJ1biBpdCBh
Z2FpbiBiZWZvcmUgc3VibWl0dGluZy4gVGhhbmtzLgoKUmVnYXJkcywKCkppYW5nCgoKPiBUaGFu
a3MsCj4gU3RlZmFubwo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
