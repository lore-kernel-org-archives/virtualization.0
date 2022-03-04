Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED5DFC433FE
	for <virtualization@archiver.kernel.org>; Fri,  4 Mar 2022 08:08:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 71B6C400CC;
	Fri,  4 Mar 2022 08:08:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FGgg1y61jNCP; Fri,  4 Mar 2022 08:08:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 85195402C3;
	Fri,  4 Mar 2022 08:08:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C5CFC001D;
	Fri,  4 Mar 2022 08:08:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92F4FC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 08:08:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 774DA400CC
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 08:08:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7uBrzIX1WMJz
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 08:08:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1907440236
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 08:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646381296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7nW25NF/tKEkz41lufEGliwVBnK2C09c2SMWTt50ne4=;
 b=iUDDwhbg2THjBO4gX+5Tat/smatRp48XzB2ShjrIWAruNgMT+YKNoUjgKgJTa8NnutraSk
 dS1Ec3VJN86d7uAU/2UfhhCApAfPL7FiNI8HERW05iqZkPeGhwRFbpVBIWsktURYR3aWrL
 5RayxCPwcutmZoNCNKMhYEvRmPHSpiU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-178-9-sI2J_DMdCHqkqQql2zuQ-1; Fri, 04 Mar 2022 03:08:11 -0500
X-MC-Unique: 9-sI2J_DMdCHqkqQql2zuQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 p18-20020adfba92000000b001e8f7697cc7so3085065wrg.20
 for <virtualization@lists.linux-foundation.org>;
 Fri, 04 Mar 2022 00:08:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7nW25NF/tKEkz41lufEGliwVBnK2C09c2SMWTt50ne4=;
 b=Xd+2qJ0asqfV1epsH7ukWgGVZMsqgYhUYUdSMJ3UBaRCF81MroNfE94iMLkiWeXmFm
 JSxxkQWXAiN2tYV7CDbcIfFHFSXc433/ni17yD+TnSJxOFwpAb1hsDPQkoBpht1Cnf9a
 YuJXMMtUswbpOLGZa39NZ300aZBpqvX7xjZeBA2SiDyudWzi951YtXwxPws7szKWvgcQ
 eTc0a5OnLy9e0/EmDG+c6l0+cmxMrL9Jc6M+F8ilR+S/VSqqxeesYH/K9bdsIIU8AbcU
 nDzgNwNwfKeTOLN65ew3TAxk72C6EAP6ic8EZzWbRd0wTNu7balkbKu5clPP/xj0QgbV
 JhMQ==
X-Gm-Message-State: AOAM532sUpWXuCwAeXWy98H/xq/fFOS5Kq5k9sNFJkAqMX8ZDjsM+rGg
 e87pyQeDJy0krcX7j87KPiE4mMkWTtgIm8aI93uaIRSnWw22+2ursF+83vz7W/3fcFV04Uoq5v1
 vgKewNHRUpquGOUWF8nMVxGgEUvpQDPZ88uudJgc/4w==
X-Received: by 2002:adf:e2cf:0:b0:1ed:a702:5ef4 with SMTP id
 d15-20020adfe2cf000000b001eda7025ef4mr28735264wrj.487.1646381290546; 
 Fri, 04 Mar 2022 00:08:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzWmNGl/lXwd8sVyeUwFDssSCLl0O441tyUAyHGIlcZJInmk3yIBuPPMjwxBJ7L/Xz8fSDmoQ==
X-Received: by 2002:adf:e2cf:0:b0:1ed:a702:5ef4 with SMTP id
 d15-20020adfe2cf000000b001eda7025ef4mr28735251wrj.487.1646381290279; 
 Fri, 04 Mar 2022 00:08:10 -0800 (PST)
Received: from redhat.com ([2.52.16.157]) by smtp.gmail.com with ESMTPSA id
 ay23-20020a5d6f17000000b001ea79f73fbcsm3762231wrb.25.2022.03.04.00.08.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Mar 2022 00:08:09 -0800 (PST)
Date: Fri, 4 Mar 2022 03:08:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4 3/4] drivers/net/virtio_net: Added RSS hash report.
Message-ID: <20220304030742-mutt-send-email-mst@kernel.org>
References: <20220222120054.400208-4-andrew@daynix.com>
 <202202230342.HPYe6dHA-lkp@intel.com>
MIME-Version: 1.0
In-Reply-To: <202202230342.HPYe6dHA-lkp@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andrew Melnychenko <andrew@daynix.com>, kbuild-all@lists.01.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, yuri.benditovich@daynix.com,
 yan@daynix.com, kuba@kernel.org, davem@davemloft.net
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Feb 23, 2022 at 03:15:28AM +0800, kernel test robot wrote:
> Hi Andrew,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on mst-vhost/linux-next]
> [also build test WARNING on net/master horms-ipvs/master net-next/master linus/master v5.17-rc5 next-20220217]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]


Andrew,
do you plan to fix this?

> url:    https://github.com/0day-ci/linux/commits/Andrew-Melnychenko/RSS-support-for-VirtioNet/20220222-200334
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
> config: i386-randconfig-s002-20220221 (https://download.01.org/0day-ci/archive/20220223/202202230342.HPYe6dHA-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.4-dirty
>         # https://github.com/0day-ci/linux/commit/4fda71c17afd24d8afb675baa0bb14dbbc6cd23c
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Andrew-Melnychenko/RSS-support-for-VirtioNet/20220222-200334
>         git checkout 4fda71c17afd24d8afb675baa0bb14dbbc6cd23c
>         # save the config file to linux build tree
>         mkdir build_dir
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
>    drivers/net/virtio_net.c:1160:25: sparse: sparse: restricted __le16 degrades to integer
>    drivers/net/virtio_net.c:1160:25: sparse: sparse: restricted __le16 degrades to integer
>    drivers/net/virtio_net.c:1160:25: sparse: sparse: restricted __le16 degrades to integer
>    drivers/net/virtio_net.c:1160:25: sparse: sparse: restricted __le16 degrades to integer
>    drivers/net/virtio_net.c:1160:25: sparse: sparse: restricted __le16 degrades to integer
>    drivers/net/virtio_net.c:1160:25: sparse: sparse: restricted __le16 degrades to integer
>    drivers/net/virtio_net.c:1160:25: sparse: sparse: restricted __le16 degrades to integer
>    drivers/net/virtio_net.c:1160:25: sparse: sparse: restricted __le16 degrades to integer
>    drivers/net/virtio_net.c:1160:25: sparse: sparse: restricted __le16 degrades to integer
> >> drivers/net/virtio_net.c:1178:35: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] hash @@     got restricted __le32 const [usertype] hash_value @@
>    drivers/net/virtio_net.c:1178:35: sparse:     expected unsigned int [usertype] hash
>    drivers/net/virtio_net.c:1178:35: sparse:     got restricted __le32 const [usertype] hash_value
> 
> vim +1178 drivers/net/virtio_net.c
> 
>   1151	
>   1152	static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
>   1153					struct sk_buff *skb)
>   1154	{
>   1155		enum pkt_hash_types rss_hash_type;
>   1156	
>   1157		if (!hdr_hash || !skb)
>   1158			return;
>   1159	
>   1160		switch (hdr_hash->hash_report) {
>   1161		case VIRTIO_NET_HASH_REPORT_TCPv4:
>   1162		case VIRTIO_NET_HASH_REPORT_UDPv4:
>   1163		case VIRTIO_NET_HASH_REPORT_TCPv6:
>   1164		case VIRTIO_NET_HASH_REPORT_UDPv6:
>   1165		case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
>   1166		case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
>   1167			rss_hash_type = PKT_HASH_TYPE_L4;
>   1168			break;
>   1169		case VIRTIO_NET_HASH_REPORT_IPv4:
>   1170		case VIRTIO_NET_HASH_REPORT_IPv6:
>   1171		case VIRTIO_NET_HASH_REPORT_IPv6_EX:
>   1172			rss_hash_type = PKT_HASH_TYPE_L3;
>   1173			break;
>   1174		case VIRTIO_NET_HASH_REPORT_NONE:
>   1175		default:
>   1176			rss_hash_type = PKT_HASH_TYPE_NONE;
>   1177		}
> > 1178		skb_set_hash(skb, hdr_hash->hash_value, rss_hash_type);
>   1179	}
>   1180	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
