Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D0FC433FE
	for <virtualization@archiver.kernel.org>; Fri,  4 Mar 2022 15:22:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3303360D6C;
	Fri,  4 Mar 2022 15:22:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YTmZvLu6J46E; Fri,  4 Mar 2022 15:22:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BF33D60A79;
	Fri,  4 Mar 2022 15:22:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BAD3C001D;
	Fri,  4 Mar 2022 15:22:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F962C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 15:22:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 10BA760D6C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 15:22:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bsFDuF6LecVu
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 15:22:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8420460A79
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 15:22:36 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 n33-20020a05600c3ba100b003832caf7f3aso4155769wms.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 04 Mar 2022 07:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=4W8I3tuoGx81FDxurpr4MQTsgqMFmG2Aaynw/Q1B6WQ=;
 b=k+JiVAPhTAqF+YhhbFY6K4lLY0h6PsOG37nRSTtxjgjMYEjnkXYdM8ue2neMxbOUMd
 glwEwfVtimdk+5VC7t8ggYeOnY3vFNqk37zudCmGNA4+TNvkYjDYVQfjCV/CAIs4sI1J
 /RItdEOsUsK896yZv7ixVficdL48rnKo0v23B8y3bqasDUYTfBDPjodUEJZo6Kl1HVaW
 oca1BIl3h2lxf5XDiEo0TxQNabbqWAne5cV6MTt5iEUN98Z4cS/ySDOn2UOyIMNL8ya6
 vMWMoiSWViYt5GdRRB1HTkWWjm+3YfM+dp8FkzuUCx/WVBqB1GR5Uk7s0Qbv2E2XVoS8
 Z+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=4W8I3tuoGx81FDxurpr4MQTsgqMFmG2Aaynw/Q1B6WQ=;
 b=BYXeRYRXZQX1i1zSwJU3MdMTGcUrWWEqulyfAaokcKuAianc84VtA8aocIk9ScZAdG
 qOVTCH40SPC6UGp9sMmronsF29EXT+8mO8FavhbwUyP6L9GPA+CNIsxuNz1KVar3jqz/
 wZpAHtXF+EogcPVE+CsNMHwQ0c2MvFdN9q+llwjL9ENhSesUMEWPnNKEDBis3URLhfHH
 UuMFqt0kGtYFQnhwzCI2jU2KUE6t1vB7dzeHoxISvS4YUL54ydS/11DLGjd79iL9fNwO
 8/cSar3pWRL0zpVT9KB9OV0w6fSFhl4BAU24vgfTJupAwbAk5WmYrjv9PQr0brxOyVVb
 eb4g==
X-Gm-Message-State: AOAM5318UywWhz7ISxjbPcHBzF2CnRAGw2/TVk71A8M0K1rSeQ/W+CM9
 WU26o71Licar9TCiJGTrs/CbpQ==
X-Google-Smtp-Source: ABdhPJxyPmGIr1XY/Q8xeCKdKIUg6uvyxv3uFluaInb3jO0pRYMOkp8CabliJMJWznAUeyx6sVvC7g==
X-Received: by 2002:a7b:c4c7:0:b0:381:874e:30a9 with SMTP id
 g7-20020a7bc4c7000000b00381874e30a9mr7932742wmk.53.1646407354614; 
 Fri, 04 Mar 2022 07:22:34 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net.
 [86.27.177.88]) by smtp.gmail.com with ESMTPSA id
 z2-20020a056000110200b001e7140ddb44sm4809507wrw.49.2022.03.04.07.22.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Mar 2022 07:22:34 -0800 (PST)
Date: Fri, 4 Mar 2022 15:22:32 +0000
From: Lee Jones <lee.jones@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <YiIuuHwY194VlLPx@google.com>
References: <20220302075421.2131221-1-lee.jones@linaro.org>
 <20220303235937-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220303235937-mutt-send-email-mst@kernel.org>
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

T24gRnJpLCAwNCBNYXIgMjAyMiwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgoKPiBPbiBXZWQs
IE1hciAwMiwgMjAyMiBhdCAwNzo1NDoyMUFNICswMDAwLCBMZWUgSm9uZXMgd3JvdGU6Cj4gPiB2
aG9zdF92c29ja19oYW5kbGVfdHhfa2ljaygpIGFscmVhZHkgaG9sZHMgdGhlIG11dGV4IGR1cmlu
ZyBpdHMgY2FsbAo+ID4gdG8gdmhvc3RfZ2V0X3ZxX2Rlc2MoKS4gIEFsbCB3ZSBoYXZlIHRvIGRv
IGlzIHRha2UgdGhlIHNhbWUgbG9jawo+ID4gZHVyaW5nIHZpcnRxdWV1ZSBjbGVhbi11cCBhbmQg
d2UgbWl0aWdhdGUgdGhlIHJlcG9ydGVkIGlzc3Vlcy4KPiA+IAo+ID4gTGluazogaHR0cHM6Ly9z
eXprYWxsZXIuYXBwc3BvdC5jb20vYnVnP2V4dGlkPTI3OTQzMmQzMGQ4MjVlNjNiYTAwCj4gPiAK
PiA+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4KPiA+IFJlcG9ydGVkLWJ5OiBzeXpib3Qr
YWRjM2NiMzIzODU1ODZiZWM4NTlAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQo+ID4gU2lnbmVk
LW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KPiAKPiBTbyBjb21iaW5l
IHdpdGggdGhlIHdhcm5pbmcgcGF0Y2ggYW5kIHVwZGF0ZSBkZXNjcmlwdGlvbiB3aXRoCj4gdGhl
IGNvbW1lbnQgSSBwb3N0ZWQsIGV4cGxhaW5pbmcgaXQncyBtb3JlIGEganVzdCBpbiBjYXNlIHRo
aW5nLgoKV2lsbCBkby4gIFBsYW4gaXMgdG8gc3VibWl0IHRoaXMgb24gTW9uZGF5LgoKLS0gCkxl
ZSBKb25lcyBb5p2O55C85pavXQpQcmluY2lwYWwgVGVjaG5pY2FsIExlYWQgLSBEZXZlbG9wZXIg
U2VydmljZXMKTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFybSBTb0Nz
CkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
