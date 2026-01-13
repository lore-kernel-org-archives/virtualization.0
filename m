Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3CD38BDD0
	for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768316963; cv=none; b=ae9ti7eONjjcDFICKJNweQmqfvFoao8gfRa/ntpV+hSPyP05LyXyCdFeWPUlfDkzJGKGDkL2ewzI03xpVbsPl5m9aIxt4GY+3/nH7HTPGQIMSGk08emkb6S4imXQP7e9DHXW9XzuBLSrBser+oJWa5IHiOG8HCrrvuRmoonkS84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768316963; c=relaxed/simple;
	bh=3zXEgrW72T0HFBYPdNsvotJZJOcjsWCZn/aiSz49gwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=oQJ78rEXTooOHs0SibIcy8vxM72lG8MQnMNvG7g9+zu5/Rp7uv2JwIcg9y3Z3S193M7YilvnbKxksMS9lGvywvzD5vPSb1JkiRMOYZcKT0Co3kiUJ6/0HsyZVTZlzXAMmdQArHeC2yJm4uV541hjYy1x81e/KZimbwbxPGM41Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HSYT/tKt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HSYT/tKt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768316961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Iv7jtHfyu2FIw37q1VMrstnC0/mkNFUj9G8Fyvhg8A=;
	b=HSYT/tKtT6SOPGqCU4tVKZ9cIMHb3EZAd4xAKXCZKeOhBjXkiW6IxOBEOJwQExE0hS1CLT
	CaOMZvfgXtoMKYf7olMndZnJR8In4ZY17PGzzmBg0TzsoAE9Z8vxOmQcAcj9whp4v+y2oS
	9vu7ftSOYM/ObwOApqnGAfBdWpt3nj8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-Yhg5G5BaP-WLqytweWWh6g-1; Tue, 13 Jan 2026 10:09:17 -0500
X-MC-Unique: Yhg5G5BaP-WLqytweWWh6g-1
X-Mimecast-MFC-AGG-ID: Yhg5G5BaP-WLqytweWWh6g_1768316956
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4775e00b16fso59677645e9.2
        for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 07:09:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768316956; x=1768921756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Iv7jtHfyu2FIw37q1VMrstnC0/mkNFUj9G8Fyvhg8A=;
        b=KNuzE+gzVUrRQrgNRU3W/ZtWfbTVUlM2mraUBca9ELMM1+z46v6qBJH9shdO9anMsp
         m0QN6gFfF2N5GtSFNSe1np2TaTMmRgsWvqbsipWzDmLvS57ez6JuHf+feebIwWzln/eY
         xOo+/gqzyBGFOd1g01tZ7FAdAWOyw6TJYkco8BvLQ4/PpHmFUMapKTvHZyEmO8TJ9mV1
         2B8B26Pj5ILNmrGxthPHSbW8F2Tgc6RjUKhs+JX0oT3wLOmc8uPDkgPRZiql1IWTv7DD
         fx/2AUTw7Bm9hCqwXeqeqc9dT/qM2DbXd59wCH2eDWV+ef3tsJWGPWq39WkY8K3m14YW
         3Iuw==
X-Forwarded-Encrypted: i=1; AJvYcCUcqciRs+OD1wqpVGCtUws/zUp/6yhjfcSx1TDas02rHQ7cZBweHjiC2bVCZKO5G/HGqdSG+6QsKm0P66Yogw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQAyHZcc1udELmAq4gG/41dPeX+8u7DLmXEXZDm8MyCAhqaEWb
	/ejo6wZyLR9nKYHIB7ttzEdpPiz0rtu91BTvsR/UKB/leTumOUr+O8cwVwyy+8BCekBQ/4B43PM
	jDeb7EpM9Mct0qcFSl0oR3o9uv8Y7UovoHpJRobU/jifnfLe/hmT3yRC9Btu4yiC0OeJd
X-Gm-Gg: AY/fxX7xzKGQI5fb9cEICKYkkiufQahjkTGP42Yw4hXPzV9/lfL9PqVXJWEK3aBc8bq
	qJnm+DUjlZcFWkPYSw2cJ5WOmlcgpQmcBmI0sZY2vSpaFkgInkdUxb0mOifDbGIX6PMBhFWVCfb
	V0I69MUvI2UeujLs5le6ZhGD1QGIFFFbh6QZCJAieJhcojvXDxWvacWq7swwLQeNGSxb7AaVA/G
	cuAYxoZveZ7iTTudauPCleukWqpXOam/GoEB04weFYjmldCkeYmwKRbMMjLzHB9bZRsBE7uLzoV
	re4/9prsMmKTrq5b6IrMsSN19P0rkZaB2g8iOLA6XHmB/XQ6T43JKH2ovzjAH4wkilJz5E8UcfK
	FNnw3bh7kIaCi+pfOetoRdHliNqKnKSE=
X-Received: by 2002:a05:600c:37ce:b0:477:7ab8:aba with SMTP id 5b1f17b1804b1-47d84b18ee1mr256230535e9.1.1768316956294;
        Tue, 13 Jan 2026 07:09:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIU9tLi+rd1piE3qCw9ltmh0taJcQjyrQSmq1XLBBBIKhKDikjGjztln4jAEzKC9qSMm64QA==
X-Received: by 2002:a05:600c:37ce:b0:477:7ab8:aba with SMTP id 5b1f17b1804b1-47d84b18ee1mr256230115e9.1.1768316955786;
        Tue, 13 Jan 2026 07:09:15 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47edee4cbc2sm18216645e9.4.2026.01.13.07.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 07:09:15 -0800 (PST)
Date: Tue, 13 Jan 2026 10:09:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2][next] virtio_net: Fix misalignment bug in struct
 virtnet_info
Message-ID: <20260113100902-mutt-send-email-mst@kernel.org>
References: <aWIItWq5dV9XTTCJ@kspp>
 <e9607915-892c-4724-b97f-7c90918f86fe@redhat.com>
 <20260113093839-mutt-send-email-mst@kernel.org>
 <916a6c1a-681e-4e5e-8d49-75d0de5c46a1@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <916a6c1a-681e-4e5e-8d49-75d0de5c46a1@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LEAQu3QnekIcvTwEQD3Wj4BF_ZixYzi1OjwutUkBG1E_1768316956
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 13, 2026 at 04:06:05PM +0100, Paolo Abeni wrote:
> On 1/13/26 3:39 PM, Michael S. Tsirkin wrote:
> > On Tue, Jan 13, 2026 at 03:30:00PM +0100, Paolo Abeni wrote:
> >> On 1/10/26 9:07 AM, Gustavo A. R. Silva wrote:
> >>> Use the new TRAILING_OVERLAP() helper to fix a misalignment bug
> >>> along with the following warning:
> >>>
> >>> drivers/net/virtio_net.c:429:46: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> >>>
> >>> This helper creates a union between a flexible-array member (FAM)
> >>> and a set of members that would otherwise follow it (in this case
> >>> `u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];`). This
> >>> overlays the trailing members (rss_hash_key_data) onto the FAM
> >>> (hash_key_data) while keeping the FAM and the start of MEMBERS aligned.
> >>> The static_assert() ensures this alignment remains.
> >>>
> >>> Notice that due to tail padding in flexible `struct
> >>> virtio_net_rss_config_trailer`, `rss_trailer.hash_key_data`
> >>> (at offset 83 in struct virtnet_info) and `rss_hash_key_data` (at
> >>> offset 84 in struct virtnet_info) are misaligned by one byte. See
> >>> below:
> >>>
> >>> struct virtio_net_rss_config_trailer {
> >>>         __le16                     max_tx_vq;            /*     0     2 */
> >>>         __u8                       hash_key_length;      /*     2     1 */
> >>>         __u8                       hash_key_data[];      /*     3     0 */
> >>>
> >>>         /* size: 4, cachelines: 1, members: 3 */
> >>>         /* padding: 1 */
> >>>         /* last cacheline: 4 bytes */
> >>> };
> >>>
> >>> struct virtnet_info {
> >>> ...
> >>>         struct virtio_net_rss_config_trailer rss_trailer; /*    80     4 */
> >>>
> >>>         /* XXX last struct has 1 byte of padding */
> >>>
> >>>         u8                         rss_hash_key_data[40]; /*    84    40 */
> >>> ...
> >>>         /* size: 832, cachelines: 13, members: 48 */
> >>>         /* sum members: 801, holes: 8, sum holes: 31 */
> >>>         /* paddings: 2, sum paddings: 5 */
> >>> };
> >>>
> >>> After changes, those members are correctly aligned at offset 795:
> >>>
> >>> struct virtnet_info {
> >>> ...
> >>>         union {
> >>>                 struct virtio_net_rss_config_trailer rss_trailer; /*   792     4 */
> >>>                 struct {
> >>>                         unsigned char __offset_to_hash_key_data[3]; /*   792     3 */
> >>>                         u8         rss_hash_key_data[40]; /*   795    40 */
> >>>                 };                                       /*   792    43 */
> >>>         };                                               /*   792    44 */
> >>> ...
> >>>         /* size: 840, cachelines: 14, members: 47 */
> >>>         /* sum members: 801, holes: 8, sum holes: 35 */
> >>>         /* padding: 4 */
> >>>         /* paddings: 1, sum paddings: 4 */
> >>>         /* last cacheline: 8 bytes */
> >>> };
> >>>
> >>> As a result, the RSS key passed to the device is shifted by 1
> >>> byte: the last byte is cut off, and instead a (possibly
> >>> uninitialized) byte is added at the beginning.
> >>>
> >>> As a last note `struct virtio_net_rss_config_hdr *rss_hdr;` is also
> >>> moved to the end, since it seems those three members should stick
> >>> around together. :)
> >>>
> >>> Cc: stable@vger.kernel.org
> >>> Fixes: ed3100e90d0d ("virtio_net: Use new RSS config structs")
> >>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> >>> ---
> >>> Changes in v2:
> >>>  - Update subject and changelog text (include feedback from Simon and
> >>>    Michael --thanks folks)
> >>>  - Add Fixes tag and CC -stable.
> >>
> >> @Michael, @Jason: This is still apparently targeting 'net-next', but I
> >> think it should land in the 'net' tree, right?
> >>
> >> /P
> > 
> > Probably but I'm yet to properly review it. The thing that puzzles me at
> > a first glance is how are things working right now then?
> 
> Apparently they aren't ?!?
> 
> rss self-tests for virtio_net are failing:
> 
> https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/471521/15-rss-api-py/stdout
> 
> but the result is into the CI reported as success (no idea why?!?)
> 
> /P

and this fixes it?

