Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D67BC433F5
	for <virtualization@archiver.kernel.org>; Thu, 10 Feb 2022 09:21:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1E64F829FD;
	Thu, 10 Feb 2022 09:21:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ikcljN5bcYFO; Thu, 10 Feb 2022 09:21:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AFF18829B6;
	Thu, 10 Feb 2022 09:21:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 855F1C001A;
	Thu, 10 Feb 2022 09:21:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD77DC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 09:21:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8CFAA60E6A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 09:21:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L5O6mHZyVpjs
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 09:21:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7F30160E68
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 09:21:19 +0000 (UTC)
Received: from dggeme761-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JvWRK3nKBz9sZY;
 Thu, 10 Feb 2022 17:19:41 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggeme761-chm.china.huawei.com (10.3.19.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Thu, 10 Feb 2022 17:21:13 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2308.021;
 Thu, 10 Feb 2022 17:21:13 +0800
To: zhenwei pi <pizhenwei@bytedance.com>
Subject: RE: RE: [PATCH 2/3] virtio-crypto: introduce akcipher service
Thread-Topic: RE: [PATCH 2/3] virtio-crypto: introduce akcipher service
Thread-Index: AQHYDm47poB50P1RmUal7n5E+2vGlKyMgQ2Q//+Jc4CAAJcu4A==
Date: Thu, 10 Feb 2022 09:21:13 +0000
Message-ID: <34ba8701eb86414e826824892e2f0892@huawei.com>
References: <20220121022438.1042547-1-pizhenwei@bytedance.com>
 <20220121022438.1042547-3-pizhenwei@bytedance.com>
 <15e960491a684b649e5d0179a32848a2@huawei.com>
 <540f29e4-12ef-3786-bd54-9a94ba6ee7ab@bytedance.com>
In-Reply-To: <540f29e4-12ef-3786-bd54-9a94ba6ee7ab@bytedance.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.149.11]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "helei.sig11@bytedance.com" <helei.sig11@bytedance.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
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
From: "Gonglei \(Arei\) via Virtualization"
 <virtualization@lists.linux-foundation.org>
Reply-To: "Gonglei \(Arei\)" <arei.gonglei@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



> -----Original Message-----
> From: zhenwei pi [mailto:pizhenwei@bytedance.com]
> Sent: Thursday, February 10, 2022 4:18 PM
> To: Gonglei (Arei) <arei.gonglei@huawei.com>
> Cc: jasowang@redhat.com; virtualization@lists.linux-foundation.org;
> linux-crypto@vger.kernel.org; linux-kernel@vger.kernel.org;
> helei.sig11@bytedance.com; mst@redhat.com
> Subject: Re: RE: [PATCH 2/3] virtio-crypto: introduce akcipher service
> 
> >>   /* The accelerator hardware is ready */  #define
> >> VIRTIO_CRYPTO_S_HW_READY  (1 << 0) @@ -442,6 +520,7 @@ struct
> >> virtio_crypto_config {
> >>   	__le32 reserve;
> >>   	/* Maximum size of each crypto request's content */
> >>   	__le64 max_size;
> >> +	__le32 akcipher_algo;
> >>   };
> >>
> > You can use the reserve attribute. Keeping 64-bit aligned.
> >
> >>   struct virtio_crypto_inhdr {
> >> --
> >> 2.25.1
> >
> 
> Can I use the "__le32 reserve;" field directly?
> 
> struct virtio_crypto_config {
>          /* See VIRTIO_CRYPTO_OP_* above */
>          __le32  status;
> 
>          /*
>           * Maximum number of data queue
>           */
>          __le32  max_dataqueues;
> 
>          /*
>           * Specifies the services mask which the device support,
>           * see VIRTIO_CRYPTO_SERVICE_* above
>           */
>          __le32 crypto_services;
> 
>          /* Detailed algorithms mask */
>          __le32 cipher_algo_l;
>          __le32 cipher_algo_h;
>          __le32 hash_algo;
>          __le32 mac_algo_l;
>          __le32 mac_algo_h;
>          __le32 aead_algo;
>          /* Maximum length of cipher key */
>          __le32 max_cipher_key_len;
>          /* Maximum length of authenticated key */
>          __le32 max_auth_key_len;
>          __le32 reserve;            -->    __le32 akcipher_algo;
>          /* Maximum size of each crypto request's content */
>          __le64 max_size;
> };
> 


Yes, I think so. Otherwise you will add other reserved field :(

Regards,
-Gonglei
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
