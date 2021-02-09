Return-Path: <SRS0=H/CR=HL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855AEC433DB
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 09:27:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DD0264EB4
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 09:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD0264EB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DA39A873C0;
	Tue,  9 Feb 2021 09:27:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dck3YuFUQ1U3; Tue,  9 Feb 2021 09:27:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E8F3486A4E;
	Tue,  9 Feb 2021 09:27:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2F59C0891;
	Tue,  9 Feb 2021 09:27:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4FD6C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 09:27:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D064B872E3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 09:27:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CpjBbW4bZLLh
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 09:27:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3E3DD87292
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 09:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612861220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ssXcbCxajiNCzH/D1KYh6ScyY3wgkyKhopHLnboLrLI=;
 b=GlJHpkFCSfhL5o1AIBP5hKA8FTVA3pjnZSDMN78maQUcunEaXZ99qj0PCL/vOXtAkgwke2
 4ejXnPRFlOleVQM6LDkEcfp+xjBaXBY1vAKSkEWXYFVW+IawCca4r15kGRmoaG51UcmYZW
 mVm4ujgnBT8v4hzyCJgOlzC05SIyMg8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612861821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ssXcbCxajiNCzH/D1KYh6ScyY3wgkyKhopHLnboLrLI=;
 b=VIBiHZPFAWQlvhxqsSvOJ8Ed3g+aaIz4J9HA7MMViFh/8FhH1fa+jDE+g1T6PrTHMtr+IY
 BXb536coTPr+mmbnRLGdT02Y220z7O7wn3S6ECJquSwCoPixNi+kfkfBnhzoeGNq44Uanz
 +Uyoz/yYRlfiibv+uq0jByyDySfbzTw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612862422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ssXcbCxajiNCzH/D1KYh6ScyY3wgkyKhopHLnboLrLI=;
 b=SW/7Kc17jd8/EdQQ7LfLrjL7OY4V8Vs83lSXoYEKmtsnajRahI5EbYO6ACWBvJ+KYr3Ivs
 bPEoaRINvMo+y9m/pHh2TZtI+g0KpVUChBSCmKTUYmmP2AutqjWH2p1D+JGgE56rbq6jEV
 yc0QoDBGSqL36U+h8gL51a0rhBkbFoM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-kOecvQWqNYi-GJVSXeiwKA-1; Tue, 09 Feb 2021 04:00:18 -0500
X-MC-Unique: kOecvQWqNYi-GJVSXeiwKA-1
Received: by mail-ej1-f72.google.com with SMTP id jl9so10531141ejc.18
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Feb 2021 01:00:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ssXcbCxajiNCzH/D1KYh6ScyY3wgkyKhopHLnboLrLI=;
 b=PKawecKlSPlQnBxvpJFnJpNNuX0pxS41LAXf0XGqyffufmj4uqUWFqJ2TOEzdnSnof
 VA2g3qZ54ZYWjJNy/ZDTAuaBYxvpDIR+N7g0P3mYwvzESLHcDMjVMXlFju0gZpWtS/Z1
 U+x/dnDwtBE9x+trUCR/i3E/FmWUkeGm12U5ugaCpK7EzF7AROaxa4pyF7p4x6pbcyTw
 Kfgyl67THtVfS0oRxtzUI8Ns4c4Vt5KNT/IMvR2bZ/S4C2fp1nc9IOFomJ+/L3x2ZrKO
 pCLzSY61tuR4auCsArOpZczK8J37pQ77mJzkDVmzWb94u5hkRW8VhGQ4hdBSBV0iH0yO
 SliA==
X-Gm-Message-State: AOAM530GuE75lQucqxuaQVPWZkSDYjbuPSdY4pXbvy6QO2qokZzW28Nz
 94ejAOqKesRsmQgBmX1RU8PRfOhwi8HbaeszpkSFDStadtmF8oUHveUqJ4IfFswyOwHx3DyVPFx
 Ou0RBJwmDlLfixtcAJy1Myuka0aqTD1+Ui61vP5Hhrg==
X-Received: by 2002:a17:906:ca0d:: with SMTP id
 jt13mr20677919ejb.170.1612861217139; 
 Tue, 09 Feb 2021 01:00:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxFhMR1s45N9hKd52KF7rZ7SoHNdNI4kdNR6gUmrzh6kavL86rdUETsPkBxOC2mPkBcOuN80g==
X-Received: by 2002:a17:906:ca0d:: with SMTP id
 jt13mr20677901ejb.170.1612861216952; 
 Tue, 09 Feb 2021 01:00:16 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id a7sm10239416eje.96.2021.02.09.01.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Feb 2021 01:00:16 -0800 (PST)
Date: Tue, 9 Feb 2021 10:00:14 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH] vdpa/mlx5: fix param validation in mlx5_vdpa_get_config()
Message-ID: <20210209090014.xolf5kxri3xdmacz@steredhat>
References: <20210208161741.104939-1-sgarzare@redhat.com>
 <20210209054302.GA210455@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20210209054302.GA210455@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Feb 09, 2021 at 07:43:02AM +0200, Eli Cohen wrote:
>On Mon, Feb 08, 2021 at 05:17:41PM +0100, Stefano Garzarella wrote:
>> It's legal to have 'offset + len' equal to
>> sizeof(struct virtio_net_config), since 'ndev->config' is a
>> 'struct virtio_net_config', so we can safely copy its content under
>> this condition.
>>
>> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>Acked-by: Eli Cohen <elic@nvidia.com>
>
>BTW, same error in vdpa_sim you may want to fix.
>

Commit 65b709586e22 ("vdpa_sim: add get_config callback in 
vdpasim_dev_attr") unintentionally solved it.

Since it's a simulator, maybe we can avoid solving it in the stable 
branches. Or does it matter?

Thanks,
Stefano

>> ---
>>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> index dc88559a8d49..10e9b09932eb 100644
>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> @@ -1820,7 +1820,7 @@ static void mlx5_vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
>>  	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>>  	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>>
>> -	if (offset + len < sizeof(struct virtio_net_config))
>> +	if (offset + len <= sizeof(struct virtio_net_config))
>>  		memcpy(buf, (u8 *)&ndev->config + offset, len);
>>  }
>>
>> --
>> 2.29.2
>>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
