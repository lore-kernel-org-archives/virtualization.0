Return-Path: <SRS0=U4FE=NK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3831C4338F
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 07:42:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64CB361139
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 07:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 64CB361139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 201F660BBE;
	Thu, 19 Aug 2021 07:42:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XdDKIhqCW1PV; Thu, 19 Aug 2021 07:42:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BE18960BC2;
	Thu, 19 Aug 2021 07:42:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9616AC0010;
	Thu, 19 Aug 2021 07:42:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42D42C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 07:42:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 233FC402D3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 07:42:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3MvSHr7cdgeA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 07:42:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B4EB4400A8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 07:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629358924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tOm5NxLt53rtPmT+9vNg7luP4wxmFPpEOTTNqx0EFcs=;
 b=d0bvPPMA2Z5kOH2zNiheWCeW5GUCrGdQkhPJEKpiWFPNtUrrwFy8ieohCmEOfbedS+LTkF
 AIENNQwOfOm9qALhVSewFiHe2k1XnX01Gb1usw8Yb2Uct7Ghcy3qYsHPSgygrHtG011Vzd
 GcJV9VjKX+W/mX3EyvzBqCzGhgNNCx0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-rNmqMEBjPFi2js9xoIN9qw-1; Thu, 19 Aug 2021 03:42:03 -0400
X-MC-Unique: rNmqMEBjPFi2js9xoIN9qw-1
Received: by mail-pl1-f198.google.com with SMTP id
 u8-20020a17090341c8b029012d5f2333bfso1328480ple.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 00:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=tOm5NxLt53rtPmT+9vNg7luP4wxmFPpEOTTNqx0EFcs=;
 b=dGrbWaNUjUbDlZw98xv+Kc3nNDKU0NCLkpOCHP/ubG1+3VKza5OqHy9G1Xpi//2/PB
 OH6roENAGn186BW5GMuhPtD5rvI7zIfd+rj+pcVC+plO6FUivnMsUbaCmskXBC/rrGCB
 c0qabCwxTuadPaKO4dlwbgHcR8WuOzu+tY4SREeqRe2pFkBBxm4HjpoohpyVKa6cDolH
 C+c7hHr5Hn0P6GgHzqq3XeGtmSwTTUJ4WGOhgWUpnYmP13cm1AYQB0ScJpmyUnW+RQCh
 CCtcuZXJrTExzWKJ/KPU+NqxmreE6UyxlYHSlu12zuf0mZBucWq1dKQmZjzRrOo8o2KD
 AtPg==
X-Gm-Message-State: AOAM531bqyl0tLxrwqD0dwrzyVUU5P1erkJjbdEuLAwXuwrd1Kpa1937
 XJKbaknt893vqXnHP9ND4Hlua0U330sI2Okql8DRozVvy9UF7NikOcvaRbdpv6kJN7A0ClVTISI
 Chxapp0YGj/NH/9UkQfEvLaj9PEjWqNcPdwkbNK8azg==
X-Received: by 2002:a17:902:c60b:b029:12d:4ea3:34a5 with SMTP id
 r11-20020a170902c60bb029012d4ea334a5mr10771281plr.34.1629358922249; 
 Thu, 19 Aug 2021 00:42:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmra3GQa90pdnWn1vKuuLje5lL3JFMYRKsujZcbWL8U2mn59ksyEBwrBjsWsybRA8AZodGmA==
X-Received: by 2002:a17:902:c60b:b029:12d:4ea3:34a5 with SMTP id
 r11-20020a170902c60bb029012d4ea334a5mr10771264plr.34.1629358921976; 
 Thu, 19 Aug 2021 00:42:01 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id p30sm2277661pfh.116.2021.08.19.00.41.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Aug 2021 00:42:01 -0700 (PDT)
Subject: Re: [PATCH v2 5/6] vdpa/mlx5: Add support for control VQ and MAC
 setting
To: Eli Cohen <elic@nvidia.com>
References: <20210817060250.188705-1-elic@nvidia.com>
 <20210817060250.188705-6-elic@nvidia.com>
 <92a8b0e6-7eba-8309-0c67-f526046573fc@redhat.com>
 <20210819060641.GA161591@mtl-vdi-166.wap.labs.mlnx>
 <b2aada9a-7cea-93aa-dc22-349968e8b2eb@redhat.com>
 <20210819072145.GA166182@mtl-vdi-166.wap.labs.mlnx>
 <20210819072438.GB166182@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c08fb86b-29d1-6b79-c421-abc7b37e8a9c@redhat.com>
Date: Thu, 19 Aug 2021 15:41:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210819072438.GB166182@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org,
 mst@redhat.com
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

CuWcqCAyMDIxLzgvMTkg5LiL5Y2IMzoyNCwgRWxpIENvaGVuIOWGmemBkzoKPj4+Pj4gKwl2cmlu
Z2hfc2V0X2lvdGxiKCZtdmRldi0+Y3ZxLnZyaW5nLCBtdmRldi0+Y3ZxLmlvdGxiLCAmbXZkZXYt
PmN2cS5pb21tdV9sb2NrKTsKPj4+Pj4gKwllcnIgPSBpb3ZhX2NhY2hlX2dldCgpOwo+Pj4+IEFu
eSByZWFzb24gZm9yIHVzaW5nIGlvdmEgY2FjaGUgaGVyZT8KPj4+IElzbid0IGl0IHJlcXVpcmVk
PyBBcmVuJ3Qgd2UgYWxsb2NhdGluZyBidWZmZXJzIGZvciB0aGUgQ1ZRIGZyb20KPj4+IGlvbW11
X2lvdmEga21lbSBjYWNoZT8KPj4gSSBtYXkgbWlzcyBzb21ldGhpbmcgaGVyZSBidXQgd2hpY2gg
YnVmZmVyIGRpZCB5b3UgcmVmZXIgaGVyZT8KPj4KPiBBcmVuJ3QgdGhlIGRhdGEgYnVmZmVycyBm
b3IgdGhlIGNvbnRyb2wgVlEgYWxsb2NhdGVkIGZyb20gdGhpcyBjYWNoZT8KCgpTb3JyeSwgYnV0
IHlvdSBtZWFuIHRoZSBidWZmZXIgbWFuYWdlZCBieSB0aGUgdmlydGlvLW5ldCBvciB0aGUgbWx4
NWUgaGVyZT8KClRoYW5rcwoKCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
