Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F35C6FD1F
	for <virtualization@archiver.kernel.org>; Wed, 22 Mar 2023 03:32:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2BEE782217;
	Wed, 22 Mar 2023 03:32:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2BEE782217
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fe0OtSP+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8ik7c2mRJ6VD; Wed, 22 Mar 2023 03:32:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A9A2B8207B;
	Wed, 22 Mar 2023 03:32:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A9A2B8207B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68DB1C0071;
	Wed, 22 Mar 2023 03:32:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82503C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 03:32:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 565A182178
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 03:32:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 565A182178
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GMQFm3nqfjj9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 03:32:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4F83B8207B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4F83B8207B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 03:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679455959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+5ozyksmBgQ5o9j+m73jd3TzZUhnMnKkTv9SFtMBtSc=;
 b=fe0OtSP+FrZ85jowAjDFHGr8BmdbMU0MTy3FMaIH/NXvRpnPBvIIxLYWEWAAJAwa6tXe0v
 xN6EHTGGfNIy/tpj64yyuP48xlybf+2OP1DWDWlrpDsN0cT4E3TN5JISj6x/O6MBZFG8yN
 qHQOegH8hxn6PW6+c6yE69qOxd4ROns=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-biIr5D9aM0KGcqkeZCoSoQ-1; Tue, 21 Mar 2023 23:32:38 -0400
X-MC-Unique: biIr5D9aM0KGcqkeZCoSoQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 ay12-20020a05600c1e0c00b003ed201dcf71so8050262wmb.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 20:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679455956;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+5ozyksmBgQ5o9j+m73jd3TzZUhnMnKkTv9SFtMBtSc=;
 b=pEIcDL40KVImWS6rzCYdhS+0EMoesDi4h5IwF+ebQn4hPb0trIYilZBwn0FZnWd9w6
 GfSOo8Nz8K0IMddaNTkS1WwPKqchAJ/1CaveeWdcqerkXa8SBsYWloFVWhUxR2khrVvq
 NgLJSTvJ1YtntMspbIVMRbkpTf8VLNMOI51zoLWAT2JVOLkncoWyu/tZfyIU5mmhb4Bn
 dTACtoKrkyJWHtJ5ortx7YbIFhGiPKi4UdDLdADk+01UQbxHH1WwXurofWwDGu8plSYE
 +32ajKSm51cmSWmc6xm5cmachb7/dRUO4FZ+dS21MhSiSw7bC6KwJdfQn3YgQCtboDtA
 Yq7A==
X-Gm-Message-State: AO0yUKX/XPSai+Blbpc4gjJOXz4cl/0Va1uMIvva0hWfZ8x9WSegBl7K
 f7XCBhUAwAXW9Vqbx1F7bVoWOaY3jqg5XkbyfIRWmZGmfunjAgUq4YWeceIzu++L3doLjJqCEYs
 HxJ56BRaY89sbjcrabM0DT+oLD+WNtb5q+m5MoDfQmQ==
X-Received: by 2002:a1c:cc1a:0:b0:3ee:18e:a1ef with SMTP id
 h26-20020a1ccc1a000000b003ee018ea1efmr3864286wmb.1.1679455956524; 
 Tue, 21 Mar 2023 20:32:36 -0700 (PDT)
X-Google-Smtp-Source: AK7set+AEBHGc97UmkB75LQFIVb5++WH6WZGSxtJOSJqQtQgzaAiQAQFTLtvRmQvm7FJyMx4yf4IHw==
X-Received: by 2002:a1c:cc1a:0:b0:3ee:18e:a1ef with SMTP id
 h26-20020a1ccc1a000000b003ee018ea1efmr3864279wmb.1.1679455956251; 
 Tue, 21 Mar 2023 20:32:36 -0700 (PDT)
Received: from redhat.com ([2.52.1.105]) by smtp.gmail.com with ESMTPSA id
 d8-20020a1c7308000000b003ed1f6878a5sm15458136wmb.5.2023.03.21.20.32.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Mar 2023 20:32:35 -0700 (PDT)
Date: Tue, 21 Mar 2023 23:32:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH v4 1/2] vdpa/mlx5: Make VIRTIO_NET_F_MRG_RXBUF off by
 default
Message-ID: <20230321232937-mutt-send-email-mst@kernel.org>
References: <20230321112809.221432-1-elic@nvidia.com>
 <20230321112809.221432-2-elic@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230321112809.221432-2-elic@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: eperezma@redhat.com, parav@mellanox.com,
 virtualization@lists.linux-foundation.org
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

On Tue, Mar 21, 2023 at 01:28:08PM +0200, Eli Cohen wrote:
> Following patch adds driver support for VIRTIO_NET_F_MRG_RXBUF.
> 
> Current firmware versions show degradation in packet rate when using
> MRG_RXBUF. Users who favor memory saving over packet rate could enable
> this feature but we want to keep it off by default.
> 
> One can still enable it when creating the vdpa device using vdpa tool by
> providing features that include it.
> 
> For example:
> $ vdpa dev add name vdpa0 mgmtdev pci/0000:86:00.2 device_features 0x300cb982b
> 
> 
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Eli Cohen <elic@nvidia.com>


I have a question. Could you guys try with the recent XDP mergeable
buffer rework? Does this address the performance issue you are
observing?

Specifically:

Message-Id: <20230322025701.2955-1-xuanzhuo@linux.alibaba.com>
Message-Id: <20230322030308.16046-1-xuanzhuo@linux.alibaba.com>

I would very much appreciate if you posted perf numbers
in response to that thread - both to help evaluate that
patchset and this one.
Thanks!

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 520646ae7fa0..502c482a93ce 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3122,6 +3122,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>  			return -EINVAL;
>  		}
>  		device_features &= add_config->device_features;
> +	} else {
> +		device_features &= ~BIT_ULL(VIRTIO_NET_F_MRG_RXBUF);
>  	}
>  	if (!(device_features & BIT_ULL(VIRTIO_F_VERSION_1) &&
>  	      device_features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM))) {
> -- 
> 2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
