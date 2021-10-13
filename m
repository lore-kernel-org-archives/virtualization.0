Return-Path: <SRS0=kx+w=PB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796CDC433EF
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 03:44:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B02260273
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 03:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1B02260273
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DEF61606C6;
	Wed, 13 Oct 2021 03:44:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AeoJxrV4FIyo; Wed, 13 Oct 2021 03:44:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9DEAA60634;
	Wed, 13 Oct 2021 03:44:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78A77C0011;
	Wed, 13 Oct 2021 03:44:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75021C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 03:44:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5795740247
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 03:44:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pxGtULSgy8p2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 03:43:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A7B0F40230
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 03:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634096638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sSCqxNxpX/YZBqwU8uADxkt0zdoagZQctWpdDAVcwO0=;
 b=NfZpi1UZTAckhP/lwBP6jY84Ul7aNHk5oi7/BntAxa0e/f6r4W+px7s02xtSnG2QD7HwJ+
 6pe+ZtSM53jUDf6xcWuAv1IGq9spWcscKq37t3paBfiqls2JcHeTK75B4z7P1rz4Hawt1M
 Op54Qf39lwdlNCmAUmUaB8kJi8Yn20o=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-tExvRst7NnyeXoJJkNCUKA-1; Tue, 12 Oct 2021 23:43:54 -0400
X-MC-Unique: tExvRst7NnyeXoJJkNCUKA-1
Received: by mail-pj1-f71.google.com with SMTP id
 my5-20020a17090b4c8500b001a0bf4025c1so1017771pjb.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 20:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=sSCqxNxpX/YZBqwU8uADxkt0zdoagZQctWpdDAVcwO0=;
 b=ju/DPVC0lxLMw7N+ePbf/feckzuFkpEAfM+Ch7/94Mx1PDOavwlCAp/7zf5ZHk97y9
 oM67+77nHfC3zW48ODdlJVkAlF870KVxu5aYbLeEdjVvwegDedXRt2s7Hvwsa5/NARDM
 l91/NWXm3RncJOKXo3LMoc6IbibUlwSB9l//IopmPAdJOkryREjBqpHscPDI13GQXUbs
 dxLNg/WPmWT39xgCSkER1dmfNVpInECk2tEkwTGCfIs1B3CgHkMicz0Qb5ZMxrxCRGE9
 PsYv+8/EgVW3HHh6VIVel7sULj9IAccrAgCW6x0F/U/ChStTPghNqy0WkeEYNNECAQ07
 4wkg==
X-Gm-Message-State: AOAM530VpuWswpWshLZk4lD9TR3y8he2pvdSEz1oSbqXAB9N8qk9MiG7
 46AL938rehVszhgpK/LRc9GmnaWiiKEctPccWgARE+Yhr5zITQrFCxn3YefqDPDQLdw5myIB4si
 y+juX9WORdp/HVD19zSrODpATKbhyivcLhN1oE+SdQg==
X-Received: by 2002:a17:902:d904:b0:13f:398e:a0df with SMTP id
 c4-20020a170902d90400b0013f398ea0dfmr14953814plz.47.1634096633226; 
 Tue, 12 Oct 2021 20:43:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcy0GT6RbympZLyR3HYopD/EFVo5KeOXXj7adcUcmNAiJI5fQwyNGWLlFtHkaiffUVY9jRbg==
X-Received: by 2002:a17:902:d904:b0:13f:398e:a0df with SMTP id
 c4-20020a170902d90400b0013f398ea0dfmr14953791plz.47.1634096632991; 
 Tue, 12 Oct 2021 20:43:52 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id w11sm12687552pgf.5.2021.10.12.20.43.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Oct 2021 20:43:52 -0700 (PDT)
Subject: Re: [RFC PATCH v4 10/20] vhost-vdpa: Take into account SVQ in
 vhost_vdpa_set_vring_call
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20211001070603.307037-1-eperezma@redhat.com>
 <20211001070603.307037-11-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6f10e27f-b40b-8c79-f829-3073f226eb6c@redhat.com>
Date: Wed, 13 Oct 2021 11:43:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211001070603.307037-11-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Parav Pandit <parav@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Eric Blake <eblake@redhat.com>, Michael Lilja <ml@napatech.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIxLzEwLzEg5LiL5Y2IMzowNSwgRXVnZW5pbyBQw6lyZXog5YaZ6YGTOgo+IFNpZ25l
ZC1vZmYtYnk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRoYXQuY29tPgo+IC0tLQo+ICAg
aHcvdmlydGlvL3Zob3N0LXZkcGEuYyB8IDE3ICsrKysrKysrKysrKysrLS0tCj4gICAxIGZpbGUg
Y2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQg
YS9ody92aXJ0aW8vdmhvc3QtdmRwYS5jIGIvaHcvdmlydGlvL3Zob3N0LXZkcGEuYwo+IGluZGV4
IDU3YTg1NzQ0NGEuLmJjMzRkZTI0MzkgMTAwNjQ0Cj4gLS0tIGEvaHcvdmlydGlvL3Zob3N0LXZk
cGEuYwo+ICsrKyBiL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMKPiBAQCAtNjQ5LDE2ICs2NDksMjcg
QEAgc3RhdGljIGludCB2aG9zdF92ZHBhX3NldF92cmluZ19raWNrKHN0cnVjdCB2aG9zdF9kZXYg
KmRldiwKPiAgICAgICByZXR1cm4gdmhvc3RfdmRwYV9jYWxsKGRldiwgVkhPU1RfU0VUX1ZSSU5H
X0tJQ0ssIGZpbGUpOwo+ICAgfQo+ICAgCj4gK3N0YXRpYyBpbnQgdmhvc3RfdmRwYV9zZXRfdnJp
bmdfZGV2X2NhbGwoc3RydWN0IHZob3N0X2RldiAqZGV2LAo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2aG9zdF92cmluZ19maWxlICpmaWxlKQo+ICt7
Cj4gKyAgICB0cmFjZV92aG9zdF92ZHBhX3NldF92cmluZ19jYWxsKGRldiwgZmlsZS0+aW5kZXgs
IGZpbGUtPmZkKTsKPiArICAgIHJldHVybiB2aG9zdF92ZHBhX2NhbGwoZGV2LCBWSE9TVF9TRVRf
VlJJTkdfQ0FMTCwgZmlsZSk7Cj4gK30KPiArCj4gICBzdGF0aWMgaW50IHZob3N0X3ZkcGFfc2V0
X3ZyaW5nX2NhbGwoc3RydWN0IHZob3N0X2RldiAqZGV2LAo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZob3N0X3ZyaW5nX2ZpbGUgKmZpbGUpCj4gICB7
Cj4gICAgICAgc3RydWN0IHZob3N0X3ZkcGEgKnYgPSBkZXYtPm9wYXF1ZTsKPiAgICAgICBpbnQg
dmRwYV9pZHggPSB2aG9zdF92ZHBhX2dldF92cV9pbmRleChkZXYsIGZpbGUtPmluZGV4KTsKPiAg
IAo+IC0gICAgdHJhY2Vfdmhvc3RfdmRwYV9zZXRfdnJpbmdfY2FsbChkZXYsIGZpbGUtPmluZGV4
LCBmaWxlLT5mZCk7Cj4gLQo+ICAgICAgIHYtPmNhbGxfZmRbdmRwYV9pZHhdID0gZmlsZS0+ZmQ7
Cj4gLSAgICByZXR1cm4gdmhvc3RfdmRwYV9jYWxsKGRldiwgVkhPU1RfU0VUX1ZSSU5HX0NBTEws
IGZpbGUpOwo+ICsgICAgaWYgKHYtPnNoYWRvd192cXNfZW5hYmxlZCkgewo+ICsgICAgICAgIFZo
b3N0U2hhZG93VmlydHF1ZXVlICpzdnEgPSBnX3B0cl9hcnJheV9pbmRleCh2LT5zaGFkb3dfdnFz
LCB2ZHBhX2lkeCk7Cj4gKyAgICAgICAgdmhvc3Rfc3ZxX3NldF9ndWVzdF9jYWxsX25vdGlmaWVy
KHN2cSwgZmlsZS0+ZmQpOwo+ICsgICAgICAgIHJldHVybiAwOwo+ICsgICAgfSBlbHNlIHsKPiAr
ICAgICAgICByZXR1cm4gdmhvc3RfdmRwYV9zZXRfdnJpbmdfZGV2X2NhbGwoZGV2LCBmaWxlKTsK
PiArICAgIH0KCgpJIGZlZWwgbGlrZSB3ZSBzaG91bGQgZG8gdGhlIHNhbWUgZm9yIGtpY2sgZmQu
CgpUaGFua3MKCgo+ICAgfQo+ICAgCj4gICBzdGF0aWMgaW50IHZob3N0X3ZkcGFfZ2V0X2ZlYXR1
cmVzKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
