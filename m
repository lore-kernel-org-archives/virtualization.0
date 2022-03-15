Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD361C433F5
	for <virtualization@archiver.kernel.org>; Tue, 15 Mar 2022 09:52:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 65AE54054A;
	Tue, 15 Mar 2022 09:52:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jWNtci_rAoNQ; Tue, 15 Mar 2022 09:52:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BC36840400;
	Tue, 15 Mar 2022 09:52:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98AFCC0012;
	Tue, 15 Mar 2022 09:52:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 430DCC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 09:52:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 152CC40112
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 09:52:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RlYGqWE1WRkt
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 09:52:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0052E40260
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 09:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647337960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N5IW2ZO+i2H4FBZWSS5hn4aliQk4aAVWjsRwugmKOuA=;
 b=RM5QfFLg5UxlMtz2w2OLU9g5PaxAMEGedlE4cqxd2CJImqZ32h8S/XW8UUSH96bRaFw1h+
 3RhRIu4P2yue0qGVWZH2dlZ4ogY7QU7TMn7wdKWJCJZrO53IHSRQbLS1ItfHTNFiwItsyC
 i69AzHbY3sbaOKSZFRIgyC3MzXEUn8g=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-210-eqhAcomeMJOaqAh0JP1CWw-1; Tue, 15 Mar 2022 05:52:35 -0400
X-MC-Unique: eqhAcomeMJOaqAh0JP1CWw-1
Received: by mail-qv1-f72.google.com with SMTP id
 dj3-20020a056214090300b004354a9c60aaso16205477qvb.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 02:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=N5IW2ZO+i2H4FBZWSS5hn4aliQk4aAVWjsRwugmKOuA=;
 b=BLatJoJzw3bc6per83/jrCWrXvCggxyXN9X+YDx775k/Kgj4yPE/IP73sHpv2lfqFX
 sEbD3Wu0oCuCEYyITSZ+5BcwjdttC1k5WJU7T32qTKbLje2v+U2fTKubUKLpOn6kek5g
 WjeTbM9wGCpq+bNMumrbwLQm9hZ15w42/ZZBshHUDTfLHZBYwWQX1uhm9k96rfWh+hJW
 Wv59WKVWrTLYTF3lCBJnIyR5q5vv+1oeTiizWkAbRcs+Pdl6A+ckKoKUbWtg83PvlX0K
 yvo7ZgR5cXsUGdNAbIfguuO/s9AlhHfwVHI9b7uv3zRFZIdqg96iWhVtccaZURTqkG4g
 1fog==
X-Gm-Message-State: AOAM530OByKqoO6dmGgekXFEgar4N8DqlC1A9iONuiZBj7Hmb72ofzta
 KHc5E95PgG/Wwe/336fWc+Lq0tuzMy+62YjwHlXAdsZcWapjGBvyzBJlAiUH/0FwJ5pzghYHZxI
 6Uz00qiO/ApYDmn+yP5FSVumwUlx2Tugqvep6QkoqYA==
X-Received: by 2002:a05:6214:19c4:b0:440:b035:594b with SMTP id
 j4-20020a05621419c400b00440b035594bmr6906955qvc.110.1647337955340; 
 Tue, 15 Mar 2022 02:52:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYTGoAIi2s1TzUq1JTWuGCm8A+zaGPrqws9RQeK42gHYAbCHsAokQeH5UfPekVFaxnkxUqmw==
X-Received: by 2002:a05:6214:19c4:b0:440:b035:594b with SMTP id
 j4-20020a05621419c400b00440b035594bmr6906945qvc.110.1647337955103; 
 Tue, 15 Mar 2022 02:52:35 -0700 (PDT)
Received: from sgarzare-redhat
 (host-212-171-187-184.pool212171.interbusiness.it. [212.171.187.184])
 by smtp.gmail.com with ESMTPSA id
 s12-20020a05622a018c00b002e1cd88645dsm5162039qtw.74.2022.03.15.02.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Mar 2022 02:52:34 -0700 (PDT)
Date: Tue, 15 Mar 2022 10:52:29 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Subject: Re: [PATCH v2 3/3] vdpa: support exposing the count of vqs to
 userspace
Message-ID: <20220315095229.e6to3g6juxbacjgk@sgarzare-redhat>
References: <20220315032553.455-1-longpeng2@huawei.com>
 <20220315032553.455-4-longpeng2@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20220315032553.455-4-longpeng2@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yechuan@huawei.com, huangzhichao@huawei.com,
 stefanha@redhat.com, virtualization@lists.linux-foundation.org
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

On Tue, Mar 15, 2022 at 11:25:53AM +0800, Longpeng(Mike) wrote:
>From: Longpeng <longpeng2@huawei.com>
>
>- GET_VQS_COUNT: the count of virtqueues that exposed
>
>Signed-off-by: Longpeng <longpeng2@huawei.com>
>---
> drivers/vhost/vdpa.c       | 13 +++++++++++++
> include/uapi/linux/vhost.h |  3 +++
> 2 files changed, 16 insertions(+)
>
>diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>index 0c82eb5..69b3f05 100644
>--- a/drivers/vhost/vdpa.c
>+++ b/drivers/vhost/vdpa.c
>@@ -370,6 +370,16 @@ static long vhost_vdpa_get_config_size(struct vhost_vdpa *v, u32 __user *argp)
> 	return 0;
> }
>
>+static long vhost_vdpa_get_vqs_count(struct vhost_vdpa *v, u32 __user *argp)
>+{
>+	struct vdpa_device *vdpa = v->vdpa;
>+
>+	if (copy_to_user(argp, &vdpa->nvqs, sizeof(vdpa->nvqs)))
>+		return -EFAULT;
>+
>+	return 0;
>+}
>+
> static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
> 				   void __user *argp)
> {
>@@ -510,6 +520,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
> 	case VHOST_VDPA_GET_CONFIG_SIZE:
> 		r = vhost_vdpa_get_config_size(v, argp);
> 		break;
>+	case VHOST_VDPA_GET_VQS_COUNT:
>+		r = vhost_vdpa_get_vqs_count(v, argp);
>+		break;
> 	default:
> 		r = vhost_dev_ioctl(&v->vdev, cmd, argp);
> 		if (r == -ENOIOCTLCMD)
>diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
>index bc74e95..5d99e7c 100644
>--- a/include/uapi/linux/vhost.h
>+++ b/include/uapi/linux/vhost.h
>@@ -154,4 +154,7 @@
> /* Get the config size */
> #define VHOST_VDPA_GET_CONFIG_SIZE	_IOR(VHOST_VIRTIO, 0x79, __u32)
>
>+/* Get the count of all virtqueues */
>+#define VHOST_VDPA_GET_VQS_COUNT	_IOR(VHOST_VIRTIO, 0x80, __u32)

I'd prefer VHOST_VDPA_GET_NUM_QUEUES, since we use "num_queues" also in 
the spec [1].

But I'm fine also with this:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

[1] 
https://docs.oasis-open.org/virtio/virtio/v1.1/csprd01/virtio-v1.1-csprd01.html#x1-1120003

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
