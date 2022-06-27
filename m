Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6A0C43334
	for <virtualization@archiver.kernel.org>; Mon, 27 Jun 2022 13:26:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B025F60D74;
	Mon, 27 Jun 2022 13:26:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B025F60D74
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MZumfXL7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fBnz5wx8j58M; Mon, 27 Jun 2022 13:26:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0448360AFA;
	Mon, 27 Jun 2022 13:26:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0448360AFA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E08B6C0039;
	Mon, 27 Jun 2022 13:26:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8FB0BC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 13:26:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4C89E41988
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 13:26:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4C89E41988
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MZumfXL7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mbnpsxxaWkK0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 13:26:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 33AD041951
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 33AD041951
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 13:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656336362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=naeqYXHlGAllaeUBiv2eXRj7Ab0soUVGYGMw5VF+feE=;
 b=MZumfXL7Lz3XqmAC/xFDEJ386+/1AwRhnfIbT8wF8HYqtQS6LSVDLyQWuxTYdqUYINUBS+
 /iKp7i+n/0Tvck26ukoq1GT3UVOZjMGwIZLOkAM0EDXMhDrgLH1wiI8QDU2an1fBWIARX0
 eg8nT4Rt2wO/+ReCxPigBlszFNEEAxg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-ms0AQoCiMEW_P8SRgRceKQ-1; Mon, 27 Jun 2022 09:25:57 -0400
X-MC-Unique: ms0AQoCiMEW_P8SRgRceKQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 690A93C11060;
 Mon, 27 Jun 2022 13:25:56 +0000 (UTC)
Received: from [10.22.10.125] (unknown [10.22.10.125])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 742B82166B29;
 Mon, 27 Jun 2022 13:25:55 +0000 (UTC)
Message-ID: <14a3278e-0299-8138-ff73-654d0208bdfa@redhat.com>
Date: Mon, 27 Jun 2022 09:25:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] x86/paravirt: useless assignment instructions cause
 Unixbench full core performance degradation
Content-Language: en-US
To: Guo Hui <guohui@uniontech.com>, peterz@infradead.org
References: <f6b68466-968c-4a91-655a-23970280a072@redhat.com>
 <20220627021350.25714-1-guohui@uniontech.com>
 <e57ab7f6-09e0-9189-8b08-4d68be76f518@redhat.com>
 <62b94621.1c69fb81.3a378.57ccSMTPIN_ADDED_BROKEN@mx.google.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <62b94621.1c69fb81.3a378.57ccSMTPIN_ADDED_BROKEN@mx.google.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Cc: jgross@suse.com, x86@kernel.org, hpa@zytor.com, pv-drivers@vmware.com,
 boqun.feng@gmail.com, dave.hansen@linux.intel.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 mingo@redhat.com, bp@alien8.de, amakhalov@vmware.com, tglx@linutronix.de,
 will@kernel.org, wangxiaohua@uniontech.com
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

T24gNi8yNy8yMiAwMTo1NCwgR3VvIEh1aSB3cm90ZToKPiBUaGFuayB5b3UgdmVyeSBtdWNoIExv
bmdtYW4sIG15IHBhdGNoIGlzIGFzIHlvdSBzYWlkLCBvbmx5IGRpc2FibGUgCj4gbm9kZV9jcHUg
b24gWDg2LCBlbmFibGUgbm9kZV9jcHUgb24gYXJtNjQsIHBvd2VycGMsIHMzOTAgYXJjaGl0ZWN0
dXJlczsKPiB0aGUgY29kZSBpcyBpbiBmaWxlIGFyY2gveDg2L2tlcm5lbC9wYXJhdmlydC1zcGlu
bG9ja3MuYzoKPiDCoMKgwqAgREVDTEFSRV9TVEFUSUNfS0VZX0ZBTFNFKHByZWVtdGVkX2tleSk7
Cj4gwqDCoMKgIHN0YXRpY19icmFuY2hfZW5hYmxlKCZwcmVlbXRlZF9rZXkpOwo+Cj4gdGhlIGRl
ZmF1bHQgdmFsdWUgb2YgcHJlZW10ZWRfa2V5IGlzIGZhbHNlIGFuZCB0aGUgaWYgY29uZGl0aW9u
YWwgCj4gc3RhdGVtZW50IGlzIHJldmVyc2VkLAo+IHRoZSBjb2RlIGlzIGluIGZpbGUga2VybmVs
L2xvY2tpbmcvb3NxX2xvY2suYzoKPiDCoMKgwqAgREVGSU5FX1NUQVRJQ19LRVlfRkFMU0UocHJl
ZW10ZWRfa2V5KTsKPgo+IMKgwqDCoCBzdGF0aWMgaW5saW5lIGludCBub2RlX2NwdShzdHJ1Y3Qg
b3B0aW1pc3RpY19zcGluX25vZGUgKm5vZGUpCj4gwqDCoMKgIHsKPiDCoMKgwqDCoMKgwqDCoCBp
bnQgY3B1ID0gMDsKPgo+IMKgwqDCoMKgwqDCoMKgIGlmICghc3RhdGljX2JyYW5jaF91bmxpa2Vs
eSgmcHJlZW10ZWRfa2V5KSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNwdSA9IG5vZGUtPmNw
dSAtIDE7Cj4KPiDCoMKgwqDCoMKgwqDCoCByZXR1cm4gY3B1Owo+IMKgIH0KPgo+IEluIHRoaXMg
d2F5LCBvbmx5IG9uZSBub3AgaW5zdHJ1Y3Rpb24gaXMgYWRkZWQgdG8gYXJjaGl0ZWN0dXJlcyBh
cm02NCwgCj4gcG93ZXJwYyBhbmQgczM5MCwgaW5jbHVkaW5nIHZpcnR1YWwgbWFjaGluZXMsIHdp
dGhvdXQgYW55IG90aGVyIGNoYW5nZXMuCgpZb3UgYXJlIHJpZ2h0LiBJIGFtIHByb2JhYmx5IHRv
byB0aXJlZCBsYXN0IG5pZ2h0IHRvIHJlYWQgdGhlIHBhdGNoIG1vcmUgCmNhcmVmdWxseS4KCkNo
ZWVycywKTG9uZ21hbgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
