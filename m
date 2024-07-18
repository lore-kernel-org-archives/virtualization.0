Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F8E110A
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Jul 2024 00:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721263966; cv=none; b=J1wbM7qIjZVoAshZUNWFheD75SxO9pxhlLxhI/nViwQuKmWtF4wPIgK0Phnlj1m74lWncRCigZvly/Km2O8SdWZdP0thx/LCWN4b5FG12CW5jhoiX16dpVHaL34VbDoDvfdNRMpHTZA3bZeqYy/VHNISBaw9iz364EthBgoAbMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721263966; c=relaxed/simple;
	bh=esd7lYe5iq+onNX9j0js0Xwd+FXvQRDJiIeVuo28nhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B0a+fYRpJVel0OZz6OgzSAYJAK33OCdxxnoYZ+iQcrfDFqDP+8fTupqs+ea5bmhaZOjt73I/wfRsQ/ncFhnLhwIOwindzWfrI9372Fzord/SXadfcouWr3aJTaKaQDSBsEhqKESfylBtVEN9xJxWl0/H6Xh6mK/xLvi5jp6ZDc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GUHoXZXn; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUHoXZXn"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF3BE402E6
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Jul 2024 00:52:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iwChh9ItbZZr for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Jul 2024 00:52:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 86A68402D9
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 86A68402D9
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GUHoXZXn
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 86A68402D9
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Jul 2024 00:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721263962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AodQvD7UxAvNv2pUpx69b2DHyG8xaHJX0frFiPMlh3I=;
	b=GUHoXZXnQ0jT/GaD8XAXtk1pEViDje+/t9q2ieOMv8zri+jSAiK/qBknyStQziSh2JZGfF
	OgeL1s62E53mBekPGHN0LJPb1hhEBari9m8eJUwzYtq7bxWCVtUCxyvie/2z3z45GB7KeM
	9UO+XEaGCC5qAByf5i0cvB1f309+8Mc=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-8hM9DKnrOQaQSZ8WCKf5Bw-1; Wed, 17 Jul 2024 20:52:40 -0400
X-MC-Unique: 8hM9DKnrOQaQSZ8WCKf5Bw-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3daa9f23fc8so360980b6e.1
        for <virtualization@lists.linux-foundation.org>; Wed, 17 Jul 2024 17:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721263960; x=1721868760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AodQvD7UxAvNv2pUpx69b2DHyG8xaHJX0frFiPMlh3I=;
        b=Kn4IPeUHfLqH8A/qduRNfhUAQUkgAnBMPj6MbtWF+6Ooj12fWny4Z/puAvtxDmMEK+
         +/b9jNzxPcwfGY3Q8s9BskVVO5zXbMMXvqvHXgFLjp5qDZCZosMdPwMvHzApfbqUvBcS
         3dZYi9FxkPHqcaatu5+bOow13diFNmkUGfOYUjc1d3CnMBrSx55yK9NiggWoU/Cgs3Sm
         i+UixzX1M0tVpmHfnaCcglWHeWQLz9EWrwKuTsVNctkg/kcCfzw+VnQD3Ol32ynDMXv6
         LGB2WA3Cit/9Fex0V35mfl6+jr1JBh3rsmEWeHJ4dtum7m9qgoEjVSfPd4HKuWAnHukg
         lP8A==
X-Forwarded-Encrypted: i=1; AJvYcCU2JQ22pVfLJf29qK1SUVCOAKBXd8401KkiOIN4DaPPN0wRTS/+nQ9lIuXzfhtHhepWmsAegn57O3d2EiLLWiLpa/4F6LkSYBn0M/CB0vuRG+/jFi0CxgdMxA==
X-Gm-Message-State: AOJu0Yz6CKblw8tvz/3llA3FsySEtN67QKni9LxfL3htfbE0kBbzUZ/Y
	01GEThbL8aYuZ6lvQWk59KObjD0ANIp8PDhH4Wwe0/tWJhLX/OxaT06RURhHpM4JZkKUvZdIBOw
	duDu76sSnQ9bkJcRePMvjWANiWOtHt/0ZKgKD+M/GeqZPpB80IA5kBuX+ZSWPdY1bdjwtF6Y0WR
	vmi6Z/Cziz0tmx2ILr8n+sEx8bYkrIMMvDgIMPgpIngjDJpNdvA3OfdQ==
X-Received: by 2002:a05:6808:1a23:b0:3d9:28d0:fcdb with SMTP id 5614622812f47-3dad51eee14mr3145983b6e.12.1721263960082;
        Wed, 17 Jul 2024 17:52:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9h+0U2xvRbnvYEIv1j3r48AzVXHuxA2+eaNiLAp0VT0zFKA+GDu9vEaf/3S87+CdfT1c71ctDFijpnhuen/I=
X-Received: by 2002:a05:6808:1a23:b0:3d9:28d0:fcdb with SMTP id
 5614622812f47-3dad51eee14mr3145947b6e.12.1721263959710; Wed, 17 Jul 2024
 17:52:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240717053034-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240717053034-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Jul 2024 08:52:28 +0800
Message-ID: <CACGkMEura9v43QtBmWSd1+E_jpEUeXf+u5UmUzP1HT5vZOw3NA@mail.gmail.com>
Subject: Re: [GIT PULL] virtio: features, fixes, cleanups
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, aha310510@gmail.com, arefev@swemel.ru, 
	arseny.krasnov@kaspersky.com, davem@davemloft.net, dtatulea@nvidia.com, 
	eperezma@redhat.com, glider@google.com, iii@linux.ibm.com, jiri@nvidia.com, 
	jiri@resnulli.us, kuba@kernel.org, lingshan.zhu@intel.com, 
	ndabilpuram@marvell.com, pgootzen@nvidia.com, pizhenwei@bytedance.com, 
	quic_jjohnson@quicinc.com, schalla@marvell.com, stefanha@redhat.com, 
	sthotton@marvell.com, syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com, 
	vattunuru@marvell.com, will@kernel.org, xuanzhuo@linux.alibaba.com, 
	yskelg@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 5:30=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> This is relatively small.
> I had to drop a buggy commit in the middle so some hashes
> changed from what was in linux-next.
> Deferred admin vq scalability fix to after rc2 as a minor issue was
> found with it recently, but the infrastructure for it
> is there now.
>
> The following changes since commit e9d22f7a6655941fc8b2b942ed354ec780936b=
3e:
>
>   Merge tag 'linux_kselftest-fixes-6.10-rc7' of git://git.kernel.org/pub/=
scm/linux/kernel/git/shuah/linux-kselftest (2024-07-02 13:53:24 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_=
linus
>
> for you to fetch changes up to 6c85d6b653caeba2ef982925703cbb4f2b3b3163:
>
>   virtio: rename virtio_find_vqs_info() to virtio_find_vqs() (2024-07-17 =
05:20:58 -0400)
>
> ----------------------------------------------------------------
> virtio: features, fixes, cleanups
>
> Several new features here:
>
> - Virtio find vqs API has been reworked
>   (required to fix the scalability issue we have with
>    adminq, which I hope to merge later in the cycle)
>
> - vDPA driver for Marvell OCTEON
>
> - virtio fs performance improvement
>
> - mlx5 migration speedups
>
> Fixes, cleanups all over the place.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>

It looks like this one is missing?

https://lore.kernel.org/kvm/20240701033159.18133-1-jasowang@redhat.com/T/

Thanks

