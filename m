Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BBFC433EF
	for <virtualization@archiver.kernel.org>; Fri,  4 Mar 2022 08:12:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4FF61401D8;
	Fri,  4 Mar 2022 08:12:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ChwFF3RYDVtz; Fri,  4 Mar 2022 08:12:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6289F4019C;
	Fri,  4 Mar 2022 08:12:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3093AC0012;
	Fri,  4 Mar 2022 08:12:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DCFDC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 08:12:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6134440236
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 08:12:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K236NVu51Fri
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 08:12:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1C5A14019C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 08:12:03 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id ay10so11453623wrb.6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 04 Mar 2022 00:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=nPMlV5C7FYeJ+MAQJRKVZgOqaeGd8xaenfi4KkbtLPY=;
 b=G6/LTYQ4LqwZ8ilqV1vwoxFaGxSsLGHoRQsqa5tR3COs03q6CFyLomCeOuZVrA44/s
 1xgWkjlm4471bRHfGIi1S4HcpjQlLSCIGaOXg9722H/mIk9xB0WyRt3mLgoyn28ZaFAt
 OAoP9ZohsokwXisW4TmpPjlkWR9iEFUmEJs90GQuHPa9UNRiYFyoqSpX3AOaeEFE3jUt
 RvWE6bZ8/rDyDBooFJhgouse5hCvgf5xVcnkhlWsrYA+UvWO2yvSOIjBcLOEaR7y/48b
 BsKFxxoLtzjkAcAs4NBdDUCrgc19O+txMoQYvQ5TGyT+KPA+JLDT8k5On7vsH+AsMxNn
 nPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=nPMlV5C7FYeJ+MAQJRKVZgOqaeGd8xaenfi4KkbtLPY=;
 b=n20F7acQJ/D7rmGR0Edy29cYBWhfrfiS05PeYP978r7Y3HB81yycli/jb4azafGapa
 udf82cLL0jjpcthhYCBJaXr12YCuiqSjpnlZiEm0lPYvT5vT9HcuomF8UhaUaF0JxplJ
 TL9n+Sed6MV2vsb1jFzBi4JEzpyCLnbVpUDdYXXLfKLOrTHaTd7CHSFBlqGO9UW9rfjd
 S8vgZhSejaRgfJm/ncTZ8/IieegfYy0rrd/TzeYLLe1rXe8SmriGDxoiowE1uzStSUwy
 8aefAp2Jr7vAOm/Mbv8aIhD5X/ViD6QKuwGCHg0rJXUj/HtLeB5IMH6uPxt9n1krcnz7
 A7ag==
X-Gm-Message-State: AOAM530z65F6C+PAfWhDGV3PAgnxF/USQ9LN0Cpljr17hEtgZ8dsGxzW
 JYw+VtZa8X8Lnn2NLlp4ZWs6Gw==
X-Google-Smtp-Source: ABdhPJxMCC1LKXJexZ/2tGgpFJil8EHA0GqnSaR3HMWbpY+mDxcJyFlSsBF+YcH9jpwZ01DwXlpjUg==
X-Received: by 2002:adf:c00b:0:b0:1ed:a100:d62 with SMTP id
 z11-20020adfc00b000000b001eda1000d62mr28708755wre.266.1646381522045; 
 Fri, 04 Mar 2022 00:12:02 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net.
 [86.27.177.88]) by smtp.gmail.com with ESMTPSA id
 n5-20020a05600c3b8500b00380fc02ff76sm4758071wms.15.2022.03.04.00.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Mar 2022 00:12:01 -0800 (PST)
Date: Fri, 4 Mar 2022 08:11:59 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH 1/1] vhost: Provide a kernel warning if mutex is held
 whilst clean-up in progress
Message-ID: <YiHJzxvxqwcCM882@google.com>
References: <20220303151929.2505822-1-lee.jones@linaro.org>
 <YiETnIcfZCLb63oB@unreal>
 <20220303155645-mutt-send-email-mst@kernel.org>
 <YiG61RqXFvq/t0fB@unreal>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YiG61RqXFvq/t0fB@unreal>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gRnJpLCAwNCBNYXIgMjAyMiwgTGVvbiBSb21hbm92c2t5IHdyb3RlOgoKPiBPbiBUaHUsIE1h
ciAwMywgMjAyMiBhdCAwNDowMTowNlBNIC0wNTAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6
Cj4gPiBPbiBUaHUsIE1hciAwMywgMjAyMiBhdCAwOToxNDozNlBNICswMjAwLCBMZW9uIFJvbWFu
b3Zza3kgd3JvdGU6Cj4gPiA+IE9uIFRodSwgTWFyIDAzLCAyMDIyIGF0IDAzOjE5OjI5UE0gKzAw
MDAsIExlZSBKb25lcyB3cm90ZToKPiA+ID4gPiBBbGwgd29ya2Vycy91c2VycyBzaG91bGQgYmUg
aGFsdGVkIGJlZm9yZSBhbnkgY2xlYW4tdXAgc2hvdWxkIHRha2UgcGxhY2UuCj4gPiA+ID4gCj4g
PiA+ID4gU3VnZ2VzdGVkLWJ5OiAgTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4K
PiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgo+
ID4gPiA+IC0tLQo+ID4gPiA+ICBkcml2ZXJzL3Zob3N0L3Zob3N0LmMgfCAzICsrKwo+ID4gPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCj4gPiA+ID4gCj4gPiA+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+ID4g
PiA+IGluZGV4IGJiYWZmNmE1ZTIxYjguLmQ5MzVkMjUwNjk2M2YgMTAwNjQ0Cj4gPiA+ID4gLS0t
IGEvZHJpdmVycy92aG9zdC92aG9zdC5jCj4gPiA+ID4gKysrIGIvZHJpdmVycy92aG9zdC92aG9z
dC5jCj4gPiA+ID4gQEAgLTY5Myw2ICs2OTMsOSBAQCB2b2lkIHZob3N0X2Rldl9jbGVhbnVwKHN0
cnVjdCB2aG9zdF9kZXYgKmRldikKPiA+ID4gPiAgCWludCBpOwo+ID4gPiA+ICAKPiA+ID4gPiAg
CWZvciAoaSA9IDA7IGkgPCBkZXYtPm52cXM7ICsraSkgewo+ID4gPiA+ICsJCS8qIElkZWFsbHkg
YWxsIHdvcmtlcnMgc2hvdWxkIGJlIHN0b3BwZWQgcHJpb3IgdG8gY2xlYW4tdXAgKi8KPiA+ID4g
PiArCQlXQVJOX09OKG11dGV4X2lzX2xvY2tlZCgmZGV2LT52cXNbaV0tPm11dGV4KSk7Cj4gPiA+
ID4gKwo+ID4gPiA+ICAJCW11dGV4X2xvY2soJmRldi0+dnFzW2ldLT5tdXRleCk7CgogICAgICAg
ICAgICAgICAgSEVSRSAtLS1eCgo+ID4gPiBJIGtub3cgbm90aGluZyBhYm91dCB2aG9zdCwgYnV0
IHRoaXMgY29uc3RydWN0aW9uIGFuZCBwYXRjaCBsb29rcwo+ID4gPiBzdHJhbmdlIHRvIG1lLgo+
ID4gPiAKPiA+ID4gSWYgYWxsIHdvcmtlcnMgd2VyZSBzdG9wcGVkLCB5b3Ugd29uJ3QgbmVlZCBt
dXRleF9sb2NrKCkuIFRoZSBtdXRleF9sb2NrCj4gPiA+IGhlcmUgc3VnZ2VzdHMgdG8gbWUgdGhh
dCB3b3JrZXJzIGNhbiBzdGlsbCBydW4gaGVyZS4KPiA+ID4gCj4gPiA+IFRoYW5rcwo+ID4gCj4g
PiAKPiA+ICJJZGVhbGx5IiBoZXJlIGlzIG1pc2xlYWRpbmcsIHdlIG5lZWQgYSBiaWdnZXIgZGV0
YWlsZWQgY29tbWVudAo+ID4gYWxvbmcgdGhlIGxpbmVzIG9mOgo+ID4gCj4gPiAvKiAKPiA+ICAq
IEJ5IGRlc2lnbiwgbm8gd29ya2VycyBjYW4gcnVuIGhlcmUuIEJ1dCBpZiB0aGVyZSdzIGEgYnVn
IGFuZCB0aGUKPiA+ICAqIGRyaXZlciBkaWQgbm90IGZsdXNoIGFsbCB3b3JrIHByb3Blcmx5IHRo
ZW4gdGhleSBtaWdodCwgYW5kIHdlCj4gPiAgKiBlbmNvdW50ZXJlZCBzdWNoIGJ1Z3MgaW4gdGhl
IHBhc3QuICBXaXRoIG5vIHByb3BlciBmbHVzaCBndWVzdCB3b24ndAo+ID4gICogd29yayBjb3Jy
ZWN0bHkgYnV0IGF2b2lkaW5nIGhvc3QgbWVtb3J5IGNvcnJ1cHRpb24gaW4gdGhpcyBjYXNlCj4g
PiAgKiBzb3VuZHMgbGlrZSBhIGdvb2QgaWRlYS4KPiA+ICAqLwo+IAo+IFRoaXMgZGVzY3JpcHRp
b24gbG9va3MgYmV0dGVyLCBidXQgdGhlIGNoZWNrIGlzIGluaGVyZW50bHkgcmFjeS4KPiBXaHkg
ZG9uJ3QgeW91IGFkZCBhIGNvbW1lbnQgYW5kIG11dGV4X2xvY2soKT8KCldlIGRvLCBsb29rIHVw
LiAgXgoKPiBUaGUgV0FSTl9PTiBoZXJlIGlzIG1vcmUgZGlzdHJhY3Rpb24gdGhhbiBhY3R1YWwg
aGVscC4KClRoZSBXQVJOKCkgaXMganVzdCBhbiBpbmRpY2F0aW9uIHRoYXQgc29tZXRoaW5nIGVs
c2UgaGFzIGdvbmUgd3JvbmcuCgpTdGVmYW5vIHBhdGNoZWQgb25lIHByb2JsZW0gaW46CgogIHZo
b3N0OiBQcm90ZWN0IHRoZSB2aXJ0cXVldWUgZnJvbSBiZWluZyBjbGVhcmVkIHdoaWxzdCBzdGls
bCBpbiB1c2UKCi4uLiBidXQgb3RoZXJzIG1heSBjcm9wIHVwIGFuZCB0aGUgV0FSTigpIGlzIGhv
dyB3ZSdsbCBiZSBpbmZvcm1lZC4KCi0tIApMZWUgSm9uZXMgW+adjueQvOaWr10KUHJpbmNpcGFs
IFRlY2huaWNhbCBMZWFkIC0gRGV2ZWxvcGVyIFNlcnZpY2VzCkxpbmFyby5vcmcg4pSCIE9wZW4g
c291cmNlIHNvZnR3YXJlIGZvciBBcm0gU29DcwpGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3
aXR0ZXIgfCBCbG9nCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
