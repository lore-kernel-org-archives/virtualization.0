Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8753FCDB474
	for <virtualization@archiver.kernel.org>; Fri, 13 Oct 2023 03:05:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0EC47408F2;
	Fri, 13 Oct 2023 03:05:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0EC47408F2
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h7dpMCZK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2l_w_Bm9_4go; Fri, 13 Oct 2023 03:05:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 89B7E4088E;
	Fri, 13 Oct 2023 03:05:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 89B7E4088E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39216C0071;
	Fri, 13 Oct 2023 03:05:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A03A2C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 03:05:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8194240898
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 03:05:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8194240898
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rKY0ae69-Ubf
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 03:05:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C0A9C4088E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 03:05:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C0A9C4088E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697166299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3zDrSwzdAeWMb/6P4lK++T4MCrJYZFn5wg8AsD0sQBw=;
 b=h7dpMCZKqkum9wGdPIb6Paynw1zG2n15MiVikE6uB/UDWObSrGK8oqI6w4Nve0reVHaQPr
 Ovr9QuK5aiD2AqhfUrjZ7kOF79XFu0y267UCX3Q/daonDu/6xwiZq2pALqK4Z+8wxP8KIu
 llx9F69SmQxAEqsSUfyfCflmpYT4/mI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-WoWW56oGPieCbFhsbxa7iA-1; Thu, 12 Oct 2023 23:04:57 -0400
X-MC-Unique: WoWW56oGPieCbFhsbxa7iA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-502fff967ccso1590174e87.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 20:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697166296; x=1697771096;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3zDrSwzdAeWMb/6P4lK++T4MCrJYZFn5wg8AsD0sQBw=;
 b=NYWgavpXmymnDolHJtD/N02yO10ALySBh2r/zBrsS4dCqVqbCGhq/NkxuU0f0uTIiB
 UrQh8gAjxrDkOsUmMYN73BT1fYYf6ZwDWPZgRT9Izu5CflFbw7y82NCvkhGtMl3Tqdqq
 s98JQ6S9g6PzLlbEHQP/TTGYNXkqixj+Mpbi3Yc+R2Kwgb5hi8tclBPcmf7ifZ+hihZW
 MXzvLRN/kLhRN8lW5mqWYGnnSmRa4mbd8WXDFfzKjGuXs0kC0Qkse0ANNzVEj3kKN7vx
 lLctZxor1DcKo6PX1B5LUVSZVHAvEfXb96R4cKV9uFeEctdV87vrAmHOau6DexNbgGXA
 FH1w==
X-Gm-Message-State: AOJu0Yw7z8i4tmv/8UzAE/IIVce+j4EaJnjHkR+mrcKUxxPsIoSvZ81y
 XJ4sN1wTnZoJXT0kuIQBR3bqsG5s0BMt6P336u6BbNQ4yMS0h/eeunPy5lxlC9Xo3u2k1VqMZbt
 7cwq0YBnm019rbYIOxsn4jcRqbUJB0gjtrlAPQop77VW1RsAcj/SEi9zBNQ==
X-Received: by 2002:a05:6512:220b:b0:500:a66b:b189 with SMTP id
 h11-20020a056512220b00b00500a66bb189mr27156026lfu.51.1697166296492; 
 Thu, 12 Oct 2023 20:04:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGddNL/kYX2H3Iu0ZNgDi52JWSlSlKIs1t+wGjc1PqbgAKfekZ6PZ06oO8kQyqeje+O7m30cse1FthqZTJhn5c=
X-Received: by 2002:a05:6512:220b:b0:500:a66b:b189 with SMTP id
 h11-20020a056512220b00b00500a66bb189mr27156017lfu.51.1697166296198; Thu, 12
 Oct 2023 20:04:56 -0700 (PDT)
MIME-Version: 1.0
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
 <1696928580-7520-5-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1696928580-7520-5-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Oct 2023 11:04:45 +0800
Message-ID: <CACGkMEtCasGmTNBZxfu2gJfSMCfD1jtKGH3cb9HCPXFP7YACpQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] vdpa/mlx5: implement .reset_map driver op
To: Si-Wei Liu <si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com
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

T24gVHVlLCBPY3QgMTAsIDIwMjMgYXQgNTowNeKAr1BNIFNpLVdlaSBMaXUgPHNpLXdlaS5saXVA
b3JhY2xlLmNvbT4gd3JvdGU6Cj4KPiBTaW5jZSBjb21taXQgNmY1MzEyZjgwMTgzICgidmRwYS9t
bHg1OiBBZGQgc3VwcG9ydCBmb3IgcnVubmluZyB3aXRoCj4gdmlydGlvX3ZkcGEiKSwgbWx4NV92
ZHBhIHN0YXJ0cyB3aXRoIHByZWFsbG9jYXRlIDE6MSBETUEgTVIgYXQgZGV2aWNlCj4gY3JlYXRp
b24gdGltZS4gVGhpcyAxOjEgRE1BIE1SIHdpbGwgYmUgaW1wbGljaXRseSBkZXN0cm95ZWQgd2hp
bGUKPiB0aGUgZmlyc3QgLnNldF9tYXAgY2FsbCBpcyBpbnZva2VkLCBpbiB3aGljaCBjYXNlIGNh
bGxlcnMgbGlrZQo+IHZob3N0LXZkcGEgd2lsbCBzdGFydCB0byBzZXQgdXAgY3VzdG9tIG1hcHBp
bmdzLiBXaGVuIHRoZSAucmVzZXQKPiBjYWxsYmFjayBpcyBpbnZva2VkLCB0aGUgY3VzdG9tIG1h
cHBpbmdzIHdpbGwgYmUgY2xlYXJlZCBhbmQgdGhlIDE6MQo+IERNQSBNUiB3aWxsIGJlIHJlLWNy
ZWF0ZWQuCj4KPiBJbiBvcmRlciB0byByZWR1Y2UgZXhjZXNzaXZlIG1lbW9yeSBtYXBwaW5nIGNv
c3QgaW4gbGl2ZSBtaWdyYXRpb24sCj4gaXQgaXMgZGVzaXJhYmxlIHRvIGRlY291cGxlIHRoZSB2
aG9zdC12ZHBhIElPVExCIGFic3RyYWN0aW9uIGZyb20KPiB0aGUgdmlydGlvIGRldmljZSBsaWZl
IGN5Y2xlLCBpLmUuIG1hcHBpbmdzIGNhbiBiZSBrZXB0IGFyb3VuZCBpbnRhY3QKPiBhY3Jvc3Mg
dmlydGlvIGRldmljZSByZXNldC4gTGV2ZXJhZ2UgdGhlIC5yZXNldF9tYXAgY2FsbGJhY2ssIHdo
aWNoCj4gaXMgbWVhbnQgdG8gZGVzdHJveSB0aGUgcmVndWxhciBNUiBvbiB0aGUgZ2l2ZW4gQVNJ
RCBhbmQgcmVjcmVhdGUgdGhlCj4gaW5pdGlhbCBETUEgbWFwcGluZy4gVGhhdCB3YXksIHRoZSBk
ZXZpY2UgLnJlc2V0IG9wIGNhbiBydW4gZnJlZSBmcm9tCj4gaGF2aW5nIHRvIG1haW50YWluIGFu
ZCBjbGVhbiB1cCBtZW1vcnkgbWFwcGluZ3MgYnkgaXRzZWxmLgo+Cj4gVGhlIGN2cSBtYXBwaW5n
IGFsc28gbmVlZHMgdG8gYmUgY2xlYXJlZCBpZiBpcyBpbiB0aGUgZ2l2ZW4gQVNJRC4KPgo+IENv
LWRldmVsb3BlZC1ieTogRHJhZ29zIFRhdHVsZWEgPGR0YXR1bGVhQG52aWRpYS5jb20+Cj4gU2ln
bmVkLW9mZi1ieTogRHJhZ29zIFRhdHVsZWEgPGR0YXR1bGVhQG52aWRpYS5jb20+Cj4gU2lnbmVk
LW9mZi1ieTogU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPgoKSSB3b25kZXIgaWYg
dGhlIHNpbXVsYXRvciBzdWZmZXJzIGZyb20gdGhlIGV4YWN0IHNhbWUgaXNzdWUuIElmIHllcywK
bGV0J3MgZml4IHRoZSBzaW11bGF0b3IgYXMgd2VsbD8KClRoYW5rcwoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
