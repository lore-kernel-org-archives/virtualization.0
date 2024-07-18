Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6931A145A12
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Jul 2024 19:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721330895; cv=none; b=aaireFvEr71WULqag5qVQS8k2GlewJ8ioNHpHL8Ijzxu1KqOUUMaedLpzzMLG/V77IXcC+N8EXEmf/woCLCefU67teLyT7u1BdYqikO1Nvfu7wm4KXjXurS5up+7g10E9/uWxWPegpDuv3WmQRcEZqgaLjDeadPz8AxS/SS/Zk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721330895; c=relaxed/simple;
	bh=hOXcRf1xMFrEzhzW/LnjACR6jGvf86F5VJttf9LLjy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HEoUwpvMYrWNj5M4uWXXgDSilzwG4xO4QcBab5zcB25EHPknb4QMJMUNQ/nrKknSu8SjbhHNFAt2rmyxpOEEOAppDoDOpElQAgmLvrIJJ8GomKGfyFgcy1ixy+w84Ss/jaDXRL9AnBQpbpZ5fIxv1SSLU6aDzKvCEiDavHUhTIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i7dAJwBP; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7dAJwBP"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A107605D4
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Jul 2024 19:28:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eau6nQlnA0F0 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Jul 2024 19:28:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E9C6060790
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E9C6060790
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i7dAJwBP
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E9C6060790
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Jul 2024 19:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721330891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rDZ5M+z92pHpshwG1/cax9lDFRAQ589w+2UZ+nT4yxw=;
	b=i7dAJwBPapsUaaTAcp3s0orhmBVxUOFqsnLK+vYLeVcDVsOpO6+ZWDS0G5MdTusR/3IANC
	P8LFpIQ6fUI9YxMJaXLbO/suEjRZa/q0Fg0hBCHzxBQU2/mGBrgFILXBoEQsolCu3l/yj8
	5lb5Ou7D6J//jSNPuzuVIoAAV5p4BNo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-7t9hYnvpOR6fkklg_zDE3w-1; Thu, 18 Jul 2024 15:28:09 -0400
X-MC-Unique: 7t9hYnvpOR6fkklg_zDE3w-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5a25bf1810bso148515a12.1
        for <virtualization@lists.linux-foundation.org>; Thu, 18 Jul 2024 12:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721330888; x=1721935688;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rDZ5M+z92pHpshwG1/cax9lDFRAQ589w+2UZ+nT4yxw=;
        b=PKUOW5IyBjdyw8UEmY9qpZH5xtP9eB4DbUxMim+Fsq13IEbEwmt4bDIR1SLoV2aV8o
         xysRRoC6yH68Dgzh1Iac2miwh6eNNMO15gJ2yk+PYinZdC0N6K0t1hUjtTeSfUTH7ZrF
         C0Iuxm8of1HdDlns/sqmaAUBqQY1zLosu/RIU8XKJ/bvYa0oAHgVxKuJkQjjNlWsxGhl
         ytl93ijGfB8jYG18G9B5lNBDXyZP75Z27efhiFr/8WObFJ5yjySWE5j9ItMN8jgF+MmN
         5bHJZlN9Fkznc1Lgp3rk6v9a4E668h5OXPzzqFs18F6b2Gef7cWCdnQXeJvh5UWjhreV
         vjUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/dSSIFKX8v6LgtByUmSzx1Tl2P8KJl9Qc8qwjzYatN46QcRem9T0zseU9+pljJlffoUWumqEZxYXnRZqG2SBhHatlQgbMMmxvavOhBp47qzvNdWb9xUcOSA==
X-Gm-Message-State: AOJu0Yyi5fBDxkKecXasl1fsT8DOjljXnHtdU8mohA2ue/uC2edaB7jd
	EKQpQcp4OpwwIEdOeBtN8/eNnJjHvNd8q9UjZD4KS62iYgIIpCZJDNxPsDj5nGCiBjO0cGElOWQ
	Q1pF3ooddefa4G7XvVftqQQIOP9mSlQojdKRY6bIHdhUqqTWaqbgXIsEYaqyrM8+lV4OMGqG007
	fQE40=
X-Received: by 2002:a17:906:615:b0:a75:3c2d:cd8e with SMTP id a640c23a62f3a-a7a011e5879mr431239966b.27.1721330888277;
        Thu, 18 Jul 2024 12:28:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNBugtdGfi6vyNKd7H45kvEtMDZ7Q+4JtfeFiuLdziqbae7sxeS5yTAmkCgh9bauEMGzVKwg==
X-Received: by 2002:a17:906:615:b0:a75:3c2d:cd8e with SMTP id a640c23a62f3a-a7a011e5879mr431232966b.27.1721330887696;
        Thu, 18 Jul 2024 12:28:07 -0700 (PDT)
Received: from redhat.com (mob-5-90-112-15.net.vodafone.it. [5.90.112.15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368727f29c6sm399103f8f.45.2024.07.18.12.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 12:28:06 -0700 (PDT)
Date: Thu, 18 Jul 2024 15:28:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, aha310510@gmail.com, arefev@swemel.ru,
	arseny.krasnov@kaspersky.com, davem@davemloft.net,
	dtatulea@nvidia.com, eperezma@redhat.com, glider@google.com,
	iii@linux.ibm.com, jiri@nvidia.com, jiri@resnulli.us,
	kuba@kernel.org, lingshan.zhu@intel.com, ndabilpuram@marvell.com,
	pgootzen@nvidia.com, pizhenwei@bytedance.com,
	quic_jjohnson@quicinc.com, schalla@marvell.com, stefanha@redhat.com,
	sthotton@marvell.com,
	syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com,
	vattunuru@marvell.com, will@kernel.org, xuanzhuo@linux.alibaba.com,
	yskelg@gmail.com
Subject: Re: [GIT PULL] virtio: features, fixes, cleanups
Message-ID: <20240718152712-mutt-send-email-mst@kernel.org>
References: <20240717053034-mutt-send-email-mst@kernel.org>
 <CACGkMEura9v43QtBmWSd1+E_jpEUeXf+u5UmUzP1HT5vZOw3NA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEura9v43QtBmWSd1+E_jpEUeXf+u5UmUzP1HT5vZOw3NA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jul 18, 2024 at 08:52:28AM +0800, Jason Wang wrote:
> On Wed, Jul 17, 2024 at 5:30 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > This is relatively small.
> > I had to drop a buggy commit in the middle so some hashes
> > changed from what was in linux-next.
> > Deferred admin vq scalability fix to after rc2 as a minor issue was
> > found with it recently, but the infrastructure for it
> > is there now.
> >
> > The following changes since commit e9d22f7a6655941fc8b2b942ed354ec780936b3e:
> >
> >   Merge tag 'linux_kselftest-fixes-6.10-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest (2024-07-02 13:53:24 -0700)
> >
> > are available in the Git repository at:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
> >
> > for you to fetch changes up to 6c85d6b653caeba2ef982925703cbb4f2b3b3163:
> >
> >   virtio: rename virtio_find_vqs_info() to virtio_find_vqs() (2024-07-17 05:20:58 -0400)
> >
> > ----------------------------------------------------------------
> > virtio: features, fixes, cleanups
> >
> > Several new features here:
> >
> > - Virtio find vqs API has been reworked
> >   (required to fix the scalability issue we have with
> >    adminq, which I hope to merge later in the cycle)
> >
> > - vDPA driver for Marvell OCTEON
> >
> > - virtio fs performance improvement
> >
> > - mlx5 migration speedups
> >
> > Fixes, cleanups all over the place.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> 
> It looks like this one is missing?
> 
> https://lore.kernel.org/kvm/20240701033159.18133-1-jasowang@redhat.com/T/
> 
> Thanks

It's not included in the full but it's a bugfix and it's subtel enough
that I decided it's best to merge later, in particular when I'm not on
vacation ;)

-- 
MST

