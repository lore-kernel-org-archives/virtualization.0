Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B299C7EE22
	for <virtualization@archiver.kernel.org>; Tue,  9 May 2023 20:51:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 838BF4294C;
	Tue,  9 May 2023 20:51:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 838BF4294C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SAeTk2Th
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PZ53cB0_rq4N; Tue,  9 May 2023 20:51:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C1DBB42940;
	Tue,  9 May 2023 20:51:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C1DBB42940
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88082C0037;
	Tue,  9 May 2023 20:51:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC50BC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 May 2023 20:51:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BFBBC8470B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 May 2023 20:51:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BFBBC8470B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SAeTk2Th
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Uk0ki0GDdWRZ
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 May 2023 20:51:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 88C7E846FB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 88C7E846FB
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 May 2023 20:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683665466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PNiIZHyonT4Lc3v22Wd8EHVvgd0ES2GAsHIl3w6taTA=;
 b=SAeTk2ThdripM3HdxcC30tK7PwUcp+Rw8rfp994YqkwTknrFGGy55qc+B6CDulQxBBraq7
 JMCAcMLt50Dw+KYBqcYFv3bYl8ae5KxJOs1LHFBhLuzJjfz4Wf9VacYVYam/jt4kJNdEw2
 vVmWTvO2TrtQLmxXsFuILzflnu9kbBw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-lGohVS29Mnu8qwt7SQTv8Q-1; Tue, 09 May 2023 16:51:04 -0400
X-MC-Unique: lGohVS29Mnu8qwt7SQTv8Q-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9662fbb79b3so367188166b.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 May 2023 13:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683665463; x=1686257463;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PNiIZHyonT4Lc3v22Wd8EHVvgd0ES2GAsHIl3w6taTA=;
 b=bEw78FnfYswFgAYuU2xxMJG6Ji6qEhVvsG/r7uWOpilSI9sd2Z+iKlxFeL+QlD3V8H
 4VTM2Cu9iFidW7J1eDUCfjsHGS7qcpAfd/2+SD0o6mK0Rt6y9cR1ALAY4QVDCY11TpKb
 gERywcg4kLsPXeIH+Vkjh+MJnWbkMVy3r0rd0RAV4VQDkzFQQz8HH34Lc9J2WDu15piU
 irTzbpmhkFPM6yzg9bYszjHrXIhRQXwt25fLvyXF22VW3V1NUM8WBk4WuziDlLw8hQma
 ziRzRHLUilJSaYbTlPKY0V4KwHYLRCP3C2iBs3/rNlwVxX44xF26/fOlkUP5pZDjyBav
 gW+A==
X-Gm-Message-State: AC+VfDxV1CLGU2PqhYi3QHq9qxx5YrlNXI3RQOasDcFbUBjkaZdtqG+0
 c6XGJ8knrIsB2AuaBUFc+ZjyVV6brQC1OfcjVhqSdI+UdJts0lJJT8Ic/7+diTG/P/8pEUhLANJ
 ZN0uS8KgtynNdz1EWy0qIdO3dZXT7XVZ3/g1ycG9cZQ==
X-Received: by 2002:a17:906:4fd1:b0:94f:21f3:b5f8 with SMTP id
 i17-20020a1709064fd100b0094f21f3b5f8mr12867378ejw.21.1683665463524; 
 Tue, 09 May 2023 13:51:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ64Z2n6Cyo1Ac1tIrysTfZgGptf8iyw8BdvNxTLiJKqxc+sT/Z3BRYol16b0K6FWwTa13f0sg==
X-Received: by 2002:a17:906:4fd1:b0:94f:21f3:b5f8 with SMTP id
 i17-20020a1709064fd100b0094f21f3b5f8mr12867347ejw.21.1683665463199; 
 Tue, 09 May 2023 13:51:03 -0700 (PDT)
Received: from redhat.com ([82.180.150.238]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170906584900b0094e597f0e4dsm1735890ejs.121.2023.05.09.13.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 May 2023 13:51:02 -0700 (PDT)
Date: Tue, 9 May 2023 16:50:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuanchu Xie <yuanchu@google.com>
Subject: Re: [RFC PATCH 2/2] virtio-balloon: Add Working Set reporting
Message-ID: <20230509164528-mutt-send-email-mst@kernel.org>
References: <20230509185419.1088297-1-yuanchu@google.com>
 <20230509185419.1088297-3-yuanchu@google.com>
MIME-Version: 1.0
In-Reply-To: <20230509185419.1088297-3-yuanchu@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Michal Hocko <mhocko@kernel.org>,
 Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org, kai.huang@intel.com,
 hch@lst.de, Yu Zhao <yuzhao@google.com>,
 Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 talumbau <talumbau@google.com>,
 "Sudarshan Rajagopalan \(QUIC\)" <quic_sudaraja@quicinc.com>,
 Shakeel Butt <shakeelb@google.com>, cgroups@vger.kernel.org,
 virtualization@lists.linux-foundation.org, jon@nutanix.com,
 SeongJae Park <sj@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Muchun Song <muchun.song@linux.dev>, linux-kernel@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vasily Averin <vasily.averin@linux.dev>
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

On Wed, May 10, 2023 at 02:54:19AM +0800, Yuanchu Xie wrote:
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> index ddaa45e723c4..06d0683d8d8c 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h

Any changes to this have to be documented in the virtio spec
and be sent to virtio TC.

> @@ -37,6 +37,7 @@
>  #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
>  #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
>  #define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
> +#define VIRTIO_BALLOON_F_WS_REPORTING 6 /* Working Set Size reporting */
>  
>  /* Size of a PFN in the balloon interface. */
>  #define VIRTIO_BALLOON_PFN_SHIFT 12
> @@ -59,6 +60,8 @@ struct virtio_balloon_config {
>  	};
>  	/* Stores PAGE_POISON if page poisoning is in use */
>  	__le32 poison_val;
> +	/* Number of bins for Working Set report if in use. */
> +	__le32 ws_num_bins;

working_set_ pls. eschew abbreviation.
Really __le32? Is 4G bins reasonable? what if it's 0?

>  };
>  
>  #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
> @@ -116,4 +119,22 @@ struct virtio_balloon_stat {
>  	__virtio64 val;
>  } __attribute__((packed));
>  
> +enum virtio_balloon_ws_op {
> +	VIRTIO_BALLOON_WS_REQUEST = 1,
> +	VIRTIO_BALLOON_WS_CONFIG = 2,
> +};


what's this?

> +
> +struct virtio_balloon_ws {

document fields.

> +#define VIRTIO_BALLOON_WS_RECLAIMABLE 0
> +#define VIRTIO_BALLOON_WS_DISCARDABLE 1

what are these?

> +	/* TODO: Provide additional detail on memory, e.g. reclaimable. */

Well? If we don't now hypervisors will come to depend on
this being broken.

> +	__virtio16 tag;
> +	/* TODO: Support per-NUMA node reports. */

Same. This is ABI we can't merge with unaddressed TODO items.

> +	__virtio16 node_id;
> +	uint8_t reserved[4];
> +	__virtio64 idle_age_ms;
> +	/* Track separately for ANON_AND_FILE. */

What does this mean?

> +	__virtio64 memory_size_bytes[2];




> +};
> +
>  #endif /* _LINUX_VIRTIO_BALLOON_H */

Use LE for new features please.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
