Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696CAC77B73
	for <virtualization@archiver.kernel.org>; Thu,  1 Jun 2023 02:44:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D82C2614E8;
	Thu,  1 Jun 2023 02:44:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D82C2614E8
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JotbcwTE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SnjsRytjRqQq; Thu,  1 Jun 2023 02:44:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4116161123;
	Thu,  1 Jun 2023 02:44:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4116161123
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09DCDC0087;
	Thu,  1 Jun 2023 02:44:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7665C0037
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jun 2023 02:44:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6E937819C8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jun 2023 02:44:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6E937819C8
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JotbcwTE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 80SIU-jJBKbx
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jun 2023 02:44:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6D97C819BC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6D97C819BC
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jun 2023 02:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685587456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P5j1g1ATxz1Tv7AYCJO77SujD8J9ABucgOuKivxgRaM=;
 b=JotbcwTEf8RpN5ojQMUJWkPPO4zzIRe5qqfE+o82NIA1ASauD0dhbKCNQ1zaybpgg35mUz
 CVz5ULjLWSbZkGLmfB1ON//8Z94rKwOsc0/LCpmEeebN1PnQw/MN26JdAjaSi5K9huh8hm
 QDZsn8Zqf1nQBv9FikunxmafwFESfT8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-rzt9WSpmNW-qvIbhhBGJSw-1; Wed, 31 May 2023 22:44:14 -0400
X-MC-Unique: rzt9WSpmNW-qvIbhhBGJSw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b12d76e029so2380981fa.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 19:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685587453; x=1688179453;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P5j1g1ATxz1Tv7AYCJO77SujD8J9ABucgOuKivxgRaM=;
 b=Dovv1sFWZUtlhkCdFjS9hfEk87jJqXCMH/FQBYeWErTQ6x3i53t+NBEdAwzmMiWbBp
 GqJKgMsiARyxdMx5yZYAMl3tunaO+MN3w/ZUwY00QPV/YPHtP2s6RL5u4TxLrxBJ+0pU
 HMNiNj/qEFgaJ9kYuFMIGSjPee0e/aEzfRPDfBNr9SnzrUbnEp9SwNn3uKWnppBekJGu
 /XPjIjMiwp9qz0PfvdkKT7VpOUlDpTJLR7oTgpy6/hi2+a6830WB5dm3JmaZCGR03PZn
 2hAhk4ZgdG8diPk86w2BdT3qyPv21rM8uZ7Nu04kcTa8kxjJUn44t6w3sTc9xmJ3OWv7
 RGtg==
X-Gm-Message-State: AC+VfDxVDWsfd4yULmm8aFrGgfIVSUyutI4SoZRnf3I47C+MlLs2XB1u
 XgPpKa6TSaGdrkpKdR75G5H/eRFzRQwqz6jUDct8T34nwyMlFrp3Tg0rlIbQ8K5M3VkJgB1VauQ
 QxGBVHajFhiNH5g7eyyqNii/gJksflpAhH68uP0ReSHAJHklYO3/u4r8L1Q==
X-Received: by 2002:a2e:9349:0:b0:2ab:42c7:cf25 with SMTP id
 m9-20020a2e9349000000b002ab42c7cf25mr3723687ljh.13.1685587453443; 
 Wed, 31 May 2023 19:44:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5SRy8UQO9IwqDcYgSA8oz4ZDB+xL2wjCTAWMJt6bNtw6hK+k0BB5H1rPnhcpKz3t/XB2RpU1CudcWpY8mflfY=
X-Received: by 2002:a2e:9349:0:b0:2ab:42c7:cf25 with SMTP id
 m9-20020a2e9349000000b002ab42c7cf25mr3723676ljh.13.1685587453169; Wed, 31 May
 2023 19:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230522025124.5863-1-michael.christie@oracle.com>
 <20230522025124.5863-4-michael.christie@oracle.com>
 <20230522123029.GA22159@redhat.com>
 <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com>
 <20230522174757.GC22159@redhat.com>
 <20230523121506.GA6562@redhat.com>
 <26c87be0-8e19-d677-a51b-e6821e6f7ae4@redhat.com>
 <20230531072449.GA25046@redhat.com>
 <CACGkMEv2kB9J1qGYkGkywk1YHV2gU2fMr7qx4vEv9L5f6qL5mg@mail.gmail.com>
 <20230531091432.GB25046@redhat.com>
In-Reply-To: <20230531091432.GB25046@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 1 Jun 2023 10:44:01 +0800
Message-ID: <CACGkMEvNrC5gc4ppp0QG-SNSbs_snrqwPkNBotffRRDJA1VJjQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] fork,
 vhost: Use CLONE_THREAD to fix freezer/ps regression
To: Oleg Nesterov <oleg@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: axboe@kernel.dk, brauner@kernel.org, mst@redhat.com, linux@leemhuis.info,
 linux-kernel@vger.kernel.org, ebiederm@xmission.com, stefanha@redhat.com,
 nicolas.dichtel@6wind.com, virtualization@lists.linux-foundation.org,
 torvalds@linux-foundation.org
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

T24gV2VkLCBNYXkgMzEsIDIwMjMgYXQgNToxNOKAr1BNIE9sZWcgTmVzdGVyb3YgPG9sZWdAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiAwNS8zMSwgSmFzb24gV2FuZyB3cm90ZToKPiA+Cj4gPiBP
biBXZWQsIE1heSAzMSwgMjAyMyBhdCAzOjI14oCvUE0gT2xlZyBOZXN0ZXJvdiA8b2xlZ0ByZWRo
YXQuY29tPiB3cm90ZToKPiA+ID4KPiA+ID4gT24gMDUvMzEsIEphc29uIFdhbmcgd3JvdGU6Cj4g
PiA+ID4KPiA+ID4gPiDlnKggMjAyMy81LzIzIDIwOjE1LCBPbGVnIE5lc3Rlcm92IOWGmemBkzoK
PiA+ID4gPiA+Cj4gPiA+ID4gPiAgICAgICAgICAgICAvKiBtYWtlIHN1cmUgZmxhZyBpcyBzZWVu
IGFmdGVyIGRlbGV0aW9uICovCj4gPiA+ID4gPiAgICAgICAgICAgICBzbXBfd21iKCk7Cj4gPiA+
ID4gPiAgICAgICAgICAgICBsbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKHdvcmssIHdvcmtfbmV4
dCwgbm9kZSwgbm9kZSkgewo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICBjbGVhcl9iaXQo
VkhPU1RfV09SS19RVUVVRUQsICZ3b3JrLT5mbGFncyk7Cj4gPiA+ID4gPgo+ID4gPiA+ID5JIGFt
IG5vdCBzdXJlIGFib3V0IHNtcF93bWIgKyBjbGVhcl9iaXQuIE9uY2Ugd2UgY2xlYXIgVkhPU1Rf
V09SS19RVUVVRUQsCj4gPiA+ID4gPnZob3N0X3dvcmtfcXVldWUoKSBjYW4gYWRkIHRoaXMgd29y
ayBhZ2FpbiBhbmQgY2hhbmdlIHdvcmstPm5vZGUtPm5leHQuCj4gPiA+ID4gPgo+ID4gPiA+ID5U
aGF0IGlzIHdoeSB3ZSB1c2UgX3NhZmUsIGJ1dCB3ZSBuZWVkIHRvIGVuc3VyZSB0aGF0IGxsaXN0
X2Zvcl9lYWNoX3NhZmUoKQo+ID4gPiA+ID5jb21wbGV0ZXMgTE9BRCh3b3JrLT5ub2RlLT5uZXh0
KSBiZWZvcmUgVkhPU1RfV09SS19RVUVVRUQgaXMgY2xlYXJlZC4KPiA+ID4gPgo+ID4gPiA+IFRo
aXMgc2hvdWxkIGJlIGZpbmUgc2luY2Ugc3RvcmUgaXMgbm90IHNwZWN1bGF0ZWQsIHNvIHdvcmst
Pm5vZGUtPm5leHQgbmVlZHMKPiA+ID4gPiB0byBiZSBsb2FkZWQgYmVmb3JlIFZIT1NUX1dPUktf
UVVFVUVEIGlzIGNsZWFyZWQgdG8gbWVldCB0aGUgbG9vcCBjb25kaXRpb24uCj4gPiA+Cj4gPiA+
IEkgZG9uJ3QgdW5kZXJzdGFuZCB5b3UuIE9LLCB0byBzaW1wbGlmeSwgc3VwcG9zZSB3ZSBoYXZl
IDIgZ2xvYmFsIHZhcnMKPiA+ID4KPiA+ID4gICAgICAgICB2b2lkICpQVFIgPSBzb21ldGhpbmdf
bm9uX251bGw7Cj4gPiA+ICAgICAgICAgdW5zaWduZWQgbG9uZyBGTEFHUyA9IC0xdWw7Cj4gPiA+
Cj4gPiA+IE5vdyBJIHRoaW5rIHRoaXMgY29kZQo+ID4gPgo+ID4gPiAgICAgICAgIENQVV8wICAg
ICAgICAgICAgICAgICAgICAgICAgICAgQ1BVXzEKPiA+ID4KPiA+ID4gICAgICAgICB2b2lkICpw
dHIgPSBQVFI7ICAgICAgICAgICAgICAgIGlmICghdGVzdF9hbmRfc2V0X2JpdCgwLCBGTEFHUykp
Cj4gPiA+ICAgICAgICAgY2xlYXJfYml0KDAsIEZMQUdTKTsgICAgICAgICAgICAgICAgICAgIFBU
UiA9IE5VTEw7Cj4gPiA+ICAgICAgICAgQlVHX09OKCFwdHIpOwo+ID4gPgo+ID4gPiBpcyByYWN5
IGFuZCBjYW4gaGl0IHRoZSBCVUdfT04oIXB0cikuCj4gPgo+ID4gVGhpcyBzZWVtcyBkaWZmZXJl
bnQgdG8gdGhlIGFib3ZlIGNhc2U/Cj4KPiBub3Qgc3VyZSwKPgo+ID4gQW5kIHlvdSBjYW4gaGl0
IEJVR19PTiB3aXRoCj4gPiB0aGUgZm9sbG93aW5nIGV4ZWN1dGlvbiBzZXF1ZW5jZToKPiA+Cj4g
PiBbY3B1IDBdIGNsZWFyX2JpdCgwLCBGTEFHUyk7Cj4gPiBbY3B1IDFdIGlmICghdGVzdF9hbmRf
c2V0X2JpdCgwLCBGTEFHUykpCj4gPiBbY3B1IDFdIFBUUiA9IE5VTEw7Cj4gPiBbY3B1IDBdIEJV
R19PTighcHRyKQo+Cj4gSSBkb24ndCB1bmRlcnN0YW5kIHRoaXMgcGFydC4uLiB5ZXMsIHdlIGNh
biBoaXQgdGhpcyBCVUdfT04oKSB3aXRob3V0IG1iIGluCj4gYmV0d2VlbiwgdGhpcyBpcyB3aGF0
IEkgdHJpZWQgdG8gc2F5LgoKSSBtYXkgbWlzcyBzb21ldGhpbmcsIGJ1dCB0aGUgYWJvdmUgaXMg
dGhlIHNlcXVlbmNlIHRoYXQgaXMgZXhlY3V0ZWQKYnkgdGhlIHByb2Nlc3NvciAoZm9yIGVhY2gg
Q1BVLCBpdCdzIGp1c3QgdGhlIHByb2dyYW0gb3JkZXIpLiBTbyB3aGVyZQpkbyB5b3UgZXhwZWN0
IHRvIHBsYWNlIGFuIG1iIGNhbiBoZWxwPwoKPgo+ID4gSW4gdmhvc3QgY29kZSwgdGhlcmUncyBh
IGNvbmRpdGlvbiBiZWZvcmUgdGhlIGNsZWFyX2JpdCgpIHdoaWNoIHNpdHMKPiA+IGluc2lkZSBs
bGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKCk6Cj4gPgo+ID4gI2RlZmluZSBsbGlzdF9mb3JfZWFj
aF9lbnRyeV9zYWZlKHBvcywgbiwgbm9kZSwgbWVtYmVyKSAgICAgICAgICAgICAgICAgICAgICAg
IFwKPiA+ICAgICAgICAgZm9yIChwb3MgPSBsbGlzdF9lbnRyeSgobm9kZSksIHR5cGVvZigqcG9z
KSwgbWVtYmVyKTsgICAgICAgICAgICAgICAgICBcCj4gPiAgICAgICAgICAgICAgbWVtYmVyX2Fk
ZHJlc3NfaXNfbm9ubnVsbChwb3MsIG1lbWJlcikgJiYgICAgICAgICAgICAgICAgICAgICAgICAg
XAo+ID4gICAgICAgICAgICAgICAgIChuID0gbGxpc3RfZW50cnkocG9zLT5tZW1iZXIubmV4dCwg
dHlwZW9mKCpuKSwgbWVtYmVyKSwgdHJ1ZSk7IFwKPiA+ICAgICAgICAgICAgICBwb3MgPSBuKQo+
ID4KPiA+IFRoZSBjbGVhcl9iaXQoKSBpcyBhIHN0b3JlIHdoaWNoIGlzIG5vdCBzcGVjdWxhdGVk
LCBzbyB0aGVyZSdzIGEKPiA+IGNvbnRyb2wgZGVwZW5kZW5jeSwgdGhlIHN0b3JlIGNhbid0IGJl
IGV4ZWN1dGVkIHVudGlsIHRoZSBjb25kaXRpb24KPiA+IGV4cHJlc3Npb24gaXMgZXZhbHVhdGVk
IHdoaWNoIHJlcXVpcmVzIHBvcy0+bWVtYmVyLm5leHQKPiA+ICh3b3JrLT5ub2RlLm5leHQpIHRv
IGJlIGxvYWRlZC4KPgo+IEJ1dCBsbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKCkgZG9lc24ndCBj
aGVjayAibiIsIEkgbWVhbiwgaXQgaXMgbm90IHRoYXQgd2UgaGF2ZQo+IHNvbWV0aGluZyBsaWtl
Cj4KPiAgICAgICAgIG4gPSBsbGlzdF9lbnRyeSguLi4pOwo+ICAgICAgICAgaWYgKG4pCj4gICAg
ICAgICAgICAgICAgIGNsZWFyX2JpdCguLi4pOwo+Cj4gc28gSSBkbyBub3Qgc2VlIGhvdyBjYW4g
d2UgcmVseSBvbiB0aGUgbG9hZC1zdG9yZSBjb250cm9sIGRlcGVuZGVuY3kuCgpKdXN0IHRvIG1h
a2Ugc3VyZSB3ZSBhcmUgb24gdGhlIHNhbWUgcGFnZSwgdGhlIGNvbmRpdGlvbiBleHByZXNzaW9u
IGlzCgptZW1iZXJfYWRkcmVzc19pc19ub25udWxsKHBvcywgbWVtYmVyKSAmJiAobiA9CmxsaXN0
X2VudHJ5KHBvcy0+bWVtYmVyLm5leHQsIHR5cGVvZigqbiksIG1lbWJlciksIHRydWUpCgpTbyBp
dCdzIHNvbWV0aGluZyBsaWtlOgoKaWYgKHdvcmstPm5vZGUgJiYgKHdvcmtfbmV4dCA9IHdvcmst
Pm5vZGUtPm5leHQsIHRydWUpKQogICAgY2xlYXJfYml0KCZ3b3JrLT5mbGFncyk7CgpTbyB0d28g
bG9hZHMgZnJvbSBib3RoIHdvcmstPm5vZGUgYW5kIHdvcmstPm5vZGUtPm5leHQsIGFuZCB0aGVy
ZSdzIGEKc3RvcmUgd2hpY2ggaXMgY2xlYXJfYml0LCB0aGVuIGl0J3MgYSBsb2FkLXN0b3JlIGNv
bnRyb2wgZGVwZW5kZW5jaWVzPwoKVGhhbmtzCgo+Cj4gT2xlZy4KPgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
