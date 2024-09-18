Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7D018B49B
	for <virtualization@lists.linux-foundation.org>; Wed, 18 Sep 2024 13:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726665459; cv=none; b=BHq596v9A6IaaRlGghTg5kURJAfoq1MUhKpjz0EEH4+oXmWDQcm8cnIUQ6DvtZGvQLL1otpYacFw3nw4FFeKhV8qCm1WrieRLGiMw34G2bDQXBlHviLi5Wmupss7pvHD6PX36WqKJov0oTfW4rV1Cfjt9mHWDbShY3U8Pvl/gxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726665459; c=relaxed/simple;
	bh=ddiVg/ZCof9Fc8Z6/UQWstr/Rfs/55bGs9nMmSabZqk=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=EoquNCJmy3OAuhtFFWwxpihTtQXFkbONcfW3ELJ91GnWHkWyOKsTBiG1Tvrg5/CkLPEMQRlqHFO5As7Z+cS+wp80Ucuupoz0fT48KVMPRqhKQdDPw9cMmVGgZr7AfvnBE4C8YSX+dA1LPA3xCWyNCWz4m/huCmSWE806koJfxPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1CwsQyf; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1CwsQyf"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06ED7844B5
	for <virtualization@lists.linux-foundation.org>; Wed, 18 Sep 2024 13:17:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o8OcGJmjsGZO for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Sep 2024 13:17:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::c29; helo=mail-oo1-xc29.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B8414844A4
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B8414844A4
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=C1CwsQyf
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B8414844A4
	for <virtualization@lists.linux-foundation.org>; Wed, 18 Sep 2024 13:17:35 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-5dfad5a9c21so3398094eaf.0
        for <virtualization@lists.linux-foundation.org>; Wed, 18 Sep 2024 06:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726665454; x=1727270254; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+AjcnUWrTvMalvFIvUO/yMFteny0ikqJRqvvIOwdmY=;
        b=C1CwsQyfLTZ5X5xQBrAAJZC53rIDR2Fm8do3nG4oCzUyk4UkojbEnNoeUgTpWk5QHj
         D8EvxX84lD64TD/lPAZZmns5pYDL+aleKVDOaY+xA8Hw4HTWeHkVBsLJap7W7xI07vxP
         37mhi7RluhDSdHjQ94Jzmn7F81F3mHBQQM4wNZibymsgc5bigqjlg2CTo58V6LVS6rWu
         NVrZ6Nt10VHDRNmUJ1Dhz4X1g/w+DHI1EDLjJ3dlABKaGX1iauV9gm/8x/sal1j3OcYN
         rtVTBWzfXTXeV7fSmV5m9HX84gqDzyDKQDh+UEclGTD5Tr1Z1dbFO6I1OCo/yTBi3m6D
         EArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726665454; x=1727270254;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+AjcnUWrTvMalvFIvUO/yMFteny0ikqJRqvvIOwdmY=;
        b=wxOEjrO2VXr0aqa0Iexu7gwfsOK54euPWkotGTbjVkgSUgwIilM8AHxB/gW/uxAULJ
         sMD2a682wMDHswUEjfGVcSK2BtRJxQU26QPqji1V5OGtJ+tv2aqBijV1iXk+Ypt+nEI1
         BU2hI3LK+M+F/d3Debb7RxtfcaxqQABkrYXTKZ3qvdjCp/2tI9ez41QZEvKZKhQwjWrv
         oBZLRjnDYMWblDF7y7bL4sNm1O+dI9fmKyeEf+gMOuyios8d1Jt50lThuSpQF3UA6EJN
         gk6Q/7zCTlWfM6WCaoGh4M1sP4X9pXjizKixA6L1xs9TfoWeAMSYrV48nrYtdQyYd0+3
         8wPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3MxyAVSIa/0H/X9456a/lKxyLrkPYRWa3cQZCgUGvkimAY3lumNCiWQWSoYlL7vEiv9a5k01+8KQznG1WiA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yw5RaQvWt+a48RLuuQkgZ0i/iNgBy2iAoXT/YeiGORQfCc2sXGX
	1So+Z+OjeHflIMAgjPt4kh5wg4I/jiOESDxAcr+Iozi/N3EfnXzP
X-Google-Smtp-Source: AGHT+IEt2gQ+5dsw6SHDyvOzeq6o0BOI0FdXwXlSspRz1PzHxr5y+AkqJhqweY9iUcUOU8bkua4aPA==
X-Received: by 2002:a05:6358:7247:b0:1b1:ac7f:51d5 with SMTP id e5c5f4694b2df-1bb23dd2f6bmr937437755d.22.1726665453816;
        Wed, 18 Sep 2024 06:17:33 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ab3e95bce0sm456519385a.3.2024.09.18.06.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 06:17:33 -0700 (PDT)
Date: Wed, 18 Sep 2024 09:17:32 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, 
 linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <66ead2ecddf14_29b986294d5@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240915-rss-v3-6-c630015db082@daynix.com>
References: <20240915-rss-v3-0-c630015db082@daynix.com>
 <20240915-rss-v3-6-c630015db082@daynix.com>
Subject: Re: [PATCH RFC v3 6/9] tun: Introduce virtio-net hash reporting
 feature
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Akihiko Odaki wrote:
> Allow the guest to reuse the hash value to make receive steering
> consistent between the host and guest, and to save hash computation.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  Documentation/networking/tuntap.rst |   7 ++
>  drivers/net/Kconfig                 |   1 +
>  drivers/net/tun.c                   | 146 +++++++++++++++++++++++++++++++-----
>  include/uapi/linux/if_tun.h         |  44 +++++++++++
>  4 files changed, 180 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/networking/tuntap.rst b/Documentation/networking/tuntap.rst
> index 4d7087f727be..86b4ae8caa8a 100644
> --- a/Documentation/networking/tuntap.rst
> +++ b/Documentation/networking/tuntap.rst
> @@ -206,6 +206,13 @@ enable is true we enable it, otherwise we disable it::
>        return ioctl(fd, TUNSETQUEUE, (void *)&ifr);
>    }
>  
> +3.4 Reference
> +-------------
> +
> +``linux/if_tun.h`` defines the interface described below:
> +
> +.. kernel-doc:: include/uapi/linux/if_tun.h
> +
>  Universal TUN/TAP device driver Frequently Asked Question
>  =========================================================
>  
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 9920b3a68ed1..e2a7bd703550 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -395,6 +395,7 @@ config TUN
>  	tristate "Universal TUN/TAP device driver support"
>  	depends on INET
>  	select CRC32
> +	select SKB_EXTENSIONS
>  	help
>  	  TUN/TAP provides packet reception and transmission for user space
>  	  programs.  It can be viewed as a simple Point-to-Point or Ethernet
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 9d93ab9ee58f..b8fcd71becac 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -173,6 +173,10 @@ struct tun_prog {
>  	struct bpf_prog *prog;
>  };
>  
> +struct tun_vnet_hash_container {
> +	struct tun_vnet_hash common;
> +};
> +
>  /* Since the socket were moved to tun_file, to preserve the behavior of persist
>   * device, socket filter, sndbuf and vnet header size were restore when the
>   * file were attached to a persist device.
> @@ -210,6 +214,7 @@ struct tun_struct {
>  	struct bpf_prog __rcu *xdp_prog;
>  	struct tun_prog __rcu *steering_prog;
>  	struct tun_prog __rcu *filter_prog;
> +	struct tun_vnet_hash_container __rcu *vnet_hash;

This is just

+struct tun_vnet_hash {
+       u32 value;
+       u16 report;
+};

Can just be fields in the struct directly.

Also, only one bit really used for report, so probably can be
condensed further.

>  	struct ethtool_link_ksettings link_ksettings;
>  	/* init args */
>  	struct file *file;
> @@ -221,6 +226,11 @@ struct veth {
>  	__be16 h_vlan_TCI;
>  };
>  
> +static const struct tun_vnet_hash tun_vnet_hash_cap = {
> +	.flags = TUN_VNET_HASH_REPORT,
> +	.types = VIRTIO_NET_SUPPORTED_HASH_TYPES
> +};
> +
>  static void tun_flow_init(struct tun_struct *tun);
>  static void tun_flow_uninit(struct tun_struct *tun);
>  
> @@ -322,10 +332,17 @@ static long tun_set_vnet_be(struct tun_struct *tun, int __user *argp)
>  	if (get_user(be, argp))
>  		return -EFAULT;
>  
> -	if (be)
> +	if (be) {
> +		struct tun_vnet_hash_container *vnet_hash = rtnl_dereference(tun->vnet_hash);
> +
> +		if (!(tun->flags & TUN_VNET_LE) &&
> +		    vnet_hash && (vnet_hash->flags & TUN_VNET_HASH_REPORT))
> +			return -EBUSY;
> +

Doesn't be here imply !tun->flags & TUN_VNET_LE? Same again below.

>  		tun->flags |= TUN_VNET_BE;
> -	else
> +	} else {
>  		tun->flags &= ~TUN_VNET_BE;
> +	}
>  
>  	return 0;
>  }
> @@ -522,14 +539,20 @@ static inline void tun_flow_save_rps_rxhash(struct tun_flow_entry *e, u32 hash)
>   * the userspace application move between processors, we may get a
>   * different rxq no. here.
>   */
> -static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
> +static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb,
> +				   const struct tun_vnet_hash_container *vnet_hash)
>  {
> +	struct tun_vnet_hash_ext *ext;
> +	struct flow_keys keys;
>  	struct tun_flow_entry *e;
>  	u32 txq, numqueues;
>  
>  	numqueues = READ_ONCE(tun->numqueues);
>  
> -	txq = __skb_get_hash_symmetric(skb);
> +	memset(&keys, 0, sizeof(keys));
> +	skb_flow_dissect(skb, &flow_keys_dissector_symmetric, &keys, 0);
> +
> +	txq = flow_hash_from_keys(&keys);
>  	e = tun_flow_find(&tun->flows[tun_hashfn(txq)], txq);
>  	if (e) {
>  		tun_flow_save_rps_rxhash(e, txq);
> @@ -538,6 +561,16 @@ static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
>  		txq = reciprocal_scale(txq, numqueues);
>  	}
>  
> +	if (vnet_hash && (vnet_hash->common.flags & TUN_VNET_HASH_REPORT)) {
> +		ext = skb_ext_add(skb, SKB_EXT_TUN_VNET_HASH);
> +		if (ext) {
> +			u32 types = vnet_hash->common.types;
> +
> +			ext->report = virtio_net_hash_report(types, keys.basic);
> +			ext->value = skb->l4_hash ? skb->hash : txq;
> +		}
> +	}
> +
>  	return txq;
>  }
>  
> @@ -565,10 +598,13 @@ static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
>  	u16 ret;
>  
>  	rcu_read_lock();
> -	if (rcu_dereference(tun->steering_prog))
> +	if (rcu_dereference(tun->steering_prog)) {
>  		ret = tun_ebpf_select_queue(tun, skb);
> -	else
> -		ret = tun_automq_select_queue(tun, skb);
> +	} else {
> +		struct tun_vnet_hash_container *vnet_hash = rcu_dereference(tun->vnet_hash);
> +
> +		ret = tun_automq_select_queue(tun, skb, vnet_hash);

Already passing tun, no need to pass tun->vnet_hash separately.
> +	}
>  	rcu_read_unlock();
>  
>  	return ret;
> @@ -2120,33 +2156,63 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>  	}
>  
>  	if (vnet_hdr_sz) {
> -		struct virtio_net_hdr gso;
> +		struct tun_vnet_hash_ext *ext;
> +		size_t vnet_hdr_content_sz = sizeof(struct virtio_net_hdr);
> +		union {
> +			struct virtio_net_hdr hdr;
> +			struct virtio_net_hdr_v1_hash hdr_v1_hash;
> +		} vnet_hdr;
> +		int ret;
>  
>  		if (iov_iter_count(iter) < vnet_hdr_sz)
>  			return -EINVAL;
>  
> -		if (virtio_net_hdr_from_skb(skb, &gso,
> -					    tun_is_little_endian(tun), true,
> -					    vlan_hlen)) {
> +		ext = vnet_hdr_sz < sizeof(vnet_hdr.hdr_v1_hash) ?
> +		      NULL : skb_ext_find(skb, SKB_EXT_TUN_VNET_HASH);
> +
> +		if (ext) {
> +			struct virtio_net_hash hash = {
> +				.value = ext->value,
> +				.report = ext->report,
> +			};
> +
> +			vnet_hdr_content_sz = sizeof(vnet_hdr.hdr_v1_hash);
> +			ret = virtio_net_hdr_v1_hash_from_skb(skb,
> +							      &vnet_hdr.hdr_v1_hash,
> +							      true,
> +							      vlan_hlen,
> +							      &hash);
> +		} else {
> +			vnet_hdr_content_sz = sizeof(struct virtio_net_hdr);
> +			ret = virtio_net_hdr_from_skb(skb,
> +						      &vnet_hdr.hdr,
> +						      tun_is_little_endian(tun),
> +						      true,
> +						      vlan_hlen);
> +		}
> +

This is why just setting the fields directly rather than adding
virtio_net_hdr_v1_hash_from_skb is actually simpler.

> +		if (ret) {
>  			struct skb_shared_info *sinfo = skb_shinfo(skb);
>  
>  			if (net_ratelimit()) {
>  				netdev_err(tun->dev, "unexpected GSO type: 0x%x, gso_size %d, hdr_len %d\n",
> -					   sinfo->gso_type, tun16_to_cpu(tun, gso.gso_size),
> -					   tun16_to_cpu(tun, gso.hdr_len));
> +					   sinfo->gso_type,
> +					   tun16_to_cpu(tun, vnet_hdr.hdr.gso_size),
> +					   tun16_to_cpu(tun, vnet_hdr.hdr.hdr_len));
>  				print_hex_dump(KERN_ERR, "tun: ",
>  					       DUMP_PREFIX_NONE,
>  					       16, 1, skb->head,
> -					       min((int)tun16_to_cpu(tun, gso.hdr_len), 64), true);
> +					       min(tun16_to_cpu(tun, vnet_hdr.hdr.hdr_len), 64),
> +					       true);
>  			}
>  			WARN_ON_ONCE(1);
>  			return -EINVAL;
>  		}
>  
> -		if (copy_to_iter(&gso, sizeof(gso), iter) != sizeof(gso))
> +		if (copy_to_iter(&vnet_hdr, vnet_hdr_content_sz, iter) != vnet_hdr_content_sz)
>  			return -EFAULT;
>  
> -		iov_iter_zero(vnet_hdr_sz - sizeof(gso), iter);
> +		iov_iter_zero(vnet_hdr_sz - vnet_hdr_content_sz, iter);
>  	}
>  
>  	if (vlan_hlen) {
> @@ -3094,6 +3160,8 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>  	int le;
>  	int ret;
>  	bool do_notify = false;
> +	struct tun_vnet_hash vnet_hash_common;
> +	struct tun_vnet_hash_container *vnet_hash;
>  
>  	if (cmd == TUNSETIFF || cmd == TUNSETQUEUE ||
>  	    (_IOC_TYPE(cmd) == SOCK_IOC_TYPE && cmd != SIOCGSKNS)) {
> @@ -3115,6 +3183,9 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>  		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
>  			return -EPERM;
>  		return open_related_ns(&net->ns, get_net_ns);
> +	} else if (cmd == TUNGETVNETHASHCAP) {
> +		return copy_to_user(argp, &tun_vnet_hash_cap, sizeof(tun_vnet_hash_cap)) ?
> +		       -EFAULT : 0;
>  	}
>  
>  	rtnl_lock();
> @@ -3314,6 +3385,13 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>  			break;
>  		}
>  
> +		vnet_hash = rtnl_dereference(tun->vnet_hash);
> +		if (vnet_hash && (vnet_hash->common.flags & TUN_VNET_HASH_REPORT) &&
> +		    vnet_hdr_sz < (int)sizeof(struct virtio_net_hdr_v1_hash)) {
> +			ret = -EBUSY;
> +			break;
> +		}
> +
>  		tun->vnet_hdr_sz = vnet_hdr_sz;
>  		break;
>  
> @@ -3328,10 +3406,18 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>  			ret = -EFAULT;
>  			break;
>  		}
> -		if (le)
> +		if (le) {
>  			tun->flags |= TUN_VNET_LE;
> -		else
> +		} else {
> +			vnet_hash = rtnl_dereference(tun->vnet_hash);
> +			if (vnet_hash && (vnet_hash->common.flags & TUN_VNET_HASH_REPORT) &&
> +			    !tun_legacy_is_little_endian(tun)) {
> +				ret = -EBUSY;
> +				break;
> +			}
> +
>  			tun->flags &= ~TUN_VNET_LE;
> +		}
>  		break;
>  
>  	case TUNGETVNETBE:
> @@ -3396,6 +3482,30 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>  		ret = open_related_ns(&net->ns, get_net_ns);
>  		break;
>  
> +	case TUNSETVNETHASH:
> +		if (copy_from_user(&vnet_hash_common, argp, sizeof(vnet_hash_common))) {
> +			ret = -EFAULT;
> +			break;
> +		}
> +		argp = (struct tun_vnet_hash __user *)argp + 1;
> +
> +		if ((vnet_hash_common.flags & TUN_VNET_HASH_REPORT) &&
> +		    (tun->vnet_hdr_sz < sizeof(struct virtio_net_hdr_v1_hash) ||
> +		     !tun_is_little_endian(tun))) {
> +			ret = -EBUSY;
> +			break;
> +		}
> +
> +		vnet_hash = kmalloc(sizeof(vnet_hash->common), GFP_KERNEL);
> +		if (!vnet_hash) {
> +			ret = -ENOMEM;
> +			break;
> +		}
> +
> +		vnet_hash->common = vnet_hash_common;
> +		kfree_rcu_mightsleep(rcu_replace_pointer_rtnl(tun->vnet_hash, vnet_hash));
> +		break;
> +
>  	default:
>  		ret = -EINVAL;
>  		break;
> diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
> index 287cdc81c939..1561e8ce0a0a 100644
> --- a/include/uapi/linux/if_tun.h
> +++ b/include/uapi/linux/if_tun.h
> @@ -62,6 +62,30 @@
>  #define TUNSETCARRIER _IOW('T', 226, int)
>  #define TUNGETDEVNETNS _IO('T', 227)
>  
> +/**
> + * define TUNGETVNETHASHCAP - ioctl to get virtio_net hashing capability.
> + *
> + * The argument is a pointer to &struct tun_vnet_hash which will store the
> + * maximal virtio_net hashing configuration.
> + */
> +#define TUNGETVNETHASHCAP _IOR('T', 228, struct tun_vnet_hash)
> +
> +/**
> + * define TUNSETVNETHASH - ioctl to configure virtio_net hashing
> + *
> + * The argument is a pointer to &struct tun_vnet_hash.
> + *
> + * %TUNSETVNETHDRSZ ioctl must be called with a number greater than or equal to
> + * the size of &struct virtio_net_hdr_v1_hash before calling this ioctl with
> + * %TUN_VNET_HASH_REPORT.
> + *
> + * The virtio_net header must be configured as little-endian before calling this
> + * ioctl with %TUN_VNET_HASH_REPORT.
> + *
> + * This ioctl currently has no effect on XDP packets.
> + */
> +#define TUNSETVNETHASH _IOW('T', 229, struct tun_vnet_hash)
> +
>  /* TUNSETIFF ifr flags */
>  #define IFF_TUN		0x0001
>  #define IFF_TAP		0x0002
> @@ -115,4 +139,24 @@ struct tun_filter {
>  	__u8   addr[][ETH_ALEN];
>  };
>  
> +/**
> + * define TUN_VNET_HASH_REPORT - Request virtio_net hash reporting for vhost
> + */
> +#define TUN_VNET_HASH_REPORT	0x0001
> +
> +/**
> + * struct tun_vnet_hash - virtio_net hashing configuration
> + * @flags:
> + *		Bitmask consists of %TUN_VNET_HASH_REPORT and %TUN_VNET_HASH_RSS
> + * @pad:
> + *		Should be filled with zero before passing to %TUNSETVNETHASH
> + * @types:
> + *		Bitmask of allowed hash types
> + */
> +struct tun_vnet_hash {
> +	__u16 flags;
> +	__u8 pad[2];
> +	__u32 types;
> +};
> +

The values for flags and types should probably be defined here.

>  #endif /* _UAPI__IF_TUN_H */
> 
> -- 
> 2.46.0
> 


