Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6D0C433EF
	for <virtualization@archiver.kernel.org>; Tue, 28 Jun 2022 10:37:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C74AA410BB;
	Tue, 28 Jun 2022 10:37:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C74AA410BB
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ahbtqh5W
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hHncNlKLdMWi; Tue, 28 Jun 2022 10:37:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 06762408CD;
	Tue, 28 Jun 2022 10:37:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 06762408CD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE11DC0039;
	Tue, 28 Jun 2022 10:37:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3C87C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 10:37:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9720A606EB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 10:37:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9720A606EB
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ahbtqh5W
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yJYpxjscsyAK
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 10:37:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 387F6606C6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 387F6606C6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 10:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656412655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JZ412A6etRNSSmCZ+MdpqmCicNkRtP9zW1av9UbdkXw=;
 b=ahbtqh5WkHi0xCkZJBJ+T5OMu0TL+pELgq92BRoHyuAu/g5kqm/TsJ+447iK9XHvm2B1I/
 XZ5odDmZZBKt5Q+kiAN38RuoPsj0UC+VtsUsgDnaz4bfHId/zmHEgUo3nAmXSOns/cNLlS
 ausVTGP0uhR8VEw0jLrl4Xj+FPdAxnM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-156-MGrM9UNIMjeS_bcFCPF0LQ-1; Tue, 28 Jun 2022 06:37:27 -0400
X-MC-Unique: MGrM9UNIMjeS_bcFCPF0LQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 k16-20020a7bc310000000b0038e6cf00439so6945711wmj.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 03:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JZ412A6etRNSSmCZ+MdpqmCicNkRtP9zW1av9UbdkXw=;
 b=v0wlqFDtqxm0hbGk367nVMqKQZ4Vn+fnupt8mybNDlZFf9PeUCGCxcjUEADNL9i0TG
 htAJne1zj6yFsUpAKkCcGvX5NAtQkn93vQKU0Zj6SBxwdg5gix+9iNZv89u+4vYkVq4E
 qbFPjIO076jcnh9PEi0lSbPN/bbFZIA05Ml0XO1L8Q3Z+toNotpEf1WdHd7d+O1TELQk
 qiEZPsmH2uIsqRabEVKVF2nou7QmKj6vMTcAq5lx8Ugn0BSt7FnqwHYhBiYWhAtlqrN5
 HGAUGGMOJHorngOQbb+s/D4hKgEdIas4sfu34o0f8HPpHnuqsD121IGgKPKrAqQJvLFI
 dFyw==
X-Gm-Message-State: AJIora8fU2lWmYTzp6JicrDj1T/EIbNhbAYJICxvOBOd9ltFB+qKCNkg
 ioBJh5EWLSOYyTYQ2leto0G80KZs7D54eH2xIeUaXPV4OlD+qHo6hEXdvxuIfHwdrPBPPTlhI6h
 z5xqGrk1pp4FzLY7tuTStMz9T/r8HHH184w8LeuRxvg==
X-Received: by 2002:a5d:5f05:0:b0:21b:8ca0:6d3d with SMTP id
 cl5-20020a5d5f05000000b0021b8ca06d3dmr16999592wrb.382.1656412645826; 
 Tue, 28 Jun 2022 03:37:25 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uXNGFE5xDiJLqCYzHw0b1cPLBkMfKGgL9TiFcXE4v2aSyk0kMGcqQcAG4JMTTFITIUubCZuQ==
X-Received: by 2002:a5d:5f05:0:b0:21b:8ca0:6d3d with SMTP id
 cl5-20020a5d5f05000000b0021b8ca06d3dmr16999571wrb.382.1656412645635; 
 Tue, 28 Jun 2022 03:37:25 -0700 (PDT)
Received: from redhat.com ([2.52.23.204]) by smtp.gmail.com with ESMTPSA id
 v24-20020a5d5918000000b0021b9870049dsm13038675wrd.82.2022.06.28.03.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jun 2022 03:37:25 -0700 (PDT)
Date: Tue, 28 Jun 2022 06:37:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xu Qiang <xuqiang36@huawei.com>
Subject: Re: [PATCH -next] vdpa/mlx5: Use eth_zero_addr() to assign zero
 address
Message-ID: <20220628063703-mutt-send-email-mst@kernel.org>
References: <20220628094418.27973-1-xuqiang36@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20220628094418.27973-1-xuqiang36@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 rui.xiang@huawei.com, elic@nvidia.com
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

On Tue, Jun 28, 2022 at 09:44:18AM +0000, Xu Qiang wrote:
> Using eth_zero_addr() to assign zero address insetad of

typo

> memset().
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Xu Qiang <xuqiang36@huawei.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index e85c1d71f4ed..f738c78ef446 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1457,8 +1457,8 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
>  
>  	*ucast = rule;
>  
> -	memset(dmac_c, 0, ETH_ALEN);
> -	memset(dmac_v, 0, ETH_ALEN);
> +	eth_zero_addr(dmac_c);
> +	eth_zero_addr(dmac_v);
>  	dmac_c[0] = 1;
>  	dmac_v[0] = 1;
>  	rule = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, &dest, 1);
> -- 
> 2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
