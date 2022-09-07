Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81CBECAAA1
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 02:17:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 26C1F81771;
	Wed,  7 Sep 2022 02:17:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 26C1F81771
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D2tdDIH8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HeOM240iURmo; Wed,  7 Sep 2022 02:17:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7681981767;
	Wed,  7 Sep 2022 02:17:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7681981767
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B6E1C0032;
	Wed,  7 Sep 2022 02:17:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9EAFC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 02:17:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C335740491
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 02:17:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C335740491
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=D2tdDIH8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eWhO8jJBCaJn
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 02:17:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E8B71403D8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E8B71403D8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 02:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662517052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=37pp2dOfkAFH3OGVSOJ+e4RmJm5kCPc4oNtISihYwXE=;
 b=D2tdDIH8Ki/kWYw5iYaySgG+3uskBRABYClmM5mEuWQyQ8R5JuUydp36AEE5bWxEjRzOP/
 JwBc+rJN5O5RX8gA+9jwlGoNqJHIcd5Pvb5H0f72nKxRjajlvaGr3sKao42Hi0tsiTP5Lo
 4bfQd/JulmHMYj6PUcNI0wU96PvywuU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-645-fwOqiWSCP5ySMe_E2V1QNA-1; Tue, 06 Sep 2022 22:17:31 -0400
X-MC-Unique: fwOqiWSCP5ySMe_E2V1QNA-1
Received: by mail-pj1-f71.google.com with SMTP id
 js4-20020a17090b148400b0020061aa46d7so2907595pjb.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 06 Sep 2022 19:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=37pp2dOfkAFH3OGVSOJ+e4RmJm5kCPc4oNtISihYwXE=;
 b=BCeHo3lKgHONIK91PoP+ngjQas8eaz2Eb/VbBNHtX01d8+et/R0uXsnO5AoK+QwoBZ
 bmWuLYwjpIgyzUDkq9FKAYth/Hy6wYWmPv4D3kkxA/rZ0CW5eBoZmo+6Oq/aJgWTQzV+
 UrIjljGkZXGgJCXoS2qZQ/q3F9BONVBfwczF+h0LFFq/8saiwJBaKCu+ZGsvaz1LbzXv
 I9UfoNl0Aa3MMXQ/JJXVdOf47IX0rBqPk3OvlyDgWM2pYeP8+omYtnnZb+RzO43gqkBx
 iKpPV7XVGmb23Oa0ykek9M7y4VPBhZq7yUGKJaoDrBndJaWfb6DD6SGedfb2UhTd+uK5
 XsjA==
X-Gm-Message-State: ACgBeo0JC0wwHWayh+9zjB1X77c+Uyj4CJiKUdaXRVAdjiHp0q6/29pE
 oLKuMJsZYHsjTeoYJdwtculH0G08WHBqACPY/HRByCKTAwPfWM7M9A1q77nXMFTBVdinc2jSBr+
 aP8IVdfyJV2OPKDtYJ3iUaHc86XNyXoasybax2zgNvg==
X-Received: by 2002:a17:902:f68d:b0:174:471b:4794 with SMTP id
 l13-20020a170902f68d00b00174471b4794mr1487358plg.156.1662517050538; 
 Tue, 06 Sep 2022 19:17:30 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4sVuqAhYxMyMk+K7mSSO1Fis+Kh9CIjCFZJYJAYBxX21s1UEUt8zKqzTAfow8lYTs74ob7Zw==
X-Received: by 2002:a17:902:f68d:b0:174:471b:4794 with SMTP id
 l13-20020a170902f68d00b00174471b4794mr1487343plg.156.1662517050239; 
 Tue, 06 Sep 2022 19:17:30 -0700 (PDT)
Received: from [10.72.13.171] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 ik26-20020a170902ab1a00b00172d0c7edf4sm8256869plb.106.2022.09.06.19.17.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Sep 2022 19:17:29 -0700 (PDT)
Message-ID: <a5e1eae0-d977-a625-afa7-69582bf49cb8@redhat.com>
Date: Wed, 7 Sep 2022 10:17:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [virtio-dev] [PATCH v5 2/2] virtio-net: use mtu size as buffer
 length for big packets
To: Gavin Li <gavinl@nvidia.com>, stephen@networkplumber.org,
 davem@davemloft.net, jesse.brandeburg@intel.com,
 alexander.h.duyck@intel.com, kuba@kernel.org, sridhar.samudrala@intel.com,
 loseweigh@gmail.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org,
 mst@redhat.com
References: <20220901021038.84751-1-gavinl@nvidia.com>
 <20220901021038.84751-3-gavinl@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220901021038.84751-3-gavinl@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: gavi@nvidia.com
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

CuWcqCAyMDIyLzkvMSAxMDoxMCwgR2F2aW4gTGkg5YaZ6YGTOgo+IEN1cnJlbnRseSBhZGRfcmVj
dmJ1Zl9iaWcoKSBhbGxvY2F0ZXMgTUFYX1NLQl9GUkFHUyBzZWdtZW50cyBmb3IgYmlnCj4gcGFj
a2V0cyBldmVuIHdoZW4gR1VFU1RfKiBvZmZsb2FkcyBhcmUgbm90IHByZXNlbnQgb24gdGhlIGRl
dmljZS4KPiBIb3dldmVyLCBpZiBndWVzdCBHU08gaXMgbm90IHN1cHBvcnRlZCwgaXQgd291bGQg
YmUgc3VmZmljaWVudCB0bwo+IGFsbG9jYXRlIHNlZ21lbnRzIHRvIGNvdmVyIGp1c3QgdXAgdGhl
IE1UVSBzaXplIGFuZCBubyBmdXJ0aGVyLgo+IEFsbG9jYXRpbmcgdGhlIG1heGltdW0gYW1vdW50
IG9mIHNlZ21lbnRzIHJlc3VsdHMgaW4gYSBsYXJnZSB3YXN0ZSBvZgo+IGJ1ZmZlciBzcGFjZSBp
biB0aGUgcXVldWUsIHdoaWNoIGxpbWl0cyB0aGUgbnVtYmVyIG9mIHBhY2tldHMgdGhhdCBjYW4K
PiBiZSBidWZmZXJlZCBhbmQgY2FuIHJlc3VsdCBpbiByZWR1Y2VkIHBlcmZvcm1hbmNlLgo+Cj4g
VGhlcmVmb3JlLCBpZiBndWVzdCBHU08gaXMgbm90IHN1cHBvcnRlZCwgdXNlIHRoZSBNVFUgdG8g
Y2FsY3VsYXRlIHRoZQo+IG9wdGltYWwgYW1vdW50IG9mIHNlZ21lbnRzIHJlcXVpcmVkLgo+Cj4g
V2hlbiBndWVzdCBvZmZsb2FkIGlzIGVuYWJsZWQgYXQgcnVudGltZSwgUlEgYWxyZWFkeSBoYXMg
cGFja2V0cyBvZiBieXRlcwo+IGxlc3MgdGhhbiA2NEsuIFNvIHdoZW4gcGFja2V0IG9mIDY0S0Ig
YXJyaXZlcywgYWxsIHRoZSBwYWNrZXRzIG9mIHN1Y2gKPiBzaXplIHdpbGwgYmUgZHJvcHBlZC4g
YW5kIFJRIGlzIG5vdyBub3QgdXNhYmxlLgo+Cj4gU28gdGhpcyBtZWFucyB0aGF0IGR1cmluZyBz
ZXRfZ3Vlc3Rfb2ZmbG9hZHMoKSBwaGFzZSwgUlFzIGhhdmUgdG8gYmUKPiBkZXN0cm95ZWQgYW5k
IHJlY3JlYXRlZCwgd2hpY2ggcmVxdWlyZXMgYWxtb3N0IGRyaXZlciByZWxvYWQuCj4KPiBJZiBW
SVJUSU9fTkVUX0ZfQ1RSTF9HVUVTVF9PRkZMT0FEUyBoYXMgYmVlbiBuZWdvdGlhdGVkLCB0aGVu
IGl0IHNob3VsZAo+IGFsd2F5cyB0cmVhdCB0aGVtIGFzIEdTTyBlbmFibGVkLgo+Cj4gQWNjb3Jk
aW5nbHksIGZvciBub3cgdGhlIGFzc3VtcHRpb24gaXMgdGhhdCBpZiBndWVzdCBHU08gaGFzIGJl
ZW4KPiBuZWdvdGlhdGVkIHRoZW4gaXQgaGFzIGJlZW4gZW5hYmxlZCwgZXZlbiBpZiBpdCdzIGFj
dHVhbGx5IGJlZW4gZGlzYWJsZWQKPiBhdCBydW50aW1lIHRocm91Z2ggVklSVElPX05FVF9GX0NU
UkxfR1VFU1RfT0ZGTE9BRFMuCgoKTml0OiBBY3R1YWxseSwgaXQncyBub3QgdGhlIGFzc3VtcHRp
b24gYnV0IHRoZSBiZWhhdmlvciBvZiB0aGUgY29kZXMgCml0c2VsZi4gU2luY2Ugd2UgZG9uJ3Qg
dHJ5IHRvIGNoYW5nZSBndWVzdCBvZmZsb2FkaW5nIGluIHByb2JlIHNvIGl0J3MgCm9rIHRvIGNo
ZWNrIEdTTyB2aWEgbmVnb3RpYXRlZCBmZWF0dXJlcz8KClRoYW5rcwoKCj4KPiBCZWxvdyBpcyB0
aGUgaXBlcmYgVENQIHRlc3QgcmVzdWx0cyBvdmVyIGEgTWVsbGFub3ggTklDLCB1c2luZyB2RFBB
IGZvcgo+IDEgVlEsIHF1ZXVlIHNpemUgMTAyNCwgYmVmb3JlIGFuZCBhZnRlciB0aGUgY2hhbmdl
LCB3aXRoIHRoZSBpcGVyZgo+IHNlcnZlciBydW5uaW5nIG92ZXIgdGhlIHZpcnRpby1uZXQgaW50
ZXJmYWNlLgo+Cj4gTVRVKEJ5dGVzKS9CYW5kd2lkdGggKEdiaXQvcykKPiAgICAgICAgICAgICAg
IEJlZm9yZSAgIEFmdGVyCj4gICAgMTUwMCAgICAgICAgMjIuNSAgICAgMjIuNAo+ICAgIDkwMDAg
ICAgICAgIDEyLjggICAgIDI1LjkKPgo+IFNpZ25lZC1vZmYtYnk6IEdhdmluIExpIDxnYXZpbmxA
bnZpZGlhLmNvbT4KPiBSZXZpZXdlZC1ieTogR2F2aSBUZWl0eiA8Z2F2aUBudmlkaWEuY29tPgo+
IFJldmlld2VkLWJ5OiBQYXJhdiBQYW5kaXQgPHBhcmF2QG52aWRpYS5jb20+Cj4gUmV2aWV3ZWQt
Ynk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gUmV2aWV3ZWQtYnk6
IFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4KPiAtLS0KPiBjaGFuZ2Vsb2c6Cj4g
djQtPnY1Cj4gLSBBZGRyZXNzZWQgY29tbWVudHMgZnJvbSBNaWNoYWVsIFMuIFRzaXJraW4KPiAt
IEltcHJvdmUgY29tbWl0IG1lc3NhZ2UKPiB2My0+djQKPiAtIEFkZHJlc3NlZCBjb21tZW50cyBm
cm9tIFNpLVdlaQo+IC0gUmVuYW1lIGJpZ19wYWNrZXRzX3NnX251bSB3aXRoIGJpZ19wYWNrZXRz
X251bV9za2JmcmFncwo+IHYyLT52Mwo+IC0gQWRkcmVzc2VkIGNvbW1lbnRzIGZyb20gU2ktV2Vp
Cj4gLSBTaW1wbGlmeSB0aGUgY29uZGl0aW9uIGNoZWNrIHRvIGVuYWJsZSB0aGUgb3B0aW1pemF0
aW9uCj4gdjEtPnYyCj4gLSBBZGRyZXNzZWQgY29tbWVudHMgZnJvbSBKYXNvbiwgTWljaGFlbCwg
U2ktV2VpLgo+IC0gUmVtb3ZlIHRoZSBmbGFnIG9mIGd1ZXN0IEdTTyBzdXBwb3J0LCBzZXQgc2df
bnVtIGZvciBiaWcgcGFja2V0cyBhbmQKPiAgICB1c2UgaXQgZGlyZWN0bHkKPiAtIFJlY2FsY3Vs
YXRlIHNnX251bSBmb3IgYmlnIHBhY2tldHMgaW4gdmlydG5ldF9zZXRfZ3Vlc3Rfb2ZmbG9hZHMK
PiAtIFJlcGxhY2UgdGhlIHJvdW5kIHVwIGFsZ29yaXRobSB3aXRoIERJVl9ST1VORF9VUAo+IC0t
LQo+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMzcgKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDEz
IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBi
L2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+IGluZGV4IGY4MzFhMDI5MDk5OC4uZGJmZmQ1ZjU2
ZmI4IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ICsrKyBiL2RyaXZl
cnMvbmV0L3ZpcnRpb19uZXQuYwo+IEBAIC0yMjUsNiArMjI1LDkgQEAgc3RydWN0IHZpcnRuZXRf
aW5mbyB7Cj4gICAJLyogSSBsaWtlLi4uIGJpZyBwYWNrZXRzIGFuZCBJIGNhbm5vdCBsaWUhICov
Cj4gICAJYm9vbCBiaWdfcGFja2V0czsKPiAgIAo+ICsJLyogbnVtYmVyIG9mIHNnIGVudHJpZXMg
YWxsb2NhdGVkIGZvciBiaWcgcGFja2V0cyAqLwo+ICsJdW5zaWduZWQgaW50IGJpZ19wYWNrZXRz
X251bV9za2JmcmFnczsKPiArCj4gICAJLyogSG9zdCB3aWxsIG1lcmdlIHJ4IGJ1ZmZlcnMgZm9y
IGJpZyBwYWNrZXRzIChzaGFrZSBpdCEgc2hha2UgaXQhKSAqLwo+ICAgCWJvb2wgbWVyZ2VhYmxl
X3J4X2J1ZnM7Cj4gICAKPiBAQCAtMTMzMSwxMCArMTMzNCwxMCBAQCBzdGF0aWMgaW50IGFkZF9y
ZWN2YnVmX2JpZyhzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwgc3RydWN0IHJlY2VpdmVfcXVldWUg
KnJxLAo+ICAgCWNoYXIgKnA7Cj4gICAJaW50IGksIGVyciwgb2Zmc2V0Owo+ICAgCj4gLQlzZ19p
bml0X3RhYmxlKHJxLT5zZywgTUFYX1NLQl9GUkFHUyArIDIpOwo+ICsJc2dfaW5pdF90YWJsZShy
cS0+c2csIHZpLT5iaWdfcGFja2V0c19udW1fc2tiZnJhZ3MgKyAyKTsKPiAgIAo+IC0JLyogcGFn
ZSBpbiBycS0+c2dbTUFYX1NLQl9GUkFHUyArIDFdIGlzIGxpc3QgdGFpbCAqLwo+IC0JZm9yIChp
ID0gTUFYX1NLQl9GUkFHUyArIDE7IGkgPiAxOyAtLWkpIHsKPiArCS8qIHBhZ2UgaW4gcnEtPnNn
W3ZpLT5iaWdfcGFja2V0c19udW1fc2tiZnJhZ3MgKyAxXSBpcyBsaXN0IHRhaWwgKi8KPiArCWZv
ciAoaSA9IHZpLT5iaWdfcGFja2V0c19udW1fc2tiZnJhZ3MgKyAxOyBpID4gMTsgLS1pKSB7Cj4g
ICAJCWZpcnN0ID0gZ2V0X2FfcGFnZShycSwgZ2ZwKTsKPiAgIAkJaWYgKCFmaXJzdCkgewo+ICAg
CQkJaWYgKGxpc3QpCj4gQEAgLTEzNjUsNyArMTM2OCw3IEBAIHN0YXRpYyBpbnQgYWRkX3JlY3Zi
dWZfYmlnKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLCBzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEs
Cj4gICAKPiAgIAkvKiBjaGFpbiBmaXJzdCBpbiBsaXN0IGhlYWQgKi8KPiAgIAlmaXJzdC0+cHJp
dmF0ZSA9ICh1bnNpZ25lZCBsb25nKWxpc3Q7Cj4gLQllcnIgPSB2aXJ0cXVldWVfYWRkX2luYnVm
KHJxLT52cSwgcnEtPnNnLCBNQVhfU0tCX0ZSQUdTICsgMiwKPiArCWVyciA9IHZpcnRxdWV1ZV9h
ZGRfaW5idWYocnEtPnZxLCBycS0+c2csIHZpLT5iaWdfcGFja2V0c19udW1fc2tiZnJhZ3MgKyAy
LAo+ICAgCQkJCSAgZmlyc3QsIGdmcCk7Cj4gICAJaWYgKGVyciA8IDApCj4gICAJCWdpdmVfcGFn
ZXMocnEsIGZpcnN0KTsKPiBAQCAtMzY5MCwxMyArMzY5MywyNyBAQCBzdGF0aWMgYm9vbCB2aXJ0
bmV0X2NoZWNrX2d1ZXN0X2dzbyhjb25zdCBzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSkKPiAgIAkJ
dmlydGlvX2hhc19mZWF0dXJlKHZpLT52ZGV2LCBWSVJUSU9fTkVUX0ZfR1VFU1RfVUZPKTsKPiAg
IH0KPiAgIAo+ICtzdGF0aWMgdm9pZCB2aXJ0bmV0X3NldF9iaWdfcGFja2V0c19maWVsZHMoc3Ry
dWN0IHZpcnRuZXRfaW5mbyAqdmksIGNvbnN0IGludCBtdHUpCj4gK3sKPiArCWJvb2wgZ3Vlc3Rf
Z3NvID0gdmlydG5ldF9jaGVja19ndWVzdF9nc28odmkpOwo+ICsKPiArCS8qIElmIGRldmljZSBj
YW4gcmVjZWl2ZSBBTlkgZ3Vlc3QgR1NPIHBhY2tldHMsIHJlZ2FyZGxlc3Mgb2YgbXR1LAo+ICsJ
ICogYWxsb2NhdGUgcGFja2V0cyBvZiBtYXhpbXVtIHNpemUsIG90aGVyd2lzZSBsaW1pdCBpdCB0
byBvbmx5Cj4gKwkgKiBtdHUgc2l6ZSB3b3J0aCBvbmx5Lgo+ICsJICovCj4gKwlpZiAobXR1ID4g
RVRIX0RBVEFfTEVOIHx8IGd1ZXN0X2dzbykgewo+ICsJCXZpLT5iaWdfcGFja2V0cyA9IHRydWU7
Cj4gKwkJdmktPmJpZ19wYWNrZXRzX251bV9za2JmcmFncyA9IGd1ZXN0X2dzbyA/IE1BWF9TS0Jf
RlJBR1MgOiBESVZfUk9VTkRfVVAobXR1LCBQQUdFX1NJWkUpOwo+ICsJfQo+ICt9Cj4gKwo+ICAg
c3RhdGljIGludCB2aXJ0bmV0X3Byb2JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ICAg
ewo+ICAgCWludCBpLCBlcnIgPSAtRU5PTUVNOwo+ICAgCXN0cnVjdCBuZXRfZGV2aWNlICpkZXY7
Cj4gICAJc3RydWN0IHZpcnRuZXRfaW5mbyAqdmk7Cj4gICAJdTE2IG1heF9xdWV1ZV9wYWlyczsK
PiAtCWludCBtdHU7Cj4gKwlpbnQgbXR1ID0gMDsKPiAgIAo+ICAgCS8qIEZpbmQgaWYgaG9zdCBz
dXBwb3J0cyBtdWx0aXF1ZXVlL3JzcyB2aXJ0aW9fbmV0IGRldmljZSAqLwo+ICAgCW1heF9xdWV1
ZV9wYWlycyA9IDE7Cj4gQEAgLTM3ODQsMTAgKzM4MDEsNiBAQCBzdGF0aWMgaW50IHZpcnRuZXRf
cHJvYmUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gICAJSU5JVF9XT1JLKCZ2aS0+Y29u
ZmlnX3dvcmssIHZpcnRuZXRfY29uZmlnX2NoYW5nZWRfd29yayk7Cj4gICAJc3Bpbl9sb2NrX2lu
aXQoJnZpLT5yZWZpbGxfbG9jayk7Cj4gICAKPiAtCS8qIElmIHdlIGNhbiByZWNlaXZlIEFOWSBH
U08gcGFja2V0cywgd2UgbXVzdCBhbGxvY2F0ZSBsYXJnZSBvbmVzLiAqLwo+IC0JaWYgKHZpcnRu
ZXRfY2hlY2tfZ3Vlc3RfZ3NvKHZpKSkKPiAtCQl2aS0+YmlnX3BhY2tldHMgPSB0cnVlOwo+IC0K
PiAgIAlpZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9NUkdfUlhCVUYp
KQo+ICAgCQl2aS0+bWVyZ2VhYmxlX3J4X2J1ZnMgPSB0cnVlOwo+ICAgCj4gQEAgLTM4NTMsMTIg
KzM4NjYsMTAgQEAgc3RhdGljIGludCB2aXJ0bmV0X3Byb2JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNl
ICp2ZGV2KQo+ICAgCj4gICAJCWRldi0+bXR1ID0gbXR1Owo+ICAgCQlkZXYtPm1heF9tdHUgPSBt
dHU7Cj4gLQo+IC0JCS8qIFRPRE86IHNpemUgYnVmZmVycyBjb3JyZWN0bHkgaW4gdGhpcyBjYXNl
LiAqLwo+IC0JCWlmIChkZXYtPm10dSA+IEVUSF9EQVRBX0xFTikKPiAtCQkJdmktPmJpZ19wYWNr
ZXRzID0gdHJ1ZTsKPiAgIAl9Cj4gICAKPiArCXZpcnRuZXRfc2V0X2JpZ19wYWNrZXRzX2ZpZWxk
cyh2aSwgbXR1KTsKPiArCj4gICAJaWYgKHZpLT5hbnlfaGVhZGVyX3NnKQo+ICAgCQlkZXYtPm5l
ZWRlZF9oZWFkcm9vbSA9IHZpLT5oZHJfbGVuOwo+ICAgCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
