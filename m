Return-Path: <SRS0=YXi0=PY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31C2C433FE
	for <virtualization@archiver.kernel.org>; Fri,  5 Nov 2021 02:48:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90CE4611CE
	for <virtualization@archiver.kernel.org>; Fri,  5 Nov 2021 02:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 90CE4611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 45A5080EB6;
	Fri,  5 Nov 2021 02:48:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dKeQEJGzigR2; Fri,  5 Nov 2021 02:48:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AEBF580D4F;
	Fri,  5 Nov 2021 02:48:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82DB7C0019;
	Fri,  5 Nov 2021 02:48:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46CA1C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 02:48:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2653340203
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 02:48:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DcH4aV6Ru3bD
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 02:48:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E3671400DE
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 02:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636080530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xCcEqsnBhifvXkjiVwnMz5H8oH0AK0pj5dvEeQNewCw=;
 b=P8PsQLaNAFe15EoPXLqHJvLqhI1Mh4ZsRfcc7kfMHOj+KTZaA4ai9RzeQi6upWs/Xu+UDQ
 bckjdU+b+xk7KUPJ7cKqAWV7BE5QsWEQyjRlON7wF+GsoprcI2J9VfHcjEJI3QvV2BwlwA
 fAYtj+Rj93Mxwt16uTrxiRsLIJWxp/I=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-iw6-Ft7QPsaRPMg0mTDlww-1; Thu, 04 Nov 2021 22:48:49 -0400
X-MC-Unique: iw6-Ft7QPsaRPMg0mTDlww-1
Received: by mail-lf1-f71.google.com with SMTP id
 h40-20020a0565123ca800b00402514d959fso1481731lfv.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 04 Nov 2021 19:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xCcEqsnBhifvXkjiVwnMz5H8oH0AK0pj5dvEeQNewCw=;
 b=qQg2lFrAsEHkzDo17OacpA9nkHoTrqg127p1Tsqs46UVntO45HEVchpmSiM1FISlGd
 opeuGL76LHo+Ft3dC8W1gaG08NqSOTcdBCME5DV/vus6+GXEUV6USKp/RVJl1zGDKLW/
 2M2kMvs9xalSGGzdvvU6ODVy3vnnEKeumceuF1lcGNUWC8Ty7mW6YfXCaVrQ5rfcJowd
 4AgfFYPcX/zzAFxwDhfVZnIu643lONuGiv7c8/nrHPvmm+OeXPyaW35BOdwsP/qY9w/U
 cXYg+fsdUfPw6Qh07CmCjOPpT6jlVx7XVLLE45XhOa+Nrj929IgqY2Vojs5XmGCnD9IU
 EgNA==
X-Gm-Message-State: AOAM532/JhWxL7u4iTWnswn87+MbUgasJmUgeVk0ZYQJ6+ZPKORDP96R
 WLpbgVtdEAtr95EcoBOSmWbhSocMREu3+uBW2Yl9Zv/pyWo2wKT4xn3Q1zmz7ub4I84JOwexEGB
 aFMef9YUgn2pGIdt+c2xEPDbLMUB3GkSjdKO1WBVWM/evYNZcheDje6Hksg==
X-Received: by 2002:ac2:4e68:: with SMTP id y8mr52932393lfs.348.1636080528102; 
 Thu, 04 Nov 2021 19:48:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzS1jRGe/qTBDl1fmwuB1InzojHnj32ucWekjQLu2yHsikj5gNhAUpYDb19ZeRf/IO8Jf3Qu4zH8GujGcXFofc=
X-Received: by 2002:ac2:4e68:: with SMTP id y8mr52932379lfs.348.1636080527953; 
 Thu, 04 Nov 2021 19:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211104195833.2089796-1-eperezma@redhat.com>
In-Reply-To: <20211104195833.2089796-1-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 5 Nov 2021 10:48:37 +0800
Message-ID: <CACGkMEug9Ci=mmQcwPwD0rKo4Lp8Vkz87i5X6H9Y0MfgQNc53g@mail.gmail.com>
Subject: Re: [PATCH] vdpa: Avoid duplicate call to vp_vdpa get_status
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev <netdev@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

T24gRnJpLCBOb3YgNSwgMjAyMSBhdCAzOjU4IEFNIEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUBy
ZWRoYXQuY29tPiB3cm90ZToKPgo+IEl0IGhhcyBubyBzZW5zZSB0byBjYWxsIGdldF9zdGF0dXMg
dHdpY2UsIHNpbmNlIHdlIGFscmVhZHkgaGF2ZSBhCj4gdmFyaWFibGUgZm9yIHRoYXQuCj4KPiBT
aWduZWQtb2ZmLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KCkFja2Vk
LWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKPiAtLS0KPiAgZHJpdmVycy92
aG9zdC92ZHBhLmMgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jIGIvZHJpdmVy
cy92aG9zdC92ZHBhLmMKPiBpbmRleCAwMWM1OWNlN2UyNTAuLjEwNjc2ZWEwMzQ4YiAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5j
Cj4gQEAgLTE2NywxMyArMTY3LDEzIEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfc2V0X3N0YXR1
cyhzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdTggX191c2VyICpzdGF0dXNwKQo+ICAgICAgICAgc3Rh
dHVzX29sZCA9IG9wcy0+Z2V0X3N0YXR1cyh2ZHBhKTsKPgo+ICAgICAgICAgLyoKPiAgICAgICAg
ICAqIFVzZXJzcGFjZSBzaG91bGRuJ3QgcmVtb3ZlIHN0YXR1cyBiaXRzIHVubGVzcyByZXNldCB0
aGUKPiAgICAgICAgICAqIHN0YXR1cyB0byAwLgo+ICAgICAgICAgICovCj4gLSAgICAgICBpZiAo
c3RhdHVzICE9IDAgJiYgKG9wcy0+Z2V0X3N0YXR1cyh2ZHBhKSAmIH5zdGF0dXMpICE9IDApCj4g
KyAgICAgICBpZiAoc3RhdHVzICE9IDAgJiYgKHN0YXR1c19vbGQgJiB+c3RhdHVzKSAhPSAwKQo+
ICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPgo+ICAgICAgICAgaWYgKChzdGF0dXNf
b2xkICYgVklSVElPX0NPTkZJR19TX0RSSVZFUl9PSykgJiYgIShzdGF0dXMgJiBWSVJUSU9fQ09O
RklHX1NfRFJJVkVSX09LKSkKPiAgICAgICAgICAgICAgICAgZm9yIChpID0gMDsgaSA8IG52cXM7
IGkrKykKPiAgICAgICAgICAgICAgICAgICAgICAgICB2aG9zdF92ZHBhX3Vuc2V0dXBfdnFfaXJx
KHYsIGkpOwo+Cj4gLS0KPiAyLjI3LjAKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
