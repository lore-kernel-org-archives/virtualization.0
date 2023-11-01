Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28238C4167D
	for <virtualization@archiver.kernel.org>; Wed,  1 Nov 2023 13:25:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A442E84456;
	Wed,  1 Nov 2023 13:25:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A442E84456
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FyDwE40i
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fmbqn4fGE5vN; Wed,  1 Nov 2023 13:25:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 35626840BA;
	Wed,  1 Nov 2023 13:25:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 35626840BA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A9FAC0072;
	Wed,  1 Nov 2023 13:25:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23BFAC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Nov 2023 13:25:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F081F401D8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Nov 2023 13:25:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F081F401D8
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FyDwE40i
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zc8jwgc-RNPs
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Nov 2023 13:25:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B698E40156
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Nov 2023 13:25:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B698E40156
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698845142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5vuuw2hgFSjYMbIsoJnBkA458K2z+JiLRYE0TFB3z/Q=;
 b=FyDwE40id3B+I1StnmclzA7Zb2ect/dG8dNPflteUutQQpIdLIFbVUgftnPdaGqq6TENQg
 IiCllp/pYdKA9nPmyma9PIVoxVRtKBH+TxjAU27Mo/NypaNBSvLTFkJExIh+gKc+ZYDCmO
 GA8HF4r6oojvWFwWxhQ1jDWxKFxHWro=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-6CiZ2ui7Nmik7SXKc5gAVA-1; Wed, 01 Nov 2023 09:25:40 -0400
X-MC-Unique: 6CiZ2ui7Nmik7SXKc5gAVA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9a62adedadbso475248066b.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 01 Nov 2023 06:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698845139; x=1699449939;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5vuuw2hgFSjYMbIsoJnBkA458K2z+JiLRYE0TFB3z/Q=;
 b=KqCnPr3DWBpE2uon5nhGPnEH+2UtuRiOPjNrwd2T+BPfAs9JCSZdMg4oWccIPsgo1j
 ZKVxjgUQjGM2JN1Aq07Xs7cY1ORIdw3u64zeYy+ObGGsUy7wRjoqYMRhpM5KeCA8kkSV
 EMwFSKyBusDK0TZayas16nVyZE5DBw7/SBT4hAUW5UyQBme3v1okFFSHxmL4xzrY4lrD
 k/7JMvyecQVEwZ+SDcZkp9JhT1WNM6+nHPU2tCT4Wd7lGPzRJsVcQZvN4nkijkPvkEgL
 D3IhX41ii3NsLn8Fk/PZylI+A/VfGiR0ewCQM4ZmqPuUm57NvPQqRGGsKXA41iIcENes
 YVTg==
X-Gm-Message-State: AOJu0YxTNTPUHTvyq8FrpoOE0bMtfwEbWQ8cwcfz3LzpMC7H1O/UV/qV
 ig5kabFRNlAxsHszttUBei84+yARHhwItwhVwD0MRDupyGD96kBhrBJD7BYmY8l2q0qvR5Ebmi/
 1+GiFSSrM8V/YOcN4NE35kS2GrGXuez/cDqpnEpcKiQ==
X-Received: by 2002:a17:907:da1:b0:9d7:139:ca02 with SMTP id
 go33-20020a1709070da100b009d70139ca02mr1593787ejc.18.1698845139549; 
 Wed, 01 Nov 2023 06:25:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGH01EOmDvR1VZ1Vpqwf7/m2EHCZhBOjFFX6rLdJc7iyoXzWszkpEDc8Iv42M1PCJjd0h1kjg==
X-Received: by 2002:a17:907:da1:b0:9d7:139:ca02 with SMTP id
 go33-20020a1709070da100b009d70139ca02mr1593777ejc.18.1698845139229; 
 Wed, 01 Nov 2023 06:25:39 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:e470:9af7:1504:1b35:8a09])
 by smtp.gmail.com with ESMTPSA id
 cl21-20020a170906c4d500b0099bd1a78ef5sm2397533ejb.74.2023.11.01.06.25.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 06:25:38 -0700 (PDT)
Date: Wed, 1 Nov 2023 09:25:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: virtcrypto_dataq_callback calls crypto_finalize_request() from
 irq context
Message-ID: <20231101092521-mutt-send-email-mst@kernel.org>
References: <20230922154546.4f7447ce.pasic@linux.ibm.com>
 <ed47fb73ad634ca395bd6c8e979dda8e@huawei.com>
 <20230924193941.6a02237f.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20230924193941.6a02237f.pasic@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
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

On Sun, Sep 24, 2023 at 07:39:41PM +0200, Halil Pasic wrote:
> On Sun, 24 Sep 2023 11:56:25 +0000
> "Gonglei (Arei)" <arei.gonglei@huawei.com> wrote:
> 
> > Hi Halil,
> > 
> > Commit 4058cf08945 introduced a check for detecting crypto completion function 
> > called with enable BH, and indeed the virtio-crypto driver didn't disable BH, which needs
> > a patch to fix it.
> > 
> > P.S.: https://lore.kernel.org/lkml/20220221120833.2618733-5-clabbe@baylibre.com/T/
> > 
> > Regards,
> > -Gonglei
> 
> Thanks Gonglei!
> 
> Thanks! I would be glad to test that fix on s390x. Are you about to send
> one?
> 
> Regards,
> Halil


Gonglei did you intend to send a fix?

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
