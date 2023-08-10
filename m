Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E7FC001DB
	for <virtualization@archiver.kernel.org>; Thu, 10 Aug 2023 03:50:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B40841822;
	Thu, 10 Aug 2023 03:50:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8B40841822
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PrJshxUS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NeIEzpPNEh89; Thu, 10 Aug 2023 03:50:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D3DC741823;
	Thu, 10 Aug 2023 03:50:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D3DC741823
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92350C0072;
	Thu, 10 Aug 2023 03:50:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1318FC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 03:50:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E07B983B83
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 03:50:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E07B983B83
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PrJshxUS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s_88ChtlTamU
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 03:50:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2843D83B61
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 03:50:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2843D83B61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691639442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u3KcLG9EcDIVp5N7kk8sK8+0DWcrl162gGODhPnk2OU=;
 b=PrJshxUSP80q20VxS//zWqKIp8D4gnO8G4EfXenQo0L0T54TwfADTOBSv0oVXTQQnQkIg9
 vHmqe1j34qc5mAcLPa3+xPYdHa73hP+zuZylQDonqNeAcV1Gj2VOhROu1bh2AM7M8VfLS8
 LM9zEhUlIqYDvLxJU0xdjWFImkm/7G8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-hS_TEI2iP5mTjby88oZ03w-1; Wed, 09 Aug 2023 23:50:39 -0400
X-MC-Unique: hS_TEI2iP5mTjby88oZ03w-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b9ce397ef1so5075521fa.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Aug 2023 20:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691639438; x=1692244238;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u3KcLG9EcDIVp5N7kk8sK8+0DWcrl162gGODhPnk2OU=;
 b=YrGWxKPc1Z2iIBfSwKFGHTB1L/4/iS0g45i74xKi5HNyD7vZcuagzfxb2Yuu3vUOxC
 iBB4rTqEHLqrz2ZpYJtZHTUwDGwISD23H/EHsCSbGR4baJIqfoOYuMULOKUoBjQQByO1
 PT0fF/xW5/YXwWA6EDHRXgFaKAeoLdeZURBD4eV5vL6rN06pERQAKpSFSa7ffYw/bi4l
 X6VZmay3GO0loM6Irta8d4TipSICnyrv1orAXKON0YecIyS6dWz7WIxtpO3PinZsPTCw
 CmnK6mlzYJUt4qvhWChh+07k4n3a5FImlBIWSmANL7f7N8T9d8TSuhUATycHFhWWuHiU
 /XBw==
X-Gm-Message-State: AOJu0YyWYhZYm8TfVv6oWk6PSAFQrxBw5R6VKmLBFI/mxIrq18GaWPYc
 MsNjbvA602S+FXSlIp3zY2VgrDwPYas6TD//6QsDnQbD6PfZNnXFIDJ+2ylGTBpBGASyPc30v8w
 8Pp3Blr6luG18gLqwMJn8WQhsJRsbEj1CYTzzGnLwJ0LeN3YNlFwcZdx+Zw==
X-Received: by 2002:a2e:9a8c:0:b0:2b6:9da9:2884 with SMTP id
 p12-20020a2e9a8c000000b002b69da92884mr784448lji.40.1691639437931; 
 Wed, 09 Aug 2023 20:50:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0q+5oPVBRtl0nkjQd8v645SoDMrLaffW1dg20dgIBaEL/NerEoiou13mre+X6I0gyBwlkyfG3DX3dVt+zYMQ=
X-Received: by 2002:a2e:9a8c:0:b0:2b6:9da9:2884 with SMTP id
 p12-20020a2e9a8c000000b002b69da92884mr784437lji.40.1691639437655; Wed, 09 Aug
 2023 20:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <1691585683-3948-1-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1691585683-3948-1-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 10 Aug 2023 11:50:26 +0800
Message-ID: <CACGkMEuUEHA9d3FXVvrzGm0_t6C3FJsNH+zkOYoH6EWpitfwqw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] vdpa: dedicated descriptor table group
To: Si-Wei Liu <si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, elic@nvidia.com
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

T24gV2VkLCBBdWcgOSwgMjAyMyBhdCA4OjU24oCvUE0gU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBv
cmFjbGUuY29tPiB3cm90ZToKPgo+IEZvbGxvd2luZyBwYXRjaHNldCBpbnRyb2R1Y2VzIGRlZGlj
YXRlZCBncm91cCBmb3IgZGVzY3JpcHRvciB0YWJsZSB0bwo+IHJlZHVjZSBsaXZlIG1pZ3JhdGlv
biBkb3dudGltZSB3aGVuIHBhc3N0aHJvdWdoIFZRIGlzIGJlaW5nIHN3aXRjaGVkCj4gdG8gc2hh
ZG93IFZRLiBBcyB0aGlzIFJGQyBzZXQgaXMgdG8gc2VlayBlYXJseSBmZWVkYmFjayBvbiB0aGUg
dUFQSQo+IGFuZCBkcml2ZXIgQVBJIHBhcnQsIGZvciBub3cgdGhlcmUncyBubyBhc3NvY2lhdGVk
IGRyaXZlciBwYXRjaCBjb25zdW1pbmcKPiB0aGUgQVBJLiBBcyBzb29uIGFzIHRoZSBzdXBwb3J0
IGlzIGluIHBsYWNlIG9uIGJvdGggaGFyZHdhcmUgZGV2aWNlIGFuZAo+IGRyaXZlciwgcGVyZm9y
bWFuY2UgZGF0YSB3aWxsIGJlIHNob3cgdXNpbmcgcmVhbCBoYXJkd2FyZSBkZXZpY2UuIFRoZQo+
IHRhcmdldCBnb2FsIG9mIHRoaXMgc2VyaWVzIGlzIHRvIHJlZHVjZSB0aGUgU1ZRIHN3aXRjaGlu
ZyBvdmVyaGVhZAo+IHRvIGxlc3MgdGhhbiAzMDBtcyBvbiBhIH4xMDBHQiBndWVzdCB3aXRoIDIg
bm9uLW1xIHZob3N0LXZkcGEgZGV2aWNlcy4KPgo+IFRoZSBwbGFuIG9mIHRoZSBpbnRlbmRlZCBk
cml2ZXIgaW1wbGVtZW50YXRpb24gaXMgdG8gdXNlIGEgZGVkaWNhdGVkCj4gZ3JvdXAgKHNwZWNp
ZmljYWxseSwgMiBpbiBiZWxvdyB0YWJsZSkgdG8gaG9zdCBkZXNjcmlwdG9yIHRhYmxlIGZvcgo+
IGFsbCBkYXRhIHZxcywgZGlmZmVyZW50IGZyb20gd2hlcmUgYnVmZmVyIGFkZHJlc3NlcyBhcmUg
Y29udGFpbmVkIChpbgo+IGdyb3VwIDAgYXMgYmVsb3cpLiBjdnEgZG9lcyBub3QgaGF2ZSB0byBh
bGxvY2F0ZSBkZWRpY2F0ZWQgZ3JvdXAgZm9yCj4gZGVzY3JpcHRvciB0YWJsZSwgc28gaXRzIGJ1
ZmZlcnMgYW5kIGRlc2NyaXB0b3IgdGFibGUgd291bGQgYWx3YXlzCj4gYmVsb25nIHRvIGEgc2Ft
ZSBncm91cCAoMSkuCgpJJ20gZmluZSB3aXRoIHRoaXMsIGJ1dCBJIHRoaW5rIHdlIG5lZWQgYW4g
aW1wbGVtZW50YXRpb24gaW4gdGhlCmRyaXZlciAoZS5nIHRoZSBzaW11bGF0b3IpLgoKVGhhbmtz
Cgo+Cj4KPiAgICAgICAgICAgICAgIHwgIGRhdGEgdnEgfCBjdHJsIHZxCj4gPT09PT09PT09PT09
PT0rPT09PT09PT09PSs9PT09PT09PT09PQo+IHZxX2dyb3VwICAgICAgfCAgICAwICAgICB8ICAg
IDEKPiB2cV9kZXNjX2dyb3VwIHwgICAgMiAgICAgfCAgICAxCj4KPgo+IC0tLQo+Cj4gU2ktV2Vp
IExpdSAoMyk6Cj4gICB2ZHBhOiBpbnRyb2R1Y2UgZGVkaWNhdGVkIGRlc2NyaXB0b3IgZ3JvdXAg
Zm9yIHZpcnRxdWV1ZQo+ICAgdmhvc3QtdmRwYTogaW50cm9kdWNlIGRlc2NyaXB0b3IgZ3JvdXAg
YmFja2VuZCBmZWF0dXJlCj4gICB2aG9zdC12ZHBhOiB1QVBJIHRvIGdldCBkZWRpY2F0ZWQgZGVz
Y3JpcHRvciBncm91cCBpZAo+Cj4gIGRyaXZlcnMvdmhvc3QvdmRwYS5jICAgICAgICAgICAgIHwg
MjcgKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gIGluY2x1ZGUvbGludXgvdmRwYS5oICAg
ICAgICAgICAgIHwgMTEgKysrKysrKysrKysKPiAgaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0Lmgg
ICAgICAgfCAgOCArKysrKysrKwo+ICBpbmNsdWRlL3VhcGkvbGludXgvdmhvc3RfdHlwZXMuaCB8
ICA1ICsrKysrCj4gIDQgZmlsZXMgY2hhbmdlZCwgNTEgaW5zZXJ0aW9ucygrKQo+Cj4gLS0KPiAx
LjguMy4xCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
