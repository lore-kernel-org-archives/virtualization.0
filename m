Return-Path: <SRS0=e+fm=NP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37C2C4338F
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 10:31:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F124608FE
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 10:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4F124608FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 14B6D60723;
	Tue, 24 Aug 2021 10:31:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bWZ55M_VulT9; Tue, 24 Aug 2021 10:31:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9FFFF600B9;
	Tue, 24 Aug 2021 10:31:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82A64C001A;
	Tue, 24 Aug 2021 10:31:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA7D0C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 10:31:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B11E5400BA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 10:31:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vmZsO_x5gT4r
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 10:31:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B9EDA400A8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 10:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629801102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=feIhjhva5jefoIxfoE0azoq+AbsdStJdrlY7GGgP55M=;
 b=Grp/aBGff6h+IQKzcuhP/volgFxSahSJj1muP9IeiGj7oGmiZSE36X3qiwXyuhVBf5EFrf
 W4K4wPx5IzdGKqYnD4G4faGs0xCPCLn6xFHR9eJnAWQOCpTfqzawi1sPNxXhn6wnE4THEu
 CaH+7hgkszL/EP52op9TNBSVnxWPmpY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-i12KxII0Ple0SlEFWX6r4Q-1; Tue, 24 Aug 2021 06:31:41 -0400
X-MC-Unique: i12KxII0Ple0SlEFWX6r4Q-1
Received: by mail-ed1-f72.google.com with SMTP id
 m16-20020a056402511000b003bead176527so1722569edd.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 03:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=feIhjhva5jefoIxfoE0azoq+AbsdStJdrlY7GGgP55M=;
 b=WnItKgsrZdV6xzVef39DUXju56G2EZub+0tjFdEp319Vi7h9GOfkKJzAgcmn8+fUmp
 jZanexgrFlY8WbJUmoyBWGfb+2YGytRBcXFD2mj/gnbmsFQb5CV7Wi1WwXS5FDz2Sbjl
 mFbdI2uCWPkCkx+pxFqL/05VioZv2KVQYod4GeCIOYQTlSdwnjsWCQz+0evgffCU7lHV
 mmNXnU/p36xElKxaYCDOQdLKwGWlLyjr6S+8jVRGqjVrA9arPGc8XwOxa+l+kxQPbZsx
 gi9F433qMdYVc1CseK6nZkBwCIVGY3MZosR8C+SccgsvVH8p/cF+pal3eoT/cQWn2zck
 f5Hg==
X-Gm-Message-State: AOAM533tI5u10zkMJ2HPBDusR49s5pXuJORcyRgPxhUAT8tpdi4zPhJ6
 Eei+pV8bXLeEsfX7VyyUExFfjOYz73k4ACrijJsISyhrPpYz3KVtJXC1iE7MwelAFDz+IQcdGCp
 19eHGy+/LhHDEkAdG1ndClsHYSsTjzvfAAyAsNkgOzg==
X-Received: by 2002:a17:906:d04b:: with SMTP id
 bo11mr40707211ejb.513.1629801100366; 
 Tue, 24 Aug 2021 03:31:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1lClZImhRtvJCoGEAqkfeG/l8kJgXUskqq5Rw2DFLftK9EBSu/dk7LEDZ72T8m++O+df9pA==
X-Received: by 2002:a17:906:d04b:: with SMTP id
 bo11mr40707195ejb.513.1629801100235; 
 Tue, 24 Aug 2021 03:31:40 -0700 (PDT)
Received: from steredhat (host-79-45-8-152.retail.telecomitalia.it.
 [79.45.8.152])
 by smtp.gmail.com with ESMTPSA id c28sm9029348ejc.102.2021.08.24.03.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Aug 2021 03:31:39 -0700 (PDT)
Date: Tue, 24 Aug 2021 12:31:37 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v3 0/6] virtio/vsock: introduce MSG_EOR flag for
 SEQPACKET
Message-ID: <20210824103137.v3fny2yc5ww46p33@steredhat>
References: <20210816085036.4173627-1-arseny.krasnov@kaspersky.com>
 <3f3fc268-10fc-1917-32c2-dc0e7737dc48@kaspersky.com>
 <20210824100523.yn5hgiycz2ysdnvm@steredhat>
 <d28ff03e-c8ab-f7c6-68a2-90c9a400d029@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <d28ff03e-c8ab-f7c6-68a2-90c9a400d029@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "stsp2@yandex.ru" <stsp2@yandex.ru>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "oxffffaa@gmail.com" <oxffffaa@gmail.com>,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Aug 24, 2021 at 01:18:06PM +0300, Arseny Krasnov wrote:
>
>On 24.08.2021 13:05, Stefano Garzarella wrote:
>> Caution: This is an external email. Be cautious while opening links or attachments.
>>
>>
>>
>> Hi Arseny,
>>
>> On Mon, Aug 23, 2021 at 09:41:16PM +0300, Arseny Krasnov wrote:
>>> Hello, please ping :)
>>>
>> Sorry, I was off last week.
>> I left some minor comments in the patches.
>>
>> Let's wait a bit for other comments before next version, also on the
>> spec, then I think you can send the next version without RFC tag.
>> The target should be the net-next tree, since this is a new feature.
>Hello,
>
>E.g. next version will be [net-next] instead of [RFC] for both
>kernel and spec patches?

Nope, net-next tag is useful only for kernel patches (net tree - 
Documentation/networking/netdev-FAQ.rst).

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
