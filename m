Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D27C1531C0
	for <virtualization@lists.linux-foundation.org>; Sat, 12 Oct 2024 10:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728728950; cv=none; b=gPsbnV9GXOJiZu6HTYdNEnqDERvRSjKrHd4fcjBonKoqpR1xDL+SKvTP24hN3aZ6/PPS9hjK/f9e2vHpF2AbKeCo8eX1KQx1xqsGnjaQr5kGED/oB/rx/te7stXvF3pSFRHvnukXnhPhMTKBe8vNMy1Uqjd5Bx37S0rnDhtwtFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728728950; c=relaxed/simple;
	bh=WiKyN1r6GQqYAkFyHWEFvYWPIZ/lS/vplAE9Zn4Qw0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r4C8lChzeH96nUjXSkCU3aBt5qeRetkp+c+eBDpAItCOQ6u4C3vrx1bkfPVDzTDgqsisQ92gQI/bCPgAwWcw9IX0PVbOONVih1loseAlpC5OSKNjmCQ4gh/Lnxvv3mN9jzzkEMTNF5mF4XBdmM3jFPvCpQGgqZmHcixuwQSSwm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=qZr8/Mtl; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="qZr8/Mtl"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A8FC360668
	for <virtualization@lists.linux-foundation.org>; Sat, 12 Oct 2024 10:29:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r84BzyqXpYPt for <virtualization@lists.linux-foundation.org>;
 Sat, 12 Oct 2024 10:29:07 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2655C6064F
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2655C6064F
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=qZr8/Mtl
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2655C6064F
	for <virtualization@lists.linux-foundation.org>; Sat, 12 Oct 2024 10:29:06 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-20ca388d242so10509185ad.2
        for <virtualization@lists.linux-foundation.org>; Sat, 12 Oct 2024 03:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728728946; x=1729333746; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZvZvDBiukxFmcHL2yTtP3l73CJ9pdkN7XygsojY6f2k=;
        b=qZr8/MtlTS46jajdfS+muVqFKr9Z9CKECKNVrDt85LwMw3l3OE5ZQi0oNvPSoYPWSg
         RRkG8LU36kzUVdQSIA4VD6yfNzcPRnY7iZe+J//oogBWtJhvCEVRqwkg5upWxdfqYfay
         cDEOFxTLBC2BNOL+R7/sowqr3KEtYqCMG+pvoo/9n8LLe8ckfMG5BbEGOUVdZY1d8NbI
         ZhGOeluQnU0LMX20i38iMSVXyMqgAdovjeABo3kjaJzENWxk6WyrVcFwDAPAlaBV9U6t
         iPj2fp+lMJn/aCm4kwFX822/nJLLrJQz/wJqiMxKT6or3ejB6ZNkyFEiIjdBqtd+Eyvw
         vQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728728946; x=1729333746;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvZvDBiukxFmcHL2yTtP3l73CJ9pdkN7XygsojY6f2k=;
        b=ttg5GdsoCUA1Cl0OoFh0XEpoGvmdore1QERv4Qk4ufW3XKpMEoh/Y/3a+r/EcjCTZt
         +FVSK7BuBdZ87+zrHgSMkp8aGgg2wlO/WiyflRRerG7vMY1LVyf9+4UMaRBHjaUpRBpK
         3Jm/Hoz3vkOJii8XaRSEjl+I/I9yLIKUVb3fdaCZ7y4semhwuN/MtZnUHMO7orMw9+Rn
         WTssF3hI62jl/w+KtPCPs5TSwfe0J65Nsi3zGp8k09QJanh3PEJhMOSt/pF7Z9vWaBWg
         vJdAI1CEDtj2Wcg0ug15R7m5fxhzRwqGlkwo2cwRyxnulWZamL+A657aBxzQwFMLDEYE
         njBQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/ytzZnJzCgwltFICUH17kLa/1YqswwasxuNOXQCbelziv9GOMYLPRjrY6nOzkRaHdwnUvFGRX2TAqeD7ImQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yw7NoQ1+O7vjculoHQYzx0GahlJGRd1MeImCHdliZ8CA4nYNmlt
	ngELUU8d4ihsOIYu0c2LxblhPMh8DU4bdqZAiHQAOfUphS08a0nEJgrCZyGZQR8=
X-Google-Smtp-Source: AGHT+IHyzCVza25JQxIftgzAHdwfwKeAPPD4DPc7eG6fDIYxhlQN/1N003jTi2Dokjo73H9YOSYMxA==
X-Received: by 2002:a17:903:2342:b0:202:13ca:d73e with SMTP id d9443c01a7336-20cbb1a967emr40579705ad.28.1728728945900;
        Sat, 12 Oct 2024 03:29:05 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c215f0esm35124005ad.219.2024.10.12.03.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2024 03:29:05 -0700 (PDT)
Message-ID: <4bc7dfaa-a7cd-41f4-a917-e71b5c7241f7@daynix.com>
Date: Sat, 12 Oct 2024 19:29:01 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v5 07/10] tun: Introduce virtio-net RSS
To: Jason Wang <jasowang@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com
References: <20241008-rss-v5-0-f3cf68df005d@daynix.com>
 <20241008-rss-v5-7-f3cf68df005d@daynix.com>
 <CACGkMEsPNTr3zcstsQGoOiQdCFQ+6EG6cSGiZzNxONsH9Xm=Aw@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEsPNTr3zcstsQGoOiQdCFQ+6EG6cSGiZzNxONsH9Xm=Aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/10/09 17:14, Jason Wang wrote:
> On Tue, Oct 8, 2024 at 2:55 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> RSS is a receive steering algorithm that can be negotiated to use with
>> virtio_net. Conventionally the hash calculation was done by the VMM.
>> However, computing the hash after the queue was chosen defeats the
>> purpose of RSS.
>>
>> Another approach is to use eBPF steering program. This approach has
>> another downside: it cannot report the calculated hash due to the
>> restrictive nature of eBPF steering program.
>>
>> Introduce the code to perform RSS to the kernel in order to overcome
>> thse challenges. An alternative solution is to extend the eBPF steering
>> program so that it will be able to report to the userspace, but I didn't
>> opt for it because extending the current mechanism of eBPF steering
>> program as is because it relies on legacy context rewriting, and
>> introducing kfunc-based eBPF will result in non-UAPI dependency while
>> the other relevant virtualization APIs such as KVM and vhost_net are
>> UAPIs.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   drivers/net/tap.c           | 11 +++++-
>>   drivers/net/tun.c           | 57 ++++++++++++++++++++-------
>>   drivers/net/tun_vnet.h      | 96 +++++++++++++++++++++++++++++++++++++++++----
>>   include/linux/if_tap.h      |  4 +-
>>   include/uapi/linux/if_tun.h | 27 +++++++++++++
>>   5 files changed, 169 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
>> index 5e2fbe63ca47..a58b83285af4 100644
>> --- a/drivers/net/tap.c
>> +++ b/drivers/net/tap.c
>> @@ -207,6 +207,7 @@ static struct tap_queue *tap_get_queue(struct tap_dev *tap,
>>           * racing against queue removal.
>>           */
>>          int numvtaps = READ_ONCE(tap->numvtaps);
>> +       struct tun_vnet_hash_container *vnet_hash = rcu_dereference(tap->vnet_hash);
>>          __u32 rxq;
>>
>>          *tap_add_hash(skb) = (struct virtio_net_hash) { .report = VIRTIO_NET_HASH_REPORT_NONE };
>> @@ -217,6 +218,12 @@ static struct tap_queue *tap_get_queue(struct tap_dev *tap,
>>          if (numvtaps == 1)
>>                  goto single;
>>
>> +       if (vnet_hash && (vnet_hash->common.flags & TUN_VNET_HASH_RSS)) {
>> +               rxq = tun_vnet_rss_select_queue(numvtaps, vnet_hash, skb, tap_add_hash);
>> +               queue = rcu_dereference(tap->taps[rxq]);
>> +               goto out;
>> +       }
>> +
>>          if (!skb->l4_hash && !skb->sw_hash) {
>>                  struct flow_keys keys;
>>
>> @@ -234,7 +241,7 @@ static struct tap_queue *tap_get_queue(struct tap_dev *tap,
>>
>>          /* Check if we can use flow to select a queue */
>>          if (rxq) {
>> -               tun_vnet_hash_report(&tap->vnet_hash, skb, &keys_basic, rxq, tap_add_hash);
>> +               tun_vnet_hash_report(vnet_hash, skb, &keys_basic, rxq, tap_add_hash);
>>                  queue = rcu_dereference(tap->taps[rxq % numvtaps]);
>>                  goto out;
>>          }
>> @@ -1058,7 +1065,7 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
>>                  tap = rtnl_dereference(q->tap);
>>                  ret = tun_vnet_ioctl(&q->vnet_hdr_sz, &q->flags,
>>                                       tap ? &tap->vnet_hash : NULL, -EINVAL,
>> -                                    cmd, sp);
>> +                                    true, cmd, sp);
>>                  rtnl_unlock();
>>                  return ret;
>>          }
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index 27308417b834..18528568aed7 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
>> @@ -209,7 +209,7 @@ struct tun_struct {
>>          struct bpf_prog __rcu *xdp_prog;
>>          struct tun_prog __rcu *steering_prog;
>>          struct tun_prog __rcu *filter_prog;
>> -       struct tun_vnet_hash vnet_hash;
>> +       struct tun_vnet_hash_container __rcu *vnet_hash;
>>          struct ethtool_link_ksettings link_ksettings;
>>          /* init args */
>>          struct file *file;
>> @@ -468,7 +468,9 @@ static const struct virtio_net_hash *tun_find_hash(const struct sk_buff *skb)
>>    * the userspace application move between processors, we may get a
>>    * different rxq no. here.
>>    */
>> -static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
>> +static u16 tun_automq_select_queue(struct tun_struct *tun,
>> +                                  const struct tun_vnet_hash_container *vnet_hash,
>> +                                  struct sk_buff *skb)
>>   {
>>          struct flow_keys keys;
>>          struct flow_keys_basic keys_basic;
>> @@ -493,7 +495,7 @@ static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
>>                  .control = keys.control,
>>                  .basic = keys.basic
>>          };
>> -       tun_vnet_hash_report(&tun->vnet_hash, skb, &keys_basic, skb->l4_hash ? skb->hash : txq,
>> +       tun_vnet_hash_report(vnet_hash, skb, &keys_basic, skb->l4_hash ? skb->hash : txq,
>>                               tun_add_hash);
>>
>>          return txq;
>> @@ -523,10 +525,17 @@ static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
>>          u16 ret;
>>
>>          rcu_read_lock();
>> -       if (rcu_dereference(tun->steering_prog))
>> +       if (rcu_dereference(tun->steering_prog)) {
>>                  ret = tun_ebpf_select_queue(tun, skb);
>> -       else
>> -               ret = tun_automq_select_queue(tun, skb);
>> +       } else {
>> +               struct tun_vnet_hash_container *vnet_hash = rcu_dereference(tun->vnet_hash);
>> +
>> +               if (vnet_hash && (vnet_hash->common.flags & TUN_VNET_HASH_RSS))
>> +                       ret = tun_vnet_rss_select_queue(READ_ONCE(tun->numqueues), vnet_hash,
>> +                                                       skb, tun_add_hash);
>> +               else
>> +                       ret = tun_automq_select_queue(tun, vnet_hash, skb);
>> +       }
>>          rcu_read_unlock();
>>
>>          return ret;
>> @@ -2248,6 +2257,9 @@ static void tun_free_netdev(struct net_device *dev)
>>          security_tun_dev_free_security(tun->security);
>>          __tun_set_ebpf(tun, &tun->steering_prog, NULL);
>>          __tun_set_ebpf(tun, &tun->filter_prog, NULL);
>> +       rtnl_lock();
>> +       kfree_rcu_mightsleep(rtnl_dereference(tun->vnet_hash));
>> +       rtnl_unlock();
>>   }
>>
>>   static void tun_setup(struct net_device *dev)
>> @@ -2946,13 +2958,9 @@ static int tun_set_queue(struct file *file, struct ifreq *ifr)
>>   }
>>
>>   static int tun_set_ebpf(struct tun_struct *tun, struct tun_prog __rcu **prog_p,
>> -                       void __user *data)
>> +                       int fd)
>>   {
>>          struct bpf_prog *prog;
>> -       int fd;
>> -
>> -       if (copy_from_user(&fd, data, sizeof(fd)))
>> -               return -EFAULT;
>>
>>          if (fd == -1) {
>>                  prog = NULL;
>> @@ -3019,6 +3027,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>>          int sndbuf;
>>          int ret;
>>          bool do_notify = false;
>> +       struct tun_vnet_hash_container *vnet_hash;
>>
>>          if (cmd == TUNSETIFF || cmd == TUNSETQUEUE ||
>>              (_IOC_TYPE(cmd) == SOCK_IOC_TYPE && cmd != SIOCGSKNS)) {
>> @@ -3078,7 +3087,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>>          }
>>
>>          if (!tun) {
>> -               ret = tun_vnet_ioctl(NULL, NULL, NULL, -EBADFD, cmd, argp);
>> +               ret = tun_vnet_ioctl(NULL, NULL, NULL, -EBADFD, true, cmd, argp);
>>                  goto unlock;
>>          }
>>
>> @@ -3256,11 +3265,27 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>>                  break;
>>
>>          case TUNSETSTEERINGEBPF:
>> -               ret = tun_set_ebpf(tun, &tun->steering_prog, argp);
>> +               if (get_user(ret, (int __user *)argp)) {
>> +                       ret = -EFAULT;
>> +                       break;
>> +               }
>> +
>> +               vnet_hash = rtnl_dereference(tun->vnet_hash);
>> +               if (ret != -1 && vnet_hash && (vnet_hash->common.flags & TUN_VNET_HASH_RSS)) {
>> +                       ret = -EBUSY;
>> +                       break;
>> +               }
>> +
>> +               ret = tun_set_ebpf(tun, &tun->steering_prog, ret);
>>                  break;
>>
>>          case TUNSETFILTEREBPF:
>> -               ret = tun_set_ebpf(tun, &tun->filter_prog, argp);
>> +               if (get_user(ret, (int __user *)argp)) {
>> +                       ret = -EFAULT;
>> +                       break;
>> +               }
>> +
>> +               ret = tun_set_ebpf(tun, &tun->filter_prog, ret);
>>                  break;
>>
>>          case TUNSETCARRIER:
>> @@ -3280,7 +3305,9 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>>
>>          default:
>>                  ret = tun_vnet_ioctl(&tun->vnet_hdr_sz, &tun->flags,
>> -                                    &tun->vnet_hash, -EINVAL, cmd, argp);
>> +                                    &tun->vnet_hash, -EINVAL,
>> +                                    !rtnl_dereference(tun->steering_prog),
>> +                                    cmd, argp);
>>          }
>>
>>          if (do_notify)
>> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
>> index 589a97dd7d02..f5de4fe9d14e 100644
>> --- a/drivers/net/tun_vnet.h
>> +++ b/drivers/net/tun_vnet.h
>> @@ -9,6 +9,13 @@
>>   typedef struct virtio_net_hash *(*tun_vnet_hash_add)(struct sk_buff *);
>>   typedef const struct virtio_net_hash *(*tun_vnet_hash_find)(const struct sk_buff *);
>>
>> +struct tun_vnet_hash_container {
>> +       struct tun_vnet_hash common;
>> +       struct tun_vnet_hash_rss rss;
>> +       u32 rss_key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
>> +       u16 rss_indirection_table[];
>> +};
>> +
>>   static inline bool tun_vnet_legacy_is_little_endian(unsigned int flags)
>>   {
>>          return !(IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) && (flags & TUN_VNET_BE)) &&
>> @@ -62,14 +69,16 @@ static inline __virtio16 cpu_to_tun_vnet16(unsigned int flags, u16 val)
>>   }
>>
>>   static inline long tun_vnet_ioctl(int *sz, unsigned int *flags,
>> -                                 struct tun_vnet_hash *hash, long fallback,
>> +                                 struct tun_vnet_hash_container __rcu **hashp,
>> +                                 long fallback, bool can_rss,
>>                                    unsigned int cmd, void __user *argp)
>>   {
>>          static const struct tun_vnet_hash cap = {
>> -               .flags = TUN_VNET_HASH_REPORT,
>> +               .flags = TUN_VNET_HASH_REPORT | TUN_VNET_HASH_RSS,
>>                  .types = VIRTIO_NET_SUPPORTED_HASH_TYPES
>>          };
>>          struct tun_vnet_hash hash_buf;
>> +       struct tun_vnet_hash_container *hash;
>>          int __user *sp = argp;
>>          int s;
>>
>> @@ -132,13 +141,57 @@ static inline long tun_vnet_ioctl(int *sz, unsigned int *flags,
>>                  return copy_to_user(argp, &cap, sizeof(cap)) ? -EFAULT : 0;
>>
>>          case TUNSETVNETHASH:
>> -               if (!hash)
>> +               if (!hashp)
>>                          return -EBADFD;
>>
>>                  if (copy_from_user(&hash_buf, argp, sizeof(hash_buf)))
>>                          return -EFAULT;
>> +               argp = (struct tun_vnet_hash __user *)argp + 1;
>> +
>> +               if (hash_buf.flags & TUN_VNET_HASH_RSS) {
>> +                       struct tun_vnet_hash_rss rss;
>> +                       size_t indirection_table_size;
>> +                       size_t key_size;
>> +                       size_t size;
>> +
>> +                       if (!can_rss)
>> +                               return -EBUSY;
>> +
>> +                       if (copy_from_user(&rss, argp, sizeof(rss)))
> 
> This seems to be a change of the uAPI of TUNSETVNETHASH.
> 
>> +                               return -EFAULT;
>> +                       argp = (struct tun_vnet_hash_rss __user *)argp + 1;
>> +
>> +                       indirection_table_size = ((size_t)rss.indirection_table_mask + 1) * 2;
>> +                       key_size = virtio_net_hash_key_length(hash_buf.types);
>> +                       size = struct_size(hash, rss_indirection_table,
>> +                                          (size_t)rss.indirection_table_mask + 1);
>> +
>> +                       hash = kmalloc(size, GFP_KERNEL);
>> +                       if (!hash)
>> +                               return -ENOMEM;
>> +
>> +                       if (copy_from_user(hash->rss_indirection_table,
>> +                                          argp, indirection_table_size)) {
>> +                               kfree(hash);
>> +                               return -EFAULT;
>> +                       }
>> +                       argp = (u16 __user *)argp + rss.indirection_table_mask + 1;
>> +
>> +                       if (copy_from_user(hash->rss_key, argp, key_size)) {
>> +                               kfree(hash);
>> +                               return -EFAULT;
>> +                       }
>> +
>> +                       virtio_net_toeplitz_convert_key(hash->rss_key, key_size);
>> +                       hash->rss = rss;
>> +               } else {
>> +                       hash = kmalloc(sizeof(hash->common), GFP_KERNEL);
>> +                       if (!hash)
>> +                               return -ENOMEM;
>> +               }
>>
>> -               *hash = hash_buf;
>> +               hash->common = hash_buf;
>> +               kfree_rcu_mightsleep(rcu_replace_pointer_rtnl(*hashp, hash));
>>                  return 0;
>>
>>          default:
>> @@ -146,7 +199,7 @@ static inline long tun_vnet_ioctl(int *sz, unsigned int *flags,
>>          }
>>   }
>>
>> -static inline void tun_vnet_hash_report(const struct tun_vnet_hash *hash,
>> +static inline void tun_vnet_hash_report(const struct tun_vnet_hash_container *hash,
>>                                          struct sk_buff *skb,
>>                                          const struct flow_keys_basic *keys,
>>                                          u32 value,
>> @@ -154,7 +207,7 @@ static inline void tun_vnet_hash_report(const struct tun_vnet_hash *hash,
>>   {
>>          struct virtio_net_hash *report;
>>
>> -       if (!(hash->flags & TUN_VNET_HASH_REPORT))
>> +       if (!hash || !(hash->common.flags & TUN_VNET_HASH_REPORT))
>>                  return;
>>
>>          report = vnet_hash_add(skb);
>> @@ -162,11 +215,40 @@ static inline void tun_vnet_hash_report(const struct tun_vnet_hash *hash,
>>                  return;
>>
>>          *report = (struct virtio_net_hash) {
>> -               .report = virtio_net_hash_report(hash->types, keys),
>> +               .report = virtio_net_hash_report(hash->common.types, keys),
>>                  .value = value
>>          };
>>   }
>>
>> +static inline u16 tun_vnet_rss_select_queue(u32 numqueues,
>> +                                           const struct tun_vnet_hash_container *hash,
>> +                                           struct sk_buff *skb,
>> +                                           tun_vnet_hash_add vnet_hash_add)
>> +{
>> +       struct virtio_net_hash *report;
>> +       struct virtio_net_hash ret;
>> +       u16 txq, index;
>> +
>> +       if (!numqueues)
>> +               return 0;
>> +
>> +       virtio_net_hash_rss(skb, hash->common.types, hash->rss_key, &ret);
>> +
>> +       if (!ret.report)
>> +               return hash->rss.unclassified_queue % numqueues;
>> +
>> +       if (hash->common.flags & TUN_VNET_HASH_REPORT) {
>> +               report = vnet_hash_add(skb);
>> +               if (report)
>> +                       *report = ret;
>> +       }
>> +
>> +       index = ret.value & hash->rss.indirection_table_mask;
>> +       txq = READ_ONCE(hash->rss_indirection_table[index]);
>> +
>> +       return txq % numqueues;
>> +}
>> +
>>   static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
>>                                     struct iov_iter *from,
>>                                     struct virtio_net_hdr *hdr)
>> diff --git a/include/linux/if_tap.h b/include/linux/if_tap.h
>> index 5bbb343a6dba..7334c46a3f10 100644
>> --- a/include/linux/if_tap.h
>> +++ b/include/linux/if_tap.h
>> @@ -4,7 +4,6 @@
>>
>>   #include <net/sock.h>
>>   #include <linux/skb_array.h>
>> -#include <uapi/linux/if_tun.h>
>>
>>   struct file;
>>   struct socket;
>> @@ -32,6 +31,7 @@ static inline struct ptr_ring *tap_get_ptr_ring(struct file *f)
>>   #define MAX_TAP_QUEUES 256
>>
>>   struct tap_queue;
>> +struct tun_vnet_hash_container;
>>
>>   struct tap_dev {
>>          struct net_device       *dev;
>> @@ -44,7 +44,7 @@ struct tap_dev {
>>          int                     numqueues;
>>          netdev_features_t       tap_features;
>>          int                     minor;
>> -       struct tun_vnet_hash    vnet_hash;
>> +       struct tun_vnet_hash_container __rcu *vnet_hash;
>>
>>          void (*update_features)(struct tap_dev *tap, netdev_features_t features);
>>          void (*count_tx_dropped)(struct tap_dev *tap);
>> diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
>> index d11e79b4e0dc..4887f97500a8 100644
>> --- a/include/uapi/linux/if_tun.h
>> +++ b/include/uapi/linux/if_tun.h
>> @@ -75,6 +75,14 @@
>>    *
>>    * The argument is a pointer to &struct tun_vnet_hash.
>>    *
>> + * The argument is a pointer to the compound of the following in order if
>> + * %TUN_VNET_HASH_RSS is set:
>> + *
>> + * 1. &struct tun_vnet_hash
>> + * 2. &struct tun_vnet_hash_rss
>> + * 3. Indirection table
>> + * 4. Key
>> + *
> 
> Let's try not modify uAPI. We can introduce new ioctl if necessary.

2, 3, and 4 are new additions. Adding a separate ioctl for them means we 
need to call two ioctls to configure RSS and it is hard to design the 
interactions with them.

For example, if we set TUN_VNET_HASH_RSS with TUNSETVNETHASH before 
setting struct tun_vnet_hash_rss with another ioctl, tuntap will enable 
RSS with undefined parameters. Setting struct tun_vnet_hash_rss with 
TUN_VNET_HASH_RSS unset also sounds unreasnoable.

Letting the new ioctl set TUN_VNET_HASH_RSS does not help either. 
TUNSETVNETHASH still sets the bitmask of allowed hash types so RSS will 
depend on two ioctls.

> 
>>    * The %TUN_VNET_HASH_REPORT flag set with this ioctl will be effective only
>>    * after calling the %TUNSETVNETHDRSZ ioctl with a number greater than or equal
>>    * to the size of &struct virtio_net_hdr_v1_hash.
>> @@ -148,6 +156,13 @@ struct tun_filter {
>>    */
>>   #define TUN_VNET_HASH_REPORT   0x0001
>>
>> +/**
>> + * define TUN_VNET_HASH_RSS - Request virtio_net RSS
>> + *
>> + * This is mutually exclusive with eBPF steering program.
>> + */
>> +#define TUN_VNET_HASH_RSS      0x0002
>> +
>>   /**
>>    * struct tun_vnet_hash - virtio_net hashing configuration
>>    * @flags:
>> @@ -163,4 +178,16 @@ struct tun_vnet_hash {
>>          __u32 types;
>>   };
>>
>> +/**
>> + * struct tun_vnet_hash_rss - virtio_net RSS configuration
>> + * @indirection_table_mask:
>> + *             Bitmask to be applied to the indirection table index
>> + * @unclassified_queue:
>> + *             The index of the queue to place unclassified packets in
>> + */
>> +struct tun_vnet_hash_rss {
>> +       __u16 indirection_table_mask;
>> +       __u16 unclassified_queue;
>> +};
>> +
>>   #endif /* _UAPI__IF_TUN_H */
>>
>> --
>> 2.46.2
>>
> 
> Thanks
> 

