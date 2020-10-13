Return-Path: <SRS0=ZRN8=DU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6751C433DF
	for <virtualization@archiver.kernel.org>; Tue, 13 Oct 2020 23:43:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43EC521582
	for <virtualization@archiver.kernel.org>; Tue, 13 Oct 2020 23:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LFSwBh+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43EC521582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DDC9287F7B;
	Tue, 13 Oct 2020 23:43:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bvnbMekd7ZwH; Tue, 13 Oct 2020 23:43:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1B02086E98;
	Tue, 13 Oct 2020 23:43:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F24D3C0052;
	Tue, 13 Oct 2020 23:43:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9081BC0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 23:43:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 791822E20C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 23:43:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TmyP-15XAu29
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 23:43:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by silver.osuosl.org (Postfix) with ESMTPS id F02592E1FB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 23:43:07 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09DNY13D165663;
 Tue, 13 Oct 2020 23:43:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 from : mime-version : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=b1qqGFIWpqYDHDX4RNbp8f/sJA5JEAYyA31Pa9AL6pw=;
 b=LFSwBh+UoSNVnW7BOAk6AdjWGLUb0g72L1QsekIvb1q83+4oHc+dCB1Ly578yl68F2jB
 AXsjqAncDI40j+IA4zsxpUaVs2Gb4qDjd/MOCkXIkonn7WTQ08ftk0GFj82zOkDTrCFC
 Q5ECKfbl4HJbAN7bDUpeLOMXuybToQuB2iI5noFtGuIEMuPcmUo00q423yjpeLfrZatG
 xfGQI/haCAvboD6fGDh5+N4ltx0phPH6za1UzGnfm5Ch6H5XyrDvc2FhzuWZsJ6VGGP1
 xyK42TCq1/gSzfiIBxwEBPh2EQRzVZRCEgA/2gvLOWF+U2+8ptT4F+DEeuzGbyl9fqzr 3g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 343vaeb6kr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 13 Oct 2020 23:43:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09DNZD11090248;
 Tue, 13 Oct 2020 23:43:04 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 343puymax2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Oct 2020 23:43:04 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09DNh2sj030296;
 Tue, 13 Oct 2020 23:43:02 GMT
Received: from [192.168.0.28] (/73.189.186.83)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 13 Oct 2020 16:43:01 -0700
Message-ID: <5F863B83.6030204@oracle.com>
Date: Tue, 13 Oct 2020 16:42:59 -0700
From: si-wei liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64;
 rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com, lingshan.zhu@intel.com
Subject: Re: [PATCH v3 2/2] vhost-vdpa: fix page pinning leakage in error path
References: <1601701330-16837-1-git-send-email-si-wei.liu@oracle.com>
 <1601701330-16837-3-git-send-email-si-wei.liu@oracle.com>
 <574a64e3-8873-0639-fe32-248cb99204bc@redhat.com>
In-Reply-To: <574a64e3-8873-0639-fe32-248cb99204bc@redhat.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773
 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=2 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010130165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773
 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 clxscore=1015
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 suspectscore=2 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010130165
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 boris.ostrovsky@oracle.com, linux-kernel@vger.kernel.org
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

Ck9uIDEwLzkvMjAyMCA3OjI3IFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Cj4gT24gMjAyMC8xMC8z
IOS4i+WNiDE6MDIsIFNpLVdlaSBMaXUgd3JvdGU6Cj4+IFBpbm5lZCBwYWdlcyBhcmUgbm90IHBy
b3Blcmx5IGFjY291bnRlZCBwYXJ0aWN1bGFybHkgd2hlbgo+PiBtYXBwaW5nIGVycm9yIG9jY3Vy
cyBvbiBJT1RMQiB1cGRhdGUuIENsZWFuIHVwIGRhbmdsaW5nCj4+IHBpbm5lZCBwYWdlcyBmb3Ig
dGhlIGVycm9yIHBhdGguIEFzIHRoZSBpbmZsaWdodCBwaW5uZWQKPj4gcGFnZXMsIHNwZWNpZmlj
YWxseSBmb3IgbWVtb3J5IHJlZ2lvbiB0aGF0IHN0cmlkZXMgYWNyb3NzCj4+IG11bHRpcGxlIGNo
dW5rcywgd291bGQgbmVlZCBtb3JlIHRoYW4gb25lIGZyZWUgcGFnZSBmb3IKPj4gYm9vayBrZWVw
aW5nIGFuZCBhY2NvdW50aW5nLiBGb3Igc2ltcGxpY2l0eSwgcGluIHBhZ2VzCj4+IGZvciBhbGwg
bWVtb3J5IGluIHRoZSBJT1ZBIHJhbmdlIGluIG9uZSBnbyByYXRoZXIgdGhhbgo+PiBoYXZlIG11
bHRpcGxlIHBpbl91c2VyX3BhZ2VzIGNhbGxzIHRvIG1ha2UgdXAgdGhlIGVudGlyZQo+PiByZWdp
b24uIFRoaXMgd2F5IGl0J3MgZWFzaWVyIHRvIHRyYWNrIGFuZCBhY2NvdW50IHRoZQo+PiBwYWdl
cyBhbHJlYWR5IG1hcHBlZCwgcGFydGljdWxhcmx5IGZvciBjbGVhbi11cCBpbiB0aGUKPj4gZXJy
b3IgcGF0aC4KPj4KPj4gRml4ZXM6IDRjOGNmMzE4ODVmNiAoInZob3N0OiBpbnRyb2R1Y2UgdkRQ
QS1iYXNlZCBiYWNrZW5kIikKPj4gU2lnbmVkLW9mZi1ieTogU2ktV2VpIExpdSA8c2ktd2VpLmxp
dUBvcmFjbGUuY29tPgo+PiAtLS0KPj4gQ2hhbmdlcyBpbiB2MzoKPj4gLSBGYWN0b3Igb3V0IHZo
b3N0X3ZkcGFfbWFwKCkgY2hhbmdlIHRvIGEgc2VwYXJhdGUgcGF0Y2gKPj4KPj4gQ2hhbmdlcyBp
biB2MjoKPj4gLSBGaXggaW5jb3JyZWN0IHRhcmdldCBTSEExIHJlZmVyZW5jZWQKPj4KPj4gICBk
cml2ZXJzL3Zob3N0L3ZkcGEuYyB8IDExOSAKPj4gKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDcxIGluc2VydGlv
bnMoKyksIDQ4IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92
ZHBhLmMgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+PiBpbmRleCAwZjI3OTE5Li5kYWQ0MWRhZSAx
MDA2NDQKPj4gLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKPj4gKysrIGIvZHJpdmVycy92aG9z
dC92ZHBhLmMKPj4gQEAgLTU5NSwyMSArNTk1LDE5IEBAIHN0YXRpYyBpbnQgCj4+IHZob3N0X3Zk
cGFfcHJvY2Vzc19pb3RsYl91cGRhdGUoc3RydWN0IHZob3N0X3ZkcGEgKnYsCj4+ICAgICAgIHN0
cnVjdCB2aG9zdF9kZXYgKmRldiA9ICZ2LT52ZGV2Owo+PiAgICAgICBzdHJ1Y3Qgdmhvc3RfaW90
bGIgKmlvdGxiID0gZGV2LT5pb3RsYjsKPj4gICAgICAgc3RydWN0IHBhZ2UgKipwYWdlX2xpc3Q7
Cj4+IC0gICAgdW5zaWduZWQgbG9uZyBsaXN0X3NpemUgPSBQQUdFX1NJWkUgLyBzaXplb2Yoc3Ry
dWN0IHBhZ2UgKik7Cj4+ICsgICAgc3RydWN0IHZtX2FyZWFfc3RydWN0ICoqdm1hczsKPj4gICAg
ICAgdW5zaWduZWQgaW50IGd1cF9mbGFncyA9IEZPTExfTE9OR1RFUk07Cj4+IC0gICAgdW5zaWdu
ZWQgbG9uZyBucGFnZXMsIGN1cl9iYXNlLCBtYXBfcGZuLCBsYXN0X3BmbiA9IDA7Cj4+IC0gICAg
dW5zaWduZWQgbG9uZyBsb2NrZWQsIGxvY2tfbGltaXQsIHBpbm5lZCwgaTsKPj4gKyAgICB1bnNp
Z25lZCBsb25nIG1hcF9wZm4sIGxhc3RfcGZuID0gMDsKPj4gKyAgICB1bnNpZ25lZCBsb25nIG5w
YWdlcywgbG9ja19saW1pdDsKPj4gKyAgICB1bnNpZ25lZCBsb25nIGksIG5tYXAgPSAwOwo+PiAg
ICAgICB1NjQgaW92YSA9IG1zZy0+aW92YTsKPj4gKyAgICBsb25nIHBpbm5lZDsKPj4gICAgICAg
aW50IHJldCA9IDA7Cj4+ICAgICAgICAgaWYgKHZob3N0X2lvdGxiX2l0cmVlX2ZpcnN0KGlvdGxi
LCBtc2ctPmlvdmEsCj4+ICAgICAgICAgICAgICAgICAgICAgICBtc2ctPmlvdmEgKyBtc2ctPnNp
emUgLSAxKSkKPj4gICAgICAgICAgIHJldHVybiAtRUVYSVNUOwo+PiAgIC0gICAgcGFnZV9saXN0
ID0gKHN0cnVjdCBwYWdlICoqKSBfX2dldF9mcmVlX3BhZ2UoR0ZQX0tFUk5FTCk7Cj4+IC0gICAg
aWYgKCFwYWdlX2xpc3QpCj4+IC0gICAgICAgIHJldHVybiAtRU5PTUVNOwo+PiAtCj4+ICAgICAg
IGlmIChtc2ctPnBlcm0gJiBWSE9TVF9BQ0NFU1NfV08pCj4+ICAgICAgICAgICBndXBfZmxhZ3Mg
fD0gRk9MTF9XUklURTsKPj4gICBAQCAtNjE3LDYxICs2MTUsODYgQEAgc3RhdGljIGludCAKPj4g
dmhvc3RfdmRwYV9wcm9jZXNzX2lvdGxiX3VwZGF0ZShzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPj4g
ICAgICAgaWYgKCFucGFnZXMpCj4+ICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPj4gICArICAg
IHBhZ2VfbGlzdCA9IGt2bWFsbG9jX2FycmF5KG5wYWdlcywgc2l6ZW9mKHN0cnVjdCBwYWdlICop
LCAKPj4gR0ZQX0tFUk5FTCk7Cj4+ICsgICAgdm1hcyA9IGt2bWFsbG9jX2FycmF5KG5wYWdlcywg
c2l6ZW9mKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqKSwKPj4gKyAgICAgICAgICAgICAgICAgIEdG
UF9LRVJORUwpOwo+Cj4KPiBUaGlzIHdpbGwgcmVzdWx0IGhpZ2ggb3JkZXIgbWVtb3J5IGFsbG9j
YXRpb24gd2hpY2ggd2FzIHdoYXQgdGhlIGNvZGUgCj4gdHJpZWQgdG8gYXZvaWQgb3JpZ2luYWxs
eS4KPgo+IFVzaW5nIGFuIHVubGltaXRlZCBzaXplIHdpbGwgY2F1c2UgYSBsb3Qgb2Ygc2lkZSBl
ZmZlY3RzIGNvbnNpZGVyIFZNIAo+IG9yIHVzZXJzcGFjZSBtYXkgdHJ5IHRvIHBpbiBzZXZlcmFs
IFRCIG9mIG1lbW9yeS4KSG1tbSwgdGhhdCdzIGEgZ29vZCBwb2ludC4gSW5kZWVkLCBpZiB0aGUg
Z3Vlc3QgbWVtb3J5IGRlbWFuZCBpcyBodWdlIG9yIAp0aGUgaG9zdCBzeXN0ZW0gaXMgcnVubmlu
ZyBzaG9ydCBvZiBmcmVlIHBhZ2VzLCBrdm1hbGxvYyB3aWxsIGJlIApwcm9ibGVtYXRpYyBhbmQg
bGVzcyBlZmZpY2llbnQgdGhhbiB0aGUgX19nZXRfZnJlZV9wYWdlIGltcGxlbWVudGF0aW9uLgoK
Pgo+Cj4+ICsgICAgaWYgKCFwYWdlX2xpc3QgfHwgIXZtYXMpIHsKPj4gKyAgICAgICAgcmV0ID0g
LUVOT01FTTsKPj4gKyAgICAgICAgZ290byBmcmVlOwo+PiArICAgIH0KPgo+Cj4gQW55IHJlYXNv
biB0aGF0IHlvdSB3YW50IHRvIHVzZSB2bWFzPwpXaXRob3V0IHByb3ZpZGluZyBjdXN0b20gdm1h
cywgaXQncyBzdWJqZWN0IHRvIGhpZ2ggb3JkZXIgYWxsb2NhdGlvbiAKZmFpbHVyZS4gV2hpbGUg
cGFnZV9saXN0IGFuZCB2bWFzIGNhbiBub3cgZmFsbGJhY2sgdG8gdmlydHVhbCBtZW1vcnkgCmFs
bG9jYXRpb24gaWYgbmVlZCBiZS4KCj4KPgo+PiArCj4+ICAgICAgIG1tYXBfcmVhZF9sb2NrKGRl
di0+bW0pOwo+PiAgIC0gICAgbG9ja2VkID0gYXRvbWljNjRfYWRkX3JldHVybihucGFnZXMsICZk
ZXYtPm1tLT5waW5uZWRfdm0pOwo+PiAgICAgICBsb2NrX2xpbWl0ID0gcmxpbWl0KFJMSU1JVF9N
RU1MT0NLKSA+PiBQQUdFX1NISUZUOwo+PiAtCj4+IC0gICAgaWYgKGxvY2tlZCA+IGxvY2tfbGlt
aXQpIHsKPj4gKyAgICBpZiAobnBhZ2VzICsgYXRvbWljNjRfcmVhZCgmZGV2LT5tbS0+cGlubmVk
X3ZtKSA+IGxvY2tfbGltaXQpIHsKPj4gICAgICAgICAgIHJldCA9IC1FTk9NRU07Cj4+IC0gICAg
ICAgIGdvdG8gb3V0Owo+PiArICAgICAgICBnb3RvIHVubG9jazsKPj4gICAgICAgfQo+PiAgIC0g
ICAgY3VyX2Jhc2UgPSBtc2ctPnVhZGRyICYgUEFHRV9NQVNLOwo+PiAtICAgIGlvdmEgJj0gUEFH
RV9NQVNLOwo+PiArICAgIHBpbm5lZCA9IHBpbl91c2VyX3BhZ2VzKG1zZy0+dWFkZHIgJiBQQUdF
X01BU0ssIG5wYWdlcywgZ3VwX2ZsYWdzLAo+PiArICAgICAgICAgICAgICAgIHBhZ2VfbGlzdCwg
dm1hcyk7Cj4+ICsgICAgaWYgKG5wYWdlcyAhPSBwaW5uZWQpIHsKPj4gKyAgICAgICAgaWYgKHBp
bm5lZCA8IDApIHsKPj4gKyAgICAgICAgICAgIHJldCA9IHBpbm5lZDsKPj4gKyAgICAgICAgfSBl
bHNlIHsKPj4gKyAgICAgICAgICAgIHVucGluX3VzZXJfcGFnZXMocGFnZV9saXN0LCBwaW5uZWQp
Owo+PiArICAgICAgICAgICAgcmV0ID0gLUVOT01FTTsKPj4gKyAgICAgICAgfQo+PiArICAgICAg
ICBnb3RvIHVubG9jazsKPj4gKyAgICB9Cj4+ICAgLSAgICB3aGlsZSAobnBhZ2VzKSB7Cj4+IC0g
ICAgICAgIHBpbm5lZCA9IG1pbl90KHVuc2lnbmVkIGxvbmcsIG5wYWdlcywgbGlzdF9zaXplKTsK
Pj4gLSAgICAgICAgcmV0ID0gcGluX3VzZXJfcGFnZXMoY3VyX2Jhc2UsIHBpbm5lZCwKPj4gLSAg
ICAgICAgICAgICAgICAgICAgIGd1cF9mbGFncywgcGFnZV9saXN0LCBOVUxMKTsKPj4gLSAgICAg
ICAgaWYgKHJldCAhPSBwaW5uZWQpCj4+IC0gICAgICAgICAgICBnb3RvIG91dDsKPj4gLQo+PiAt
ICAgICAgICBpZiAoIWxhc3RfcGZuKQo+PiAtICAgICAgICAgICAgbWFwX3BmbiA9IHBhZ2VfdG9f
cGZuKHBhZ2VfbGlzdFswXSk7Cj4+IC0KPj4gLSAgICAgICAgZm9yIChpID0gMDsgaSA8IHJldDsg
aSsrKSB7Cj4+IC0gICAgICAgICAgICB1bnNpZ25lZCBsb25nIHRoaXNfcGZuID0gcGFnZV90b19w
Zm4ocGFnZV9saXN0W2ldKTsKPj4gLSAgICAgICAgICAgIHU2NCBjc2l6ZTsKPj4gLQo+PiAtICAg
ICAgICAgICAgaWYgKGxhc3RfcGZuICYmICh0aGlzX3BmbiAhPSBsYXN0X3BmbiArIDEpKSB7Cj4+
IC0gICAgICAgICAgICAgICAgLyogUGluIGEgY29udGlndW91cyBjaHVuayBvZiBtZW1vcnkgKi8K
Pj4gLSAgICAgICAgICAgICAgICBjc2l6ZSA9IChsYXN0X3BmbiAtIG1hcF9wZm4gKyAxKSA8PCBQ
QUdFX1NISUZUOwo+PiAtICAgICAgICAgICAgICAgIGlmICh2aG9zdF92ZHBhX21hcCh2LCBpb3Zh
LCBjc2l6ZSwKPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgIG1hcF9wZm4gPDwgUEFHRV9T
SElGVCwKPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgIG1zZy0+cGVybSkpCj4+IC0gICAg
ICAgICAgICAgICAgICAgIGdvdG8gb3V0Owo+PiAtICAgICAgICAgICAgICAgIG1hcF9wZm4gPSB0
aGlzX3BmbjsKPj4gLSAgICAgICAgICAgICAgICBpb3ZhICs9IGNzaXplOwo+PiArICAgIGlvdmEg
Jj0gUEFHRV9NQVNLOwo+PiArICAgIG1hcF9wZm4gPSBwYWdlX3RvX3BmbihwYWdlX2xpc3RbMF0p
Owo+PiArCj4+ICsgICAgLyogT25lIG1vcmUgaXRlcmF0aW9uIHRvIGF2b2lkIGV4dHJhIHZkcGFf
bWFwKCkgY2FsbCBvdXQgb2YgCj4+IGxvb3AuICovCj4+ICsgICAgZm9yIChpID0gMDsgaSA8PSBu
cGFnZXM7IGkrKykgewo+PiArICAgICAgICB1bnNpZ25lZCBsb25nIHRoaXNfcGZuOwo+PiArICAg
ICAgICB1NjQgY3NpemU7Cj4+ICsKPj4gKyAgICAgICAgLyogVGhlIGxhc3QgY2h1bmsgbWF5IGhh
dmUgbm8gdmFsaWQgUEZOIG5leHQgdG8gaXQgKi8KPj4gKyAgICAgICAgdGhpc19wZm4gPSBpIDwg
bnBhZ2VzID8gcGFnZV90b19wZm4ocGFnZV9saXN0W2ldKSA6IC0xVUw7Cj4+ICsKPj4gKyAgICAg
ICAgaWYgKGxhc3RfcGZuICYmICh0aGlzX3BmbiA9PSAtMVVMIHx8Cj4+ICsgICAgICAgICAgICAg
ICAgIHRoaXNfcGZuICE9IGxhc3RfcGZuICsgMSkpIHsKPj4gKyAgICAgICAgICAgIC8qIFBpbiBh
IGNvbnRpZ3VvdXMgY2h1bmsgb2YgbWVtb3J5ICovCj4+ICsgICAgICAgICAgICBjc2l6ZSA9IGxh
c3RfcGZuIC0gbWFwX3BmbiArIDE7Cj4+ICsgICAgICAgICAgICByZXQgPSB2aG9zdF92ZHBhX21h
cCh2LCBpb3ZhLCBjc2l6ZSA8PCBQQUdFX1NISUZULAo+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgIG1hcF9wZm4gPDwgUEFHRV9TSElGVCwKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICBt
c2ctPnBlcm0pOwo+PiArICAgICAgICAgICAgaWYgKHJldCkgewo+PiArICAgICAgICAgICAgICAg
IC8qCj4+ICsgICAgICAgICAgICAgICAgICogVW5waW4gdGhlIHJlc3QgY2h1bmtzIG9mIG1lbW9y
eSBvbiB0aGUKPj4gKyAgICAgICAgICAgICAgICAgKiBmbGlnaHQgd2l0aCBubyBjb3JyZXNwb25k
aW5nIHZkcGFfbWFwKCkKPj4gKyAgICAgICAgICAgICAgICAgKiBjYWxscyBoYXZpbmcgYmVlbiBt
YWRlIHlldC4gT24gdGhlIG90aGVyCj4+ICsgICAgICAgICAgICAgICAgICogaGFuZCwgdmRwYV91
bm1hcCgpIGluIHRoZSBmYWlsdXJlIHBhdGgKPj4gKyAgICAgICAgICAgICAgICAgKiBpcyBpbiBj
aGFyZ2Ugb2YgYWNjb3VudGluZyB0aGUgbnVtYmVyIG9mCj4+ICsgICAgICAgICAgICAgICAgICog
cGlubmVkIHBhZ2VzIGZvciBpdHMgb3duLgo+PiArICAgICAgICAgICAgICAgICAqIFRoaXMgYXN5
bW1ldHJpY2FsIHBhdHRlcm4gb2YgYWNjb3VudGluZwo+PiArICAgICAgICAgICAgICAgICAqIGlz
IGZvciBlZmZpY2llbmN5IHRvIHBpbiBhbGwgcGFnZXMgYXQKPj4gKyAgICAgICAgICAgICAgICAg
KiBvbmNlLCB3aGlsZSB0aGVyZSBpcyBubyBvdGhlciBjYWxsc2l0ZQo+PiArICAgICAgICAgICAg
ICAgICAqIG9mIHZkcGFfbWFwKCkgdGhhbiBoZXJlIGFib3ZlLgo+PiArICAgICAgICAgICAgICAg
ICAqLwo+PiArICAgICAgICAgICAgICAgIHVucGluX3VzZXJfcGFnZXMoJnBhZ2VfbGlzdFtubWFw
XSwKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICBucGFnZXMgLSBubWFwKTsKPj4gKyAgICAg
ICAgICAgICAgICBnb3RvIG91dDsKPj4gICAgICAgICAgICAgICB9Cj4+IC0KPj4gLSAgICAgICAg
ICAgIGxhc3RfcGZuID0gdGhpc19wZm47Cj4+ICsgICAgICAgICAgICBhdG9taWM2NF9hZGQoY3Np
emUsICZkZXYtPm1tLT5waW5uZWRfdm0pOwo+PiArICAgICAgICAgICAgbm1hcCArPSBjc2l6ZTsK
Pj4gKyAgICAgICAgICAgIGlvdmEgKz0gY3NpemUgPDwgUEFHRV9TSElGVDsKPj4gKyAgICAgICAg
ICAgIG1hcF9wZm4gPSB0aGlzX3BmbjsKPj4gICAgICAgICAgIH0KPj4gLQo+PiAtICAgICAgICBj
dXJfYmFzZSArPSByZXQgPDwgUEFHRV9TSElGVDsKPj4gLSAgICAgICAgbnBhZ2VzIC09IHJldDsK
Pj4gKyAgICAgICAgbGFzdF9wZm4gPSB0aGlzX3BmbjsKPj4gICAgICAgfQo+Cj4KPiBTbyB3aGF0
IEkgc3VnZ2VzdCBpcyB0byBmaXggdGhlIHBpbm5pbmcgbGVha2FnZSBmaXJzdCBhbmQgZG8gdGhl
IAo+IHBvc3NpYmxlIG9wdGltaXphdGlvbiBvbiB0b3AgKHdoaWNoIGlzIHN0aWxsIHF1ZXN0aW9u
YWJsZSB0byBtZSkuCk9LLiBVbmZvcnR1bmF0ZWx5LCB0aGlzIHdhcyBwaWNrZWQgYW5kIGdvdCBt
ZXJnZWQgaW4gdXBzdHJlYW0uIFNvIEkgd2lsbCAKcG9zdCBhIGZvbGxvdyB1cCBwYXRjaCBzZXQg
dG8gMSkgcmV2ZXJ0IHRoZSBjb21taXQgdG8gdGhlIG9yaWdpbmFsIApfX2dldF9mcmVlX3BhZ2Uo
KSBpbXBsZW1lbnRhdGlvbiwgYW5kIDIpIGZpeCB0aGUgYWNjb3VudGluZyBhbmQgbGVha2FnZSAK
b24gdG9wLiBXaWxsIGl0IGJlIGZpbmU/CgoKLVNpd2VpCj4KPiBUaGFua3MKPgo+Cj4+ICAgLSAg
ICAvKiBQaW4gdGhlIHJlc3QgY2h1bmsgKi8KPj4gLSAgICByZXQgPSB2aG9zdF92ZHBhX21hcCh2
LCBpb3ZhLCAobGFzdF9wZm4gLSBtYXBfcGZuICsgMSkgPDwgCj4+IFBBR0VfU0hJRlQsCj4+IC0g
ICAgICAgICAgICAgICAgIG1hcF9wZm4gPDwgUEFHRV9TSElGVCwgbXNnLT5wZXJtKTsKPj4gKyAg
ICBXQVJOX09OKG5tYXAgIT0gbnBhZ2VzKTsKPj4gICBvdXQ6Cj4+IC0gICAgaWYgKHJldCkgewo+
PiArICAgIGlmIChyZXQpCj4+ICAgICAgICAgICB2aG9zdF92ZHBhX3VubWFwKHYsIG1zZy0+aW92
YSwgbXNnLT5zaXplKTsKPj4gLSAgICAgICAgYXRvbWljNjRfc3ViKG5wYWdlcywgJmRldi0+bW0t
PnBpbm5lZF92bSk7Cj4+IC0gICAgfQo+PiArdW5sb2NrOgo+PiAgICAgICBtbWFwX3JlYWRfdW5s
b2NrKGRldi0+bW0pOwo+PiAtICAgIGZyZWVfcGFnZSgodW5zaWduZWQgbG9uZylwYWdlX2xpc3Qp
Owo+PiArZnJlZToKPj4gKyAgICBrdmZyZWUodm1hcyk7Cj4+ICsgICAga3ZmcmVlKHBhZ2VfbGlz
dCk7Cj4+ICAgICAgIHJldHVybiByZXQ7Cj4+ICAgfQo+CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
