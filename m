Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BF41E527
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cjlWLJ9V"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A433F41A3A
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 14:59:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A433F41A3A
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cjlWLJ9V
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7bxQLYYzNS52
	for <virtualization@lists.linux-foundation.org>;
	Wed, 29 Nov 2023 14:59:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C8E4E4026E
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 14:59:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C8E4E4026E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701269953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MI2wXYD1dHy0biP40vAHd/lkz+ijx91uo3bdYG08BTA=;
	b=cjlWLJ9V+i6QvdS38OrElVGmhllGuU+xqMWO7aQT6erblyZhDTPNBZwtt+gCyfQ0o14sUB
	x8wJfQ6yXpWmAoKjqqkQHRmrDm3G9gkR8Ck0F+FVnZI8QaT0LQBJpVchvylT8OH2W4duOE
	2MttsLOWKYyZmUAtFCArL7SbpTqClds=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-IcQafGOBNC2P11LMpYE3bQ-1; Wed, 29 Nov 2023 09:59:09 -0500
X-MC-Unique: IcQafGOBNC2P11LMpYE3bQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-332dfa77997so4698319f8f.0
        for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 06:59:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701269948; x=1701874748;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MI2wXYD1dHy0biP40vAHd/lkz+ijx91uo3bdYG08BTA=;
        b=luWuQv3h7X9e5+xe8wb+OwhNRcXM8B/DQ3zRYLFH34YXG8hE0IuwY3BxErzAJFDSyA
         vLyOhRGWX9BgNB9M3+oCSKjHNb86yCTF+QzsH7H9Sl1so12KcjG5549l312MY1V99Obs
         dhSn/PThNFcNKjHXFKSvBrPPGbqewTkREhygSLoVX2oSjBEAuhrQS3eSTfizgfM+QNhy
         1wEVLDDTrQZ7IS9UENPUI/Z93gZ/Iys1LN1fjUwTM6YWF571z87KbAveFdroLqjx2ipJ
         B2zm9vEN3zkE68hwzWVDYGVqV30QialLzSQLkA4AvF7ybmry0bv0AdDLAXp+RmigemUd
         NZ3g==
X-Gm-Message-State: AOJu0Yx7flXVPzoZpmPkCMhWBh4MgqlUiE+01buWkNk9WTigARnK/rBY
	lBgqokn8TC3C6bO+e8EYqfkhm+rd+1nHl8e+FHyYgvbm/Nc5/cVzPQB4ReE0gzYMnrYzs9CBPud
	ovuJG9MAR2B7sYsm8f9TO+u/orgeb7PhsUmIb/Vo9XQ==
X-Received: by 2002:adf:eb41:0:b0:333:727:2ff5 with SMTP id u1-20020adfeb41000000b0033307272ff5mr5590101wrn.9.1701269948082;
        Wed, 29 Nov 2023 06:59:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmMigrMbu6mymybp1KFy8Po2HEeHonkXFHl9UM+Rm947CoT67bByrDPdYVKwxNSrc1C5AKsA==
X-Received: by 2002:adf:eb41:0:b0:333:727:2ff5 with SMTP id u1-20020adfeb41000000b0033307272ff5mr5590083wrn.9.1701269947721;
        Wed, 29 Nov 2023 06:59:07 -0800 (PST)
Received: from redhat.com ([2.55.57.48])
        by smtp.gmail.com with ESMTPSA id j7-20020adfb307000000b00332e7f9e2a8sm16187336wrd.68.2023.11.29.06.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:59:07 -0800 (PST)
Date: Wed, 29 Nov 2023 09:59:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Liang Chen <liangchen.linux@gmail.com>, jasowang@redhat.com,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xuanzhuo@linux.alibaba.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	pabeni@redhat.com, alexander.duyck@gmail.com
Subject: Re: [PATCH net-next 2/5] virtio_net: Add page_pool support to
 improve performance
Message-ID: <20231129095825-mutt-send-email-mst@kernel.org>
References: <20230526054621.18371-1-liangchen.linux@gmail.com>
 <20230526054621.18371-2-liangchen.linux@gmail.com>
 <c745f67e-91e6-4a32-93f2-dc715056eb51@linux.dev>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <c745f67e-91e6-4a32-93f2-dc715056eb51@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Nov 29, 2023 at 10:50:57PM +0800, Zhu Yanjun wrote:
> 在 2023/5/26 13:46, Liang Chen 写道:


what made you respond to a patch from May, now?

-- 
MST

