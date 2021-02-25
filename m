Return-Path: <SRS0=rmzs=H3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B33CC433DB
	for <virtualization@archiver.kernel.org>; Thu, 25 Feb 2021 06:49:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8721464ED9
	for <virtualization@archiver.kernel.org>; Thu, 25 Feb 2021 06:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8721464ED9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0CBB7431E3;
	Thu, 25 Feb 2021 06:49:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ix9oygliOK4X; Thu, 25 Feb 2021 06:49:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id B24404314E;
	Thu, 25 Feb 2021 06:49:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93A2AC000B;
	Thu, 25 Feb 2021 06:49:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56348C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 06:49:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3CB8083F42
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 06:49:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ud9B4eN4qRrJ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 06:49:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 191CC83EF2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 06:49:53 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11P6jZD1166878;
 Thu, 25 Feb 2021 06:49:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=3pJAyI/fUQAryNzsjN+YewxVnA7EYrT8GCdF5SxbVVA=;
 b=IPBsVaXMT4H0T4rXTlsDywHEthfo06qA9Sl5SLqsNueEfzNuT3gHUWFYt0frVXAn2D56
 ZLr4/DXnm8ag3RH7+25w8TQz3Fy4x2PvwtE75JhFntX6TTcFLlZQoCTbxaf0b5aQT5PD
 o1DtnfuClDspwRtOi0K/TaV3vz9Kedkn86iI/367pn4fpmo8pELlSKu3Jgb+cTrau2fc
 llddT3UYaSQGNPhEuExquZ6xsDeir1v94CpE+xYSHvbDGSpMnQiYbpUv1UGwfRNJKv1j
 Jh+FqB/J133hBlfgASgjYErRQsR+D59CUN36kBkSjiUtDkt2WUfEV6qZHCuuEjfqIdac Lg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 36tsur5dre-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Feb 2021 06:49:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11P6iaTS083894;
 Thu, 25 Feb 2021 06:49:51 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 36ucc0u2sc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Feb 2021 06:49:50 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 11P6nn3H028130;
 Thu, 25 Feb 2021 06:49:49 GMT
Received: from mwanda (/102.36.221.92) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 24 Feb 2021 22:49:48 -0800
Date: Thu, 25 Feb 2021 09:49:43 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: jasowang@redhat.com
Subject: [bug report] vdpa: introduce virtio pci driver
Message-ID: <YDdIh3XRctsOAUkQ@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9905
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=774
 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250056
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9905
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxlogscore=681 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102250056
Cc: virtualization@lists.linux-foundation.org
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

Hello Jason Wang,

The patch 010eee82c84e: "vdpa: introduce virtio pci driver" from Feb
23, 2021, leads to the following static checker warning:

	drivers/vdpa/virtio_pci/vp_vdpa.c:168 vp_vdpa_request_irq()
	warn: inconsistent indenting

drivers/vdpa/virtio_pci/vp_vdpa.c
   154                          goto err;
   155                  }
   156                  vp_modern_queue_vector(mdev, i, i);
   157                  vp_vdpa->vring[i].irq = irq;
   158          }
   159  
   160          snprintf(vp_vdpa->msix_name, VP_VDPA_NAME_SIZE, "vp-vdpa[%s]-config\n",
   161                   pci_name(pdev));
   162          irq = pci_irq_vector(pdev, queues);
   163          ret = devm_request_irq(&pdev->dev, irq, vp_vdpa_config_handler, 0,
   164                                 vp_vdpa->msix_name, vp_vdpa);
   165          if (ret) {
   166                  dev_err(&pdev->dev,
   167                          "vp_vdpa: fail to request irq for vq %d\n", i);
                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Is this error message right?

   168                          goto err;
                                ^^^^^^^^
indented too far

   169          }
   170          vp_modern_config_vector(mdev, queues);
   171          vp_vdpa->config_irq = irq;
   172  
   173          return 0;
   174  err:
   175          vp_vdpa_free_irq(vp_vdpa);
   176          return ret;
   177  }

regards,
dan carpenter
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
