Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C7AC25B0E
	for <virtualization@archiver.kernel.org>; Thu, 18 Aug 2022 04:15:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E983741B4C;
	Thu, 18 Aug 2022 04:15:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E983741B4C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LKGSUtnb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q93Iq49FDaJq; Thu, 18 Aug 2022 04:15:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1A3514191B;
	Thu, 18 Aug 2022 04:15:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1A3514191B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E845DC0032;
	Thu, 18 Aug 2022 04:15:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9730C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 04:15:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 94A434191E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 04:15:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 94A434191E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CJjv0kRk-hoH
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 04:15:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8136D4191B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8136D4191B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 04:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660796152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=90ff8sjY+m9HsEs6i8v1jPNF4u6ADKMljn/DWnOc7tg=;
 b=LKGSUtnbvaUkUh+WaBMKzrrtp0xuqT+4WZ8az09iMzrtboJ0vDzDQIS7zf6lbh+AB44A3K
 yvlVVd9czWwFoFJpsK6+sGvKzwjGDrniW4Ma430kEmbzKXpdR7f53TPcvHz103sS2plBOz
 kLjCT76AC2PgEWvJLns0RjNk5alWGB4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-258-s-jj0-HeMBqmqtgO07wQ-A-1; Thu, 18 Aug 2022 00:15:50 -0400
X-MC-Unique: s-jj0-HeMBqmqtgO07wQ-A-1
Received: by mail-pl1-f199.google.com with SMTP id
 s18-20020a170902ea1200b0016f11bfefe4so408103plg.14
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 21:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=90ff8sjY+m9HsEs6i8v1jPNF4u6ADKMljn/DWnOc7tg=;
 b=CaOxukrvRayxzofkaTrP34q8yS51FUP8ESKuvDgKJ7czCDWGauJzEwxzzjv3/VtCY6
 xuDC2Nd40OB1eJkp7urGKDXFpo3P1ig3XSLCsP7xDPLvkb1B9T43SFOv/xDq3g490VT5
 e4c7drUiHPGzdqTbfLRfI8uYduaG4f0/nXlJtQHK5XTYLYvc2y8AXU8VqB3qQug1kg1e
 W+DMZyYPEYsFUBZVXyiuKShaSPgAlJ0SgqyKrdOc0Kqqi4NZkslkU12SXkIOpyJn1FZB
 4H/vOabVQeJQHc2Kerx85ntc45jztV6iSmXYiIRjyJ6jvREaj2RjTRv/yOk/ga42QudD
 8waw==
X-Gm-Message-State: ACgBeo0u9MF0kWEOfIviq++XwRXUWYz9o82fJYEdxIfxRgAnKMQIpFoj
 pxaMExB5tPJ/wn9DT0nHeJq2A3Yo9CW0Pk8rLbf3W81+WCvcnfmQILzd+PSS/aPWVPu3L1w+TzC
 8E9eYXn34arVQTEKTiNi7+TamDbWsB91HEvcUVdwRgg==
X-Received: by 2002:a62:4c2:0:b0:52e:bd4d:50e1 with SMTP id
 185-20020a6204c2000000b0052ebd4d50e1mr1296687pfe.8.1660796149649; 
 Wed, 17 Aug 2022 21:15:49 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7t4FbXeSRyLqR6Fb1Pn3xF/TW5GpOgcSkBjfKmVbsWkrQCgDysCjqSzTKPrOnCKYR30QQCMQ==
X-Received: by 2002:a62:4c2:0:b0:52e:bd4d:50e1 with SMTP id
 185-20020a6204c2000000b0052ebd4d50e1mr1296667pfe.8.1660796149336; 
 Wed, 17 Aug 2022 21:15:49 -0700 (PDT)
Received: from [10.72.13.223] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 c127-20020a621c85000000b005289ef6db79sm376729pfc.32.2022.08.17.21.15.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Aug 2022 21:15:48 -0700 (PDT)
Message-ID: <54aa5a5c-69e2-d372-3e0c-b87f595d213c@redhat.com>
Date: Thu, 18 Aug 2022 12:15:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH 2/2] vDPA: conditionally read fields in virtio-net dev
To: "Michael S. Tsirkin" <mst@redhat.com>,
 "Zhu, Lingshan" <lingshan.zhu@intel.com>
References: <c5075d3d-9d2c-2716-1cbf-cede49e2d66f@oracle.com>
 <20e92551-a639-ec13-3d9c-13bb215422e1@intel.com>
 <9b6292f3-9bd5-ecd8-5e42-cd5d12f036e7@oracle.com>
 <22e0236f-b556-c6a8-0043-b39b02928fd6@intel.com>
 <892b39d6-85f8-bff5-030d-e21288975572@oracle.com>
 <52a47bc7-bf26-b8f9-257f-7dc5cea66d23@intel.com>
 <20220817045406-mutt-send-email-mst@kernel.org>
 <a91fa479-d1cc-a2d6-0821-93386069a2c1@intel.com>
 <20220817053821-mutt-send-email-mst@kernel.org>
 <449c2fb2-3920-7bf9-8c5c-a68456dfea76@intel.com>
 <20220817063450-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220817063450-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 gautam.dawar@amd.com
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

CuWcqCAyMDIyLzgvMTcgMTg6MzcsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4gT24gV2Vk
LCBBdWcgMTcsIDIwMjIgYXQgMDU6NDM6MjJQTSArMDgwMCwgWmh1LCBMaW5nc2hhbiB3cm90ZToK
Pj4KPj4gT24gOC8xNy8yMDIyIDU6MzkgUE0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPj4+
IE9uIFdlZCwgQXVnIDE3LCAyMDIyIGF0IDA1OjEzOjU5UE0gKzA4MDAsIFpodSwgTGluZ3NoYW4g
d3JvdGU6Cj4+Pj4gT24gOC8xNy8yMDIyIDQ6NTUgUE0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90
ZToKPj4+Pj4gT24gV2VkLCBBdWcgMTcsIDIwMjIgYXQgMTA6MTQ6MjZBTSArMDgwMCwgWmh1LCBM
aW5nc2hhbiB3cm90ZToKPj4+Pj4+IFllcyBpdCBpcyBhIGxpdHRsZSBtZXNzeSwgYW5kIHdlIGNh
biBub3QgY2hlY2sgX0ZfVkVSU0lPTl8xIGJlY2F1c2Ugb2YKPj4+Pj4+IHRyYW5zaXRpb25hbCBk
ZXZpY2VzLCBzbyBtYXliZSB0aGlzIGlzIHRoZSBiZXN0IHdlIGNhbiBkbyBmb3Igbm93Cj4+Pj4+
IEkgdGhpbmsgdmhvc3QgZ2VuZXJhbGx5IG5lZWRzIGFuIEFQSSB0byBkZWNsYXJlIGNvbmZpZyBz
cGFjZSBlbmRpYW4tbmVzcwo+Pj4+PiB0byBrZXJuZWwuIHZkcGEgY2FuIHJldXNlIHRoYXQgdG9v
IHRoZW4uCj4+Pj4gWWVzLCBJIHJlbWVtYmVyIHlvdSBoYXZlIG1lbnRpb25lZCBzb21lIElPQ1RM
IHRvIHNldCB0aGUgZW5kaWFuLW5lc3MsCj4+Pj4gZm9yIHZEUEEsIEkgdGhpbmsgb25seSB0aGUg
dmVuZG9yIGRyaXZlciBrbm93cyB0aGUgZW5kaWFuLAo+Pj4+IHNvIHdlIG1heSBuZWVkIGEgbmV3
IGZ1bmN0aW9uIHZkcGFfb3BzLT5nZXRfZW5kaWFuKCkuCj4+Pj4gSW4gdGhlIGxhc3QgdGhyZWFk
LCB3ZSBzYXkgbWF5YmUgaXQncyBiZXR0ZXIgdG8gYWRkIGEgY29tbWVudCBmb3Igbm93Lgo+Pj4+
IEJ1dCBpZiB5b3UgdGhpbmsgd2Ugc2hvdWxkIGFkZCBhIHZkcGFfb3BzLT5nZXRfZW5kaWFuKCks
IEkgY2FuIHdvcmsKPj4+PiBvbiBpdCBmb3Igc3VyZSEKPj4+Pgo+Pj4+IFRoYW5rcwo+Pj4+IFpo
dSBMaW5nc2hhbgo+Pj4gSSB0aGluayBRRU1VIGhhcyB0byBzZXQgZW5kaWFuLW5lc3MuIE5vIG9u
ZSBlbHNlIGtub3dzLgo+PiBZZXMsIGZvciBTVyBiYXNlZCB2aG9zdCBpdCBpcyB0cnVlLiBCdXQg
Zm9yIEhXIHZEUEEsIG9ubHkKPj4gdGhlIGRldmljZSAmIGRyaXZlciBrbm93cyB0aGUgZW5kaWFu
LCBJIHRoaW5rIHdlIGNhbiBub3QKPj4gInNldCIgYSBoYXJkd2FyZSdzIGVuZGlhbi4KPiBRRU1V
IGtub3dzIHRoZSBndWVzdCBlbmRpYW4tbmVzcyBhbmQgaXQga25vd3MgdGhhdAo+IGRldmljZSBp
cyBhY2Nlc3NlZCB0aHJvdWdoIHRoZSBsZWdhY3kgaW50ZXJmYWNlLgo+IEl0IGNhbiBhY2NvcmRp
bmdseSBzZW5kIGVuZGlhbi1uZXNzIHRvIHRoZSBrZXJuZWwgYW5kCj4ga2VybmVsIGNhbiBwcm9w
YWdhdGUgaXQgdG8gdGhlIGRyaXZlci4KCgpJIHdvbmRlciBpZiB3ZSBjYW4gc2ltcGx5IGZvcmNl
IExFIGFuZCB0aGVuIFFlbXUgY2FuIGRvIHRoZSBlbmRpYW4gCmNvbnZlcnNpb24/CgpUaGFua3MK
Cgo+Cj4+IFNvIGlmIHlvdSB0aGluayB3ZSBzaG91bGQgYWRkIGEgdmRwYV9vcHMtPmdldF9lbmRp
YW4oKSwKPj4gSSB3aWxsIGRyb3AgdGhlc2UgY29tbWVudHMgaW4gdGhlIG5leHQgdmVyc2lvbiBv
Zgo+PiBzZXJpZXMsIGFuZCB3b3JrIG9uIGEgbmV3IHBhdGNoIGZvciBnZXRfZW5kaWFuKCkuCj4+
Cj4+IFRoYW5rcywKPj4gWmh1IExpbmdzaGFuCj4gR3Vlc3RzIGRvbid0IGdldCBlbmRpYW4tbmVz
cyBmcm9tIGRldmljZXMgc28gdGhpcyBzZWVtcyBwb2ludGxlc3MuCj4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
