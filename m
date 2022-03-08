Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0209C433F5
	for <virtualization@archiver.kernel.org>; Tue,  8 Mar 2022 08:01:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 627C540A99;
	Tue,  8 Mar 2022 08:01:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YuqJFsFkc96z; Tue,  8 Mar 2022 08:01:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B04C440A8C;
	Tue,  8 Mar 2022 08:01:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 887F2C0012;
	Tue,  8 Mar 2022 08:01:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD21BC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 08:01:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A993460F19
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 08:01:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U_-sM9yFn8Yw
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 08:01:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 61B3D60E87
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 08:01:37 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id h15so2727381wrc.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 00:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=IucybA/BbH72cgwgMkENy2nc0cw2uppzQpsI3A+UQng=;
 b=n2kvax4T596zRbJNHl3pnQBK56Kh3dAHGIATboCR3y4jygN1ehcf5ApBgDCV5Vb3y2
 SLWndLQ0RqQWcpJbKcyPuO4ztnaTn3WfZR+tAtBuAeiJ0Y4BNeMp+yu7V3xAAAEvQsfw
 vGDZbgQA8EuIXMQU+qtoE3wx/BO1VbroSviRdyIUievVZU8k63A/eymNH8QYO7RND78l
 0P+hi35rqJI6VNdQR07pPSUOTsEeJ7ZspVOX8afsoJi3MTripFjC89dnGdmYHSVLZ1dl
 3WbZw96mkjwI/2AQL/umBpbHA+/2eq+3Ehftz+AHUwt9F0eWyqjKCErDO6inxcJrERVt
 OwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=IucybA/BbH72cgwgMkENy2nc0cw2uppzQpsI3A+UQng=;
 b=jg/3QAYqEU42XXJ+MjN30pLE3hnMg9SPw43/WAdAQsUD69DHOBt0joqH5G7hyQrVxM
 kAqlLzMuFeNPz5W2B/7TgF0C7m8v1VNzxTsEoNSujOHxqlTEFUIa7xNEj0SOdv6nY19G
 WhW0v72o2HfMyWcLURcL+1rw3+tp/xf6Pq5xxeYCTgQOXimcEcZCWTZhrh4g9hWtDQUL
 bWvQ5IDYW5Z/QuykJdLJU3F/K65DI8im0+auYvn0408I/REvNMtccWIUk3dgmt6rMvli
 ZJSfT1o+5YEnvaht98DU3HKAd97yWU3xUV0psIsNmV8fvz70TvWwn4245+4qfamY/FE6
 cbLg==
X-Gm-Message-State: AOAM533a+3pAyxTUwRy2dxuysw0yZNOth7HOzT84H9AMUkSlvz1VREDC
 ctuCVFUdv+OIFVzDOTR2PH9Vkg==
X-Google-Smtp-Source: ABdhPJz+6S70Pvi8hGyqht0OJu08Ak+kz7cIlHduA+N2p+09HFTvirJzU5DqlyxwJQXndXnzxWy20w==
X-Received: by 2002:adf:e7c5:0:b0:1f2:1a3:f1a0 with SMTP id
 e5-20020adfe7c5000000b001f201a3f1a0mr5098043wrn.21.1646726495571; 
 Tue, 08 Mar 2022 00:01:35 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net.
 [86.27.177.88]) by smtp.gmail.com with ESMTPSA id
 bg42-20020a05600c3caa00b00380deeaae72sm1978124wmb.1.2022.03.08.00.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Mar 2022 00:01:35 -0800 (PST)
Date: Tue, 8 Mar 2022 08:01:32 +0000
From: Lee Jones <lee.jones@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <YicNXOlH8al/Rlk3@google.com>
References: <20220307191757.3177139-1-lee.jones@linaro.org>
 <20220307173439-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220307173439-mutt-send-email-mst@kernel.org>
Cc: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
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

T24gTW9uLCAwNyBNYXIgMjAyMiwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgoKPiBPbiBNb24s
IE1hciAwNywgMjAyMiBhdCAwNzoxNzo1N1BNICswMDAwLCBMZWUgSm9uZXMgd3JvdGU6Cj4gPiB2
aG9zdF92c29ja19oYW5kbGVfdHhfa2ljaygpIGFscmVhZHkgaG9sZHMgdGhlIG11dGV4IGR1cmlu
ZyBpdHMgY2FsbAo+ID4gdG8gdmhvc3RfZ2V0X3ZxX2Rlc2MoKS4gIEFsbCB3ZSBoYXZlIHRvIGRv
IGhlcmUgaXMgdGFrZSB0aGUgc2FtZSBsb2NrCj4gPiBkdXJpbmcgdmlydHF1ZXVlIGNsZWFuLXVw
IGFuZCB3ZSBtaXRpZ2F0ZSB0aGUgcmVwb3J0ZWQgaXNzdWVzLgo+IAo+IFBscyBqdXN0IGJhc2lj
YWxseSBjb3B5IHRoZSBjb2RlIGNvbW1lbnQgaGVyZS4gdGhpcyBpcyBqdXN0IGNvbmZ1c2VzLgo+
IAo+ID4gQWxzbyBXQVJOKCkgYXMgYSBwcmVjYXV0aW9uYXJ5IG1lYXN1cmUuICBUaGUgcHVycG9z
ZSBvZiB0aGlzIGlzIHRvCj4gPiBjYXB0dXJlIHBvc3NpYmxlIGZ1dHVyZSByYWNlIGNvbmRpdGlv
bnMgd2hpY2ggbWF5IHBvcCB1cCBvdmVyIHRpbWUuCj4gPiAKPiA+IExpbms6IGh0dHBzOi8vc3l6
a2FsbGVyLmFwcHNwb3QuY29tL2J1Zz9leHRpZD0yNzk0MzJkMzBkODI1ZTYzYmEwMAo+IAo+IEFu
ZCB0aGlzIGlzIGEgYnVnIHdlIGFscmVhZHkgZml4ZWQsIHJpZ2h0PwoKV2VsbCwgdGhpcyB3YXMg
dGhlIGJ1ZyBJIHNldCBvdXQgdG8gZml4LgoKSSBkaWRuJ3Qga25vdyB5b3VyIHBhdGNoIHdhcyBp
biBmbGlnaHQgYXQgdGhlIHRpbWUuCgo+ID4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPgo+
ID4gUmVwb3J0ZWQtYnk6IHN5emJvdCthZGMzY2IzMjM4NTU4NmJlYzg1OUBzeXprYWxsZXIuYXBw
c3BvdG1haWwuY29tCj4gCj4gbm90IHJlYWxseSBhcHBsaWNhYmxlIGFueW1vcmUgLi4uCgpJIGNh
biByZW1vdmUgdGhlc2UgaWYgaXQgaGVscHMuCgotLSAKTGVlIEpvbmVzIFvmnY7nkLzmlq9dClBy
aW5jaXBhbCBUZWNobmljYWwgTGVhZCAtIERldmVsb3BlciBTZXJ2aWNlcwpMaW5hcm8ub3JnIOKU
giBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQXJtIFNvQ3MKRm9sbG93IExpbmFybzogRmFjZWJv
b2sgfCBUd2l0dGVyIHwgQmxvZwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
