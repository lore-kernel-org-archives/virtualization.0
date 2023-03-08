Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E9DC678D5
	for <virtualization@archiver.kernel.org>; Wed,  8 Mar 2023 06:59:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 522C341763;
	Wed,  8 Mar 2023 06:59:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 522C341763
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ciifgJ74
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M67deZWhBQM8; Wed,  8 Mar 2023 06:59:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B5E0E4174C;
	Wed,  8 Mar 2023 06:59:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B5E0E4174C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8946BC0071;
	Wed,  8 Mar 2023 06:59:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C64FC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 06:59:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5785441763
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 06:59:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5785441763
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A6o9Vd-uXUqk
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 06:59:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7919F4174C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7919F4174C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 06:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678258785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JKUbCkPYS6hopkpQssmBhFs4p2j+vvb1VsO2ZfvpRwU=;
 b=ciifgJ74pBBHkTj83Wf2ZsGVHo7Xz/17/NjjzyWzxntj38GdHdNT9qtjCQpiGIinvp8CCR
 x4/c1fZZeb7nVqy7bO6l5Gaeyctrk1B/CRC8HpzgqgKCs7lOvkfTtLq0O6a/AqiXfbKlqL
 f4l5q8PjFGCgmryRmyH7KEk9psqBv0w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-AFP6gvuONfCOLmybSfnrmQ-1; Wed, 08 Mar 2023 01:59:41 -0500
X-MC-Unique: AFP6gvuONfCOLmybSfnrmQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 u5-20020a5d6da5000000b002cd82373455so2629608wrs.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Mar 2023 22:59:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678258780;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JKUbCkPYS6hopkpQssmBhFs4p2j+vvb1VsO2ZfvpRwU=;
 b=yZq9HE1sCj4ZZHHLeTo0AhUicKXWf+g9cOB7L6WY4/sPshJF+qK061+YVaCAwqQCj8
 EMTxfVX3tVVVSL/C0IFX6DY80l9mej0DqPHlYCNrR7PN1R0sF5I81t7r7mEcnniCB0Fl
 8kwYgQXaThfQkbq9Cloxpp6+1yOKMPxNHHPZGtlWtdUNX9/lXJHbnrCyRh4cl34wP1lr
 EX9KJarSauDe/X76b00usjxPRisllSUdp2io/ac0OB8QIgSdTY4L6MmUox2bIZif60gd
 TjhYIl35nBjgGlNy22j9IYDQvWgbVjW/9zxH+z30orbjL5+vI8MSLn5qCSaNKz5A6fTH
 GPuQ==
X-Gm-Message-State: AO0yUKXW46BfkJFPs+kteYiXxlIX6GZ0de4M2mrNZxL8IfrvSYqX2JB5
 oGdtKbLEr3BREiEz5hSdcfI3BNUxY7eogQeDlcdcV31OtjflTnfYI7ff8IF9BW8KYtEZBI6RnEY
 Cqzr6cVwe5qWQnvsesiNSDgzWJD6MTKRWDj4Cwalqqw==
X-Received: by 2002:a05:600c:1e0e:b0:3dc:55d9:ec8 with SMTP id
 ay14-20020a05600c1e0e00b003dc55d90ec8mr14707977wmb.41.1678258780181; 
 Tue, 07 Mar 2023 22:59:40 -0800 (PST)
X-Google-Smtp-Source: AK7set9BAKLIppPhLC/5H+C7F9h4P4ZHKpnTP7stbG6M5nGWxx4EQAWwVmPn3H7AR5Tu7HccKtDNWg==
X-Received: by 2002:a05:600c:1e0e:b0:3dc:55d9:ec8 with SMTP id
 ay14-20020a05600c1e0e00b003dc55d90ec8mr14707968wmb.41.1678258779901; 
 Tue, 07 Mar 2023 22:59:39 -0800 (PST)
Received: from redhat.com ([2.52.138.216]) by smtp.gmail.com with ESMTPSA id
 j17-20020adff011000000b002c5a1bd527dsm14235258wro.96.2023.03.07.22.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Mar 2023 22:59:39 -0800 (PST)
Date: Wed, 8 Mar 2023 01:59:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Feng Liu <feliu@nvidia.com>
Subject: Re: [PATCH 3/3] virtio_ring: Use const to annotate read-only pointer
 params
Message-ID: <20230308015827-mutt-send-email-mst@kernel.org>
References: <20230307035705.4479-1-feliu@nvidia.com>
 <20230307035705.4479-4-feliu@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230307035705.4479-4-feliu@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, Jiri Pirko <jiri@nvidia.com>,
 Bodong Wang <bodong@nvidia.com>, Gavin Li <gavinl@nvidia.com>
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

On Tue, Mar 07, 2023 at 05:57:05AM +0200, Feng Liu wrote:
> @@ -2827,8 +2827,7 @@ bool virtqueue_is_broken(struct virtqueue *_vq)
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_is_broken);
>  
> -/*
> - * This should prevent the device from being used, allowing drivers to
> +/ This should prevent the device from being used, allowing drivers to
>   * recover.  You may need to grab appropriate locks to flush.
>   */
>  void virtio_break_device(struct virtio_device *dev)

How was this tested? Does this even compile? Pls include testing info
in future postings.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
