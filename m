Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3566EEB64DB
	for <virtualization@archiver.kernel.org>; Thu, 22 Jun 2023 12:28:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A520141E84;
	Thu, 22 Jun 2023 12:28:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A520141E84
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Px9fRGbV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 169cjOF3AUbG; Thu, 22 Jun 2023 12:28:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E417541E4B;
	Thu, 22 Jun 2023 12:28:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E417541E4B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBFB5C007A;
	Thu, 22 Jun 2023 12:28:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54DA8C0029
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 12:28:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2206883C2B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 12:28:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2206883C2B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Px9fRGbV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3ahqAynn-BdQ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 12:28:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6FB1883C28
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6FB1883C28
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 12:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687436900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5pmHwEzAPicyH88XD8XeXekL+O3YOK5f/E4/IhyQwRg=;
 b=Px9fRGbV+oQUD8vef5gqSFsZuVGddE1y05YSRwMFthqcCmK2iBqJ4Ff6+WSXk1PmVTWpWI
 7OFoSeQ2P6i7VWoXeGcCceQoVVaiq1eV6zkAA+XbEbX9rKGOU8JpxNNIRUspLxGlVd5uBi
 c85DRyldPwxFd7qLiVVzNoGK5p11xAA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-r_U30CsJMkSNkIa9J8EZDA-1; Thu, 22 Jun 2023 08:28:17 -0400
X-MC-Unique: r_U30CsJMkSNkIa9J8EZDA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7623a4864c2so905078185a.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 05:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687436897; x=1690028897;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5pmHwEzAPicyH88XD8XeXekL+O3YOK5f/E4/IhyQwRg=;
 b=FQqdlLniyJq9fuh314FNPmZvuGaAHHXCJ9we2zEWea3zJa/bGgv++7g9umVOrXkIz1
 9qQCibY4mDIUoECaJlnpNWYcnjXwCFecp1MxGvt4AkoWjaf5EtAobYte87XRATmPj+as
 5YI3D4BSeqDqhjGyCtEPO50S+ibNBIQMnCOLgydv30beNltHRXUzh8lRKdVqMtxea/CH
 u+7zvIAfClMUba/vIR7w7+q3+XsgqqG9kYaFyKZl1A7timFUlvdO6dj0fhWUkQNfMg8g
 GiRrWC5nTGczTDgS7vLAofzBtkq6/RV86JYKgMGdz+XanpXEfpOMK2QQYsAxis4gHFJv
 mNLw==
X-Gm-Message-State: AC+VfDzaTgz5ApNEADQnj9ECGgHozwHSS0elMbmfF7MggIZ4hPwmCq0O
 aM1n2wPOTU/X/o2oTYVESTBZsJ2wolnksGdyWTaoODUoaDtowsvDHN+WDGByBA2vciUSn/ubIWN
 F6MJXNCLPmnznFTckPFbpjDLebN3jEBQbq0BvWItGXg==
X-Received: by 2002:a05:620a:4d4:b0:765:25be:36e4 with SMTP id
 20-20020a05620a04d400b0076525be36e4mr2203235qks.6.1687436897371; 
 Thu, 22 Jun 2023 05:28:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6+Pf7PlnZxl+iDCZchQ2oSl5E1RwIAB5qxqHpnM5zKpM+NYgKOaaF1kJ1Jxjl6Kghb8vQT2Q==
X-Received: by 2002:a05:620a:4d4:b0:765:25be:36e4 with SMTP id
 20-20020a05620a04d400b0076525be36e4mr2203223qks.6.1687436897080; 
 Thu, 22 Jun 2023 05:28:17 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it.
 [87.11.6.160]) by smtp.gmail.com with ESMTPSA id
 s16-20020a05620a031000b0075f13bda351sm3301106qkm.115.2023.06.22.05.28.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 05:28:16 -0700 (PDT)
Date: Thu, 22 Jun 2023 14:28:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
Message-ID: <6culpnuswqq4fh7r5iqqtvwrpnsapn4jhx3heorfctztc2miem@hscigltkix5d>
References: <20230605110644.151211-1-sgarzare@redhat.com>
 <20230622073625-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230622073625-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Tiwei Bie <tiwei.bie@intel.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
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

On Thu, Jun 22, 2023 at 07:37:08AM -0400, Michael S. Tsirkin wrote:
>On Mon, Jun 05, 2023 at 01:06:44PM +0200, Stefano Garzarella wrote:
>> vhost-vdpa IOCTLs (eg. VHOST_GET_VRING_BASE, VHOST_SET_VRING_BASE)
>> don't support packed virtqueue well yet, so let's filter the
>> VIRTIO_F_RING_PACKED feature for now in vhost_vdpa_get_features().
>>
>> This way, even if the device supports it, we don't risk it being
>> negotiated, then the VMM is unable to set the vring state properly.
>>
>> Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>OK so for now I dropped this, we have a better fix upstream.
>

Yep, I agree.

Maybe we can reuse this patch in the stable branches where the backport
is not easy. Although as Jason said, maybe we don't need it.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
