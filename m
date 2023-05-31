Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34112C77B73
	for <virtualization@archiver.kernel.org>; Wed, 31 May 2023 05:22:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7C04D82336;
	Wed, 31 May 2023 05:22:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7C04D82336
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fz2xN4O8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Etiwh0JGr0m; Wed, 31 May 2023 05:22:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EFFFF82199;
	Wed, 31 May 2023 05:22:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EFFFF82199
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C58F8C007C;
	Wed, 31 May 2023 05:22:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8CE1C0037
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 05:22:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9C57641F24
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 05:22:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9C57641F24
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fz2xN4O8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id axc8Gat8OW99
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 05:22:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1ED2D41EE0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1ED2D41EE0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 05:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685510538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hyyMYTFvM0Mbkvw27bbtYVzj+3x2ZRPx23KOzo9PcFU=;
 b=Fz2xN4O8CNCnGF+//G0lCCMXGiys0b/umdRIVFpVjAeBU4zwudTrt5+ErDA/VoINucxTsv
 CCHdR1dCwyIZYuol9MEqTlNIp6eg6kDEp+Rgv+hwd6Q43tVmkBT1Hu3WrZhuV8RebukC/L
 LZCvdJtcFKKk1NfqjGYOT6meyJur6ng=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-ks59f4vmMZGCh3BVCb9M8Q-1; Wed, 31 May 2023 01:22:15 -0400
X-MC-Unique: ks59f4vmMZGCh3BVCb9M8Q-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-25642d15b40so4545874a91.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 22:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685510534; x=1688102534;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hyyMYTFvM0Mbkvw27bbtYVzj+3x2ZRPx23KOzo9PcFU=;
 b=FRT/WCaeww3YUght/Xq5eTC4MKmMzcT7GZg/cQnyGSn6+O9F63Tfo7YWJmTKip1/eu
 6mQojUenem8LwOH+jCNO3V4aPKaNhOgaG8T5Hag+7pEqqGMYPunj1EazfDGdLkk7CpVj
 oGMcAGR3Yc9rzwjn+mD22V5/ZYZO2aReXW951m9Q4NFA4mhFkFi4SdnSF4oTaSOcbWVY
 kwbhQX8SigUNdkTyQ//AwfHabBfRhT7R8OXSjSjO/UGNw1rYlShTQmFdlXk1XoD4IITv
 caFWxPVMm6N7aboWJl43GQUWWmE0lee0Uu4gHFVim2MKeNsYzmuaC/z1mycq8uohvMuZ
 VLOQ==
X-Gm-Message-State: AC+VfDzQGR6HyzpI4noA8rsqjiNjvkYPyVH+iMtLXfkhsFMEK6KGesDI
 vzGiVx1UMR2ttrcsLH07Ysf/ODhVSEe/YOJOpMONZiDclfvTwfaO+c7AO1dkUvBtIOkjTf/tB8l
 QbaJPBL88NusdsTjZ0izOXljlyhQcD6RulnBNFNwDgQ==
X-Received: by 2002:a17:903:32c5:b0:1a2:6257:36b9 with SMTP id
 i5-20020a17090332c500b001a2625736b9mr5737404plr.31.1685510534200; 
 Tue, 30 May 2023 22:22:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5NKnnkrfvWoHVrOcZULHtbOJ9PTxVtzJ5WaIVNPRr3IRbwtd4MYYnRfhK2JfjixmtArqhmkA==
X-Received: by 2002:a17:903:32c5:b0:1a2:6257:36b9 with SMTP id
 i5-20020a17090332c500b001a2625736b9mr5737373plr.31.1685510533888; 
 Tue, 30 May 2023 22:22:13 -0700 (PDT)
Received: from [10.72.13.48] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 e13-20020a170902d38d00b001b033873744sm253550pld.249.2023.05.30.22.22.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 22:22:13 -0700 (PDT)
Message-ID: <e8c702f3-e364-c624-1ff5-1f3da624d538@redhat.com>
Date: Wed, 31 May 2023 13:22:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 Oleg Nesterov <oleg@redhat.com>
References: <20230522025124.5863-1-michael.christie@oracle.com>
 <20230522025124.5863-4-michael.christie@oracle.com>
 <20230522123029.GA22159@redhat.com>
 <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com>
 <20230522174757.GC22159@redhat.com> <20230523121506.GA6562@redhat.com>
 <87bkib6nxr.fsf@email.froward.int.ebiederm.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <87bkib6nxr.fsf@email.froward.int.ebiederm.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: axboe@kernel.dk, brauner@kernel.org, mst@redhat.com, linux@leemhuis.info,
 linux-kernel@vger.kernel.org, stefanha@redhat.com, nicolas.dichtel@6wind.com,
 virtualization@lists.linux-foundation.org, torvalds@linux-foundation.org
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

CuWcqCAyMDIzLzUvMjMgMjM6NTcsIEVyaWMgVy4gQmllZGVybWFuIOWGmemBkzoKPiBPbGVnIE5l
c3Rlcm92IDxvbGVnQHJlZGhhdC5jb20+IHdyaXRlczoKPgo+PiBPbiAwNS8yMiwgT2xlZyBOZXN0
ZXJvdiB3cm90ZToKPj4+IFJpZ2h0IG5vdyBJIHRoaW5rIHRoYXQgImludCBkZWFkIiBzaG91bGQg
ZGllLAo+PiBObywgcHJvYmFibHkgd2Ugc2hvdWxkbid0IGNhbGwgZ2V0X3NpZ25hbCgpIGlmIHdl
IGhhdmUgYWxyZWFkeQo+PiBkZXF1ZXVlZCBTSUdLSUxMLgo+IFZlcnkgbXVjaCBhZ3JlZWQuICBJ
dCBpcyBvbmUgdGhpbmcgdG8gYWRkIGEgcGF0Y2ggdG8gbW92ZSBkb19leGl0Cj4gb3V0IG9mIGdl
dF9zaWduYWwuICBJdCBpcyBhbm90aGVyIHRvIGtlZXAgY2FsbGluZyBnZXRfc2lnbmFsIGFmdGVy
Cj4gdGhhdC4gIE5vdGhpbmcgdGVzdHMgdGhhdCBjYXNlLCBhbmQgc28gd2UgZ2V0IHNvbWUgd2Vp
cmQgYmVoYXZpb3JzLgo+Cj4KPj4+IGJ1dCBsZXQgbWUgdGhpbmsgdG9tb3Jyb3cuCj4+IE1heSBi
ZSBzb21ldGhpbmcgbGlrZSB0aGlzLi4uIEkgZG9uJ3QgbGlrZSBpdCBidXQgSSBjYW4ndCBzdWdn
ZXN0IGFueXRoaW5nIGJldHRlcgo+PiByaWdodCBub3cuCj4+Cj4+IAlib29sIGtpbGxlZCA9IGZh
bHNlOwo+Pgo+PiAJZm9yICg7Oykgewo+PiAJCS4uLgo+PiAJCj4+IAkJbm9kZSA9IGxsaXN0X2Rl
bF9hbGwoJndvcmtlci0+d29ya19saXN0KTsKPj4gCQlpZiAoIW5vZGUpIHsKPj4gCQkJc2NoZWR1
bGUoKTsKPj4gCQkJLyoKPj4gCQkJICogV2hlbiB3ZSBnZXQgYSBTSUdLSUxMIG91ciByZWxlYXNl
IGZ1bmN0aW9uIHdpbGwKPj4gCQkJICogYmUgY2FsbGVkLiBUaGF0IHdpbGwgc3RvcCBuZXcgSU9z
IGZyb20gYmVpbmcgcXVldWVkCj4+IAkJCSAqIGFuZCBjaGVjayBmb3Igb3V0c3RhbmRpbmcgY21k
IHJlc3BvbnNlcy4gSXQgd2lsbCB0aGVuCj4+IAkJCSAqIGNhbGwgdmhvc3RfdGFza19zdG9wIHRv
IHRlbGwgdXMgdG8gcmV0dXJuIGFuZCBleGl0Lgo+PiAJCQkgKi8KPj4gCQkJaWYgKHNpZ25hbF9w
ZW5kaW5nKGN1cnJlbnQpKSB7Cj4+IAkJCQlzdHJ1Y3Qga3NpZ25hbCBrc2lnOwo+Pgo+PiAJCQkJ
aWYgKCFraWxsZWQpCj4+IAkJCQkJa2lsbGVkID0gZ2V0X3NpZ25hbCgma3NpZyk7Cj4+Cj4+IAkJ
CQljbGVhcl90aHJlYWRfZmxhZyhUSUZfU0lHUEVORElORyk7Cj4+IAkJCX0KPj4KPj4gCQkJY29u
dGludWU7Cj4+IAkJfQo+IEkgd2FudCB0byBwb2ludCBvdXQgdGhhdCB3ZSBuZWVkIHRvIGNvbnNp
ZGVyIG5vdCBqdXN0IFNJR0tJTEwsIGJ1dAo+IFNJR0FCUlQgdGhhdCBjYXVzZXMgYSBjb3JlZHVt
cCwgYXMgd2VsbCBhcyB0aGUgcHJvY2VzcyBwZWZvcm1pbmcKPiBhbiBvcmRpbmFyeSBleGl0KDIp
LiAgQWxsIG9mIHdoaWNoIHdpbGwgY2F1c2UgZ2V0X3NpZ25hbCB0byByZXR1cm4KPiBTSUdLSUxM
IGluIHRoaXMgY29udGV4dC4KPgo+PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4+IEJ1dCBsZXQg
bWUgYXNrIGEgY291cGxlIG9mIHF1ZXN0aW9ucy4KPiBJIHNoYXJlIG1vc3Qgb2YgdGhlc2UgcXVl
c3Rpb25zLgo+Cj4+IExldCdzIGZvcmdldCB0aGlzIHBhdGNoLCBsZXQncyBsb29rIGF0IHRoZQo+
PiBjdXJyZW50IGNvZGU6Cj4+Cj4+IAkJbm9kZSA9IGxsaXN0X2RlbF9hbGwoJndvcmtlci0+d29y
a19saXN0KTsKPj4gCQlpZiAoIW5vZGUpCj4+IAkJCXNjaGVkdWxlKCk7Cj4+Cj4+IAkJbm9kZSA9
IGxsaXN0X3JldmVyc2Vfb3JkZXIobm9kZSk7Cj4+IAkJLi4uIHByb2Nlc3Mgd29ya3MgLi4uCj4+
Cj4+IFRvIG1lIHRoaXMgbG9va3MgYSBiaXQgY29uZnVzaW5nLiBTaG91bGRuJ3Qgd2UgZG8KPj4K
Pj4gCQlpZiAoIW5vZGUpIHsKPj4gCQkJc2NoZWR1bGUoKTsKPj4gCQkJY29udGludWU7Cj4+IAkJ
fQo+Pgo+PiBqdXN0IHRvIG1ha2UgdGhlIGNvZGUgYSBiaXQgbW9yZSBjbGVhcj8gSWYgbm9kZSA9
PSBOVUxMIHRoZW4KPj4gbGxpc3RfcmV2ZXJzZV9vcmRlcigpIGFuZCBsbGlzdF9mb3JfZWFjaF9l
bnRyeV9zYWZlKCkgd2lsbCBkbyBub3RoaW5nLgo+PiBCdXQgdGhpcyBpcyBtaW5vci4KPj4KPj4K
Pj4KPj4gCQkvKiBtYWtlIHN1cmUgZmxhZyBpcyBzZWVuIGFmdGVyIGRlbGV0aW9uICovCj4+IAkJ
c21wX3dtYigpOwo+PiAJCWxsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUod29yaywgd29ya19uZXh0
LCBub2RlLCBub2RlKSB7Cj4+IAkJCWNsZWFyX2JpdChWSE9TVF9XT1JLX1FVRVVFRCwgJndvcmst
PmZsYWdzKTsKPj4KPj4gSSBhbSBub3Qgc3VyZSBhYm91dCBzbXBfd21iICsgY2xlYXJfYml0LiBP
bmNlIHdlIGNsZWFyIFZIT1NUX1dPUktfUVVFVUVELAo+PiB2aG9zdF93b3JrX3F1ZXVlKCkgY2Fu
IGFkZCB0aGlzIHdvcmsgYWdhaW4gYW5kIGNoYW5nZSB3b3JrLT5ub2RlLT5uZXh0Lgo+Pgo+PiBU
aGF0IGlzIHdoeSB3ZSB1c2UgX3NhZmUsIGJ1dCB3ZSBuZWVkIHRvIGVuc3VyZSB0aGF0IGxsaXN0
X2Zvcl9lYWNoX3NhZmUoKQo+PiBjb21wbGV0ZXMgTE9BRCh3b3JrLT5ub2RlLT5uZXh0KSBiZWZv
cmUgVkhPU1RfV09SS19RVUVVRUQgaXMgY2xlYXJlZC4KPj4KPj4gU28gaXQgc2VlbXMgdGhhdCBz
bXBfd21iKCkgY2FuJ3QgaGVscCBhbmQgc2hvdWxkIGJlIHJlbW92ZWQsIGluc3RlYWQgd2UgbmVl
ZAo+Pgo+PiAJCWxsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoLi4uKSB7Cj4+IAkJCXNtcF9tYl9f
YmVmb3JlX2F0b21pYygpOwo+PiAJCQljbGVhcl9iaXQoVkhPU1RfV09SS19RVUVVRUQsICZ3b3Jr
LT5mbGFncyk7Cj4+Cj4+IEFsc28sIGlmIHRoZSB3b3JrLT5mbiBwb2ludGVyIGlzIG5vdCBzdGFi
bGUsIHdlIHNob3VsZCByZWFkIGl0IGJlZm9yZQo+PiBzbXBfbWJfX2JlZm9yZV9hdG9taWMoKSBh
cyB3ZWxsLgo+Pgo+PiBObz8KPj4KPj4KPj4gCQkJX19zZXRfY3VycmVudF9zdGF0ZShUQVNLX1JV
Tk5JTkcpOwo+Pgo+PiBXaHkgZG8gd2Ugc2V0IFRBU0tfUlVOTklORyBpbnNpZGUgdGhlIGxvb3A/
IERvZXMgdGhpcyBtZWFuIHRoYXQgd29yay0+Zm4oKQo+PiBjYW4gcmV0dXJuIHdpdGggY3VycmVu
dC0+c3RhdGUgIT0gUlVOTklORyA/Cj4+Cj4+Cj4+IAkJCXdvcmstPmZuKHdvcmspOwo+Pgo+PiBO
b3cgdGhlIG1haW4gcXVlc3Rpb24uIFdoYXRldmVyIHdlIGRvLCBTSUdLSUxML1NJR1NUT1AvZXRj
IGNhbiBjb21lIHJpZ2h0Cj4+IGJlZm9yZSB3ZSBjYWxsIHdvcmstPmZuKCkuIElzIGl0ICJzYWZl
IiB0byBydW4gdGhpcyBjYWxsYmFjayB3aXRoCj4+IHNpZ25hbF9wZW5kaW5nKCkgb3IgZmF0YWxf
c2lnbmFsX3BlbmRpbmcoKSA/Cj4+Cj4+Cj4+IEZpbmFsbHkuIEkgbmV2ZXIgbG9va2VkIGludG8g
ZHJpdmVycy92aG9zdC8gYmVmb3JlIHNvIEkgZG9uJ3QgdW5kZXJzdGFuZAo+PiB0aGlzIGNvZGUg
YXQgYWxsLCBidXQgbGV0IG1lIGFzayBhbnl3YXkuLi4gQ2FuIHdlIGNoYW5nZSB2aG9zdF9kZXZf
Zmx1c2goKQo+PiB0byBydW4gdGhlIHBlbmRpbmcgY2FsbGJhY2tzIHJhdGhlciB0aGFuIHdhaXQg
Zm9yIHZob3N0X3dvcmtlcigpID8KPj4gSSBndWVzcyB3ZSBjYW4ndCwgLT5tbSB3b24ndCBiZSBj
b3JyZWN0LCBidXQgY2FuIHlvdSBjb25maXJtPwo+IEluIGEgY29udmVyc2F0aW9uIGxvbmcgYWdv
IEkgcmVtZW1iZXIgaGVhcmluZyB0aGF0IHZob3N0IGRvZXMgbm90Cj4gc3VwcG9ydCBmaWxlIGRl
c2NyaXB0b3IgcGFzc2luZy4gIFdoaWNoIG1lYW5zIGFsbCBvZiB0aGUgZmlsZQo+IGRlc2NyaXB0
b3JzIHNob3VsZCBiZSBpbiB0aGUgc2FtZSBwcm9jZXNzLgoKCkl0J3Mgbm90LiBBY3R1YWxseSBw
YXNzaW5nIHZob3N0IGZkIGlzIHByZXR0eSBjb21tb24gc2luY2UgUWVtdSBpcyAKdXN1YWxseSBy
dW5uaW5nIHdpdGhvdXQgcHJpdmlsZWdlLiBTbyBpdCdzIHRoZSBjaGFyZ2Ugb2YgdGhlIG1hbmFn
ZW1lbnQgCmxheWVyIHRvIG9wZW4gdmhvc3QgZmQgYW5kIHBhc3MgaXQgdG8gUWVtdS4KCgo+Cj4g
TG9va2luZyBhdCB0aGUgdmhvc3QgY29kZSB3aGF0IEkgYW0gc2VlaW5nIGhhcHBlbmluZyBpcyB0
aGF0IHRoZQo+IHZob3N0X3dvcmtlciBwZXJzaXN0cyB1bnRpbCB2aG9zdF9kZXZfY2xlYW51cCBp
cyBjYWxsZWQgZnJvbQo+IG9uZSBvZiB0aGUgdmhvc3RfPz8/X3JlbGVhc2UoKSBmdW5jdGlvbnMu
ICBUaGUgcmVsZWFzZSBmdW5jdGlvbnMKPiBhcmUgb25seSBjYWxsZWQgYWZ0ZXIgdGhlIGxhc3Qg
Zmx1c2ggZnVuY3Rpb24gY29tcGxldGVzLiAgU2VlIF9fZnB1dAo+IGlmIHlvdSB3YW50IHRvIHRy
YWNlIHRoZSBkZXRhaWxzLgo+Cj4KPiBPbiBvbmUgaGFuZCB0aGlzIGFsbCBzZWVtcyByZWFzb25h
YmxlLiAgT24gdGhlIG90aGVyIGhhbmQgSSBhbSBub3QKPiBzZWVpbmcgdGhlIGNvZGUgdGhhdCBw
cmV2ZW50cyBmaWxlIGRlc2NyaXB0b3IgcGFzc2luZy4KCgpZZXMuCgoKPgo+Cj4gSXQgaXMgcHJv
YmFibHkgbm90IHRoZSB3b3JzdCB0aGluZyBpbiB0aGUgd29ybGQsIGJ1dCB3aGF0IHRoaXMgbWVh
bnMKPiBpcyBub3cgaWYgeW91IHBhc3MgYSBjb3B5IG9mIHRoZSB2aG9zdCBmaWxlIGRlc2NyaXB0
b3IgdG8gYW5vdGhlcgo+IHByb2Nlc3MgdGhlIHZob3N0X3dvcmtlciB3aWxsIHBlcnNpc3QsIGFu
ZCB0aHVzIHRoZSBwcm9jZXNzIHdpbGwgcGVyc2lzdAo+IHVudGlsIHRoYXQgY29weSBvZiB0aGUg
ZmlsZSBkZXNjcmlwdG9yIGlzIGNsb3NlZC4KCgpSaWdodC4KClRoYW5rcwoKCj4KPiBFcmljCj4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
