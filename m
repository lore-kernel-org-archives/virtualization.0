Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9FCC433F5
	for <virtualization@archiver.kernel.org>; Sun, 30 Jan 2022 06:50:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 70F97405AE;
	Sun, 30 Jan 2022 06:50:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9TWii2f9O04D; Sun, 30 Jan 2022 06:50:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1D8A1405CE;
	Sun, 30 Jan 2022 06:50:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2FEFC001A;
	Sun, 30 Jan 2022 06:50:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33A7DC000B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Jan 2022 06:50:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1914F40139
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Jan 2022 06:50:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DTSctqE5uMyk
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Jan 2022 06:50:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 02C82400E0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Jan 2022 06:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643525439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bzZVcP/vnAaeDpsixBNZqpLgN2oQGxF+rhswlTNK7r4=;
 b=idu1NGTdASVxsFcvXZ5Qb3T9YWN/7sg6813vq9hvYQIIofDvnmMo04SNoBJ1wsSxv5SfaU
 BixmH60ziu7PDHUsHXrZZHsePtEnryUIS2+PxlEhS466+JRGXkoCEsLM508pWJSUqH0TNv
 pcoNe/7B6h7ICdnzQSBi4E+0JJYduRA=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-1cu6M3SqOdy1mJQeH3eOEw-1; Sun, 30 Jan 2022 01:50:33 -0500
X-MC-Unique: 1cu6M3SqOdy1mJQeH3eOEw-1
Received: by mail-pg1-f199.google.com with SMTP id
 r3-20020a634403000000b0034dea886e0aso6213372pga.21
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jan 2022 22:50:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=bzZVcP/vnAaeDpsixBNZqpLgN2oQGxF+rhswlTNK7r4=;
 b=YgimkShxKFPcI5mtT1GfjNImboOIfpPT6uAsJoztwjnK/xj9/b5I078/nsKB/7tDcE
 ZMkWhHuUlM9y1hU3QvmQXMP4bBf6wWzvwt63loE3L/5DE7M0+i8YK//J8sMROBs0xJN0
 ai2sCY3piRDr2ZGqAvP1AjleccgBx1eZR5QzTiFQCxdYZ2GOGtgGHKyU/ywuwY+3I/h+
 0/p3nW37UI6xLEBmn0sH1Spd9qaCHNma7HIkfzJp3aANaEuSxwud0w9lU+jnzMoI23MB
 Albn3dBkpWHqzIiBaPS7GpUOj/BmFZt8hQSsZyIbaQ1aXq5rtMau7IQ8aiYzXa4i4KHh
 21kg==
X-Gm-Message-State: AOAM5308u+4zStdYosxKu8yNU/gkKh/DeAXq7O5HYdrUoyktpi/CPE2a
 LJSMIdAgruaBlKYdC2E+4UBpCfCUzEmAuLUHTzm0vnZUPsK1tGpyEpbbtiAWXXfAJVp8ajqsNYm
 iLR1JdyF2zsn7m38Cly4sWu8xerjgAloosK5kN6Qzxg==
X-Received: by 2002:a17:902:d50d:: with SMTP id
 b13mr15497347plg.170.1643525432337; 
 Sat, 29 Jan 2022 22:50:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJypCazowZawvAJp3qjD1ARehRzwfZT99zuv2/XaiFEaIcwm835UkiPxGRUs90B9rmw57wev6w==
X-Received: by 2002:a17:902:d50d:: with SMTP id
 b13mr15497312plg.170.1643525432077; 
 Sat, 29 Jan 2022 22:50:32 -0800 (PST)
Received: from [10.72.12.243] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id lt17sm6796189pjb.41.2022.01.29.22.50.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Jan 2022 22:50:31 -0800 (PST)
Message-ID: <42664143-6d0c-b107-ec90-8e6336bae29b@redhat.com>
Date: Sun, 30 Jan 2022 14:50:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH 28/31] vdpa: Expose VHOST_F_LOG_ALL on SVQ
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-29-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220121202733.404989-29-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Gautam Dawar <gdawar@xilinx.com>,
 virtualization@lists.linux-foundation.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 Eric Blake <eblake@redhat.com>
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

CuWcqCAyMDIyLzEvMjIg5LiK5Y2INDoyNywgRXVnZW5pbyBQw6lyZXog5YaZ6YGTOgo+IFNWUSBp
cyBhYmxlIHRvIGxvZyB0aGUgZGlydHkgYml0cyBieSBpdHNlbGYsIHNvIGxldCdzIHVzZSBpdCB0
byBub3QKPiBibG9jayBtaWdyYXRpb24uCj4KPiBBbHNvLCBpZ25vcmUgc2V0IGFuZCBjbGVhciBv
ZiBWSE9TVF9GX0xPR19BTEwgb24gc2V0X2ZlYXR1cmVzIGlmIFNWUSBpcwo+IGVuYWJsZWQuIEV2
ZW4gaWYgdGhlIGRldmljZSBzdXBwb3J0cyBpdCwgdGhlIHJlcG9ydHMgd291bGQgYmUgbm9uc2Vu
c2UKPiBiZWNhdXNlIFNWUSBtZW1vcnkgaXMgaW4gdGhlIHFlbXUgcmVnaW9uLgo+Cj4gVGhlIGxv
ZyByZWdpb24gaXMgc3RpbGwgYWxsb2NhdGVkLiBGdXR1cmUgY2hhbmdlcyBtaWdodCBza2lwIHRo
YXQsIGJ1dAo+IHRoaXMgc2VyaWVzIGlzIGFscmVhZHkgbG9uZyBlbm91Z2guCj4KPiBTaWduZWQt
b2ZmLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiAtLS0KPiAgIGh3
L3ZpcnRpby92aG9zdC12ZHBhLmMgfCAyMCArKysrKysrKysrKysrKysrKysrKwo+ICAgMSBmaWxl
IGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmhv
c3QtdmRwYS5jIGIvaHcvdmlydGlvL3Zob3N0LXZkcGEuYwo+IGluZGV4IGZiMGEzMzhiYWEuLjc1
MDkwZDY1ZTggMTAwNjQ0Cj4gLS0tIGEvaHcvdmlydGlvL3Zob3N0LXZkcGEuYwo+ICsrKyBiL2h3
L3ZpcnRpby92aG9zdC12ZHBhLmMKPiBAQCAtMTAyMiw2ICsxMDIyLDkgQEAgc3RhdGljIGludCB2
aG9zdF92ZHBhX2dldF9mZWF0dXJlcyhzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIHVpbnQ2NF90ICpm
ZWF0dXJlcykKPiAgICAgICBpZiAocmV0ID09IDAgJiYgdi0+c2hhZG93X3Zxc19lbmFibGVkKSB7
Cj4gICAgICAgICAgIC8qIEZpbHRlciBvbmx5IGZlYXR1cmVzIHRoYXQgU1ZRIGNhbiBvZmZlciB0
byBndWVzdCAqLwo+ICAgICAgICAgICB2aG9zdF9zdnFfdmFsaWRfZ3Vlc3RfZmVhdHVyZXMoZmVh
dHVyZXMpOwo+ICsKPiArICAgICAgICAvKiBBZGQgU1ZRIGxvZ2dpbmcgY2FwYWJpbGl0aWVzICov
Cj4gKyAgICAgICAgKmZlYXR1cmVzIHw9IEJJVF9VTEwoVkhPU1RfRl9MT0dfQUxMKTsKPiAgICAg
ICB9Cj4gICAKPiAgICAgICByZXR1cm4gcmV0Owo+IEBAIC0xMDM5LDggKzEwNDIsMjUgQEAgc3Rh
dGljIGludCB2aG9zdF92ZHBhX3NldF9mZWF0dXJlcyhzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsCj4g
ICAKPiAgICAgICBpZiAodi0+c2hhZG93X3Zxc19lbmFibGVkKSB7Cj4gICAgICAgICAgIHVpbnQ2
NF90IGRldl9mZWF0dXJlcywgc3ZxX2ZlYXR1cmVzLCBhY2tlZF9mZWF0dXJlczsKPiArICAgICAg
ICB1aW50OF90IHN0YXR1cyA9IDA7Cj4gICAgICAgICAgIGJvb2wgb2s7Cj4gICAKPiArICAgICAg
ICByZXQgPSB2aG9zdF92ZHBhX2NhbGwoZGV2LCBWSE9TVF9WRFBBX0dFVF9TVEFUVVMsICZzdGF0
dXMpOwo+ICsgICAgICAgIGlmICh1bmxpa2VseShyZXQpKSB7Cj4gKyAgICAgICAgICAgIHJldHVy
biByZXQ7Cj4gKyAgICAgICAgfQo+ICsKPiArICAgICAgICBpZiAoc3RhdHVzICYgVklSVElPX0NP
TkZJR19TX0RSSVZFUl9PSykgewo+ICsgICAgICAgICAgICAvKgo+ICsgICAgICAgICAgICAgKiB2
aG9zdCBpcyB0cnlpbmcgdG8gZW5hYmxlIG9yIGRpc2FibGUgX0ZfTE9HLCBhbmQgdGhlIGRldmlj
ZQo+ICsgICAgICAgICAgICAgKiB3b3VsZCByZXBvcnQgd3JvbmcgZGlydHkgcGFnZXMuIFNWUSBo
YW5kbGVzIGl0Lgo+ICsgICAgICAgICAgICAgKi8KCgpJIGZhaWwgdG8gdW5kZXJzdGFuZCB0aGlz
IGNvbW1lbnQsIEknZCB0aGluayB0aGVyZSdzIG5vIHdheSB0byBkaXNhYmxlIApkaXJ0eSBwYWdl
IHRyYWNraW5nIGZvciBTVlEuCgpUaGFua3MKCgo+ICsgICAgICAgICAgICByZXR1cm4gMDsKPiAr
ICAgICAgICB9Cj4gKwo+ICsgICAgICAgIC8qIFdlIG11c3Qgbm90IGFjayBfRl9MT0cgaWYgU1ZR
IGlzIGVuYWJsZWQgKi8KPiArICAgICAgICBmZWF0dXJlcyAmPSB+QklUX1VMTChWSE9TVF9GX0xP
R19BTEwpOwo+ICsKPiAgICAgICAgICAgcmV0ID0gdmhvc3RfdmRwYV9nZXRfZGV2X2ZlYXR1cmVz
KGRldiwgJmRldl9mZWF0dXJlcyk7Cj4gICAgICAgICAgIGlmIChyZXQgIT0gMCkgewo+ICAgICAg
ICAgICAgICAgZXJyb3JfcmVwb3J0KCJDYW4ndCBnZXQgdmRwYSBkZXZpY2UgZmVhdHVyZXMsIGdv
dCAoJWQpIiwgcmV0KTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
