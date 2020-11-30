Return-Path: <SRS0=9iyF=FE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78EBC64E8A
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 17:53:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDF5D207F7
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 17:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQnUFR1u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF5D207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6A16C85F91;
	Mon, 30 Nov 2020 17:53:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j20WDwEE9chE; Mon, 30 Nov 2020 17:53:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0B3CA85FDB;
	Mon, 30 Nov 2020 17:53:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6F5FC0859;
	Mon, 30 Nov 2020 17:53:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9925C0052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 17:53:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9DCD6872A8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 17:53:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WX-f1ZZNOH+B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 17:53:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 137EA872A7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 17:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606758787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XZHdMrptq2/rYXjufX3+GIBx1xnGVoh3uBEQ7r4wKDM=;
 b=bQnUFR1ur6N1sP66V9HArMJTwi8a5WK7HYD8KgTIp/AmoHPySNSboefcj+ICHEdtyodky+
 TBC+JrRGxMEOebA1QuQ+xboWLj0Uf2Knf/WQhrLTf4Vae+UtSvdATaZT+eOsuss0VHE/YE
 Ce6szbdPmFbSTIADNazk/PSqI+ILm+c=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-gqOn3bzaN3G3rdsx3dEhnw-1; Mon, 30 Nov 2020 12:53:03 -0500
X-MC-Unique: gqOn3bzaN3G3rdsx3dEhnw-1
Received: by mail-ej1-f70.google.com with SMTP id s13so2010641ejr.17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 09:53:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XZHdMrptq2/rYXjufX3+GIBx1xnGVoh3uBEQ7r4wKDM=;
 b=XFymzxddqXnFr6EzOOuKO9mtT2SPv1ZEJ/CVGoW9pqZnZSOMeIhv/XpNYP4d6ff0An
 0G+1uiOISdCS/yAkED5l17ymS5qq3fMwEnBlherFgeoH58ht76C++3OatFmVb1FWXHKk
 rNNHMOT1Zr5L8bbSNzf2mnQbCYx4fLyJ1TUM+owFQsrvnx1ZT/JfwFoCysH+nHx+9Ci6
 iu+wDwF5q3UgfaE496yvYM5GDxvcwzdppr/3AEWaPfRuzIw1Qm3hCJo3+nfv5rLv3ge+
 M5gtBuWOkPgstTx+kQlufQpld/WwmrkYrGvfj5VbarQZF9FqEitz3l3UJ347jnzLhK+K
 FRjQ==
X-Gm-Message-State: AOAM531lsx1giCVfeW8+IP+0C2pXFltPuYpfVtOJj6Rw5YC9mEPB0w/n
 amMtOTe95z2MjbkHvvluEFEtwQR+FjFlcxvXCCcBOZFPuMKyHHm5F8t16N6NN+qEOFlep+GwG2S
 U3YmjwHQs321FcoOFQpzrjb3MjGIfkXf+XQ9S7j1NsA==
X-Received: by 2002:aa7:d2c9:: with SMTP id k9mr18165153edr.74.1606758781769; 
 Mon, 30 Nov 2020 09:53:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzr0C3ztJydvyz+oFfxr6BS9zKoQLZ9ul0+KLwEWxb/tzWQGQh/4ALcMPa0sNYIu2m1iyoA+g==
X-Received: by 2002:aa7:d2c9:: with SMTP id k9mr18165131edr.74.1606758781630; 
 Mon, 30 Nov 2020 09:53:01 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id k17sm8657435ejh.103.2020.11.30.09.53.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Nov 2020 09:53:00 -0800 (PST)
Subject: Re: [PATCH AUTOSEL 5.9 22/33] vhost scsi: add lun parser helper
To: Sasha Levin <sashal@kernel.org>
References: <20201125153550.810101-1-sashal@kernel.org>
 <20201125153550.810101-22-sashal@kernel.org>
 <25cd0d64-bffc-9506-c148-11583fed897c@redhat.com>
 <20201125180102.GL643756@sasha-vm>
 <9670064e-793f-561e-b032-75b1ab5c9096@redhat.com>
 <20201129041314.GO643756@sasha-vm>
 <7a4c3d84-8ff7-abd9-7340-3a6d7c65cfa7@redhat.com>
 <20201129210650.GP643756@sasha-vm>
 <e499986d-ade5-23bd-7a04-fa5eb3f15a56@redhat.com>
 <20201130173832.GR643756@sasha-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <238cbdd1-dabc-d1c1-cff8-c9604a0c9b95@redhat.com>
Date: Mon, 30 Nov 2020 18:52:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201130173832.GR643756@sasha-vm>
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

T24gMzAvMTEvMjAgMTg6MzgsIFNhc2hhIExldmluIHdyb3RlOgo+PiBJIGFtIG5vdCBhd2FyZSBv
ZiBhbnkgcHVibGljIENJIGJlaW5nIGRvbmUgX2F0IGFsbF8gZG9uZSBvbiAKPj4gdmhvc3Qtc2Nz
aSwgYnkgQ0tJIG9yIGV2ZXJ5b25lIGVsc2UuwqAgU28gYXV0b3NlbGVjdGlvbiBzaG91bGQgYmUg
ZG9uZSAKPj4gb25seSBvbiBzdWJzeXN0ZW1zIHRoYXQgaGF2ZSB2ZXJ5IGhpZ2ggY292ZXJhZ2Ug
aW4gQ0kuCj4gCj4gV2hlcmUgY2FuIEkgZmluZCBhIHRlc3RzdWl0ZSBmb3IgdmlydGlvL3Zob3N0
PyBJIHNlZSBvbmUgZm9yIEtWTSwgYnV0Cj4gd2hlcmUgaXMgdGhlIG9uZSB0aGF0IHRoZSBtYWlu
dGFpbmVycyBvZiB2aXJ0aW8vdmhvc3QgcnVuIG9uIHBhdGNoZXMKPiB0aGF0IGNvbWUgaW4/CgpJ
IGRvbid0IGtub3cgb2YgYW55LCBlc3BlY2lhbGx5IGZvciB2aG9zdC1zY3NpLiAgTWlrZUM/CgpQ
YW9sbwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
