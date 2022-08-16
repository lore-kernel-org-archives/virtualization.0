Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C396C32772
	for <virtualization@archiver.kernel.org>; Tue, 16 Aug 2022 09:15:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91BFE818E6;
	Tue, 16 Aug 2022 09:15:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 91BFE818E6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O9UHSXEhMjaX; Tue, 16 Aug 2022 09:15:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 095CC81919;
	Tue, 16 Aug 2022 09:15:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 095CC81919
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B796BC0032;
	Tue, 16 Aug 2022 09:15:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23E54C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 09:15:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EC2A54064D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 09:15:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EC2A54064D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VNNvCM01BnaH
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 09:15:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F288740128
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F288740128
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 09:15:50 +0000 (UTC)
Received: from kwepemi500011.china.huawei.com (unknown [172.30.72.56])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4M6QQd51zkz1M8yg;
 Tue, 16 Aug 2022 17:12:25 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 kwepemi500011.china.huawei.com (7.221.188.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 17:15:44 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2375.024;
 Tue, 16 Aug 2022 17:15:44 +0800
To: "Michael S. Tsirkin" <mst@redhat.com>, Lei He <helei.sig11@bytedance.com>
Subject: RE: [PATCH] crypto-virtio: fix memory-leak
Thread-Topic: [PATCH] crypto-virtio: fix memory-leak
Thread-Index: AQHYsUY0nKlBM3YWoEWBnWo9iL/j1q2wr84AgACNxNA=
Date: Tue, 16 Aug 2022 09:15:44 +0000
Message-ID: <0a675c21c1dc4e699d542c2f4f92f729@huawei.com>
References: <20220816075916.23651-1-helei.sig11@bytedance.com>
 <20220816044118-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220816044118-mutt-send-email-mst@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.149.11]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
 "pizhenwei@bytedance.com" <pizhenwei@bytedance.com>,
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
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Tuesday, August 16, 2022 4:43 PM
> To: Lei He <helei.sig11@bytedance.com>
> Cc: Gonglei (Arei) <arei.gonglei@huawei.com>;
> herbert@gondor.apana.org.au; virtualization@lists.linux-foundation.org;
> linux-crypto@vger.kernel.org; linux-kernel@vger.kernel.org;
> pizhenwei@bytedance.com
> Subject: Re: [PATCH] crypto-virtio: fix memory-leak
> 

Pls 's/crypto-virtio/virtio-crypto' in order to keep consistency.

Reviewed-by: Gonglei <arei.gonglei@huawei.com>

Regards,
-Gonglei

> On Tue, Aug 16, 2022 at 03:59:16PM +0800, Lei He wrote:
> > From: lei he <helei.sig11@bytedance.com>
> >
> > Fix memory-leak for virtio-crypto akcipher request, this problem is
> > introduced by 59ca6c93387d3(virtio-crypto: implement RSA algorithm).
> > The leak can be reproduced and tested with the following script inside
> > virtual machine:
> >
> > #!/bin/bash
> >
> > LOOP_TIMES=10000
> >
> > # required module: pkcs8_key_parser, virtio_crypto modprobe
> > pkcs8_key_parser # if CONFIG_PKCS8_PRIVATE_KEY_PARSER=m modprobe
> > virtio_crypto # if CONFIG_CRYPTO_DEV_VIRTIO=m rm -rf /tmp/data dd
> > if=/dev/random of=/tmp/data count=1 bs=230
> >
> > # generate private key and self-signed cert openssl req -nodes -x509
> > -newkey rsa:2048 -keyout key.pem \
> > 		-outform der -out cert.der  \
> > 		-subj
> "/C=CN/ST=GD/L=SZ/O=vihoo/OU=dev/CN=always.com/emailAddress=yy@
> always.com"
> > # convert private key from pem to der
> > openssl pkcs8 -in key.pem -topk8 -nocrypt -outform DER -out key.der
> >
> > # add key
> > PRIV_KEY_ID=`cat key.der | keyctl padd asymmetric test_priv_key @s`
> > echo "priv key id = "$PRIV_KEY_ID PUB_KEY_ID=`cat cert.der | keyctl
> > padd asymmetric test_pub_key @s` echo "pub key id = "$PUB_KEY_ID
> >
> > # query key
> > keyctl pkey_query $PRIV_KEY_ID 0
> > keyctl pkey_query $PUB_KEY_ID 0
> >
> > # here we only run pkey_encrypt becasuse it is the fastest interface
> > function bench_pub() {
> > 	keyctl pkey_encrypt $PUB_KEY_ID 0 /tmp/data
> enc=pkcs1 >/tmp/enc.pub }
> >
> > # do bench_pub in loop to obtain the memory leak for (( i = 0; i <
> > ${LOOP_TIMES}; ++i )); do
> > 	bench_pub
> > done
> >
> > Signed-off-by: lei he <helei.sig11@bytedance.com>
> 
> trash below pls drop.
> 
> 
> > # Please enter the commit message for your changes. Lines starting #
> > with '#' will be kept; you may remove them yourself if you want to.
> > # An empty message aborts the commit.
> > #
> > # Date:      Tue Aug 16 11:53:30 2022 +0800
> > #
> > # On branch master
> > # Your branch is ahead of 'origin/master' by 1 commit.
> > #   (use "git push" to publish your local commits)
> > #
> > # Changes to be committed:
> > #	modified:   drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> > #
> > # Untracked files:
> > #	cert.der
> > #	key.der
> > #	key.pem
> > #
> >
> > # Please enter the commit message for your changes. Lines starting #
> > with '#' will be kept; you may remove them yourself if you want to.
> > # An empty message aborts the commit.
> > #
> > # Date:      Tue Aug 16 11:53:30 2022 +0800
> > #
> > # On branch master
> > # Your branch is ahead of 'origin/master' by 1 commit.
> > #   (use "git push" to publish your local commits)
> > #
> > # Changes to be committed:
> > #	modified:   drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> > #
> > # Untracked files:
> > #	cert.der
> > #	key.der
> > #	key.pem
> > #
> >
> > # Please enter the commit message for your changes. Lines starting #
> > with '#' will be kept; you may remove them yourself if you want to.
> > # An empty message aborts the commit.
> > #
> > # Date:      Tue Aug 16 11:53:30 2022 +0800
> > #
> > # On branch master
> > # Your branch is ahead of 'origin/master' by 1 commit.
> > #   (use "git push" to publish your local commits)
> > #
> > # Changes to be committed:
> > #	modified:   drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> > #
> > # Untracked files:
> > #	cert.der
> > #	key.der
> > #	key.pem
> > #
> > ---
> 
> with commit log fixed:
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> >  drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> > b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> > index 2a60d0525cde..168195672e2e 100644
> > --- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> > +++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> > @@ -56,6 +56,10 @@ static void virtio_crypto_akcipher_finalize_req(
> >  	struct virtio_crypto_akcipher_request *vc_akcipher_req,
> >  	struct akcipher_request *req, int err)  {
> > +	kfree(vc_akcipher_req->src_buf);
> > +	kfree(vc_akcipher_req->dst_buf);
> > +	vc_akcipher_req->src_buf = NULL;
> > +	vc_akcipher_req->dst_buf = NULL;
> >  	virtcrypto_clear_request(&vc_akcipher_req->base);
> >
> >
> > crypto_finalize_akcipher_request(vc_akcipher_req->base.dataq->engine,
> > req, err);
> > --
> > 2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
