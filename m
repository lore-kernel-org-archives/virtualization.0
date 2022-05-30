Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632DCC433F5
	for <virtualization@archiver.kernel.org>; Mon, 30 May 2022 13:31:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E736F40C39;
	Mon, 30 May 2022 13:31:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jHIeovsNQ4EH; Mon, 30 May 2022 13:31:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6207040C08;
	Mon, 30 May 2022 13:31:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B1BFC0039;
	Mon, 30 May 2022 13:31:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0815DC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 13:31:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D881240C08
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 13:31:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wj6gAT5yqUfi
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 13:31:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4F8F240A79
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 13:31:26 +0000 (UTC)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LBbqW3LhwzgYJS;
 Mon, 30 May 2022 21:29:43 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 30 May 2022 21:31:20 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2375.024;
 Mon, 30 May 2022 21:31:20 +0800
To: zhenwei pi <pizhenwei@bytedance.com>, "mst@redhat.com" <mst@redhat.com>
Subject: RE: [PATCH v8 1/1] crypto: Introduce RSA algorithm
Thread-Topic: [PATCH v8 1/1] crypto: Introduce RSA algorithm
Thread-Index: AQHYcab+Uy73hbBLQEKRln7LUOEy0K03azTg
Date: Mon, 30 May 2022 13:31:20 +0000
Message-ID: <848d579e2c504ba493cd57510a7ff3b0@huawei.com>
References: <20220527084734.2649594-1-pizhenwei@bytedance.com>
 <20220527084734.2649594-2-pizhenwei@bytedance.com>
In-Reply-To: <20220527084734.2649594-2-pizhenwei@bytedance.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.149.11]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "helei.sig11@bytedance.com" <helei.sig11@bytedance.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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
> Sent: Friday, May 27, 2022 4:48 PM
> To: mst@redhat.com; Gonglei (Arei) <arei.gonglei@huawei.com>
> Cc: qemu-devel@nongnu.org; virtualization@lists.linux-foundation.org;
> helei.sig11@bytedance.com; berrange@redhat.com; zhenwei pi
> <pizhenwei@bytedance.com>
> Subject: [PATCH v8 1/1] crypto: Introduce RSA algorithm
> 
> 
Skip...

> +static int64_t
> +virtio_crypto_create_asym_session(VirtIOCrypto *vcrypto,
> +               struct virtio_crypto_akcipher_create_session_req
> *sess_req,
> +               uint32_t queue_id, uint32_t opcode,
> +               struct iovec *iov, unsigned int out_num) {
> +    VirtIODevice *vdev = VIRTIO_DEVICE(vcrypto);
> +    CryptoDevBackendSessionInfo info = {0};
> +    CryptoDevBackendAsymSessionInfo *asym_info;
> +    int64_t session_id;
> +    int queue_index;
> +    uint32_t algo, keytype, keylen;
> +    g_autofree uint8_t *key = NULL;
> +    Error *local_err = NULL;
> +
> +    algo = ldl_le_p(&sess_req->para.algo);
> +    keytype = ldl_le_p(&sess_req->para.keytype);
> +    keylen = ldl_le_p(&sess_req->para.keylen);
> +
> +    if ((keytype != VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PUBLIC)
> +         && (keytype != VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PRIVATE)) {
> +        error_report("unsupported asym keytype: %d", keytype);
> +        return -VIRTIO_CRYPTO_NOTSUPP;
> +    }
> +
> +    if (keylen) {
> +        key = g_malloc(keylen);
> +        if (iov_to_buf(iov, out_num, 0, key, keylen) != keylen) {
> +            virtio_error(vdev, "virtio-crypto asym key incorrect");
> +            return -EFAULT;

Memory leak.

> +        }
> +        iov_discard_front(&iov, &out_num, keylen);
> +    }
> +
> +    info.op_code = opcode;
> +    asym_info = &info.u.asym_sess_info;
> +    asym_info->algo = algo;
> +    asym_info->keytype = keytype;
> +    asym_info->keylen = keylen;
> +    asym_info->key = key;
> +    switch (asym_info->algo) {
> +    case VIRTIO_CRYPTO_AKCIPHER_RSA:
> +        asym_info->u.rsa.padding_algo =
> +            ldl_le_p(&sess_req->para.u.rsa.padding_algo);
> +        asym_info->u.rsa.hash_algo =
> +            ldl_le_p(&sess_req->para.u.rsa.hash_algo);
> +        break;
> +
> +    /* TODO DSA&ECDSA handling */
> +
> +    default:
> +        return -VIRTIO_CRYPTO_ERR;
> +    }
> +
> +    queue_index = virtio_crypto_vq2q(queue_id);
> +    session_id = cryptodev_backend_create_session(vcrypto->cryptodev,
> &info,
> +                     queue_index, &local_err);
> +    if (session_id < 0) {
> +        if (local_err) {
> +            error_report_err(local_err);
> +        }
> +        return -VIRTIO_CRYPTO_ERR;
> +    }
> +
> +    return session_id;

Where to free the key at both normal and exceptional paths?


Regards,
-Gonglei


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
