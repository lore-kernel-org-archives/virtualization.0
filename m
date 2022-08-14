Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249BAC25B06
	for <virtualization@archiver.kernel.org>; Sun, 14 Aug 2022 09:00:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7E94360BAA;
	Sun, 14 Aug 2022 09:00:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7E94360BAA
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZkSOk5DR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cr1KbeuGdsbd; Sun, 14 Aug 2022 09:00:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9124760BAE;
	Sun, 14 Aug 2022 09:00:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9124760BAE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 196AAC0032;
	Sun, 14 Aug 2022 09:00:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C046CC002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 Aug 2022 09:00:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 93989400D8
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 Aug 2022 09:00:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 93989400D8
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZkSOk5DR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0S8poAmY2VKY
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 Aug 2022 09:00:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9543F400F8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9543F400F8
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 Aug 2022 09:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660467599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fgWKHQAsxfiE02svIG1GlyOPzEiU/s53wr+EvIkuC5s=;
 b=ZkSOk5DRzUbQKlfl9Y/Tx92q843qTyoVGXop3R5dc5i0lTm64pv/AuuAD3rVkTQGVEHMk3
 GgvHntTAqCHc3rNqFXjtu3qAJuovHprdnUkLgmzQwEJQ3eNrEhK1UYFRFGBexEmYWCJBqC
 dF3IAUN5Mu4n51ot6JGmbZDXys5g71Q=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-622-G5lmpHIRN9WEzQYvhsiTEQ-1; Sun, 14 Aug 2022 04:59:58 -0400
X-MC-Unique: G5lmpHIRN9WEzQYvhsiTEQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 s21-20020a056402521500b00440e91f30easo3079193edd.7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 Aug 2022 01:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=fgWKHQAsxfiE02svIG1GlyOPzEiU/s53wr+EvIkuC5s=;
 b=DqJJhfBA5HI1L4HXcU2YhO020+NCy983xZzsMdLnlIybzMXn8NuwI0JxDqaXosEiny
 rM3Lt/BoUjYgBcAhr3ieaXHmC7vFwPstYdnaK2h2pcZQ9g4nrYW/wkqcj4b4W2Tpf0Bj
 HICZTzDEeIxnNhmJo6PgE6DMN1XG5L/CNsUP/TeW5A0X8cASoyOilVDoERvCpQLD8pCg
 LiKUndXIZdPnAAHWX6bC9dQBuvZzogNaEQI07lKeRrKl6XxandLojcuGXiZKcFopcxVQ
 s/oK47ZwBYIFhncp7Q9Kh2xjgvH2558n6GV7r83k/3E5gkik78SFinSsCCWNkivMOmIn
 QjTA==
X-Gm-Message-State: ACgBeo2npN+5GeRAV5U2qdc58MWWdnT1A54B+CWoXt1pPgqpA4neFBjn
 aV94c+Q4sIDfUXyvq3uyWVQHpdoce1Mcj0tEz7ZTBucPaqeExlHMW5AkHOsGSs47w2TjAp76Yry
 TVv9Pq508Er9IbV9tqTUzTXQMrw4X8/rrj0csSzz7TA==
X-Received: by 2002:a17:907:8692:b0:730:b0d3:5311 with SMTP id
 qa18-20020a170907869200b00730b0d35311mr7626856ejc.674.1660467597657; 
 Sun, 14 Aug 2022 01:59:57 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4Jadz5kR2nLnc2rixgHWUCJWsMJ+KvMQFIq/16RUbwY2CdGtnCFdI14mOJpckbCgySblIwmg==
X-Received: by 2002:a17:907:8692:b0:730:b0d3:5311 with SMTP id
 qa18-20020a170907869200b00730b0d35311mr7626840ejc.674.1660467597281; 
 Sun, 14 Aug 2022 01:59:57 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 hr16-20020a1709073f9000b007317ad372c0sm2717544ejc.20.2022.08.14.01.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Aug 2022 01:59:56 -0700 (PDT)
Date: Sun, 14 Aug 2022 04:59:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andres Freund <andres@anarazel.de>
Subject: Re: [GIT PULL] virtio: fatures, fixes
Message-ID: <20220814045853-mutt-send-email-mst@kernel.org>
References: <20220812114250-mutt-send-email-mst@kernel.org>
 <20220814004522.33ecrwkmol3uz7aq@awork3.anarazel.de>
 <1660441835.6907768-1-xuanzhuo@linux.alibaba.com>
 <20220814035239.m7rtepyum5xvtu2c@awork3.anarazel.de>
 <20220814043906.xkmhmnp23bqjzz4s@awork3.anarazel.de>
MIME-Version: 1.0
In-Reply-To: <20220814043906.xkmhmnp23bqjzz4s@awork3.anarazel.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: peng.fan@nxp.com, kvm@vger.kernel.org, alvaro.karsz@solid-run.com,
 virtualization@lists.linux-foundation.org, quic_mingxue@quicinc.com,
 syoshida@redhat.com, elic@nvidia.com, eperezma@redhat.com,
 jiaming@nfschina.com, hulkci@huawei.com, liubo03@inspur.com,
 dan.carpenter@oracle.com, kangjie.xu@linux.alibaba.com, robin.murphy@arm.com,
 hdegoede@redhat.com, pankaj.gupta@amd.com, gautam.dawar@xilinx.com,
 suwan.kim027@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 xuqiang36@huawei.com, xieyongji@bytedance.com, colin.i.king@gmail.com,
 lingshan.zhu@intel.com, colin.king@intel.com,
 Linus Torvalds <torvalds@linux-foundation.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sat, Aug 13, 2022 at 09:39:06PM -0700, Andres Freund wrote:
> Hi,
> 
> On 2022-08-13 20:52:39 -0700, Andres Freund wrote:
> > Is there specific information you'd like from the VM? I just recreated the
> > problem and can extract.
> 
> Actually, after reproducing I seem to now hit a likely different issue. I
> guess I should have checked exactly the revision I had a problem with earlier,
> rather than doing a git pull (up to aea23e7c464b)

Looks like there's a generic memory corruption so it crashes
in random places. Would bisect be possible for you?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
