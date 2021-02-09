Return-Path: <SRS0=H/CR=HL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA822C433E0
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 09:28:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B2B364EBE
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 09:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B2B364EBE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 28961873C6;
	Tue,  9 Feb 2021 09:28:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BwGZG34HEx6J; Tue,  9 Feb 2021 09:28:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 79E9E86B05;
	Tue,  9 Feb 2021 09:28:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58DF5C0891;
	Tue,  9 Feb 2021 09:28:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26D8FC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 09:28:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1D9FE870BD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 09:28:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mchj-36BSM+D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 09:28:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTP id 37496870C7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 09:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612861131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KhbSJj/u7/Klvaf0H1NUS1T/THomFeB/0I+b8lFOAhk=;
 b=GLROGT2nyv/pBH0NuJ+2XaxWJ0SBjjmXnnCpt5MmbbxftM7ACarlvgDNDkWBdaXCRn+Uvb
 fWw7/97Fudq3z7qAbStJTKKowNwrtaNH2yGEXZzpvEjGis72uAGXnCQjPW4C9PJvsR+J+5
 adcp86hEzZUVtJRRW65/Vw57YsU4JNc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612861732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KhbSJj/u7/Klvaf0H1NUS1T/THomFeB/0I+b8lFOAhk=;
 b=dFVdibbZ/Idj5uzpdVA7vSK1em1YjCx4epoorvtOwoVNcufkpzwylwSv8ygWB3dD2XsV/j
 TgHKt0bM3XFJbrpFswIJ9RmmQ+6P3fYFcMyW9zHEchLsvjfSu7aLQfFCuaMexaeZuDZ9CZ
 LZgyQbA8RgdCHLgcVON/T+tLv55Aq/g=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612862334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KhbSJj/u7/Klvaf0H1NUS1T/THomFeB/0I+b8lFOAhk=;
 b=fk+jFlnWWVjrgkBxT7gsFfQ+dX4RSYQMBRYu8HmHlrIWAm+i3C5daQelp/yuE8sxm8CpaE
 HzbixbcsePNwM5F7MkAw4/g6TYK/Ft68x7QJ8iroIUf+mmXoFohtCVD62OiSDoVkQbF7vw
 6SxK0opb4QybzjT0wfehwmmWdgTCKaE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-vpypIdWCMtuwKZD8vvhuQQ-1; Tue, 09 Feb 2021 03:58:49 -0500
X-MC-Unique: vpypIdWCMtuwKZD8vvhuQQ-1
Received: by mail-ed1-f71.google.com with SMTP id o21so4860841edq.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Feb 2021 00:58:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=KhbSJj/u7/Klvaf0H1NUS1T/THomFeB/0I+b8lFOAhk=;
 b=OaKQSWhhI8iEvzvD4F2WqK1O1d1zXEws5ZO4H5OwgJqV9RxmFouY1VwQtVtN8A7H7N
 zUCp5sfpAcMBcmM3Fqytfu07E4sQj/rYuapUqXzu6Lq0PxKvRTmN0HlleKHTqeSW+Vsu
 feVUqnyJOwq3oOQQHMMU+fwty9o1l6AqdsO8nZ5w9OOTcozwdxhJ3t6u+rKqYAwmY+n0
 5JVFiykua0GDWERXy5ekvsOZQEoFhfYQB1YytUN1jYtwv+a3K6khHIkjpR5xPOY69X0o
 0DUPy31Nu92NADp6+a26Ci24MHt5kubzKIkvdvQN+miQ9oHmLOPDli1iPUUSDbWfwR9I
 cYJg==
X-Gm-Message-State: AOAM533ASowDLiDoA4vZZC0MNqMdJO9gtFvZ5wbPmPZishe9NvMd97f7
 GG45ARutI0v3ElxODL+TGXcSO91hrq5qjG6Eh04YYy1LUd7C6iQJQcQSZBP89pdpGMHCDzHbEaY
 mSCT9AQ8ML2sx8K8dJNEiuSnnk4NnWIK2R/wkohwuSw==
X-Received: by 2002:a50:ec06:: with SMTP id g6mr21664790edr.12.1612861128702; 
 Tue, 09 Feb 2021 00:58:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJymcI9SAwF3UFCLc61KiBRA73aQgsEZsgY8MckX3xcIQCybfwa4DFmWwXMZJgFEzdRLQKkl3g==
X-Received: by 2002:a50:ec06:: with SMTP id g6mr21664777edr.12.1612861128479; 
 Tue, 09 Feb 2021 00:58:48 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id du6sm9918346ejc.78.2021.02.09.00.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Feb 2021 00:58:47 -0800 (PST)
Date: Tue, 9 Feb 2021 09:58:45 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa/mlx5: fix param validation in mlx5_vdpa_get_config()
Message-ID: <20210209085845.5zwtxacfgnbmnlot@steredhat>
References: <20210208161741.104939-1-sgarzare@redhat.com>
 <20210208133312-mutt-send-email-mst@kernel.org>
 <fc523fbe-b742-0ebe-84d1-2b7e5529f00b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <fc523fbe-b742-0ebe-84d1-2b7e5529f00b@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Eli Cohen <elic@nvidia.com>, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
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

T24gVHVlLCBGZWIgMDksIDIwMjEgYXQgMTE6MjQ6MDNBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+T24gMjAyMS8yLzkg5LiK5Y2IMjozOCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+
Pk9uIE1vbiwgRmViIDA4LCAyMDIxIGF0IDA1OjE3OjQxUE0gKzAxMDAsIFN0ZWZhbm8gR2FyemFy
ZWxsYSB3cm90ZToKPj4+SXQncyBsZWdhbCB0byBoYXZlICdvZmZzZXQgKyBsZW4nIGVxdWFsIHRv
Cj4+PnNpemVvZihzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcpLCBzaW5jZSAnbmRldi0+Y29uZmln
JyBpcyBhCj4+PidzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcnLCBzbyB3ZSBjYW4gc2FmZWx5IGNv
cHkgaXRzIGNvbnRlbnQgdW5kZXIKPj4+dGhpcyBjb25kaXRpb24uCj4+Pgo+Pj5GaXhlczogMWE4
NmIzNzdhYTIxICgidmRwYS9tbHg1OiBBZGQgVkRQQSBkcml2ZXIgZm9yIHN1cHBvcnRlZCBtbHg1
IGRldmljZXMiKQo+Pj5DYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwo+Pj5TaWduZWQtb2ZmLWJ5
OiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+Cj4+Pi0tLQo+Pj4gIGRy
aXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8IDIgKy0KPj4+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPj4+Cj4+PmRpZmYgLS1naXQgYS9kcml2
ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4
NV92bmV0LmMKPj4+aW5kZXggZGM4ODU1OWE4ZDQ5Li4xMGU5YjA5OTMyZWIgMTAwNjQ0Cj4+Pi0t
LSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+Pj4rKysgYi9kcml2ZXJzL3Zk
cGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4+QEAgLTE4MjAsNyArMTgyMCw3IEBAIHN0YXRpYyB2
b2lkIG1seDVfdmRwYV9nZXRfY29uZmlnKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdW5zaWdu
ZWQgaW50IG9mZnNldCwKPj4+ICAJc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2ID0gdG9fbXZk
ZXYodmRldik7Cj4+PiAgCXN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2ID0gdG9fbWx4NV92ZHBh
X25kZXYobXZkZXYpOwo+Pj4tCWlmIChvZmZzZXQgKyBsZW4gPCBzaXplb2Yoc3RydWN0IHZpcnRp
b19uZXRfY29uZmlnKSkKPj4+KwlpZiAob2Zmc2V0ICsgbGVuIDw9IHNpemVvZihzdHJ1Y3Qgdmly
dGlvX25ldF9jb25maWcpKQo+Pj4gIAkJbWVtY3B5KGJ1ZiwgKHU4ICopJm5kZXYtPmNvbmZpZyAr
IG9mZnNldCwgbGVuKTsKPj4+ICB9Cj4+QWN0dWFsbHkgZmlyc3QgSSBhbSBub3Qgc3VyZSB3ZSBu
ZWVkIHRoZXNlIGNoZWNrcyBhdCBhbGwuCj4+dmhvc3RfdmRwYV9jb25maWdfdmFsaWRhdGUgYWxy
ZWFkeSB2YWxpZGF0ZXMgdGhlIHZhbHVlcywgcmlnaHQ/Cj4KPgo+SSB0aGluayB0aGV5J3JlIHdv
cmtpbmcgYXQgZGlmZmVyZW50IGxldmVscy4gVGhlcmUncyBubyBndWFyYW50ZWUgdGhhdCAKPnZo
b3N0LXZkcGEgaXMgdGhlIGRyaXZlciBmb3IgdGhpcyB2ZHBhIGRldmljZS4KPgoKTWF5YmUgd2Ug
Y2FuIGRvIHRoZXNlIGNoZWNrcyBpbiB0aGUgdmRwYV9nZXRfY29uZmlnKCkgaGVscGVyIGFuZCB3
ZSBjYW4gCmFsc28gYWRkIGEgdmRwYV9zZXRfY29uZmlnKCkgdG8gZG8gdGhlIHNhbWUuCgpUaGFu
a3MsClN0ZWZhbm8KCj4KPj4KPj5TZWNvbmQsIHdoYXQgd2lsbCBoYXBwZW4gd2hlbiB3ZSBleHRl
bmQgdGhlIHN0cnVjdCBhbmQgdGhlbgo+PnJ1biBuZXcgdXNlcnNwYWNlIG9uIGFuIG9sZCBrZXJu
ZWw/IExvb2tzIGxpa2UgaXQgd2lsbCBqdXN0Cj4+ZmFpbCByaWdodD8gU28gd2hhdCBpcyB0aGUg
cGxhbj8KPgo+Cj5JbiB0aGlzIGNhc2UsIGdldF9jb25maWcoKSBzaG91bGQgbWF0Y2ggdGhlIHNw
ZWMgYmVoYXZpb3VyLiBUaGF0IGlzIHRvIAo+c2F5IHRoZSBzaXplIG9mIGNvbmZpZyBzcGFjZSBk
ZXBlbmRzIG9uIHRoZSBmZWF0dXJlIG5lZ290aWF0ZWQuCj4KPlRoYW5rcwo+Cj4KPj4gIEkgdGhp
bmsgd2Ugc2hvdWxkCj4+YWxsb3cgYSBiaWdnZXIgc2l6ZSwgYW5kIHJldHVybiB0aGUgY29waWVk
IGNvbmZpZyBzaXplIHRvIHVzZXJzcGFjZS4KPj4KPj4KPj4+LS0gCj4+PjIuMjkuMgo+CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
