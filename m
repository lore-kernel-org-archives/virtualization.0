Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF4529A30D
	for <virtualization@lists.linux.dev>; Tue, 16 Sep 2025 06:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758004674; cv=none; b=MAueZSLzVwZsv+7NTJdcxwb67FtPb8hmyAQvRtdobBRp6cL6T1ewndbgM3iPr5sQrppuxCLScUsXzmJdKYsaoJg8khMbYdNtLv7Ks5wbTWWdqadsgjmRd0fDL3DQMV9+EGvKkxQeebqsDQ9EhNjpbuvhLLIp867CnSdKAzyUQFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758004674; c=relaxed/simple;
	bh=W4K17Xgz86RjMnxn5TYpq043Q6o53dAX2EopwT6+spI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZLVR8XaeacRReQsJhay51qUX7CT0iFr+PCFRtaJvNssbr00qspQmwyQ1c0AR9HVn0V0Vp0V6TTnclC0YXX9EEBbWfF+qxrfXpHvaRsVF2mBBW1AiY58NaRXnSHJpwMqzt9zzj59uNeeAbz2VfSBoSJ+HPpcC10uyB6BdWgmf7YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c8URzE2b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c8URzE2b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758004672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W4K17Xgz86RjMnxn5TYpq043Q6o53dAX2EopwT6+spI=;
	b=c8URzE2b3IiOat22Wd4FU4X6OHX0FCh+FICrJBI2KfbtG9DnMVPPo7g1uZ+jDJ0WAHVl6r
	4YCBV1ebf/VyXAUydH8ud+9a/jc+2o3l3dAN/jYT033l4eX/Ev+er1eF2q6uy8gjvJ/1ZC
	sx60id1s1IcvISoV8zU/yDw4DIjXN1A=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-M2bRzSEfPeSNzuV-4ihn0w-1; Tue, 16 Sep 2025 02:37:50 -0400
X-MC-Unique: M2bRzSEfPeSNzuV-4ihn0w-1
X-Mimecast-MFC-AGG-ID: M2bRzSEfPeSNzuV-4ihn0w_1758004670
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7339355513fso24646077b3.1
        for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 23:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758004670; x=1758609470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4K17Xgz86RjMnxn5TYpq043Q6o53dAX2EopwT6+spI=;
        b=ge10ji1ZxOzPBwLaM65V6sLMMjBUkBU4NTa7W0GGDj8PTBlmvP8sYpAyHLF/PPdmVC
         SEOpp1O10xT7OeiSeUGpPgFjALKTLhkJX1tC/PgqWcA8as8kOoQ3ZUp7cwKGB6Uf+qMK
         ORzDqV2IKZraueW8/9cA5LPPk93hy5WkEC5fUomk1RcdaQVgJTAsODMQ4SD8asQkS8+U
         pBDK0KbBEwWaCWb5FF3qwJkteF/vq9+JF00EPDlTyg4qjDrryDwgmf7gbbOW6w6Pf3IF
         ZRdwx51coJrxVsWtR8W3aXMte2bK3Gqd2HakQ4uuk9VfV7uK/UxWsM6b8lTXY6nttAw/
         O/wQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcGYdd6FTJyufY/hlXDLeldCKv/zyzEFOkk73KPypkYxAr3zClXqKgHScppqURgNHptBsVV//6oX+xARdkXA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwRmmzs1bYKdlfh4rcb2TxcVO0F3H4p+Jfq2NAchPNARXjwOQlU
	DI5Cjzt2M6rOInxLDQIoWV5mzgm1/TqwKi2RRCmlEELAwF8gvhvuCK22bICu8tAwiegVrrPLL0p
	o44hSpR9ThbDTWNfCnGhFf0WP7k0yNaFYAqo6pHQ3t6fWEq1oTVD0Zg1fDT8QtkWSNO8FDNLDx+
	woA694Nx6GMzbHnxObdldUFzMorcTK6kLjlsqpv4YWiT8=
X-Gm-Gg: ASbGncsa1YqluFuUjM0JXAWarwS3BJHstv/jLvXjmzjSBgOQYiQ39gUr2HW8ho9gzyt
	32cDcuVSTWLwIVOIzEnJu3q+r3+Yjyy4jx0fnyrpR1YjsUqBN+ZfdDNPXLQu5/1EkLTnTsqESfA
	v3RCh1uExYotPmRdyNX4591ZK2lDVP0+LRyQwglY/oZWZF7TkxbvmST4ybkxoKcazxAr2ukM9sE
	q6ba/t+
X-Received: by 2002:a05:690e:25c4:b0:5fc:a995:69ce with SMTP id 956f58d0204a3-627225a757emr10100344d50.20.1758004669897;
        Mon, 15 Sep 2025 23:37:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGGn2W7kG6BqGefO0xIXacaiXghzf9KhbnCuK9dVqfFwyXoxNkUA5tzwB/f13a1h5iXG2WNShRtzNd+AXPZvQ=
X-Received: by 2002:a05:690e:25c4:b0:5fc:a995:69ce with SMTP id
 956f58d0204a3-627225a757emr10100335d50.20.1758004669385; Mon, 15 Sep 2025
 23:37:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250826112709.1051172-1-eperezma@redhat.com> <20250915184200-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250915184200-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 16 Sep 2025 08:37:12 +0200
X-Gm-Features: Ac12FXzYOFF9kv0KHhH8HVvtk04Rp75094MEuDRwZh40OOUbBnBS4J9acZkwBK8
Message-ID: <CAJaqyWdLB1dWASf6NXW_8VXUNoWQ=G4pGjZLRbD_3U=2rfXkig@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add multiple address spaces support to VDUSE
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Laurent Vivier <lvivier@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	jasowang@redhat.com, Yongji Xie <xieyongji@bytedance.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OMDxA5Ixcltpz37zJFYVvhUpTqboTkiXxq5WCRk0nm4_1758004670
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 12:42=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Tue, Aug 26, 2025 at 01:27:03PM +0200, Eugenio P=C3=A9rez wrote:
> > When used by vhost-vDPA bus driver for VM, the control virtqueue
> > should be shadowed via userspace VMM (QEMU) instead of being assigned
> > directly to Guest. This is because QEMU needs to know the device state
> > in order to start and stop device correctly (e.g for Live Migration).
> >
> > This requies to isolate the memory mapping for control virtqueue
> > presented by vhost-vDPA to prevent guest from accessing it directly.
> >
> > This series add support to multiple address spaces in VDUSE device
> > allowing selective virtqueue isolation through address space IDs (ASID)=
.
>
>
> There hasn't been a new version of this yet, has there?
>

No, I was on PTO last week. I plan to send it today.

Thanks!

