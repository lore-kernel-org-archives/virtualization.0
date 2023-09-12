Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86342CA0ED3
	for <virtualization@archiver.kernel.org>; Tue, 12 Sep 2023 04:20:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EF3AF403AC;
	Tue, 12 Sep 2023 04:20:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EF3AF403AC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UURAkTN7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1TpDlbmF558c; Tue, 12 Sep 2023 04:20:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7A68C40003;
	Tue, 12 Sep 2023 04:20:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7A68C40003
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A775C0039;
	Tue, 12 Sep 2023 04:20:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4DB49C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 04:20:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1574F81F4C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 04:20:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1574F81F4C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UURAkTN7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sdD98-lLSkXf
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 04:20:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0001481F4B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 04:20:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0001481F4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694492440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u6LAvoxrA++ddyGlbZEfJ4woougSxOGWkQHAKbY5VPw=;
 b=UURAkTN7eCaFtdOsF86ItwEoYdsxp1fx8vOaaqpk/dsEO3VPXGua6Tp4kQooJhBAkEC99w
 riR7k60KNN1WpqgDs7inflR4qztCAATCzmkR80DninsHXsqgCXrIopYMhz4cH/ZACht/Rt
 eJFJbTS8XvcUeWL6ViCC8SSijX5SdzQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-WZNBbj5GMOuCtSbk7X7Hwg-1; Tue, 12 Sep 2023 00:20:38 -0400
X-MC-Unique: WZNBbj5GMOuCtSbk7X7Hwg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5007cabf295so3300539e87.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 21:20:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694492437; x=1695097237;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u6LAvoxrA++ddyGlbZEfJ4woougSxOGWkQHAKbY5VPw=;
 b=PJFcVgbmsvtZpkvsH6wz++2xxYiprwAhp+kCN9WHMAmINCcUiGIPvI4NTw7u1n300f
 i0ORSSvQJ1KQi8HxAmdsI8pquC5DzNtk9GBbGBRtJU5gC++/VXUB2vCtXUvUNHAV5iPM
 ao3FsP/pk537OlqLrsO2UUhhycGan9QC+qxVMz28boRC0G8nWq0gPU4Fo7XC7bI6N0JG
 ehNEXii6l/46XOL/v0KnvW4jPMyglbMXB9quC883Fy63QhSLQGJgh8NbIP19FG3802ro
 vCCb/ASf0zmq6rsaF9/BqxzpSVP03krSCJ76r8pdb2N6zcTK8XdeR6iK1mk4ZWYxTYZg
 TEzA==
X-Gm-Message-State: AOJu0YwV6zLEa/79mMd4Kq9f0UlPPG+w4FApOGsesie3UoHiaiSaqq0s
 PiDRcKYU3zjSNW0MAJbC/af5y/ZarlzO5Zyp9UUevsx+yvTX5vF5EVWasgBByRZ5qVfRmc8PC/O
 Tuuui/XrRbfG7Qwl8HtK+82GlufaQDKdEprnRWk9HYqdHkx3OX0DtTShI9g==
X-Received: by 2002:a05:6512:2316:b0:4fe:bfa:9d8b with SMTP id
 o22-20020a056512231600b004fe0bfa9d8bmr517012lfu.12.1694492437309; 
 Mon, 11 Sep 2023 21:20:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7S/I7ZWNi2kM9iAuPAShj8/IiRcb1wj+fArTe8MC0SS9AH0w1KXFbw0WxANKbi4vELzpAlajCjNIFW2kHyys=
X-Received: by 2002:a05:6512:2316:b0:4fe:bfa:9d8b with SMTP id
 o22-20020a056512231600b004fe0bfa9d8bmr517008lfu.12.1694492437002; Mon, 11 Sep
 2023 21:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230911213104.14391-1-shannon.nelson@amd.com>
In-Reply-To: <20230911213104.14391-1-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Sep 2023 12:20:26 +0800
Message-ID: <CACGkMEv9ZXx+y=gwCBL5TbMX24rNAYSZ4_5ormVE0oeDZcr1vw@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio: kdoc for struct virtio_pci_modern_device
To: Shannon Nelson <shannon.nelson@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: brett.creeley@amd.com, mst@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 simon.horman@corigine.com, kuba@kernel.org, drivers@pensando.io,
 davem@davemloft.net
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

T24gVHVlLCBTZXAgMTIsIDIwMjMgYXQgNTozMeKAr0FNIFNoYW5ub24gTmVsc29uIDxzaGFubm9u
Lm5lbHNvbkBhbWQuY29tPiB3cm90ZToKPgo+IEZpbmFsbHkgZm9sbG93aW5nIHVwIHRvIFNpbW9u
J3Mgc3VnZ2VzdGlvbiBmb3Igc29tZSBrZG9jIGF0dGVudGlvbgo+IG9uIHN0cnVjdCB2aXJ0aW9f
cGNpX21vZGVybl9kZXZpY2UuCj4KPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRk
ZXYvWkUlMkZRUzBsblV2eEZhY2pmQGNvcmlnaW5lLmNvbS8KPiBDYzogU2ltb24gSG9ybWFuIDxz
aW1vbi5ob3JtYW5AY29yaWdpbmUuY29tPgo+IFNpZ25lZC1vZmYtYnk6IFNoYW5ub24gTmVsc29u
IDxzaGFubm9uLm5lbHNvbkBhbWQuY29tPgo+IEFja2VkLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBl
cmV6bWFAcmVkaGF0LmNvbT4KCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPgoKVGhhbmtzCgo+IC0tLQo+ICBpbmNsdWRlL2xpbnV4L3ZpcnRpb19wY2lfbW9kZXJuLmgg
fCAzNCArKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAy
MiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L3ZpcnRpb19wY2lfbW9kZXJuLmggYi9pbmNsdWRlL2xpbnV4L3ZpcnRpb19wY2lfbW9k
ZXJuLmgKPiBpbmRleCAwNjdhYzFkNzg5YmMuLmEzOGM3MjlkMTk3MyAxMDA2NDQKPiAtLS0gYS9p
bmNsdWRlL2xpbnV4L3ZpcnRpb19wY2lfbW9kZXJuLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L3Zp
cnRpb19wY2lfbW9kZXJuLmgKPiBAQCAtMTIsMzcgKzEyLDQ3IEBAIHN0cnVjdCB2aXJ0aW9fcGNp
X21vZGVybl9jb21tb25fY2ZnIHsKPiAgICAgICAgIF9fbGUxNiBxdWV1ZV9yZXNldDsgICAgICAg
ICAgICAgLyogcmVhZC13cml0ZSAqLwo+ICB9Owo+Cj4gKy8qKgo+ICsgKiBzdHJ1Y3QgdmlydGlv
X3BjaV9tb2Rlcm5fZGV2aWNlIC0gaW5mbyBmb3IgbW9kZXJuIFBDSSB2aXJ0aW8KPiArICogQHBj
aV9kZXY6ICAgICAgIFB0ciB0byB0aGUgUENJIGRldmljZSBzdHJ1Y3QKPiArICogQGNvbW1vbjog
ICAgICAgIFBvc2l0aW9uIG9mIHRoZSBjb21tb24gY2FwYWJpbGl0eSBpbiB0aGUgUENJIGNvbmZp
Zwo+ICsgKiBAZGV2aWNlOiAgICAgICAgRGV2aWNlLXNwZWNpZmljIGRhdGEgKG5vbi1sZWdhY3kg
bW9kZSkKPiArICogQG5vdGlmeV9iYXNlOiAgICBCYXNlIG9mIHZxIG5vdGlmaWNhdGlvbnMgKG5v
bi1sZWdhY3kgbW9kZSkKPiArICogQG5vdGlmeV9wYTogICAgIFBoeXNpY2FsIGJhc2Ugb2YgdnEg
bm90aWZpY2F0aW9ucwo+ICsgKiBAaXNyOiAgICAgICAgICAgV2hlcmUgdG8gcmVhZCBhbmQgY2xl
YXIgaW50ZXJydXB0Cj4gKyAqIEBub3RpZnlfbGVuOiAgICAgICAgICAgIFNvIHdlIGNhbiBzYW5p
dHktY2hlY2sgYWNjZXNzZXMKPiArICogQGRldmljZV9sZW46ICAgICAgICAgICAgU28gd2UgY2Fu
IHNhbml0eS1jaGVjayBhY2Nlc3Nlcwo+ICsgKiBAbm90aWZ5X21hcF9jYXA6IENhcGFiaWxpdHkg
Zm9yIHdoZW4gd2UgbmVlZCB0byBtYXAgbm90aWZpY2F0aW9ucyBwZXItdnEKPiArICogQG5vdGlm
eV9vZmZzZXRfbXVsdGlwbGllcjogTXVsdGlwbHkgcXVldWVfbm90aWZ5X29mZiBieSB0aGlzIHZh
bHVlCj4gKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAgIChub24tbGVnYWN5IG1vZGUpLgo+
ICsgKiBAbW9kZXJuX2JhcnM6ICAgIEJpdG1hc2sgb2YgQkFScwo+ICsgKiBAaWQ6ICAgICAgICAg
ICAgICAgICAgICBEZXZpY2UgYW5kIHZlbmRvciBpZAo+ICsgKiBAZGV2aWNlX2lkX2NoZWNrOiBD
YWxsYmFjayBkZWZpbmVkIGJlZm9yZSB2cF9tb2Rlcm5fcHJvYmUoKSB0byBiZSB1c2VkIHRvCj4g
KyAqICAgICAgICAgICAgICAgICB2ZXJpZnkgdGhlIFBDSSBkZXZpY2UgaXMgYSB2ZW5kb3IncyBl
eHBlY3RlZCBkZXZpY2UgcmF0aGVyCj4gKyAqICAgICAgICAgICAgICAgICB0aGFuIHRoZSBzdGFu
ZGFyZCB2aXJ0aW8gUENJIGRldmljZQo+ICsgKiAgICAgICAgICAgICAgICAgUmV0dXJucyB0aGUg
Zm91bmQgZGV2aWNlIGlkIG9yIEVSUk5PCj4gKyAqIEBkbWFfbWFzazogICAgICBPcHRpb25hbCBt
YXNrIGluc3RlYWQgb2YgdGhlIHRyYWRpdGlvbmFsIERNQV9CSVRfTUFTSyg2NCksCj4gKyAqICAg
ICAgICAgICAgICAgICBmb3IgdmVuZG9yIGRldmljZXMgd2l0aCBETUEgc3BhY2UgYWRkcmVzcyBs
aW1pdGF0aW9ucwo+ICsgKi8KPiAgc3RydWN0IHZpcnRpb19wY2lfbW9kZXJuX2RldmljZSB7Cj4g
ICAgICAgICBzdHJ1Y3QgcGNpX2RldiAqcGNpX2RldjsKPgo+ICAgICAgICAgc3RydWN0IHZpcnRp
b19wY2lfY29tbW9uX2NmZyBfX2lvbWVtICpjb21tb247Cj4gLSAgICAgICAvKiBEZXZpY2Utc3Bl
Y2lmaWMgZGF0YSAobm9uLWxlZ2FjeSBtb2RlKSAgKi8KPiAgICAgICAgIHZvaWQgX19pb21lbSAq
ZGV2aWNlOwo+IC0gICAgICAgLyogQmFzZSBvZiB2cSBub3RpZmljYXRpb25zIChub24tbGVnYWN5
IG1vZGUpLiAqLwo+ICAgICAgICAgdm9pZCBfX2lvbWVtICpub3RpZnlfYmFzZTsKPiAtICAgICAg
IC8qIFBoeXNpY2FsIGJhc2Ugb2YgdnEgbm90aWZpY2F0aW9ucyAqLwo+ICAgICAgICAgcmVzb3Vy
Y2Vfc2l6ZV90IG5vdGlmeV9wYTsKPiAtICAgICAgIC8qIFdoZXJlIHRvIHJlYWQgYW5kIGNsZWFy
IGludGVycnVwdCAqLwo+ICAgICAgICAgdTggX19pb21lbSAqaXNyOwo+Cj4gLSAgICAgICAvKiBT
byB3ZSBjYW4gc2FuaXR5LWNoZWNrIGFjY2Vzc2VzLiAqLwo+ICAgICAgICAgc2l6ZV90IG5vdGlm
eV9sZW47Cj4gICAgICAgICBzaXplX3QgZGV2aWNlX2xlbjsKPgo+IC0gICAgICAgLyogQ2FwYWJp
bGl0eSBmb3Igd2hlbiB3ZSBuZWVkIHRvIG1hcCBub3RpZmljYXRpb25zIHBlci12cS4gKi8KPiAg
ICAgICAgIGludCBub3RpZnlfbWFwX2NhcDsKPgo+IC0gICAgICAgLyogTXVsdGlwbHkgcXVldWVf
bm90aWZ5X29mZiBieSB0aGlzIHZhbHVlLiAobm9uLWxlZ2FjeSBtb2RlKS4gKi8KPiAgICAgICAg
IHUzMiBub3RpZnlfb2Zmc2V0X211bHRpcGxpZXI7Cj4gLQo+ICAgICAgICAgaW50IG1vZGVybl9i
YXJzOwo+IC0KPiAgICAgICAgIHN0cnVjdCB2aXJ0aW9fZGV2aWNlX2lkIGlkOwo+Cj4gLSAgICAg
ICAvKiBvcHRpb25hbCBjaGVjayBmb3IgdmVuZG9yIHZpcnRpbyBkZXZpY2UsIHJldHVybnMgZGV2
X2lkIG9yIC1FUlJOTyAqLwo+ICAgICAgICAgaW50ICgqZGV2aWNlX2lkX2NoZWNrKShzdHJ1Y3Qg
cGNpX2RldiAqcGRldik7Cj4gLQo+IC0gICAgICAgLyogb3B0aW9uYWwgbWFzayBmb3IgZGV2aWNl
cyB3aXRoIGxpbWl0ZWQgRE1BIHNwYWNlICovCj4gICAgICAgICB1NjQgZG1hX21hc2s7Cj4gIH07
Cj4KPiAtLQo+IDIuMTcuMQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
