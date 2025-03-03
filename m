Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79A31F03E1
	for <virtualization@lists.linux-foundation.org>; Mon,  3 Mar 2025 09:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740993140; cv=none; b=Q4ckm28WeMhUAS2/f2AvZoiebstHCTXg+CSbj6lS+/OoXxr8ZZ4QjvR2UTQTAfmfIOFTzFxwJT+j//U+3IR/f+jOF8vPfbfaEoHPGygF3Gk5hjKYSfRZ2oXfsg1KJWRXuvvZIg5Mj5L0hzoDdw4RZawg16zDvoVopjC6OdU0SJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740993140; c=relaxed/simple;
	bh=geG++AXD09rWCrdjxBMlqbjlj7UuYkL2iv00OIpXTMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OdHZkojNnHofqUC8Rddzj3UfSiSzzHG31d7O47rs8tjk9vMW8j6IZvRIh7iXbc9rkWr7Ma46Blo6uNec9LaFMmW5elcMmh9qyefBLobXw3KAtceq2b6+1KUJFwhFjOHM07ZvL6q1lSEo5c9fP4nggPS2QvZSBUv6Xu8Ihxhx600=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SXHkb+uR; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXHkb+uR"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 554CC40A21
	for <virtualization@lists.linux-foundation.org>; Mon,  3 Mar 2025 09:12:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hjhs-UTooXKh for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Mar 2025 09:12:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D699F404C1
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D699F404C1
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SXHkb+uR
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D699F404C1
	for <virtualization@lists.linux-foundation.org>; Mon,  3 Mar 2025 09:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740993134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YjVRjv35fHjv7RLlPVFkOhvXHHHtnF0rtq1Tf6M4yK4=;
	b=SXHkb+uR6dPoaye8FAbMHGiKgPSsD9M0i+mCKsnwVP23UjVM6CXx5dg5esxKRd1j2OoI3N
	qJuKSDbb7JNWthMBnOUhwlEnYk6L1nHR8jq3emOHWjQaRkIaGo7EUACk6YgAjSAWkvPvK5
	9vbNHyCrJyyluYojtNA7lKns6XgcFsk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-Nl-RUc0yMsKyId1zTByISQ-1; Mon, 03 Mar 2025 04:12:13 -0500
X-MC-Unique: Nl-RUc0yMsKyId1zTByISQ-1
X-Mimecast-MFC-AGG-ID: Nl-RUc0yMsKyId1zTByISQ_1740993132
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-abb8f65af3dso414181766b.1
        for <virtualization@lists.linux-foundation.org>; Mon, 03 Mar 2025 01:12:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740993132; x=1741597932;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YjVRjv35fHjv7RLlPVFkOhvXHHHtnF0rtq1Tf6M4yK4=;
        b=bsY9AaOFELjlybY91req8GwM+u1E9yKbolsHrtJ6YWX9WDfQyGE7HBVVant+zCthv6
         m+d0QAm6k7JO9WXyudxSBT++ma2M3PX8cSXACZCY5rgrHu3C7mJ1KLhFNIy4Q8VCNGZs
         Q6+JwItqlOU+M3BK/NWYPtYxhwCPq84T4QHYnzqJy+NfiyxDLHKhfPVI+Tf5JdEkWcEz
         xSEtx3WchsO7eQNFXaGqiyTn0Ivu8GxIaIeq8IydYKidvIPZLUmzejMC2oaaL3ZXPSEr
         HfTPk8i8j/8ecl5AtYSp8/9qRPCKGbNAr5HG6u7rg26EWzvIPYApqcOESEjUVwPrUgGO
         3P3g==
X-Forwarded-Encrypted: i=1; AJvYcCUhJf9wV1vB6Ojzl/VdHM0kV4gifdzSp6vIJmTeOHfR3/k6gjN9uXsmCAe8FU7E8Jo7C9ocDkV4KTtsjga7eA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzXEVFrwlW2gshEJCTXLqXmyHtlBk+WiDNI/Mr0FgAJ10XSySo0
	F0KwSobO52EEsvbghbRFWAoSyeffQO7UqgVkC2Ih2UJ/bQ70PTgFa4nh884TJH8s5jzLq912FMr
	OVuvWxrhv7VYxt3KcBS37FDbnzQYTJywL8CFhWUDioPolrARdvnZAzJIDIcPq1YpT8Gu1xNYd1m
	kZBdE=
X-Gm-Gg: ASbGnctWsw7Se4V0WpShoKHqo57Ow+bxCwOOBS46pBb31bEn9cbmU2VDd3gnbJw8eA9
	WwS9dno6V67ocjpKg3zw8/jNO1U5U2gXNprGUuhc1AXfztP/NPgr3OsSCy2yPU3Qnx2CCbfHo0v
	F6aWlf8XiDF/7qikz8b5aTZyun8qHd9lKp7inkCzwQLcdGBj8Qnfy89yBgBrjbp/KvxnzSK7Vsd
	B+/LU38ETQdTOYHm3O2bq5EIgkimdtK+C6DzLL6jgdN2iicYwXcy+0NZT1Ia5jqaWjAtmoNW//m
	cPnCF1XVTJnVpHObOGU67W+LgX705BUDM1v8tAXpnf4GZrxcwrMCrF3s6xjH6duA
X-Received: by 2002:a17:907:da2:b0:abf:777d:fb7a with SMTP id a640c23a62f3a-abf777dfd1amr339932566b.46.1740993131901;
        Mon, 03 Mar 2025 01:12:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtqN1qqtRWL94TvBz+1bpSPX8FaHG0oLP1oFMSS8+5uidcrPRyW31eyU/Z3YzkjO4tPcIZtw==
X-Received: by 2002:a17:907:da2:b0:abf:777d:fb7a with SMTP id a640c23a62f3a-abf777dfd1amr339929466b.46.1740993131263;
        Mon, 03 Mar 2025 01:12:11 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf78023d7esm172842966b.34.2025.03.03.01.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 01:12:10 -0800 (PST)
Date: Mon, 3 Mar 2025 10:12:06 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, mst@redhat.com, 
	michael.christie@oracle.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v7 8/8] vhost: Add a KConfig knob to enable IOCTL
 VHOST_FORK_FROM_OWNER
Message-ID: <svi5ui3ea55mor5cav7jirrttd6lkv4xkjnjj57tnjdyiwmr5c@p2hhfwuokyv5>
References: <20250302143259.1221569-1-lulu@redhat.com>
 <20250302143259.1221569-9-lulu@redhat.com>
 <CACGkMEv7WdOds0D+QtfMSW86TNMAbjcdKvO1x623sLANkE5jig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEv7WdOds0D+QtfMSW86TNMAbjcdKvO1x623sLANkE5jig@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PRNbReusCaNwaasHmlmta3SLKCxHk51BwdwV8Yj3sxk_1740993132
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Mar 03, 2025 at 01:52:06PM +0800, Jason Wang wrote:
>On Sun, Mar 2, 2025 at 10:34 PM Cindy Lu <lulu@redhat.com> wrote:
>>
>> Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
>> to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
>> When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
>> is disabled, and any attempt to use it will result in failure.
>>
>> Signed-off-by: Cindy Lu <lulu@redhat.com>
>> ---
>>  drivers/vhost/Kconfig | 15 +++++++++++++++
>>  drivers/vhost/vhost.c | 11 +++++++++++
>>  2 files changed, 26 insertions(+)
>>
>> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
>> index b455d9ab6f3d..e5b9dcbf31b6 100644
>> --- a/drivers/vhost/Kconfig
>> +++ b/drivers/vhost/Kconfig
>> @@ -95,3 +95,18 @@ config VHOST_CROSS_ENDIAN_LEGACY
>>           If unsure, say "N".
>>
>>  endif
>> +
>> +config VHOST_ENABLE_FORK_OWNER_IOCTL
>> +       bool "Enable IOCTL VHOST_FORK_FROM_OWNER"
>> +       default n
>> +       help
>> +         This option enables the IOCTL VHOST_FORK_FROM_OWNER, which allows
>> +         userspace applications to modify the thread mode for vhost devices.
>> +
>> +          By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL` is set to `n`,
>> +          meaning the ioctl is disabled and any operation using this ioctl
>> +          will fail.
>> +          When the configuration is enabled (y), the ioctl becomes
>> +          available, allowing users to set the mode if needed.
>> +
>> +         If unsure, say "N".
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index fb0c7fb43f78..09e5e44dc516 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -2294,6 +2294,8 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
>>                 r = vhost_dev_set_owner(d);
>>                 goto done;
>>         }
>> +
>> +#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
>>         if (ioctl == VHOST_FORK_FROM_OWNER) {
>>                 u8 inherit_owner;
>>                 /*inherit_owner can only be modified before owner is set*/
>> @@ -2313,6 +2315,15 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
>>                 r = 0;
>>                 goto done;
>>         }
>> +

nit: this empyt line is not needed

>> +#else
>> +       if (ioctl == VHOST_FORK_FROM_OWNER) {
>> +               /* When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is 'n', return error */
>> +               r = -ENOTTY;
>> +               goto done;
>> +       }
>> +#endif
>> +
>>         /* You must be the owner to do anything else */
>>         r = vhost_dev_check_owner(d);
>>         if (r)
>> --
>> 2.45.0
>
>Do we need to change the default value of the inhert_owner? For example:
>
>#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
>inherit_owner = false;
>#else
>inherit_onwer = true;
>#endif
>
>?

I'm not sure about this honestly, the user space has no way to figure 
out the default value and still has to do the IOCTL.
So IMHO better to have a default value that is independent of the kernel 
configuration and consistent with the current behavior.

Thanks,
Stefano

>
>Other patches look good to me.
>
>Thanks
>
>>
>

