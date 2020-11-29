Return-Path: <SRS0=PU37=FD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F71C3E8C5
	for <virtualization@archiver.kernel.org>; Sun, 29 Nov 2020 17:34:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F6492080C
	for <virtualization@archiver.kernel.org>; Sun, 29 Nov 2020 17:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OcFNQ8Q0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F6492080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B914685F8F;
	Sun, 29 Nov 2020 17:34:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5zQW1ysm5L6E; Sun, 29 Nov 2020 17:34:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0AE2B85F88;
	Sun, 29 Nov 2020 17:34:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1334C163C;
	Sun, 29 Nov 2020 17:34:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D138AC0052
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Nov 2020 17:34:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B8D2487411
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Nov 2020 17:34:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 03CbYPVS4aHW
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Nov 2020 17:34:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A6F7586DC0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Nov 2020 17:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606671248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Baf2YabTsa2IfZZmu8SPbdZascUUB96+ibE6qUCU1Gc=;
 b=OcFNQ8Q0Cd66CIJO+fd/hzSsFKTxj7yn/w3Ki3tEzQXczI7jT73cO1CXLE5JNvmZ6rIYTg
 5xB1fMDsU+CaTUd1QWtapL2wFrZxQMyCHbDnZBumLxmXlKbuF2MNI1RdsfX2011faP474+
 AivSLGSkSnZLMDee2sHzRNovMaRYFOs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-IYGi5--vOhyezZD6p49Vqw-1; Sun, 29 Nov 2020 12:34:06 -0500
X-MC-Unique: IYGi5--vOhyezZD6p49Vqw-1
Received: by mail-wm1-f72.google.com with SMTP id k128so6103674wme.7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Nov 2020 09:34:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Baf2YabTsa2IfZZmu8SPbdZascUUB96+ibE6qUCU1Gc=;
 b=iHoOUihVCPjSznAjp60J6Br7JNOjlmDDEEtxM1Xp2NwKo2LO2y/K9TNFDVWoa6ah8U
 2r6nZs2u2NW4oK0G2jHRFXAhqBw5CMSRBCGPgmptSWptWKWgTBX1olsfj0RZr3u/QGYI
 6M+KnpUHZZxzeekmKsTUXjew5qd7cLeJZUEcUDhfj9+J+SOZiAu07TGbU/DwFoDDuX/0
 jZDxp38kSXEISCB0IBAZoPOzrPPX0SjA+gJq9Ki+KS6oO/pZvnq/Zh7sfAEf5eQKSpT+
 5jiRx7xOJEl1wBkyE8yLBeLzmO+/YyMFoGHAEU+9mySRUFOg0Nx8UnP9qCFl9f3xAdZT
 8/4A==
X-Gm-Message-State: AOAM530UMUw79ggYt2jkzwa3rMqv+tJ73lj/Xz6RZf+NA7gzmeY7OksW
 kRoyCbmOee8GG0CgmW0Ipx/UB2ZCug14pLv4f9SPJMeofZGS5emjMKTBuZmmGjLOPap41qDqgl+
 mIAJ/hzo4p2QH8Sbhr7g+TqZCVKo+CNXqwq7O6bGvoQ==
X-Received: by 2002:a1c:4d0a:: with SMTP id o10mr19426264wmh.107.1606671245227; 
 Sun, 29 Nov 2020 09:34:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy21n5+1MquKPMw6OBo6U5LqUAw3wOmx072b/JbOC0N0bjRNE96mnvZ3UYX3LcDBBupYSjL2g==
X-Received: by 2002:a1c:4d0a:: with SMTP id o10mr19426239wmh.107.1606671244962; 
 Sun, 29 Nov 2020 09:34:04 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e?
 ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id m4sm4842595wmi.41.2020.11.29.09.34.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Nov 2020 09:34:04 -0800 (PST)
Subject: Re: [PATCH AUTOSEL 5.9 22/33] vhost scsi: add lun parser helper
To: Sasha Levin <sashal@kernel.org>
References: <20201125153550.810101-1-sashal@kernel.org>
 <20201125153550.810101-22-sashal@kernel.org>
 <25cd0d64-bffc-9506-c148-11583fed897c@redhat.com>
 <20201125180102.GL643756@sasha-vm>
 <9670064e-793f-561e-b032-75b1ab5c9096@redhat.com>
 <20201129041314.GO643756@sasha-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7a4c3d84-8ff7-abd9-7340-3a6d7c65cfa7@redhat.com>
Date: Sun, 29 Nov 2020 18:34:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201129041314.GO643756@sasha-vm>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Mike Christie <michael.christie@oracle.com>
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

T24gMjkvMTEvMjAgMDU6MTMsIFNhc2hhIExldmluIHdyb3RlOgo+PiBXaGljaCBkb2Vzbid0IHNl
ZW0gdG8gYmUgc3VpdGFibGUgZm9yIHN0YWJsZSBlaXRoZXIuLi7CoCBQYXRjaCAzLzUgaW4gCj4g
Cj4gV2h5IG5vdD8gSXQgd2FzIHNlbnQgYXMgYSBmaXggdG8gTGludXMuCgpEdW5ubywgMTIwIGxp
bmVzIG9mIG5ldyBjb2RlPyAgRXZlbiBpZiBpdCdzIG9rYXkgZm9yIGFuIHJjLCBJIGRvbid0IHNl
ZSAKd2h5IGl0IGlzIHdvdWxkIGJlIGJhY2twb3J0ZWQgdG8gc3RhYmxlIHJlbGVhc2VzIGFuZCBy
ZWxlYXNlIGl0IHdpdGhvdXQgCmFueSBraW5kIG9mIHRlc3RpbmcuICBNYXliZSBmb3IgNS45IHRo
ZSBjaGFuY2VzIG9mIGJyZWFraW5nIHRoaW5ncyBhcmUgCmxvdywgYnV0IHN0dWZmIGxpa2UgbG9j
a2luZyBydWxlcyBtaWdodCBoYXZlIGNoYW5nZWQgc2luY2Ugb2xkZXIgCnJlbGVhc2VzIGxpa2Ug
NS40IG9yIDQuMTkuICBUaGUgYXV0b3NlbGVjdGlvbiBib3QgZG9lcyBub3Qga25vdyB0aGF0LCBp
dCAKYmFzaWNhbGx5IGNyb3NzZXMgZmluZ2VycyB0aGF0IHRoZXNlIGxhcmdlci1zY2FsZSBjaGFu
Z2VzIGNhdXNlIHRoZSAKcGF0Y2hlcyBub3QgdG8gYXBwbHkgb3IgY29tcGlsZSBhbnltb3JlLgoK
TWF5YmUgaXQncyBqdXN0IG1lLCBidXQgdGhlIHdob2xlICJhdXRvc2VsZWN0IHN0YWJsZSBwYXRj
aGVzIiBhbmQgCnJlbGVhc2UgdGhlbSBpcyB2ZXJ5IHN1c3BpY2lvdXMuICBZb3UgYXJlIGJhc2lj
YWxseSBjcm9zc2luZyBmaW5nZXJzIGFuZCAKYXJlIHJlYWR5IHRvIHJlbGVhc2UgYW55IGtpbmQg
b2YgdW50ZXN0ZWQgY3JhcCwgYmVjYXVzZSB5b3UgZG8gbm90IHRydXN0IAptYWludGFpbmVycyBv
ZiBtYXJraW5nIHN0YWJsZSBwYXRjaGVzIHJpZ2h0LiAgT25seSB0aGVuLCB3aGVuIGEgYmFja3Bv
cnQgCmlzIGJyb2tlbiwgaXQncyBtYWludGFpbmVycyB3aG8gZ2V0IHRoZSBibGFtZSBhbmQgaGF2
ZSB0byBmaXggaXQuCgpQZXJzb25hbGx5IEkgZG9uJ3QgY2FyZSBiZWNhdXNlIEkgaGF2ZSBhc2tl
ZCB5b3UgdG8gb3B0IEtWTSBvdXQgb2YgCmF1dG9zZWxlY3Rpb24sIGJ1dCB0aGlzIGlzIHRoZSBv
cHBvc2l0ZSBvZiB3aGF0IEdyZWcgYnJhZ3MgYWJvdXQgd2hlbiBoZSAKdG91dHMgdGhlIHZpcnR1
ZXMgb2YgdGhlIHVwc3RyZWFtIHN0YWJsZSBwcm9jZXNzIG92ZXIgdmVuZG9yIGtlcm5lbHMuCgpQ
YW9sbwoKPj4gdGhlIHNlcmllcyBtaWdodCBiZSAodmhvc3Qgc2NzaTogZml4IGNtZCBjb21wbGV0
aW9uIHJhY2UpLCBzbyBJIGNhbiAKPj4gdW5kZXJzdGFuZCBpbmNsdWRpbmcgMS81IGFuZCAyLzUg
anVzdCBpbiBjYXNlLCBidXQgbm90IHRoZSByZXN0LsKgIERvZXMgCj4+IHRoZSBib3Qgbm90IHVu
ZGVyc3RhbmQgZGlmZnN0YXRzPwo+IAo+IE5vdCBvbiB0aGVpciBvd24sIG5vLiBXaGF0J3Mgd3Jv
bmcgd2l0aCB0aGUgZGlmZnN0YXRzPwo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
