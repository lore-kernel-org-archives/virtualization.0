Return-Path: <SRS0=IhT0=PV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBBEC433F5
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 07:40:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6109C60E9B
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 07:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6109C60E9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 37AD760682;
	Tue,  2 Nov 2021 07:40:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rLRsdBgGujnN; Tue,  2 Nov 2021 07:40:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CB76D605D5;
	Tue,  2 Nov 2021 07:40:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5457C0012;
	Tue,  2 Nov 2021 07:40:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2AC42C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 07:40:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0C60F402B5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 07:40:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 69tBx-rbEnDz
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 07:40:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3C097402AF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 07:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635838817;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rPu+TEWex7DM2XBPyMWNsPrFrpctl7ejYlHuF04HTQA=;
 b=Hh0oMvDXN2YmljNDLMOBzE4IQSIQsYBNEYErTrxoa0NvN1dCfOsxT1N61y5vMsKdLdg9eJ
 zED0wPN9UySeuebechWMdFWqmfAtI7yEedPVuYPEhvBvvuWw8PfmA8fWwhYTYl8hcwJshV
 R6eSROGOcZ509czgQAxAS1doAv8ZRaM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-YoK2mwF1Nh-E4U6F8rIl1Q-1; Tue, 02 Nov 2021 03:40:14 -0400
X-MC-Unique: YoK2mwF1Nh-E4U6F8rIl1Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 b133-20020a1c808b000000b0032cdd691994so719228wmd.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 02 Nov 2021 00:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rPu+TEWex7DM2XBPyMWNsPrFrpctl7ejYlHuF04HTQA=;
 b=vsyyYUdw30+EJw9++g7nSZ4BIlrnllzK4ePy5FhyttFZV4JPCdpMLgc5uhqWyM43+f
 5A37stkdiTczWjH1UmfbDMBk46Gjw5KcVPyM5sYmT01urZq3Z+eGF7GKXCzFwyqInhx+
 Y4yPYMs74Xds1JBmaLYVS5FaT/ro8gbHQW6wow+1QyCYTZPdvzxp3X+g91eWScfmbvPf
 OgPXVCwQ84Vo9ge1YVrjpHEig+P5Gsmg7QT7uJvhEAq1Fvj3p6hf6w9Kjvk4LPjR9AVS
 5glxXwqW14T1Ca+d4nVspACePl794cXDmVWTwM//67M0gDwiRlrqK7O5mJx+LVnWFn2r
 hgjQ==
X-Gm-Message-State: AOAM530TnN6TsM9N1L8MfpQXKvhMlq0pGhp3pvloir7xKla2cCsMLQCl
 ABrwKmF831lERCaEEba75KchcCj5KUxuizROAcdoiCcPU5gV8lUmPa7Z1EStfm4KUNMOl++tW4Q
 69dIjExwsAreLcUBQfFelSpR7ZbzXFN8TAAIzD5hJGw==
X-Received: by 2002:a7b:c303:: with SMTP id k3mr5030192wmj.44.1635838813083;
 Tue, 02 Nov 2021 00:40:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDXjZ2/S+Zu4EmMWCEIeewzQXHCc0CYy7LGlLuQHKmQa056kHgEW9fPc0Xyhggtn8VOI4Tew==
X-Received: by 2002:a7b:c303:: with SMTP id k3mr5030164wmj.44.1635838812943;
 Tue, 02 Nov 2021 00:40:12 -0700 (PDT)
Received: from localhost ([188.26.219.88])
 by smtp.gmail.com with ESMTPSA id u16sm1547759wmc.21.2021.11.02.00.40.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Nov 2021 00:40:12 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Eugenio =?utf-8?Q?P=C3=A9rez?= <eperezma@redhat.com>
Subject: Re: [RFC PATCH v5 02/26] vhost: Fix last queue index of devices
 with no cvq
In-Reply-To: <20211029183525.1776416-3-eperezma@redhat.com> ("Eugenio
 =?utf-8?Q?P=C3=A9rez=22's?=
 message of "Fri, 29 Oct 2021 20:35:01 +0200")
References: <20211029183525.1776416-1-eperezma@redhat.com>
 <20211029183525.1776416-3-eperezma@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date: Tue, 02 Nov 2021 08:40:11 +0100
Message-ID: <87mtmnngys.fsf@secure.mitica>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=quintela@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Xiao W Wang <xiao.w.wang@intel.com>, Harpreet Singh Anand <hanand@xilinx.com>,
 Eli Cohen <eli@mellanox.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>, virtualization@lists.linux-foundation.org,
 Parav Pandit <parav@mellanox.com>
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
Reply-To: quintela@redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

RXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+IHdyb3RlOgo+IFRoZSAtMSBhc3N1
bWVzIHRoYXQgYWxsIGRldmljZXMgd2l0aCBubyBjdnEgaGF2ZSBhbiBzcGFyZSB2cSBhbGxvY2F0
ZWQKPiBmb3IgdGhlbSwgYnV0IHdpdGggbm8gb2ZmZXIgb2YgVklSVElPX05FVF9GX0NUUkxfVlEu
IFRoaXMgbWF5IG5vdCBiZSB0aGUKPiBjYXNlLCBhbmQgdGhlIGRldmljZSBtYXkgaGF2ZSBhIHBh
aXIgbnVtYmVyIG9mIHF1ZXVlcy4KPgo+IFRvIGZpeCB0aGlzLCBqdXN0IHJlc29ydCB0byB0aGUg
bG93ZXIgZXZlbiBudW1iZXIgb2YgcXVldWVzLgo+Cj4gRml4ZXM6IDA0OWViMTViNWZjOSAoInZo
b3N0OiByZWNvcmQgdGhlIGxhc3QgdmlydHF1ZXVlIGluZGV4IGZvciB0aGUKPiB2aXJ0aW8gZGV2
aWNlIikKPiBTaWduZWQtb2ZmLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNv
bT4KClJldmlld2VkLWJ5OiBKdWFuIFF1aW50ZWxhIDxxdWludGVsYUByZWRoYXQuY29tPgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
