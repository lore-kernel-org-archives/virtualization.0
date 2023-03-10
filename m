Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C45CC64EC4
	for <virtualization@archiver.kernel.org>; Fri, 10 Mar 2023 08:51:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E22124183B;
	Fri, 10 Mar 2023 08:51:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E22124183B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YHbsebyK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nRR6gmYwnTXh; Fri, 10 Mar 2023 08:51:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 36EEA41835;
	Fri, 10 Mar 2023 08:51:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 36EEA41835
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A19EC0071;
	Fri, 10 Mar 2023 08:51:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A610C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 08:51:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CB36560B95
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 08:51:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CB36560B95
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YHbsebyK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yWyk5rgZtCey
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 08:51:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0ABA060B3D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0ABA060B3D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 08:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678438267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XCB3NLRMqFtG3fMsofAO3zKYURlj2MLuhu7W0R6/NpQ=;
 b=YHbsebyKyUB13yQay25KzGrTRG2rNuz2xzMPxtD9Iemklay2ahVcM6PdV+dQhsqb3Bh/pD
 TZVcs917918jm/pUXB72rpQZ57HR0Cj5sn2ceqYpkjgkxuE0mmSkoeikQY2ZuuODxQQ9kf
 b2ZLr0RYDJDzju1NoYL50rQQgYK2WZA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-ucU1OQM2NvinG4QnzlZiTg-1; Fri, 10 Mar 2023 03:51:06 -0500
X-MC-Unique: ucU1OQM2NvinG4QnzlZiTg-1
Received: by mail-wr1-f72.google.com with SMTP id
 m7-20020a056000008700b002c7047ea429so906460wrx.21
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 00:51:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678438265;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XCB3NLRMqFtG3fMsofAO3zKYURlj2MLuhu7W0R6/NpQ=;
 b=pJ863zNCP/GG19OZ8m9eQhO8F3Kc6xb7dGb61Dt2hsIPxy8+ffosMwonhOWeDegQgn
 xpxKkF8p/IqtddKDtitrb3hWc2t8/ZhcUAzjydEslLXjL19f5DfXpJ7BTVcLHUwTf4lS
 3OP2CBla8L/1Gt4adyYaNhvIgStIiT8g5cr2RHGUjp9U11cuMeZ2OHS8J++Usk1A7+4I
 VymyTZ+tNkmEvwXxql3ZT0vsenGXX5wfq89EXa9f7mfDthEyQseu6mvq/m/J/SzecWAK
 kv36PRUkJET2gXH69cQFYutPsBTF4vY6pehQjpBTUgNHF98Wdl1egTacQqdkc7SSEm3Z
 JmsQ==
X-Gm-Message-State: AO0yUKWAjG/TBa/OFooqh5TDl8wwbORxJHvfesxhevnNgDKDrab06nCJ
 0Hs2iIL2ND/UoRschyG1zyLbJ4uPcsfitt9WQRyFPezw0PrEctPChsmSlugBDIm+N+QI5mu6Fwi
 m9sq4V0VV5L3JP0hbVUMeamalRpXJXqj/HVlBxIyycw==
X-Received: by 2002:a05:600c:3491:b0:3eb:2e19:ff3a with SMTP id
 a17-20020a05600c349100b003eb2e19ff3amr1925859wmq.7.1678438265304; 
 Fri, 10 Mar 2023 00:51:05 -0800 (PST)
X-Google-Smtp-Source: AK7set+YCSlbveYwJJSJ8QQkuxSPnYyAuHAXqgAyeZXp5ze1IHRI4pjohjPqmISg5ZfMnz/zcZvJdw==
X-Received: by 2002:a05:600c:3491:b0:3eb:2e19:ff3a with SMTP id
 a17-20020a05600c349100b003eb2e19ff3amr1925847wmq.7.1678438265038; 
 Fri, 10 Mar 2023 00:51:05 -0800 (PST)
Received: from redhat.com ([2.52.9.88]) by smtp.gmail.com with ESMTPSA id
 18-20020a05600c229200b003dc4a47605fsm2344351wmf.8.2023.03.10.00.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Mar 2023 00:51:04 -0800 (PST)
Date: Fri, 10 Mar 2023 03:51:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH v3 01/11] lib/group_cpus: Export group_cpus_evenly()
Message-ID: <20230310035013-mutt-send-email-mst@kernel.org>
References: <20230228094110.37-1-xieyongji@bytedance.com>
 <20230228094110.37-2-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230228094110.37-2-xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 tglx@linutronix.de, hch@lst.de
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

On Tue, Feb 28, 2023 at 05:41:00PM +0800, Xie Yongji wrote:
> Export group_cpus_evenly() so that some modules
> can make use of it to group CPUs evenly according
> to NUMA and CPU locality.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

Thomas can I get an ack from you pls?
Anyone else?

> ---
>  lib/group_cpus.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> index 9c837a35fef7..aa3f6815bb12 100644
> --- a/lib/group_cpus.c
> +++ b/lib/group_cpus.c
> @@ -426,3 +426,4 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
>  	return masks;
>  }
>  #endif /* CONFIG_SMP */
> +EXPORT_SYMBOL_GPL(group_cpus_evenly);
> -- 
> 2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
