Return-Path: <SRS0=fPht=DW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DB3C43457
	for <virtualization@archiver.kernel.org>; Thu, 15 Oct 2020 20:17:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10EA12076A
	for <virtualization@archiver.kernel.org>; Thu, 15 Oct 2020 20:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A1OkIizR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10EA12076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 146FC88331;
	Thu, 15 Oct 2020 20:17:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wmPnLKtxiPJ3; Thu, 15 Oct 2020 20:17:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 424FD882A6;
	Thu, 15 Oct 2020 20:17:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24E8EC07FF;
	Thu, 15 Oct 2020 20:17:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1F34C0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 20:17:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D8AFD88304
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 20:17:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QDdnle9TZTDA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 20:17:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 553F4882A6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 20:17:25 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FKANCM103594;
 Thu, 15 Oct 2020 20:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 from : mime-version : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=7QAvXMeeS57/+hrtbbW9yGz6rPw3JrSqRU0qxFyRT80=;
 b=A1OkIizRKmb2Tfffot7DQRboH4NjLAAgg5VPMw/Qu1eoLeLv4ZaX1f8u9SUO4FPblYJ3
 3aUqC3tk/9dI2gBCyGsH5GwfrmqnjVHfofMK4BafUdLOEtERR9UNrJW1I6UTgqOL/tds
 Asns4lw07xICdR7ozCNJ2SliSuUeCPsilY+yYYY0NS3u+SuFYwza0P6vzliH117c0jR2
 7udPRVs9MSAH8Z7oiOb7DG6irDjeEzpPUtWCJCRzSQhrgTw8rV97FY9Bgy5T0MclLfOw
 cyZKnXPphc+kGheXmu65EgCai+41ygQtK7kS7v9cRiEiOJOlowOVLsTbSykQjaHbrcN/ Mg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 3434wkxt97-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 15 Oct 2020 20:17:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FK6eXF158648;
 Thu, 15 Oct 2020 20:17:18 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 343pw0u8tv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Oct 2020 20:17:18 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09FKHHZU002127;
 Thu, 15 Oct 2020 20:17:17 GMT
Received: from [10.159.253.148] (/10.159.253.148)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 15 Oct 2020 13:17:17 -0700
Message-ID: <5F88AE4A.9030300@oracle.com>
Date: Thu, 15 Oct 2020 13:17:14 -0700
From: si-wei liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64;
 rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v3 2/2] vhost-vdpa: fix page pinning leakage in error path
References: <1601701330-16837-1-git-send-email-si-wei.liu@oracle.com>
 <1601701330-16837-3-git-send-email-si-wei.liu@oracle.com>
 <574a64e3-8873-0639-fe32-248cb99204bc@redhat.com>
 <5F863B83.6030204@oracle.com>
 <835e79de-52d9-1d07-71dd-d9bee6b9f62e@redhat.com>
 <20201015091150-mutt-send-email-mst@kernel.org>
In-Reply-To: <20201015091150-mutt-send-email-mst@kernel.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=2 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=2 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150134
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, boris.ostrovsky@oracle.com,
 lingshan.zhu@intel.com
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Ck9uIDEwLzE1LzIwMjAgNjoxMSBBTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9uIFRo
dSwgT2N0IDE1LCAyMDIwIGF0IDAyOjE1OjMyUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+
IE9uIDIwMjAvMTAvMTQg5LiK5Y2INzo0Miwgc2ktd2VpIGxpdSB3cm90ZToKPj4+Pgo+Pj4+IFNv
IHdoYXQgSSBzdWdnZXN0IGlzIHRvIGZpeCB0aGUgcGlubmluZyBsZWFrYWdlIGZpcnN0IGFuZCBk
byB0aGUKPj4+PiBwb3NzaWJsZSBvcHRpbWl6YXRpb24gb24gdG9wICh3aGljaCBpcyBzdGlsbCBx
dWVzdGlvbmFibGUgdG8gbWUpLgo+Pj4gT0suIFVuZm9ydHVuYXRlbHksIHRoaXMgd2FzIHBpY2tl
ZCBhbmQgZ290IG1lcmdlZCBpbiB1cHN0cmVhbS4gU28gSSB3aWxsCj4+PiBwb3N0IGEgZm9sbG93
IHVwIHBhdGNoIHNldCB0byAxKSByZXZlcnQgdGhlIGNvbW1pdCB0byB0aGUgb3JpZ2luYWwKPj4+
IF9fZ2V0X2ZyZWVfcGFnZSgpIGltcGxlbWVudGF0aW9uLCBhbmQgMikgZml4IHRoZSBhY2NvdW50
aW5nIGFuZCBsZWFrYWdlCj4+PiBvbiB0b3AuIFdpbGwgaXQgYmUgZmluZT8KPj4KPj4gRmluZS4K
Pj4KPj4gVGhhbmtzCj4gRmluZSBieSBtZSB0b28uCj4KVGhhbmtzLCBNaWNoYWVsICYgSmFzb24u
IEkgd2lsbCBwb3N0IHRoZSBmaXggc2hvcnRseS4gU3RheSB0dW5lZC4KCi1TaXdlaQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
