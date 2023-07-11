Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BB5EB64DC
	for <virtualization@archiver.kernel.org>; Tue, 11 Jul 2023 14:20:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 61D5081CD0;
	Tue, 11 Jul 2023 14:20:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 61D5081CD0
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AynzTM9U
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CJoADjV-kwwC; Tue, 11 Jul 2023 14:20:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C6C5681DE6;
	Tue, 11 Jul 2023 14:20:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C6C5681DE6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95095C0071;
	Tue, 11 Jul 2023 14:20:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2DC9DC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jul 2023 14:20:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 07E0B40185
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jul 2023 14:20:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 07E0B40185
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AynzTM9U
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9vUd_0tebQGp
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jul 2023 14:20:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3E58040141
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3E58040141
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jul 2023 14:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689085224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NY9zvWPkMIRBdIzQwvp51bTldJwjnkTeVv0DGYO1saU=;
 b=AynzTM9UdTcmtBBNrDZMNCjbYmIqDU4kVngIbo95jhlroyQaEaOjJhSGDn+5oWdn9+jNwS
 d7ulyklRqmMBNYpP/ZR1azbt1mLtJNd9wLy8mca4jv7tb0kPupNIAo8XKijfewQAvSsgrT
 IjnCqHGegGD5zGjMn50xwK8rYIbltkw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-190-owKJyGXMPSOsyC8L1C253A-1; Tue, 11 Jul 2023 10:20:22 -0400
X-MC-Unique: owKJyGXMPSOsyC8L1C253A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52C1B28040B2;
 Tue, 11 Jul 2023 14:16:56 +0000 (UTC)
Received: from [10.39.208.24] (unknown [10.39.208.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6434B40C2070;
 Tue, 11 Jul 2023 14:16:54 +0000 (UTC)
Message-ID: <3a8073d5-dab4-ed13-2c53-84ed5093bacb@redhat.com>
Date: Tue, 11 Jul 2023 16:16:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com, mst@redhat.com,
 xieyongji@bytedance.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20230628065919.54042-1-lulu@redhat.com>
 <20230628065919.54042-2-lulu@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [RFC 1/4] vduse: Add the struct to save the vq reconnect info
In-Reply-To: <20230628065919.54042-2-lulu@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

Hello Cindy,

On 6/28/23 08:59, Cindy Lu wrote:
> From: Your Name <you@example.com>
> 
> this struct is to save the reconnect info struct, in this
> struct saved the page info that alloc to save the
> reconnect info
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>   drivers/vdpa/vdpa_user/vduse_dev.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 26b7e29cb900..f845dc46b1db 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -72,6 +72,12 @@ struct vduse_umem {
>   	struct page **pages;
>   	struct mm_struct *mm;
>   };
> +struct vdpa_reconnect_info {
> +	u32 index;
> +	phys_addr_t addr;
> +	unsigned long vaddr;
> +	phys_addr_t size;
> +};
>   
>   struct vduse_dev {
>   	struct vduse_vdpa *vdev;
> @@ -106,6 +112,7 @@ struct vduse_dev {
>   	u32 vq_align;
>   	struct vduse_umem *umem;
>   	struct mutex mem_lock;
> +	struct vdpa_reconnect_info reconnect_info[64];

Why 64?
Shouldn't it be part of struct vduse_virtqueue instead?

>   };
>   
>   struct vduse_dev_msg {

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
