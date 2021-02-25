Return-Path: <SRS0=rmzs=H3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBF9C433DB
	for <virtualization@archiver.kernel.org>; Thu, 25 Feb 2021 15:10:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA63664F10
	for <virtualization@archiver.kernel.org>; Thu, 25 Feb 2021 15:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA63664F10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5E07E43169;
	Thu, 25 Feb 2021 15:10:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lgXv4cZZyj4s; Thu, 25 Feb 2021 15:10:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id E37F2430B0;
	Thu, 25 Feb 2021 15:10:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AFF5DC000A;
	Thu, 25 Feb 2021 15:10:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0C45C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 15:10:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BA1314EE68
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 15:10:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l19zkpqo8tIw
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 15:10:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D8BBE4EE66
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 15:10:46 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11PFAj5H135072;
 Thu, 25 Feb 2021 15:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=NOVh+eKyqawBhmksoh+N2rh9tSrdXBaC6u5dbQ8Dmao=;
 b=DUMSrlgBrPOgDPJcyWYkW5UnmBkqweOeEfMpIPBfvn037VnbpwEiupBQIVEQ3vCXjqwd
 vZixJiZshPZamA8x0J2/+ggZrOuF3BjcveIAW4coBMuwMauSZ2YDwmpm1GF5YiSg/T18
 xDBtfn7tZYNLV5vutPFg2crOvFnSDmxHQJ4LQJXwmA5TouWYCAipIW928J/qClBeIqAm
 MuIELFsBwGeF6XN20f6U+4mHc25NdOhyANpzSeS40Nu2HEOgk1hFFzqXOUH7PWjAz6fd
 +zvxO16HYL7fslXUpNefFP0yTq0bUc3urg212LgTPMImr8B9JYEHSEv1SqIOOSj5qAC/ Jw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 36ugq3nngw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Feb 2021 15:10:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11PFAb65033794;
 Thu, 25 Feb 2021 15:10:43 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 36ucc1b69x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Feb 2021 15:10:43 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 11PFAgdm008296;
 Thu, 25 Feb 2021 15:10:42 GMT
Received: from mwanda (/10.175.201.156)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 25 Feb 2021 07:10:41 -0800
Date: Thu, 25 Feb 2021 18:10:36 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: jasowang@redhat.com
Subject: [bug report] vdpa: set the virtqueue num during register
Message-ID: <YDe97MG41eViGPxr@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9905
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250124
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9905
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxlogscore=982
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250124
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

The patch ddd50f4495d3: "vdpa: set the virtqueue num during register"
from Feb 23, 2021, leads to the following static checker warning:

	drivers/vdpa/ifcvf/ifcvf_main.c:433 ifcvf_probe()
	warn: risky error pointer math: '__vdpa_alloc_device(dev, &ifc_vdpa_ops, 2592 + (0), (0)))'

include/linux/vdpa.h
   255  #define vdpa_alloc_device(dev_struct, member, parent, config, name)   \
   256                            container_of(__vdpa_alloc_device( \
   257                                         parent, config, \
   258                                         sizeof(dev_struct) + \
   259                                         BUILD_BUG_ON_ZERO(offsetof( \
   260                                         dev_struct, member)), name), \
   261                                         dev_struct, member)
   262  

The __vdpa_alloc_device() returns an error pointer and if we call
container_of() on then that's a bug...  (Unless the container_of() is
known to be a no-op, in which case it's sort of ugly but fine, I guess.
There is one caller where this is the case.).

drivers/vdpa/ifcvf/ifcvf_main.c
   432  
   433          adapter = vdpa_alloc_device(struct ifcvf_adapter, vdpa,
   434                                      dev, &ifc_vdpa_ops, NULL);
   435          if (adapter == NULL) {

All the other caller check for NULL.  :P

   436                  IFCVF_ERR(pdev, "Failed to allocate vDPA structure");
   437                  return -ENOMEM;
   438          }
   439  
   440          pci_set_master(pdev);
   441          pci_set_drvdata(pdev, adapter);
   442  

regards,
dan carpenter
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
