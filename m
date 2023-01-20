Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA17AC05027
	for <virtualization@archiver.kernel.org>; Fri, 20 Jan 2023 13:10:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 77FE960F65;
	Fri, 20 Jan 2023 13:10:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 77FE960F65
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O2eHgFmR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ddQ3FClYUbrl; Fri, 20 Jan 2023 13:10:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1592A605B0;
	Fri, 20 Jan 2023 13:10:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1592A605B0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CCF83C0033;
	Fri, 20 Jan 2023 13:10:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A51ABC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 13:10:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6AAED4190A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 13:10:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6AAED4190A
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=O2eHgFmR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N21-E7iVAuVC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 13:10:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 75A5B4170A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 75A5B4170A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 13:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674220199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+C39jO85JsD3Q9eXxeCD+myyrJco13dFNHGsDI90u+4=;
 b=O2eHgFmRXeRaXOqUh1Qo3AZ3MsGrrH+MuvMwYH1UflahGglKrmvo2SccRky9O3BJenKoNJ
 X6StislLFNlujuMCKEWu+QhtJOPHpqG5WDwFqG0Z64eiaeP35Kfg4RtbLkD3iaGDCL4Yms
 WI/Ay+NWE5qkdRyMwEBf1jPkpMp8teU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-584-IzNgGu-DPnKNifKRWUlEtw-1; Fri, 20 Jan 2023 08:09:57 -0500
X-MC-Unique: IzNgGu-DPnKNifKRWUlEtw-1
Received: by mail-wm1-f69.google.com with SMTP id
 k20-20020a05600c1c9400b003db2e916b3aso1376424wms.6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 05:09:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+C39jO85JsD3Q9eXxeCD+myyrJco13dFNHGsDI90u+4=;
 b=WOrFACEOp3KrbWqleCqHFypj9URfS3ziX6Z1QI3fSF+88nKbkFoRBY8mdgPhSMWIa3
 cBAJ24oJH0HUDWVVlM1HQrRE1H1RRCSEVl71QCF3JtmqjbFZbC6xHHBBiymKL/R5PCtB
 XD4+UNdoNOpsWeuvCjpT8YQyDmSdIaEFYaRgD1msGMVclGy0QLprumkwvmJwmsEImn/l
 mOl0H67uEut8qmGn8JF1WwdZHvCPOAYyRoFR8QbdJYXD0YUlSElOHez2+PvB8niwLOD8
 /w2EVQ9bIEI+XX2NRW3NXVTPw3YjiEarZcPwOVx57NwXl1X9t3Fpv7aBCr21FjicsSF5
 yFrw==
X-Gm-Message-State: AFqh2ko6DnCY3rQbC2TAGxxF6K5+/FvMp5LIXAd5Uafm44qJ62lwWTw3
 gj0eNBcA5a8/WC1DuXquM3iL+R4iSzHu3ShohmYIBSJAnc/zYuE7WQwKq1jqwkfW9MfGe69K1Fj
 S71/1lgegEXe2C02EeCFE52/5ILIDaKCag6RYFHGuqA==
X-Received: by 2002:a5d:46c2:0:b0:2bf:9465:64a with SMTP id
 g2-20020a5d46c2000000b002bf9465064amr959953wrs.27.1674220196774; 
 Fri, 20 Jan 2023 05:09:56 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtB86EpI+Uk/QmIK169Ggv7pp6dT7DRIV8GGfKECy1ikbm5Z1YG5tWlTiPKL1/KOpaEV9azJw==
X-Received: by 2002:a5d:46c2:0:b0:2bf:9465:64a with SMTP id
 g2-20020a5d46c2000000b002bf9465064amr959939wrs.27.1674220196548; 
 Fri, 20 Jan 2023 05:09:56 -0800 (PST)
Received: from redhat.com ([2.52.19.29]) by smtp.gmail.com with ESMTPSA id
 m5-20020a056000024500b00267bcb1bbe5sm36968806wrz.56.2023.01.20.05.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jan 2023 05:09:55 -0800 (PST)
Date: Fri, 20 Jan 2023 08:09:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH v1 5/6] virtio_net: Guard against buffer length overflow
 in xdp_linearize_page()
Message-ID: <20230120080256-mutt-send-email-mst@kernel.org>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-6-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20230119135721.83345-6-alexander.shishkin@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Paolo Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 elena.reshetova@intel.com, Jakub Kicinski <kuba@kernel.org>,
 virtualization@lists.linux-foundation.org,
 "David S . Miller" <davem@davemloft.net>, kirill.shutemov@linux.intel.com
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

On Thu, Jan 19, 2023 at 03:57:20PM +0200, Alexander Shishkin wrote:
> When reassembling incoming buffers to an xdp_page, there is a potential
> integer overflow in the buffer size test and trigger and out of bounds
> memcpy().
> 
> Fix this by reordering the test so that both sides are of the same
> signedness.
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> ---
>  drivers/net/virtio_net.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7723b2a49d8e..dfa51dd95f63 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -751,8 +751,10 @@ static struct page *xdp_linearize_page(struct receive_queue *rq,
>  
>  		/* guard against a misconfigured or uncooperative backend that
>  		 * is sending packet larger than the MTU.
> +		 * At the same time, make sure that an especially uncooperative
> +		 * backend can't overflow the test by supplying a large buflen.
>  		 */
> -		if ((page_off + buflen + tailroom) > PAGE_SIZE) {
> +		if (buflen > PAGE_SIZE - page_off - tailroom) {
>  			put_page(p);
>  			goto err_buf;
>  		}

I feel the issue should be addressed in virtqueue_get_buf.
In fact, when using DMA API, we already keep track of the
length in vring_desc_extra.

So, isn't this just the question of passing the length and
validating it e.g. in vring_unmap_one_split?
We can also use the index_nospec trick since otherwise
there could be speculation concerns.

> -- 
> 2.39.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
