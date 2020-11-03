Return-Path: <SRS0=JeE0=EJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A99C4742C
	for <virtualization@archiver.kernel.org>; Tue,  3 Nov 2020 05:34:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BA7922403
	for <virtualization@archiver.kernel.org>; Tue,  3 Nov 2020 05:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wx+EmW8B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA7922403
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2BC892050A;
	Tue,  3 Nov 2020 05:34:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Iyh8CgsP0V12; Tue,  3 Nov 2020 05:34:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0866720500;
	Tue,  3 Nov 2020 05:34:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F043BC088B;
	Tue,  3 Nov 2020 05:34:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A1DEC0051
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 05:34:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 284C78547D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 05:34:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SpR2QJ6iANJH
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 05:34:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5E6E785218
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 05:34:52 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A35YmhY057709;
 Tue, 3 Nov 2020 05:34:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 from : mime-version : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=HlT5yJVmAJtxWGJeAI2tVIvqrtonMltJepMGyY8oo38=;
 b=Wx+EmW8BNpU+Dka5DuqAk6puQvQotsLuVBMOBSJqKpYabLf+eJp9ItSmf33Kr5XwOjFY
 t2qhYultNad0JHbxteK+ND5qv5vKurNvuPZn2dILJ61m9l/Yn2NhB82qdt12oIB8LoWB
 2JcLqjMdyB4joOs1JTj5+Yz+VM0mrgwEeqOZnNrBW0mJ6G6VsZxR9efNVjnFZln0BAjY
 RV3V2RGgTylwq0PCmQ6Ohq8dn2x2c11mObHnJ3U3qA2+DXFbK60Gy+rQrP3Ibucy1zcD
 yOEDwcJiQDyPbhqUxTYpla87v5cDrwh/5CjKLjC+b+ISO6l4ubnGmKXlNIq+a6B0R2t5 PQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2130.oracle.com with ESMTP id 34hhb1yc5p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 03 Nov 2020 05:34:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A35UgPr053927;
 Tue, 3 Nov 2020 05:34:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 34hw0cy2w9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Nov 2020 05:34:47 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A35YkoU015307;
 Tue, 3 Nov 2020 05:34:46 GMT
Received: from [10.159.241.142] (/10.159.241.142)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 02 Nov 2020 21:34:46 -0800
Message-ID: <5FA0EBF4.5050802@oracle.com>
Date: Mon, 02 Nov 2020 21:34:44 -0800
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
 <20201015091150-mutt-send-email-mst@kernel.org> <5F88AE4A.9030300@oracle.com>
 <20201029175305-mutt-send-email-mst@kernel.org>
In-Reply-To: <20201029175305-mutt-send-email-mst@kernel.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9793
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011030040
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9793
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011030041
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

Ck9uIDEwLzI5LzIwMjAgMjo1MyBQTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9uIFRo
dSwgT2N0IDE1LCAyMDIwIGF0IDAxOjE3OjE0UE0gLTA3MDAsIHNpLXdlaSBsaXUgd3JvdGU6Cj4+
IE9uIDEwLzE1LzIwMjAgNjoxMSBBTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+Pj4gT24g
VGh1LCBPY3QgMTUsIDIwMjAgYXQgMDI6MTU6MzJQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToK
Pj4+PiBPbiAyMDIwLzEwLzE0IOS4iuWNiDc6NDIsIHNpLXdlaSBsaXUgd3JvdGU6Cj4+Pj4+PiBT
byB3aGF0IEkgc3VnZ2VzdCBpcyB0byBmaXggdGhlIHBpbm5pbmcgbGVha2FnZSBmaXJzdCBhbmQg
ZG8gdGhlCj4+Pj4+PiBwb3NzaWJsZSBvcHRpbWl6YXRpb24gb24gdG9wICh3aGljaCBpcyBzdGls
bCBxdWVzdGlvbmFibGUgdG8gbWUpLgo+Pj4+PiBPSy4gVW5mb3J0dW5hdGVseSwgdGhpcyB3YXMg
cGlja2VkIGFuZCBnb3QgbWVyZ2VkIGluIHVwc3RyZWFtLiBTbyBJIHdpbGwKPj4+Pj4gcG9zdCBh
IGZvbGxvdyB1cCBwYXRjaCBzZXQgdG8gMSkgcmV2ZXJ0IHRoZSBjb21taXQgdG8gdGhlIG9yaWdp
bmFsCj4+Pj4+IF9fZ2V0X2ZyZWVfcGFnZSgpIGltcGxlbWVudGF0aW9uLCBhbmQgMikgZml4IHRo
ZSBhY2NvdW50aW5nIGFuZCBsZWFrYWdlCj4+Pj4+IG9uIHRvcC4gV2lsbCBpdCBiZSBmaW5lPwo+
Pj4+IEZpbmUuCj4+Pj4KPj4+PiBUaGFua3MKPj4+IEZpbmUgYnkgbWUgdG9vLgo+Pj4KPj4gVGhh
bmtzLCBNaWNoYWVsICYgSmFzb24uIEkgd2lsbCBwb3N0IHRoZSBmaXggc2hvcnRseS4gU3RheSB0
dW5lZC4KPj4KPj4gLVNpd2VpCj4gZGlkIEkgbWlzcyB0aGUgcGF0Y2g/Cj4KVGhlIHBhdGNoIGhh
ZCBiZWVuIHBvc3RlZCBsYXN0IEZyaWRheS4gU2VlIHRoaXMgdGhyZWFkOgoKaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvdmlydHVhbGl6YXRpb24vMTYwNDA0Mzk0NC00ODk3LTItZ2l0LXNlbmQtZW1h
aWwtc2ktd2VpLmxpdUBvcmFjbGUuY29tLwoKLVNpd2VpCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
