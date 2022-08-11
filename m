Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D13C19F2D
	for <virtualization@archiver.kernel.org>; Thu, 11 Aug 2022 08:53:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 86F13827AF;
	Thu, 11 Aug 2022 08:53:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 86F13827AF
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FISvsLL9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MBeJscHwbm07; Thu, 11 Aug 2022 08:53:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0FD968271A;
	Thu, 11 Aug 2022 08:53:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0FD968271A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB0AEC0033;
	Thu, 11 Aug 2022 08:53:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00D09C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:53:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A8C1240332
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:53:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A8C1240332
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FISvsLL9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sMQan_UyYK5y
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:53:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 77AD3402FB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 77AD3402FB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660207995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lJ6dO5FkJbRlPuu7ETIUoBKLHvygzrFjGVpCJhy/afY=;
 b=FISvsLL9AIRklPe3jUWy152LyJMShmT0b+K/kroUwJtsPfCE+jifgbXQnFOLJCL7DyatV7
 080iVo20G2/mylcRLw/7qWVHuzbnDLj8iQIxMnUfAvqL1Rjg8FCWBPk/yG2/ZoDtmjdYZt
 kNFuD/y+OJCBqOvgUQOF9UI9M5K/Vrc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-fQ4WbSRDNUGZVSNwjiBReQ-1; Thu, 11 Aug 2022 04:53:13 -0400
X-MC-Unique: fQ4WbSRDNUGZVSNwjiBReQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 y14-20020a056402440e00b0044301c7ccd9so512683eda.19
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 01:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=lJ6dO5FkJbRlPuu7ETIUoBKLHvygzrFjGVpCJhy/afY=;
 b=4UdzmNA46H2JuZ+wH3HMsUnypSfQAA+V2KlWXS2Ggd5I991mZIo6y+Bf5jLqRnbzl2
 EEp17rNsxbCw4rPJjftgOxirRHprfdJzHHR5Ls/K2mlU35LWfcfSI7tjjPApYFVxKYB8
 bhazZF5R4inoDBjn578NUyHS20iYCmZ/LZYsrKEzS+zkw7nlXtais0qb6gdj7SUCElFl
 YbLMBFgx6Qli5fh8+wL9R0Hy2Sa2w6G+40cGPJnTQjerwJ3oh+rJfjLz1c9JtAQHAjEF
 G3uuXoWuGATblSsIezVNoKrKfFzFTJ0u9myXlj9QiskKNTbeoZzYJRAjpuzMxIgKpoeo
 t7Eg==
X-Gm-Message-State: ACgBeo0hWL9If87iRCIXEpASKGs8k2Es3pX/7m+WGGmEgT1K3x03eLfw
 omjAAY+d+kID9g3K388rj9QGxS92/5quNNNZJNNiZdzWM6+i49Oqd4yGtTZaezygPRAfFVn+VcZ
 zrhMZfJq3HoUdvmwz3u8Yhj/DKTUEeiDXJzITlxQ+Yw==
X-Received: by 2002:a17:907:3e06:b0:733:693:600e with SMTP id
 hp6-20020a1709073e0600b007330693600emr5126999ejc.410.1660207992767; 
 Thu, 11 Aug 2022 01:53:12 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4/6esuEFdoJ5rOUNg2auAt+loCsh2rGaNBovidkUuVarDYw91Xl8Xc9+Wbs3oYAcm7LRxQiA==
X-Received: by 2002:a17:907:3e06:b0:733:693:600e with SMTP id
 hp6-20020a1709073e0600b007330693600emr5126985ejc.410.1660207992576; 
 Thu, 11 Aug 2022 01:53:12 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 k21-20020aa7c395000000b0043cc66d7accsm8823638edq.36.2022.08.11.01.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Aug 2022 01:53:12 -0700 (PDT)
Date: Thu, 11 Aug 2022 04:53:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Melnychenko <andrew@daynix.com>
Subject: Re: [PATCH v5 3/4] drivers/net/virtio_net: Added RSS hash report.
Message-ID: <20220811045005-mutt-send-email-mst@kernel.org>
References: <20220328175336.10802-1-andrew@daynix.com>
 <20220328175336.10802-4-andrew@daynix.com>
MIME-Version: 1.0
In-Reply-To: <20220328175336.10802-4-andrew@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, yuri.benditovich@daynix.com,
 yan@daynix.com, kuba@kernel.org, davem@davemloft.net
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

On Mon, Mar 28, 2022 at 08:53:35PM +0300, Andrew Melnychenko wrote:
> +static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
> +				struct sk_buff *skb)
> +{
> +	enum pkt_hash_types rss_hash_type;
> +
> +	if (!hdr_hash || !skb)
> +		return;
> +
> +	switch ((int)hdr_hash->hash_report) {
> +	case VIRTIO_NET_HASH_REPORT_TCPv4:
> +	case VIRTIO_NET_HASH_REPORT_UDPv4:
> +	case VIRTIO_NET_HASH_REPORT_TCPv6:
> +	case VIRTIO_NET_HASH_REPORT_UDPv6:
> +	case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
> +	case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
> +		rss_hash_type = PKT_HASH_TYPE_L4;
> +		break;
> +	case VIRTIO_NET_HASH_REPORT_IPv4:
> +	case VIRTIO_NET_HASH_REPORT_IPv6:
> +	case VIRTIO_NET_HASH_REPORT_IPv6_EX:
> +		rss_hash_type = PKT_HASH_TYPE_L3;
> +		break;
> +	case VIRTIO_NET_HASH_REPORT_NONE:
> +	default:
> +		rss_hash_type = PKT_HASH_TYPE_NONE;
> +	}
> +	skb_set_hash(skb, (unsigned int)hdr_hash->hash_value, rss_hash_type);
> +}
> +
>  static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>  			void *buf, unsigned int len, void **ctx,
>  			unsigned int *xdp_xmit,

I just noticed this- endian-ness broken here, you need _le16_to_cpu for
hash_report and __le_32_to_cpu for hash_value.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
