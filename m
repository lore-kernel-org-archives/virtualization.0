Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A90EDC77B7D
	for <virtualization@archiver.kernel.org>; Fri,  5 May 2023 06:45:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3996F840CE;
	Fri,  5 May 2023 06:45:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3996F840CE
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XApaVaYh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YRWvwB14X85Y; Fri,  5 May 2023 06:45:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B2AC58401B;
	Fri,  5 May 2023 06:45:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B2AC58401B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 977CDC0037;
	Fri,  5 May 2023 06:45:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CDB90C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 May 2023 06:45:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A72A441F8D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 May 2023 06:45:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A72A441F8D
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XApaVaYh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mPMe1ZS2nRdF
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 May 2023 06:45:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B834D41F8B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B834D41F8B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 May 2023 06:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683269142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tKpAY5tib+SQpvOchvtEiIJtmEfRPK050PpqPwR0jHc=;
 b=XApaVaYhFFSj0aDxsb91UmXPsNa9bPzmfMraB6LF5bFaIrihGBcYGC2cowToau6bISyTMg
 ironTNdNf2qSF4jK/D4yModgtr2NDRn+7e68AMpPycl9P7g2+qBy0AXud6gf90X+2cg7fK
 3u+H88bR7YA2TeulahJgcTliwh/cWpI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-p6GfDGwCMLO7T7Fu0EFEbg-1; Fri, 05 May 2023 02:45:41 -0400
X-MC-Unique: p6GfDGwCMLO7T7Fu0EFEbg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4edc7ab63ccso738642e87.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 04 May 2023 23:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683269140; x=1685861140;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tKpAY5tib+SQpvOchvtEiIJtmEfRPK050PpqPwR0jHc=;
 b=NDZLMVcuPlW48Ix9X3xjX6omNYk9KzdsNCbTCeL9eJzv5LZ1g84pJ45Iz/jBc+K3xh
 XMHn7afLtdWGarbuZDsiC4hmCo33KSfa3IllirL3/Z1eSQn1p0UBxjGu6lHCP6d0MXm1
 ciHekE2/EpM0eoSQEO2thXbSCrjwNgHKjtJnrcSq+Uc6JcoQcn7NkvopywlHxwJ965GL
 eiDzh9D0++QT0dmbFnGCzeqmdWWzeceSTkRyHS/U7VnHbbAUKUBvg4hRdCQbLD+q10w1
 cT7lKTvfs1lKL+Hi9UvlBbSXO9g83VRTPXx6o88HXxxD3lJYAK7p+UjEnvE4kVop39Pk
 FuMg==
X-Gm-Message-State: AC+VfDwKvpjHPzXOma08TfMb4O5Ji+liA8uKymwnsw9mguaC8xyO9S12
 ClHwZTAJ13G03Zri1yUmINSDBk8nyf180ocmqQKT0BkMic5bXjBydp/hCpo7CFNrjVui7L4mME6
 D7hO6YSmb83DUDFlEAcij0zqmTXnty8C7RieDjIdLB82ooa1PwE9+RLU3LQ==
X-Received: by 2002:ac2:442a:0:b0:4dd:afd7:8f1 with SMTP id
 w10-20020ac2442a000000b004ddafd708f1mr243039lfl.52.1683269139921; 
 Thu, 04 May 2023 23:45:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5P/6Ery2ecRIgtV5T5zf4Jc/nCqTDngMKXH4mXgZ7mTAePFoMVTxdzE82a2WU80aozee42X8+tx+80IrXPk0s=
X-Received: by 2002:ac2:442a:0:b0:4dd:afd7:8f1 with SMTP id
 w10-20020ac2442a000000b004ddafd708f1mr243034lfl.52.1683269139638; Thu, 04 May
 2023 23:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <202305051424047152799@zte.com.cn>
In-Reply-To: <202305051424047152799@zte.com.cn>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 5 May 2023 14:45:28 +0800
Message-ID: <CACGkMEsmf3PgxmhgRCsPZe7fRWHDXQ=TtYu5Tgx1=_Ymyvi-pA@mail.gmail.com>
Subject: Re: [PATCH] vhost_net: Use fdget() and fdput()
To: ye.xingchen@zte.com.cn
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com
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

T24gRnJpLCBNYXkgNSwgMjAyMyBhdCAyOjI04oCvUE0gPHllLnhpbmdjaGVuQHp0ZS5jb20uY24+
IHdyb3RlOgo+Cj4gRnJvbTogWWUgWGluZ2NoZW4gPHllLnhpbmdjaGVuQHp0ZS5jb20uY24+Cj4K
PiBjb252ZXJ0IHRoZSBmZ2V0KCkvZnB1dCgpIHVzZXMgdG8gZmRnZXQoKS9mZHB1dCgpLgoKV2hh
dCdzIHRoZSBhZHZhbnRhZ2VzIG9mIHRoaXM/CgpUaGFua3MKCj4KPiBTaWduZWQtb2ZmLWJ5OiBZ
ZSBYaW5nY2hlbiA8eWUueGluZ2NoZW5AenRlLmNvbS5jbj4KPiAtLS0KPiAgZHJpdmVycy92aG9z
dC9uZXQuYyB8IDEwICsrKysrLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygr
KSwgNSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L25ldC5jIGIv
ZHJpdmVycy92aG9zdC9uZXQuYwo+IGluZGV4IGFlMjI3MzE5NmIwYy4uNWIzZmU0ODA1MTgyIDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhvc3QvbmV0LmMKPiArKysgYi9kcml2ZXJzL3Zob3N0L25l
dC5jCj4gQEAgLTE0NjYsMTcgKzE0NjYsMTcgQEAgc3RhdGljIHN0cnVjdCBwdHJfcmluZyAqZ2V0
X3RhcF9wdHJfcmluZyhzdHJ1Y3QgZmlsZSAqZmlsZSkKPgo+ICBzdGF0aWMgc3RydWN0IHNvY2tl
dCAqZ2V0X3RhcF9zb2NrZXQoaW50IGZkKQo+ICB7Cj4gLSAgICAgICBzdHJ1Y3QgZmlsZSAqZmls
ZSA9IGZnZXQoZmQpOwo+ICsgICAgICAgc3RydWN0IGZkIGYgPSBmZGdldChmZCk7Cj4gICAgICAg
ICBzdHJ1Y3Qgc29ja2V0ICpzb2NrOwo+Cj4gLSAgICAgICBpZiAoIWZpbGUpCj4gKyAgICAgICBp
ZiAoIWYuZmlsZSkKPiAgICAgICAgICAgICAgICAgcmV0dXJuIEVSUl9QVFIoLUVCQURGKTsKPiAt
ICAgICAgIHNvY2sgPSB0dW5fZ2V0X3NvY2tldChmaWxlKTsKPiArICAgICAgIHNvY2sgPSB0dW5f
Z2V0X3NvY2tldChmLmZpbGUpOwo+ICAgICAgICAgaWYgKCFJU19FUlIoc29jaykpCj4gICAgICAg
ICAgICAgICAgIHJldHVybiBzb2NrOwo+IC0gICAgICAgc29jayA9IHRhcF9nZXRfc29ja2V0KGZp
bGUpOwo+ICsgICAgICAgc29jayA9IHRhcF9nZXRfc29ja2V0KGYuZmlsZSk7Cj4gICAgICAgICBp
ZiAoSVNfRVJSKHNvY2spKQo+IC0gICAgICAgICAgICAgICBmcHV0KGZpbGUpOwo+ICsgICAgICAg
ICAgICAgICBmZHB1dChmKTsKPiAgICAgICAgIHJldHVybiBzb2NrOwo+ICB9Cj4KPiAtLQo+IDIu
MjUuMQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
