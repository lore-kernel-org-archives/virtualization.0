Return-Path: <SRS0=9HDO=B2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DA8C433DF
	for <virtualization@archiver.kernel.org>; Sun, 16 Aug 2020 18:37:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5751F2067C
	for <virtualization@archiver.kernel.org>; Sun, 16 Aug 2020 18:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sEKdEuQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5751F2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E959487C51;
	Sun, 16 Aug 2020 18:37:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OgsIlVW2RKU0; Sun, 16 Aug 2020 18:37:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0A88387B07;
	Sun, 16 Aug 2020 18:37:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1E68C088B;
	Sun, 16 Aug 2020 18:37:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C846FC0051
 for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Aug 2020 18:37:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id BC69C87853
 for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Aug 2020 18:37:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g-gJLbQQYFYo
 for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Aug 2020 18:37:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2608886E7F
 for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Aug 2020 18:37:23 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07GIXSLr158492;
 Sun, 16 Aug 2020 18:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=jTisxmMW221i9uwzgGnNkEi3iqqT2NXxak80B/qENrA=;
 b=sEKdEuQJVgZ1jVNWmab0eVw8KyyZmSG7h+DvPJzU5xMAzTyi+iXYlRLEbrDE5TPRa+p3
 Fgvz+QUNcbrJsRJ5sL9+vR0bpFEqcBr1Pp62yYsufsHbOjyYZn4RSrOlNpBLwHpK4+o5
 VY0mV8C1DU6QiYGq5fAFxv7e7uF/YQBQrEKvFPCMwnRic9X8mO96doyEKqK94uUOU9K6
 wW2FC5j+aImUZw9sqCik2LO6H5nnDpQyV9wlDOkMwyjoq22vNZtyCeEzrf2QfCGejj34
 FO1mSbICEkbX1lM2VHJZo2oSZDnimnk4yo7ZdSBuTG5afXO1/3JD3T8uRh0yHgIfwozx Vg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 32x8bmudac-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 16 Aug 2020 18:37:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07GIXweC152229;
 Sun, 16 Aug 2020 18:37:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 32xsfp6wdm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 16 Aug 2020 18:37:06 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07GIb4C6020787;
 Sun, 16 Aug 2020 18:37:04 GMT
Received: from [10.74.109.130] (/10.74.109.130)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sun, 16 Aug 2020 11:37:04 -0700
Subject: Re: [PATCH v4 1/6] x86/paravirt: remove 32-bit support from
 PARAVIRT_XXL
To: Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
References: <20200815100641.26362-1-jgross@suse.com>
 <20200815100641.26362-2-jgross@suse.com>
From: boris.ostrovsky@oracle.com
Organization: Oracle Corporation
Message-ID: <207102f2-7938-3d2c-fd05-ea4b157f9dfc@oracle.com>
Date: Sun, 16 Aug 2020 14:37:00 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200815100641.26362-2-jgross@suse.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9715
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 spamscore=0 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008160153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9715
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 lowpriorityscore=0
 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008160153
Cc: Stefano Stabellini <sstabellini@kernel.org>, "VMware,
 Inc." <pv-drivers@vmware.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
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


On 8/15/20 6:06 AM, Juergen Gross wrote:
> The last 32-bit user of stuff under CONFIG_PARAVIRT_XXL is gone.
>
> Remove 32-bit specific parts.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>


Reviewed-by: Boris Ostrovsky <bortis.ostrovsky@oracle.com>


(There is another '#ifdef CONFIG_X86_64' in paravirt.h, at the bottom,
that can be removed as well)


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
