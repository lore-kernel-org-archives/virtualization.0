Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8685C433F5
	for <virtualization@archiver.kernel.org>; Tue, 17 May 2022 03:13:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 503B34086A;
	Tue, 17 May 2022 03:13:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v4RpGXJvX4ML; Tue, 17 May 2022 03:13:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A72A640869;
	Tue, 17 May 2022 03:13:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54709C0039;
	Tue, 17 May 2022 03:13:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A22DC0039
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 03:13:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 81CF240B95
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 03:13:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hOvxjbwoenuJ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 03:13:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C3E3C40408
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 03:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652757231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HfJbYuY7R4HP5peL+HAi0KstksgeafurlGyGto4ht1g=;
 b=NVNRUzxCmD+bGy3n2NB8EHdYKTKu5+chU8j1PMjTJGwb5RA+gf7Swo+sYITJKa8KmChg6q
 K9DGJR6vj0cjeHVV8bZu/0g9RSJk2/pcpmf+lH3Zyj9BEcdkzPxUsGQQvzbx37MDcmbH2o
 Tz/Xg2Nv5W22xRmATQ3TXceCfiQEJ/w=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-PABhFghlNG-Azpx6L_DvuA-1; Mon, 16 May 2022 23:13:49 -0400
X-MC-Unique: PABhFghlNG-Azpx6L_DvuA-1
Received: by mail-pf1-f199.google.com with SMTP id
 g5-20020a62e305000000b0050d2dba0c5dso7040648pfh.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 20:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=HfJbYuY7R4HP5peL+HAi0KstksgeafurlGyGto4ht1g=;
 b=PzizzTIQNnaSAGZgwVoCEzxJ+a8PsURozzvwU57yRI/EddAnhbJ1hlddMV66S1XNdM
 DTJSr5XGl1NxWaQgufDWe+I2sHuwosDYJ1I4zTAjrqDxeVcNh9buAumm8ykFOS79AWuo
 v4F18QEtOZeZDNjy3jkQwznHDQQvtDGD8E+SCySzvSrgFjPUG+DYjc00L22mklv0EOf6
 sg40IEbqpwORwilMzNvgr3XBgHmvGpkXgIKawVsdL9bHDlxEIIXwayOsLJvOsiSJgcD7
 1W9BFFEx4YuoM7wQLF7wNiizMRmZVlx9kGuEbQCDHAl6pgw47UTeH9wQ4GU3de7D4v64
 zGzw==
X-Gm-Message-State: AOAM530Ksvz/7ndRg37RBszFYduLjZ5wnNtYMqnDHc09aaAQS3ZQ7Z5H
 N/Wy9alGdYlXZUGumQQ5OXp+gJIbqsC+IgqzXig70oBiCWA1uKyT4WzKIGZRf/B7s6m35gWhJkU
 K4A3eKKQbtgFE+uDWN7caqdzOCuiBxKhGWW2d/g4IWA==
X-Received: by 2002:a17:90b:3e8b:b0:1dc:e2ba:b697 with SMTP id
 rj11-20020a17090b3e8b00b001dce2bab697mr33992469pjb.176.1652757228774; 
 Mon, 16 May 2022 20:13:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZ/l5U3Pkf/n/m3imocW2KYAiJVoWecFZuIpFjkN0tfJ1o8gJ7+QSx1kdEfwQQvwK56k2s2g==
X-Received: by 2002:a17:90b:3e8b:b0:1dc:e2ba:b697 with SMTP id
 rj11-20020a17090b3e8b00b001dce2bab697mr33992454pjb.176.1652757228508; 
 Mon, 16 May 2022 20:13:48 -0700 (PDT)
Received: from [10.72.12.227] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 c24-20020a170902c2d800b0015f309f14d0sm7776347pla.56.2022.05.16.20.13.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 May 2022 20:13:47 -0700 (PDT)
Message-ID: <2401fa32-bcbe-614a-9305-9b91e97f7d7f@redhat.com>
Date: Tue, 17 May 2022 11:13:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH V2 0/8] vhost flush cleanups
To: Mike Christie <michael.christie@oracle.com>, stefanha@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org, arbn@yandex-team.com
References: <20220515202922.174066-1-michael.christie@oracle.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220515202922.174066-1-michael.christie@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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

CuWcqCAyMDIyLzUvMTYgMDQ6MjksIE1pa2UgQ2hyaXN0aWUg5YaZ6YGTOgo+IFRoZSBmb2xsb3dp
bmcgcGF0Y2hlcyBhcmUgQW5kcmV5IFJ5YWJpbmluJ3MgZmx1c2ggY2xlYW51cHMgYW5kIHNvbWUK
PiBmcm9tIG1lLiBUaGV5IHJlZHVjZSB0aGUgbnVtYmVyIG9mIGZsdXNoIGNhbGxzIGFuZCByZW1v
dmUgc29tZSBib2d1cwo+IG9uZXMgd2hlcmUgd2UgZG9uJ3QgZXZlbiBoYXZlIGEgd29ya2VyIHJ1
bm5pbmcgYW55bW9yZSBvciB0aGV5IHdlcmUKPiBiYXNlZCBvbiBvdXRkYXRlZCBvciBpbmNvcnJl
Y3QgYXNzdW1wdGlvbnMuCj4KPiBKYXNvbiwgZm9yIHRoZSBwYXRjaGVzIHlvdSBnYXZlIG1lIGFu
IGV4cGxpY2l0IGFja2VkL3Jldmlld2VkIHRhZyBJCj4gYWRkZWQgaXQuIEZvciB0aGUgcmVwbGll
cyB3aGVyZSBJIGFuc3dlcmVkIHlvdXIgcmV2aWV3IHF1ZXN0aW9ucyBhbmQKPiB5b3Ugb25seSBy
ZXBsaWVkIHdpdGggYW4gYWZmaXJpbWF0aXZlIHJlcGx5IEkgZGlkIG5vdCBhZGQgYSB0YWcsCj4g
YmVjYXVzZSBJIHdhcyBub3Qgbm90IDEwMCUgc3VyZSB3aGF0IHlvdSB3YW50ZWQgdG8gZG8uCgoK
RmluZSwgSSB3aWxsIGdvIHRocm91Z2ggdGhlIGNvZGVzLgoKVGhhbmtzCgoKPgo+IFRoZXNlIHBh
dGNoZXMgd2lsbCBiZSB1c2VkIGluIHRoZSB2aG9zdCB0aHJlYWRpbmcgcGF0Y2hlcyB3aGljaCBJ
IHRoaW5rCj4gd2lsbCBtYWtlIHByb2dyZXNzIGFnYWluIG5vdyB0aGF0IEkgaGF2ZSBDaHJpc3Rp
YW4ncyBlbWFpbCBmaWd1cmVkIG91dAo+IDopIChoZSBoYWQgbW92ZWQgdG8gbWljcm9zb2Z0IGJ1
dCBJJ3ZlIGJlZW4gdXNpbmcgdGhlIHVidW50dSBhZGRyZXNzKS4KPiBJIHRoaW5rIHRoZSBwYXRj
aGVzIGFyZSBvayBjbGVhbnVwcyBpbiBnZW5lcmFsIHNvIEkgdGhvdWdodCB0aGV5IGNvdWxkCj4g
Z2V0IG1lcmdlZCBzZXBhcmF0ZWx5IGlmIHBlb3BsZSBhZ3JlZS4KPgo+IFYyOgo+IC0gQWRkZWQg
cGF0Y2ggdG8gcmVuYW1lIHZob3N0X3dvcmtfZGV2X2ZsdXNoIHRvIGp1c3Qgdmhvc3RfZGV2X2Zs
dXNoCj4gdG8gaGFuZGxlIHJldmlldyBjb21tZW50IGZyb20gSmFzb24gYWJvdXQgdGhlIG5hbWlu
ZyBub3QgYmVpbmcgc28KPiBncmVhdC4KPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
