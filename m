Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5B618A92F
	for <virtualization@lists.linux-foundation.org>; Wed, 18 Sep 2024 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726666139; cv=none; b=RsPp0sNcacRQ/MhmCzPExJVci5qKs2cW99Kyv2v6lYTLANnLoTwUhk0cz6Pbv2TnatXK9B1XgL4F9PeXyMB4ZWJRa6NMRpo0T7DpxdKSVWwFfBqijqijOfz92CEsNWZS5fihcy5azaTS9QUTxlzj1RC+b+TrReM3hlQU1xkXl88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726666139; c=relaxed/simple;
	bh=pwJlgZdNvaHAu3h2V42KKywDFQy+3s/ezLpfFC9KxPY=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hfsbm/K0AMd/1M6X4PDlSL53FLwDs1Q5B1Wni8Wtm2PR/9bhjjQ5J166gG4nleCVzdPd0DbDmF/B+m/Af5V+rpuE2AFXt1gPdc/mI2x+4O4HA+wtleGravezKu84olL6Bqoh1IZim1rl54PEDclqHpyEEArKSZj+RV//eWP/D2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=je/spY7y; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="je/spY7y"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6872140460
	for <virtualization@lists.linux-foundation.org>; Wed, 18 Sep 2024 13:28:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id suTB1lMmLWCg for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Sep 2024 13:28:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::735; helo=mail-qk1-x735.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D4B5F4025F
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D4B5F4025F
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=je/spY7y
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D4B5F4025F
	for <virtualization@lists.linux-foundation.org>; Wed, 18 Sep 2024 13:28:55 +0000 (UTC)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7a99e8ad977so537551685a.3
        for <virtualization@lists.linux-foundation.org>; Wed, 18 Sep 2024 06:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726666134; x=1727270934; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PO6xXVZwg8yPwq6+RoXJWv7tBdE1qoSkPyC9pmm5es0=;
        b=je/spY7yvJPdWEEFJ9d4V94TcBu3ziGv+h7/pbB4WQsavgHMoN3Y/qm/cyZH2uM8rT
         gtZh9IDwteUU4nSgn+Dwm7w+Fp/NP2APLXonPs0OvTV31FYZMVXefn07BHF1Uj0NtFFW
         un7qZNkuNwJ6E8jLg9GB/d6AZe4mtgBo6Yk4lxAQsWr+FXr7aT/XBW9jDLFKdE17Bycp
         hL4MNfpwGPdKXrFHfrjUfU8M+fXutDrxPFIR1OiOlR66kRR2mM80lvEc654Ui1SLsXRx
         2PVh7W+PNO/PwsOvrvtzFuRcR/H3DgbfEkEqNFn0JmRIpyMPezcNrLRiu34i+V0tdy8E
         +W1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726666134; x=1727270934;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PO6xXVZwg8yPwq6+RoXJWv7tBdE1qoSkPyC9pmm5es0=;
        b=g1L+B7tA8kaaGfv1r12USC/srVWx3LwXFvsfTlAgRsrqtclGfbMEeYyaaoGupkbUxY
         egRXvzS6alQChaZPO5WG4QV9RNLFVuKU4fITPmnhIWpveGB8N8w1HqV7bYI5VLa0vRDZ
         cr3YhLi2p5oJ5sxLpmT2UykBoOuUsSmD/ihyPs4rsbhGbhue7u91FoKK3upAx3O0GSRd
         MkA/4CcCFoP1i78HioK7av0rJd2tIY/ftd5kELcIHZWFcw/RgnWqbCXUQ4AemRhBIGtn
         kevAFl3w5UBQQa5HdIEKLstjWwPnQWImeQRqXkTEd+FD1HDmfssUSWuaQjAjCAI6gF0T
         EGkA==
X-Forwarded-Encrypted: i=1; AJvYcCU8P/sPcGWaPJCmEx2DYxkEFdWezN8tEd0se4ft9lPrb4lzMlwBbRYshhmvHkcNNoMfQoQjSas9cBXM1hyq1w==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwlQD5eDUKYQWZYANmO4Kav4vF6eNEvMK4d4odUD8rzqbcD9ddH
	LxigfVXn0ZVzKl8cZk3/X4vNq+ZZm3HNcnK+pOM2g0eNOP7hpL7E
X-Google-Smtp-Source: AGHT+IF2vrnj8K+gBg3usSPHeVczA2J4fMnkbmh5Atajbjfn/KMfDGU5V+YBStG+Z6nUgN9dEpud+g==
X-Received: by 2002:a05:620a:44c4:b0:79f:a82:51b6 with SMTP id af79cd13be357-7a9e5f2e718mr3258828885a.37.1726666134258;
        Wed, 18 Sep 2024 06:28:54 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ab3e996c71sm458125985a.48.2024.09.18.06.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 06:28:53 -0700 (PDT)
Date: Wed, 18 Sep 2024 09:28:53 -0400
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
Message-ID: <66ead59563da7_29b98629486@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240915-rss-v3-7-c630015db082@daynix.com>
References: <20240915-rss-v3-0-c630015db082@daynix.com>
 <20240915-rss-v3-7-c630015db082@daynix.com>
Subject: Re: [PATCH RFC v3 7/9] tun: Introduce virtio-net RSS
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
> RSS is a receive steering algorithm that can be negotiated to use with
> virtio_net. Conventionally the hash calculation was done by the VMM.
> However, computing the hash after the queue was chosen defeats the
> purpose of RSS.
> 
> Another approach is to use eBPF steering program. This approach has
> another downside: it cannot report the calculated hash due to the
> restrictive nature of eBPF steering program.
> 
> Introduce the code to perform RSS to the kernel in order to overcome
> thse challenges. An alternative solution is to extend the eBPF steering
> program so that it will be able to report to the userspace, but I didn't
> opt for it because extending the current mechanism of eBPF steering
> program as is because it relies on legacy context rewriting, and
> introducing kfunc-based eBPF will result in non-UAPI dependency while
> the other relevant virtualization APIs such as KVM and vhost_net are
> UAPIs.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  drivers/net/tun.c           | 119 +++++++++++++++++++++++++++++++++++++++-----
>  include/uapi/linux/if_tun.h |  27 ++++++++++
>  2 files changed, 133 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index b8fcd71becac..5a429b391144 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -175,6 +175,9 @@ struct tun_prog {
>  
>  struct tun_vnet_hash_container {
>  	struct tun_vnet_hash common;
> +	struct tun_vnet_hash_rss rss;
> +	__be32 rss_key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> +	u16 rss_indirection_table[];
>  };
>  
>  /* Since the socket were moved to tun_file, to preserve the behavior of persist
> @@ -227,7 +230,7 @@ struct veth {
>  };
>  
>  static const struct tun_vnet_hash tun_vnet_hash_cap = {
> -	.flags = TUN_VNET_HASH_REPORT,
> +	.flags = TUN_VNET_HASH_REPORT | TUN_VNET_HASH_RSS,
>  	.types = VIRTIO_NET_SUPPORTED_HASH_TYPES
>  };
>  
> @@ -591,6 +594,36 @@ static u16 tun_ebpf_select_queue(struct tun_struct *tun, struct sk_buff *skb)
>  	return ret % numqueues;
>  }
>  
> +static u16 tun_vnet_rss_select_queue(struct tun_struct *tun,
> +				     struct sk_buff *skb,
> +				     const struct tun_vnet_hash_container *vnet_hash)
> +{
> +	struct tun_vnet_hash_ext *ext;
> +	struct virtio_net_hash hash;
> +	u32 numqueues = READ_ONCE(tun->numqueues);
> +	u16 txq, index;
> +
> +	if (!numqueues)
> +		return 0;
> +
> +	if (!virtio_net_hash_rss(skb, vnet_hash->common.types, vnet_hash->rss_key,
> +				 &hash))
> +		return vnet_hash->rss.unclassified_queue % numqueues;
> +
> +	if (vnet_hash->common.flags & TUN_VNET_HASH_REPORT) {
> +		ext = skb_ext_add(skb, SKB_EXT_TUN_VNET_HASH);
> +		if (ext) {
> +			ext->value = hash.value;
> +			ext->report = hash.report;
> +		}
> +	}
> +
> +	index = hash.value & vnet_hash->rss.indirection_table_mask;
> +	txq = READ_ONCE(vnet_hash->rss_indirection_table[index]);
> +
> +	return txq % numqueues;
> +}
> +
>  static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
>  			    struct net_device *sb_dev)
>  {
> @@ -603,7 +636,10 @@ static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
>  	} else {
>  		struct tun_vnet_hash_container *vnet_hash = rcu_dereference(tun->vnet_hash);
>  
> -		ret = tun_automq_select_queue(tun, skb, vnet_hash);
> +		if (vnet_hash && (vnet_hash->common.flags & TUN_VNET_HASH_RSS))
> +			ret = tun_vnet_rss_select_queue(tun, skb, vnet_hash);
> +		else
> +			ret = tun_automq_select_queue(tun, skb, vnet_hash);
>  	}
>  	rcu_read_unlock();
>  
> @@ -3085,13 +3121,9 @@ static int tun_set_queue(struct file *file, struct ifreq *ifr)
>  }
>  
>  static int tun_set_ebpf(struct tun_struct *tun, struct tun_prog __rcu **prog_p,
> -			void __user *data)
> +			int fd)
>  {
>  	struct bpf_prog *prog;
> -	int fd;
> -
> -	if (copy_from_user(&fd, data, sizeof(fd)))
> -		return -EFAULT;
>  
>  	if (fd == -1) {
>  		prog = NULL;
> @@ -3157,6 +3189,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>  	int ifindex;
>  	int sndbuf;
>  	int vnet_hdr_sz;
> +	int fd;
>  	int le;
>  	int ret;
>  	bool do_notify = false;
> @@ -3460,11 +3493,27 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>  		break;
>  
>  	case TUNSETSTEERINGEBPF:
> -		ret = tun_set_ebpf(tun, &tun->steering_prog, argp);
> +		if (get_user(fd, (int __user *)argp)) {
> +			ret = -EFAULT;
> +			break;
> +		}
> +
> +		vnet_hash = rtnl_dereference(tun->vnet_hash);
> +		if (fd != -1 && vnet_hash && (vnet_hash->common.flags & TUN_VNET_HASH_RSS)) {
> +			ret = -EBUSY;
> +			break;
> +		}
> +
> +		ret = tun_set_ebpf(tun, &tun->steering_prog, fd);
>  		break;
>  
>  	case TUNSETFILTEREBPF:
> -		ret = tun_set_ebpf(tun, &tun->filter_prog, argp);
> +		if (get_user(fd, (int __user *)argp)) {
> +			ret = -EFAULT;
> +			break;
> +		}
> +
> +		ret = tun_set_ebpf(tun, &tun->filter_prog, fd);
>  		break;
>  
>  	case TUNSETCARRIER:
> @@ -3496,10 +3545,54 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>  			break;
>  		}
>  
> -		vnet_hash = kmalloc(sizeof(vnet_hash->common), GFP_KERNEL);
> -		if (!vnet_hash) {
> -			ret = -ENOMEM;
> -			break;
> +		if (vnet_hash_common.flags & TUN_VNET_HASH_RSS) {
> +			struct tun_vnet_hash_rss rss;
> +			size_t indirection_table_size;
> +			size_t key_size;
> +			size_t size;
> +
> +			if (tun->steering_prog) {
> +				ret = -EBUSY;
> +				break;
> +			}
> +
> +			if (copy_from_user(&rss, argp, sizeof(rss))) {
> +				ret = -EFAULT;
> +				break;
> +			}
> +			argp = (struct tun_vnet_hash_rss __user *)argp + 1;
> +
> +			indirection_table_size = ((size_t)rss.indirection_table_mask + 1) * 2;

Why make uapi a mask rather than a length?

Also is there a upper length bounds sanity check for this input from
userspace?

> +			key_size = virtio_net_hash_key_length(vnet_hash_common.types);
> +			size = sizeof(*vnet_hash) + indirection_table_size + key_size;

key_size is included in sizeof(*vnet_hash), always
VIRTIO_NET_RSS_MAX_KEY_SIZE.
> +
> +			vnet_hash = kmalloc(size, GFP_KERNEL);
> +			if (!vnet_hash) {
> +				ret = -ENOMEM;
> +				break;
> +			}
> +
> +			if (copy_from_user(vnet_hash->rss_indirection_table,
> +					   argp, indirection_table_size)) {
> +				kfree(vnet_hash);
> +				ret = -EFAULT;
> +				break;
> +			}
> +			argp = (u16 __user *)argp + rss.indirection_table_mask + 1;
> +
> +			if (copy_from_user(vnet_hash->rss_key, argp, key_size)) {
> +				kfree(vnet_hash);
> +				ret = -EFAULT;
> +				break;
> +			}
> +
> +			vnet_hash->rss = rss;
> +		} else {
> +			vnet_hash = kmalloc(sizeof(vnet_hash->common), GFP_KERNEL);
> +			if (!vnet_hash) {
> +				ret = -ENOMEM;
> +				break;
> +			}
>  		}
>  
>  		vnet_hash->common = vnet_hash_common;
> diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
> index 1561e8ce0a0a..1c130409db5d 100644
> --- a/include/uapi/linux/if_tun.h
> +++ b/include/uapi/linux/if_tun.h
> @@ -75,6 +75,14 @@
>   *
>   * The argument is a pointer to &struct tun_vnet_hash.
>   *
> + * The argument is a pointer to the compound of the following in order if
> + * %TUN_VNET_HASH_RSS is set:
> + *
> + * 1. &struct tun_vnet_hash
> + * 2. &struct tun_vnet_hash_rss
> + * 3. Indirection table
> + * 4. Key
> + *
>   * %TUNSETVNETHDRSZ ioctl must be called with a number greater than or equal to
>   * the size of &struct virtio_net_hdr_v1_hash before calling this ioctl with
>   * %TUN_VNET_HASH_REPORT.
> @@ -144,6 +152,13 @@ struct tun_filter {
>   */
>  #define TUN_VNET_HASH_REPORT	0x0001
>  
> +/**
> + * define TUN_VNET_HASH_RSS - Request virtio_net RSS
> + *
> + * This is mutually exclusive with eBPF steering program.
> + */
> +#define TUN_VNET_HASH_RSS	0x0002
> +
>  /**
>   * struct tun_vnet_hash - virtio_net hashing configuration
>   * @flags:
> @@ -159,4 +174,16 @@ struct tun_vnet_hash {
>  	__u32 types;
>  };
>  
> +/**
> + * struct tun_vnet_hash_rss - virtio_net RSS configuration
> + * @indirection_table_mask:
> + *		Bitmask to be applied to the indirection table index
> + * @unclassified_queue:
> + *		The index of the queue to place unclassified packets in
> + */
> +struct tun_vnet_hash_rss {
> +	__u16 indirection_table_mask;
> +	__u16 unclassified_queue;
> +};
> +
>  #endif /* _UAPI__IF_TUN_H */
> 
> -- 
> 2.46.0
> 


