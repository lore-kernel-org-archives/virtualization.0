Return-Path: <SRS0=st/B=FW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B4BC4361B
	for <virtualization@archiver.kernel.org>; Fri, 18 Dec 2020 08:15:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9C6523A00
	for <virtualization@archiver.kernel.org>; Fri, 18 Dec 2020 08:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C6523A00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4BC24879E9;
	Fri, 18 Dec 2020 08:15:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8ktN-XMIZPJS; Fri, 18 Dec 2020 08:15:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BBB1C86BA0;
	Fri, 18 Dec 2020 08:15:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6EBF3C1787;
	Fri, 18 Dec 2020 08:15:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C57DC0893
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Dec 2020 08:15:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4DBC0879E9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Dec 2020 08:15:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8SMyQDfbggrU
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Dec 2020 08:15:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E8AD186BA0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Dec 2020 08:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608279339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yJQNuWN6HgmUgv+RsZbi92+/+MM37ldG2zXD3RbUN9s=;
 b=h9tbKPTmhmasmI4DxdZ/6Kd6E48LUzxzQG0RX80lSXs3MH7xVjAXPkI/taM/VeTlXN3rHh
 kU44C2BADd4bG4g0iOKskmN+nxE8Edw2dlEZrAjZFaf5te52iEoS/J5wmsiU61CbW/ID6J
 In+bKS4J85kiX3ne7muTzn0SR4RwybE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-ME6i4_EfPsGhd_dd0dYT3A-1; Fri, 18 Dec 2020 03:15:37 -0500
X-MC-Unique: ME6i4_EfPsGhd_dd0dYT3A-1
Received: by mail-wr1-f72.google.com with SMTP id w5so817863wrl.9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Dec 2020 00:15:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=yJQNuWN6HgmUgv+RsZbi92+/+MM37ldG2zXD3RbUN9s=;
 b=cwHwFBr4dCPMa0eJbDhzufrAiR8EQADdVOM3y/0GACCyF26ZumldRkdee5TysK5JU9
 rAjLBWuoH9G8QvrSGYLvXscA50LKj6cXDiDD6ex96BA+7Z0tDN+EpQtviPk1lN3pjy1F
 UsfgAhN35yWfO4WFeyohs53tiiFNDX3iIGnddujTxo2Hve1HJdNeUJDGorirwzobJyTF
 Vvh58BQRC+h2S1JJlwHfr+i3bwmkfJxBebkVYyIIdYUBkc+5HMRpcsV4rsrzA0XcXeJz
 A+pUa0nK+3t2fR2SgI642BglQfva7IkD9/WWvh6lxv/IdCuZs2fFMJXwUiDAX58WmtIR
 mTKA==
X-Gm-Message-State: AOAM5336xUEYr3KwNVR5P/Gmezpy00D0M5YZEe6T/7Gfay0PM4dk5JwP
 prlPL701+brrBhk3WZ6LSBrs7bxQTBVo8kPjvZ+O3z2LtDBMqjey/MRbOwvg4OHiwUTamvi4NGI
 wB83X4koqGxk54+UPGNptK0MGjI1TNlQK/dQfVZZ7gw==
X-Received: by 2002:adf:e710:: with SMTP id c16mr3007764wrm.295.1608279336680; 
 Fri, 18 Dec 2020 00:15:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxUFVDuslSIR7sNU3rmxCt3qjTQFKF/gKj1mKj2MVbmEs9Iy1ApdCkivOAma0zVSTrHR8vMmw==
X-Received: by 2002:adf:e710:: with SMTP id c16mr3007739wrm.295.1608279336451; 
 Fri, 18 Dec 2020 00:15:36 -0800 (PST)
Received: from steredhat (host-79-13-204-15.retail.telecomitalia.it.
 [79.13.204.15])
 by smtp.gmail.com with ESMTPSA id k6sm10866853wmf.25.2020.12.18.00.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Dec 2020 00:15:35 -0800 (PST)
Date: Fri, 18 Dec 2020 09:15:33 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Zouwei (Samuel)" <zou_wei@huawei.com>
Subject: Re: =?utf-8?B?562U5aSN?= =?utf-8?Q?=3A?= [PATCH -next] vdpa: Mark
 macaddr_buf with static keyword
Message-ID: <20201218081533.r7lv3yx5xba46saa@steredhat>
References: <1608256295-69649-1-git-send-email-zou_wei@huawei.com>
 <20201218075659.zjts2fiwp2jkh2ei@steredhat>
 <14fa1fb211784992a0e64e9810bdedef@huawei.com>
MIME-Version: 1.0
In-Reply-To: <14fa1fb211784992a0e64e9810bdedef@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "mgurtovoy@nvidia.com" <mgurtovoy@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>
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

T24gRnJpLCBEZWMgMTgsIDIwMjAgYXQgMDg6MTE6MjBBTSArMDAwMCwgWm91d2VpIChTYW11ZWwp
IHdyb3RlOgo+SGksCj5JIHJ1biB0aGlzIGNvbW1hbmQ6Cj5tYWtlIGFsbG1vZGNvbmZpZyBBUkNI
PXg4Nl82NCBDUk9TU19DT01QSUxFPXg4Nl82NC1saW51eC1nbnUtCj5tYWtlIEM9MiBkcml2ZXJz
L3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fbmV0Lm8gQVJDSD14ODZfNjQgQ1JPU1NfQ09NUElMRT14
ODZfNjQtbGludXgtZ251LQoKWWVhaCwgSSBjYW4gc2VlIHRoZSB3YXJuaW5nIHVzaW5nIEM9Mi4K
SSdsbCB1c2UgaXQgbmV4dCB0aW1lcy4KClRoYW5rcyBmb3Igc2hhcmluZywKU3RlZmFubwoKPgo+
Cj4tLS0tLemCruS7tuWOn+S7ti0tLS0tCj7lj5Hku7bkuro6IFN0ZWZhbm8gR2FyemFyZWxsYSBb
bWFpbHRvOnNnYXJ6YXJlQHJlZGhhdC5jb21dCj7lj5HpgIHml7bpl7Q6IDIwMjDlubQxMuaciDE4
5pelIDE1OjU3Cj7mlLbku7bkuro6IFpvdXdlaSAoU2FtdWVsKSA8em91X3dlaUBodWF3ZWkuY29t
Pgo+5oqE6YCBOiBtc3RAcmVkaGF0LmNvbTsgamFzb3dhbmdAcmVkaGF0LmNvbTsgbWd1cnRvdm95
QG52aWRpYS5jb207IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj7kuLvpopg6IFJlOiBbUEFUQ0ggLW5leHRdIHZk
cGE6IE1hcmsgbWFjYWRkcl9idWYgd2l0aCBzdGF0aWMga2V5d29yZAo+Cj5PbiBGcmksIERlYyAx
OCwgMjAyMCBhdCAwOTo1MTozNUFNICswODAwLCBab3UgV2VpIHdyb3RlOgo+PkZpeCB0aGUgZm9s
bG93aW5nIHNwYXJzZSB3YXJuaW5nOgo+Pgo+PmRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3Np
bV9uZXQuYzozNjo0OiB3YXJuaW5nOiBzeW1ib2wgJ21hY2FkZHJfYnVmJyB3YXMgbm90IGRlY2xh
cmVkLiBTaG91bGQgaXQgYmUgc3RhdGljPwo+Pgo+PlJlcG9ydGVkLWJ5OiBIdWxrIFJvYm90IDxo
dWxrY2lAaHVhd2VpLmNvbT4KPj5TaWduZWQtb2ZmLWJ5OiBab3UgV2VpIDx6b3Vfd2VpQGh1YXdl
aS5jb20+Cj4+LS0tCj4+IGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9uZXQuYyB8IDIg
Ky0KPj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPlJl
dmlld2VkLWJ5OiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+Cj4KPkkg
YnVpbHQgd2l0aCBXPTEgYnV0IEkgZGlkbid0IGhhdmUgdGhpcyB3YXJuaW5nLgo+Cj5UaGFua3Mg
Zm9yIGZpeGluZywKPlN0ZWZhbm8KPgo+Pgo+PmRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRw
YV9zaW0vdmRwYV9zaW1fbmV0LmMKPj5iL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9u
ZXQuYwo+PmluZGV4IGMxMGI2OTguLmYwNDgyNDIgMTAwNjQ0Cj4+LS0tIGEvZHJpdmVycy92ZHBh
L3ZkcGFfc2ltL3ZkcGFfc2ltX25ldC5jCj4+KysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3Zk
cGFfc2ltX25ldC5jCj4+QEAgLTMzLDcgKzMzLDcgQEAgc3RhdGljIGNoYXIgKm1hY2FkZHI7ICBt
b2R1bGVfcGFyYW0obWFjYWRkciwgY2hhcnAsCj4+MCk7ICBNT0RVTEVfUEFSTV9ERVNDKG1hY2Fk
ZHIsICJFdGhlcm5ldCBNQUMgYWRkcmVzcyIpOwo+Pgo+Pi11OCBtYWNhZGRyX2J1ZltFVEhfQUxF
Tl07Cj4+K3N0YXRpYyB1OCBtYWNhZGRyX2J1ZltFVEhfQUxFTl07Cj4+Cj4+IHN0YXRpYyBzdHJ1
Y3QgdmRwYXNpbSAqdmRwYXNpbV9uZXRfZGV2Owo+Pgo+Pi0tCj4+Mi42LjIKPj4KPgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
