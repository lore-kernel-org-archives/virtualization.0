Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C84C433FE
	for <virtualization@archiver.kernel.org>; Tue, 31 May 2022 12:08:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CCCDD41868;
	Tue, 31 May 2022 12:08:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mlev-zI-HG-r; Tue, 31 May 2022 12:08:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0A86D4170F;
	Tue, 31 May 2022 12:08:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D62E3C0039;
	Tue, 31 May 2022 12:08:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84033C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 12:08:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 635AF60FAA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 12:08:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3rzm3LCxq_dL
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 12:08:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 78E9E60701
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 12:08:38 +0000 (UTC)
Received: from kwepemi100014.china.huawei.com (unknown [172.30.72.57])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LC9xW2lhHz1JCT2;
 Tue, 31 May 2022 20:06:55 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 kwepemi100014.china.huawei.com (7.221.188.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 31 May 2022 20:08:33 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2375.024;
 Tue, 31 May 2022 20:08:33 +0800
To: zhenwei pi <pizhenwei@bytedance.com>
Subject: RE: RE: [PATCH v8 1/1] crypto: Introduce RSA algorithm
Thread-Topic: RE: [PATCH v8 1/1] crypto: Introduce RSA algorithm
Thread-Index: AQHYcab+Uy73hbBLQEKRln7LUOEy0K03azTggABMOICAATL30A==
Date: Tue, 31 May 2022 12:08:33 +0000
Message-ID: <39f884dbc25d4b0cbec510ab090e6778@huawei.com>
References: <20220527084734.2649594-1-pizhenwei@bytedance.com>
 <20220527084734.2649594-2-pizhenwei@bytedance.com>
 <848d579e2c504ba493cd57510a7ff3b0@huawei.com>
 <b2ee77ae-2044-32b4-20c5-43fa78e8213c@bytedance.com>
In-Reply-To: <b2ee77ae-2044-32b4-20c5-43fa78e8213c@bytedance.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.149.11]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "helei.sig11@bytedance.com" <helei.sig11@bytedance.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>
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
> Sent: Tuesday, May 31, 2022 9:48 AM
> To: Gonglei (Arei) <arei.gonglei@huawei.com>
> Cc: qemu-devel@nongnu.org; mst@redhat.com;
> virtualization@lists.linux-foundation.org; helei.sig11@bytedance.com;
> berrange@redhat.com
> Subject: Re: RE: [PATCH v8 1/1] crypto: Introduce RSA algorithm
> 
> On 5/30/22 21:31, Gonglei (Arei) wrote:
> >
> >
> >> -----Original Message-----
> >> From: zhenwei pi [mailto:pizhenwei@bytedance.com]
> >> Sent: Friday, May 27, 2022 4:48 PM
> >> To: mst@redhat.com; Gonglei (Arei) <arei.gonglei@huawei.com>
> >> Cc: qemu-devel@nongnu.org; virtualization@lists.linux-foundation.org;
> >> helei.sig11@bytedance.com; berrange@redhat.com; zhenwei pi
> >> <pizhenwei@bytedance.com>
> >> Subject: [PATCH v8 1/1] crypto: Introduce RSA algorithm
> >>
> >>
> > Skip...
> >
> >> +static int64_t
> >> +virtio_crypto_create_asym_session(VirtIOCrypto *vcrypto,
> >> +               struct virtio_crypto_akcipher_create_session_req
> >> *sess_req,
> >> +               uint32_t queue_id, uint32_t opcode,
> >> +               struct iovec *iov, unsigned int out_num) {
> >> +    VirtIODevice *vdev = VIRTIO_DEVICE(vcrypto);
> >> +    CryptoDevBackendSessionInfo info = {0};
> >> +    CryptoDevBackendAsymSessionInfo *asym_info;
> >> +    int64_t session_id;
> >> +    int queue_index;
> >> +    uint32_t algo, keytype, keylen;
> >> +    g_autofree uint8_t *key = NULL;
> >> +    Error *local_err = NULL;
> >> +
> >> +    algo = ldl_le_p(&sess_req->para.algo);
> >> +    keytype = ldl_le_p(&sess_req->para.keytype);
> >> +    keylen = ldl_le_p(&sess_req->para.keylen);
> >> +
> >> +    if ((keytype != VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PUBLIC)
> >> +         && (keytype !=
> VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PRIVATE)) {
> >> +        error_report("unsupported asym keytype: %d", keytype);
> >> +        return -VIRTIO_CRYPTO_NOTSUPP;
> >> +    }
> >> +
> >> +    if (keylen) {
> >> +        key = g_malloc(keylen);
> >> +        if (iov_to_buf(iov, out_num, 0, key, keylen) != keylen) {
> >> +            virtio_error(vdev, "virtio-crypto asym key incorrect");
> >> +            return -EFAULT;
> >
> > Memory leak.
> >
> >> +        }
> >> +        iov_discard_front(&iov, &out_num, keylen);
> >> +    }
> >> +
> >> +    info.op_code = opcode;
> >> +    asym_info = &info.u.asym_sess_info;
> >> +    asym_info->algo = algo;
> >> +    asym_info->keytype = keytype;
> >> +    asym_info->keylen = keylen;
> >> +    asym_info->key = key;
> >> +    switch (asym_info->algo) {
> >> +    case VIRTIO_CRYPTO_AKCIPHER_RSA:
> >> +        asym_info->u.rsa.padding_algo =
> >> +            ldl_le_p(&sess_req->para.u.rsa.padding_algo);
> >> +        asym_info->u.rsa.hash_algo =
> >> +            ldl_le_p(&sess_req->para.u.rsa.hash_algo);
> >> +        break;
> >> +
> >> +    /* TODO DSA&ECDSA handling */
> >> +
> >> +    default:
> >> +        return -VIRTIO_CRYPTO_ERR;
> >> +    }
> >> +
> >> +    queue_index = virtio_crypto_vq2q(queue_id);
> >> +    session_id =
> >> + cryptodev_backend_create_session(vcrypto->cryptodev,
> >> &info,
> >> +                     queue_index, &local_err);
> >> +    if (session_id < 0) {
> >> +        if (local_err) {
> >> +            error_report_err(local_err);
> >> +        }
> >> +        return -VIRTIO_CRYPTO_ERR;
> >> +    }
> >> +
> >> +    return session_id;
> >
> > Where to free the key at both normal and exceptional paths?
> >
> 
> Hi, Lei
> 
> The key is declared with g_autofree:
> g_autofree uint8_t *key = NULL;
> 

OK. For the patch:

Reviewed-by: Gonglei <arei.gonglei@huawei.com>


Regards,
-Gonglei
    

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
