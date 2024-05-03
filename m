Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CED153565
	for <virtualization@lists.linux.dev>; Fri,  3 May 2024 12:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714738705; cv=none; b=MI2XvV4sw8T+swt8BrWIjQuqWg/07WUGbRefZe2NKSFxbTxKieTRzPiDNQJu5JQsnAvsToqAkqReVf69kSDQkDAb9iRDrD/1u6Wtl8lXnptm4NqYvHyfynNsm1Hr9UTnRHmitmw2QgBAjxhfDKN9sbuY0ys/FSi9h+QyQRvOqq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714738705; c=relaxed/simple;
	bh=ns+ZEOsJIivrYrWML6q5m1uxPpbcL1z/6PzwKwIKrvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=k227jt0OMS7xtw+K7QmUMuhTP5KrZAdghcCvnC19Sx9VC2dd2bAXmg+8dU1u6SMls5nliZJ8GPTyvSNi19nxhqMppztiVrIOF8W8oV5gBk6kn4ZveH38X/+hFkbOoMyCEVxGnzuEEsNx0dRzAx5GqH+qsDGWIHnjF5t6bojWXEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IW2A3UFs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IW2A3UFs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714738702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yxDtTn4KG4gCeJ+R3KY9xlVy0Q16/vMhQbZ2Pi0wIi4=;
	b=IW2A3UFsW6uoDrq20ODNgIh+MJ6NHGoNkk8uHDguKufifEYlpl5/+XkHKca2I73rDyFch+
	rI0LhGbtdqmnpNl2pvkxOZHWZvi4AxZNm7zix0Lu/Hm9Lu7o1cMKMjncJhhzrQnmHtrBM0
	OxOWEWrOEdwR+NsY2hf6auV+O+FE65w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-3gqm5GDFON-njAM7tNEyRA-1; Fri, 03 May 2024 08:18:19 -0400
X-MC-Unique: 3gqm5GDFON-njAM7tNEyRA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-41bf6751b28so28367935e9.2
        for <virtualization@lists.linux.dev>; Fri, 03 May 2024 05:18:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714738698; x=1715343498;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yxDtTn4KG4gCeJ+R3KY9xlVy0Q16/vMhQbZ2Pi0wIi4=;
        b=EL7GB4Fl9KfqFWQF95exCOhoBg9rPatKZ70XEIwNCC07gNsYPtLBoatzvTV7WOOmIc
         TloWQ1UVwxaZy98a+AFSep0iM456hsJz6LrsCpuBd/tiziqExm01L3jFzu0ZLXGBD6Hj
         Ri9WHdP7J/kbwREyfcWp44TvnTW7vLlPGS/TU6ch0xZ83UqWbV+obkoHmqmxvCHRhsRZ
         oR1tlqw+2es2HdBgXb+LcOC/rbTTLbSmo79w7APVh4XOWb/tWR3XzOfACaYcJMrgOxDm
         EmIsiT5/TlW5CZjSz3IepoNFJp0oluQOQxNnnu1dobn1Epe8W59kEh5kpCIAgaUvyBxM
         3vQg==
X-Forwarded-Encrypted: i=1; AJvYcCXPK+LC2zUzVmDSBCui9ncnIQsQ6Vo0UeJ8imjAKx2nlQvMlTFDBFqv6tCKCjV8v03UP6wKOsV+tag7eqMi9hyE/G5nOf8OnD25oQnpqV0=
X-Gm-Message-State: AOJu0Yy4ok0dVxkKH6gG6ydHwdlCKj4ZjG7goF/lbKyX73AlORk3DfZn
	8LtXGrFzl07pLsrQcPCHOMxSWaMQZK8VKX9w0wXK9HNwkKTdGuGIZvtCfYnre66kbwSKeAMyGEv
	tGRodtnOTrIOAOQymXTkNhZxcb547se9NlYKBH46iagLByUkH+U1dUR4b7nCagwS+
X-Received: by 2002:a05:600c:3516:b0:41a:9c33:9c25 with SMTP id h22-20020a05600c351600b0041a9c339c25mr1917857wmq.13.1714738698146;
        Fri, 03 May 2024 05:18:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpmNBdrGdRmMckz/gHSnp/lRLlkszQGP+r54DPSa8tX9rl+61pCeoQhjN/AnkQuqRTRoqjCQ==
X-Received: by 2002:a05:600c:3516:b0:41a:9c33:9c25 with SMTP id h22-20020a05600c351600b0041a9c339c25mr1917842wmq.13.1714738697745;
        Fri, 03 May 2024 05:18:17 -0700 (PDT)
Received: from sgarzare-redhat (c-115-213.cust-q.wadsl.it. [212.43.115.213])
        by smtp.gmail.com with ESMTPSA id r8-20020a5d4988000000b0034cceee9051sm3622412wrq.105.2024.05.03.05.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 05:18:16 -0700 (PDT)
Date: Fri, 3 May 2024 14:18:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, mst@redhat.com, virtualization@lists.linux.dev
Subject: Re: [PATCH 09/10] vDPA: report virtio-block read-only info to user
 space
Message-ID: <2tzq7nfmcsfxh37mrwkkl25ok3lrn4blj3le5fvzbrcl6w4h4z@22geh32s4bfq>
References: <20240218185606.13509-1-lingshan.zhu@intel.com>
 <20240218185606.13509-10-lingshan.zhu@intel.com>
 <ms2roqd326s5j5ynksciz4tdijqx4taeoyjvtzelbttkt4vich@b4geobrynwj5>
 <a0672e72-5c17-4457-9f31-9f9db6f9f229@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <a0672e72-5c17-4457-9f31-9f9db6f9f229@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Apr 09, 2024 at 04:37:18PM GMT, Zhu, Lingshan wrote:
>
>
>On 3/20/2024 12:40 AM, Stefano Garzarella wrote:
>>On Mon, Feb 19, 2024 at 02:56:05AM +0800, Zhu Lingshan wrote:
>>>This commit report read-only information of
>>>virtio-blk devices to user space.
>>>
>>>Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>>>---
>>>drivers/vdpa/vdpa.c       | 14 ++++++++++++++
>>>include/uapi/linux/vdpa.h |  1 +
>>>2 files changed, 15 insertions(+)
>>>
>>>diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>>>index adbcbc7b18b2..d6fd3cadc44f 100644
>>>--- a/drivers/vdpa/vdpa.c
>>>+++ b/drivers/vdpa/vdpa.c
>>>@@ -1084,6 +1084,17 @@ 
>>>vdpa_dev_blk_write_zeroes_config_fill(struct sk_buff *msg, u64 
>>>features,
>>>    return 0;
>>>}
>>>
>>>+static int vdpa_dev_blk_ro_config_fill(struct sk_buff *msg, u64 
>>>features)
>>>+{
>>>+    u8 ro;
>>>+
>>>+    ro = ((features & BIT_ULL(VIRTIO_BLK_F_RO)) == 0) ? 0 : 1;
>>>+    if (nla_put_u8(msg, VDPA_ATTR_DEV_BLK_CFG_READ_ONLY, ro))
>>
>>This is not really related to the config space, what about renaming it
>>to VDPA_ATTR_DEV_BLK_READ_ONLY ?
>>
>>Also the type, maybe better to use "flag" and set it through
>>`nla_put_flag()`.
>Hi Stefano,
>
>I am implementing this change.
>In my humble opinion, maybe using a boolean(the u8 above) is better?

If boolean is available, I agree that could be better.
I did just a fast search when I commented.

BTW, sorry for the late reply, I was on PTO.

Stefano

>Because using the flag means we conditionally put a "0" into the 
>attribution,
>or the attribution does not exist, this is still a bool logic but
>a little vague.
>
>Thanks
>Lingshan
>>
>>Not a strong opinion on that, it just seems a little more consistent to
>>me.
>>
>>Thanks,
>>Stefano
>>
>>>+        return -EMSGSIZE;
>>>+
>>>+    return 0;
>>>+}
>>>+
>>>static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
>>>                    struct sk_buff *msg)
>>>{
>>>@@ -1122,6 +1133,9 @@ static int vdpa_dev_blk_config_fill(struct 
>>>vdpa_device *vdev,
>>>    if (vdpa_dev_blk_write_zeroes_config_fill(msg, 
>>>features_device, &config))
>>>        return -EMSGSIZE;
>>>
>>>+    if (vdpa_dev_blk_ro_config_fill(msg, features_device))
>>>+        return -EMSGSIZE;
>>>+
>>>    return 0;
>>>}
>>>
>>>diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
>>>index 797d5708492f..4be8e3a15874 100644
>>>--- a/include/uapi/linux/vdpa.h
>>>+++ b/include/uapi/linux/vdpa.h
>>>@@ -70,6 +70,7 @@ enum vdpa_attr {
>>>    VDPA_ATTR_DEV_BLK_CFG_DISCARD_SEC_ALIGN,/* u32 */
>>>    VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEC,    /* u32 */
>>>    VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEG,    /* u32 */
>>>+    VDPA_ATTR_DEV_BLK_CFG_READ_ONLY,        /* u8 */
>>>
>>>    /* new attributes must be added above here */
>>>    VDPA_ATTR_MAX,
>>>-- 
>>>2.39.3
>>>
>>>
>>
>>
>

