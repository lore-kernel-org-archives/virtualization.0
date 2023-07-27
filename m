Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D2EC001E0
	for <virtualization@archiver.kernel.org>; Thu, 27 Jul 2023 13:28:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 442714077D;
	Thu, 27 Jul 2023 13:28:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 442714077D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P7Z89AXR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AZnpZcwJwsq2; Thu, 27 Jul 2023 13:28:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6316A4033B;
	Thu, 27 Jul 2023 13:28:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6316A4033B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D8FEC0071;
	Thu, 27 Jul 2023 13:28:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B6D9C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 13:28:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E333760E8F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 13:28:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E333760E8F
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=P7Z89AXR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sKeAeeuhdpao
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 13:28:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ED14360E4C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 13:28:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ED14360E4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690464522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m2yLzDlyUcF2RuBnCSo3HYbKe/4NFt4IwHbmPIwMLXk=;
 b=P7Z89AXRgL1/Du4I0HCDXsJgqE+0lBf1HFFhArDNIHphMaych3Tj189laYZ66n7KAQ+jd7
 j9V4C6frQeWJolpHPxmLy1G6mSDVeOht1TCXoJ+vxmOZjml+z2hJwL+sde1o30WUD0kboy
 Az0yYJXLQBWrrMadV6RdES7ExWQoDt4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-W-rraSlEPGiVlitJVhnfXw-1; Thu, 27 Jul 2023 09:28:38 -0400
X-MC-Unique: W-rraSlEPGiVlitJVhnfXw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-767c4cc8d84so21627785a.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 06:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690464517; x=1691069317;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rRXsOUJMOHDEoSqPt6aYSJsJvljvQhH7ysfJpGE7U3I=;
 b=aFo8yivedpvNdPveNTvLETLoZGcHImeGwbWtP6OnSbjzWPfVgttLaiTQtDozfVcmKL
 dxRnuqna8rW8hwaBjI/FdIJVVSQxNcdrRs8C++GqnoTxYQ3dB8+Hd2PhWofwMBmpXqS1
 MWCGCEPdFxAJadCnD3G42vNFp2ofPJsSeSTr+3HSbgBFnv75+JYacGDLcLpU6ttv8rAb
 H3442Hip+BNQ5skZZfADPImHC7kIHgGokFQN6lw1MiKytcYB/kkGhHnQ35n1jJp6+F6j
 LPtmGgTRNumziwundXTsirVynOC6mgXgYy96YJoqfBXq/YcwPIkf+6+FNFEjmBn01fUO
 Pa6A==
X-Gm-Message-State: ABy/qLZO6rZ/UsFkf2VIhZKlKIzSsfAPZxlQCNC7ZHCqpbnBCiYhX4iC
 JGtLMZPsLzq7avaNrXHZp6XQ7G+X7HEVUsyqJq8y+q9SjatmCFPXHwODTbrAln6X2Zr1aRTLkci
 Nfex3nqj5uGOepfzwLrzpE9Xbnqd/UtB7+uFq2gdbQw==
X-Received: by 2002:a05:620a:318f:b0:765:a957:f526 with SMTP id
 bi15-20020a05620a318f00b00765a957f526mr5530688qkb.3.1690464517504; 
 Thu, 27 Jul 2023 06:28:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHSS1sj3ooFLxDH7GaJepQJ5naZSQaFVoxc5DBSu1lp42qGgOiczSwad8h1rf/0DMO/8MK1BQ==
X-Received: by 2002:a05:620a:318f:b0:765:a957:f526 with SMTP id
 bi15-20020a05620a318f00b00765a957f526mr5530665qkb.3.1690464517246; 
 Thu, 27 Jul 2023 06:28:37 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-238-55.dyn.eolo.it.
 [146.241.238.55]) by smtp.gmail.com with ESMTPSA id
 b4-20020a05620a126400b00767dafbf282sm411683qkl.12.2023.07.27.06.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 06:28:36 -0700 (PDT)
Message-ID: <f5823996fffad2f3c1862917772c182df74c74e7.camel@redhat.com>
Subject: Re: [PATCH net-next V4 2/3] virtio_net: support per queue interrupt
 coalesce command
From: Paolo Abeni <pabeni@redhat.com>
To: Gavin Li <gavinl@nvidia.com>, mst@redhat.com, jasowang@redhat.com, 
 xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
 kuba@kernel.org, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
 john.fastabend@gmail.com, jiri@nvidia.com, dtatulea@nvidia.com
Date: Thu, 27 Jul 2023 15:28:32 +0200
In-Reply-To: <20230725130709.58207-3-gavinl@nvidia.com>
References: <20230725130709.58207-1-gavinl@nvidia.com>
 <20230725130709.58207-3-gavinl@nvidia.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, gavi@nvidia.com,
 virtualization@lists.linux-foundation.org, Heng Qi <hengqi@linux.alibaba.com>,
 bpf@vger.kernel.org
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

On Tue, 2023-07-25 at 16:07 +0300, Gavin Li wrote:
> Add interrupt_coalesce config in send_queue and receive_queue to cache user
> config.
> 
> Send per virtqueue interrupt moderation config to underlying device in
> order to have more efficient interrupt moderation and cpu utilization of
> guest VM.
> 
> Additionally, address all the VQs when updating the global configuration,
> as now the individual VQs configuration can diverge from the global
> configuration.
> 
> Signed-off-by: Gavin Li <gavinl@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

FTR, this patch is significantly different from the version previously
acked/reviewed, I'm unsure if all the reviewers are ok with the new
one.

[...]

>  static int virtnet_set_coalesce(struct net_device *dev,
>  				struct ethtool_coalesce *ec,
>  				struct kernel_ethtool_coalesce *kernel_coal,
>  				struct netlink_ext_ack *extack)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> -	int ret, i, napi_weight;
> +	int ret, queue_number, napi_weight;
>  	bool update_napi = false;
>  
>  	/* Can't change NAPI weight if the link is up */
>  	napi_weight = ec->tx_max_coalesced_frames ? NAPI_POLL_WEIGHT : 0;
> -	if (napi_weight ^ vi->sq[0].napi.weight) {
> -		if (dev->flags & IFF_UP)
> -			return -EBUSY;
> -		else
> -			update_napi = true;
> +	for (queue_number = 0; queue_number < vi->max_queue_pairs; queue_number++) {
> +		ret = virtnet_should_update_vq_weight(dev->flags, napi_weight,
> +						      vi->sq[queue_number].napi.weight,
> +						      &update_napi);
> +		if (ret)
> +			return ret;
> +
> +		if (update_napi) {
> +			/* All queues that belong to [queue_number, queue_count] will be
> +			 * updated for the sake of simplicity, which might not be necessary

It looks like the comment above still refers to the old code. Should
be:
	[queue_number, vi->max_queue_pairs]
			
Otherwise LGTM, thanks!

Paolo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
