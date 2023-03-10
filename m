Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C67C6FD19
	for <virtualization@archiver.kernel.org>; Fri, 10 Mar 2023 08:37:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CEB6680DA8;
	Fri, 10 Mar 2023 08:37:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CEB6680DA8
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GY6G42Bo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dSDP13DpGeAR; Fri, 10 Mar 2023 08:37:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 08F4B801EA;
	Fri, 10 Mar 2023 08:37:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 08F4B801EA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9A22C0071;
	Fri, 10 Mar 2023 08:37:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B5C1C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 08:37:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E67FB60B35
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 08:37:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E67FB60B35
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GY6G42Bo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oZhvB_B70zO4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 08:37:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0C3EE60B2A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0C3EE60B2A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 08:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678437451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O8ovMxuqTav+RM59yevfCqZhcFC/qRlWg3JJtflmVmY=;
 b=GY6G42BoTJlkX5lWNmM1dhaPuFIaCAJ+YouFbQKNy1rnrXdKHUMpUNmWP76FNoyUGn5TTL
 W9urTHoB1cDDCSuOzGvShowk1hPhYUYS7/I5c6lpyAS3GZRXG7vaU5Q29/8wB4LxUPFjnW
 FSBFmLFhyIxyaxguvt5tEY7V+m37N1w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-NBoBf08XMGiuZrWGcK2ebw-1; Fri, 10 Mar 2023 03:37:30 -0500
X-MC-Unique: NBoBf08XMGiuZrWGcK2ebw-1
Received: by mail-wm1-f71.google.com with SMTP id
 o27-20020a05600c511b00b003ebf87958f8so1721704wms.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 00:37:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678437449;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O8ovMxuqTav+RM59yevfCqZhcFC/qRlWg3JJtflmVmY=;
 b=M2R4lCTP635jCCobc2PbkO4mJpCv2aAT70q0vNOnzS4u+n8qNubBKtf9s1G6wS1JVM
 mjNz96dGy+Ou40292MNYSWh4DhPbMLivwoa+Qx1Kgy4ckt5FpQh7EiI//gK//LNupEAe
 RhcawSLSXoL5XL8S8s/7kkMyYfAGQdLpsKqM/2L1X/o1SUJrGwU7QOnjYNVKa0cZzzH8
 BTGaoD8GV8gIYhB+mCuNzr1Ou4v/gTb6xvOS33Lk6DZD94nQFT5Iyk+hsuF4LidPCqBY
 o7JbX7dmLBGxoX5QdU4zQO7MM/bceyUt+XoXqcuY6XxD+7VOr1HUlbvMz9H3EXQ/RXyR
 AfmA==
X-Gm-Message-State: AO0yUKU7BRgM8YBN6CuPlHKxKy/UklZfrjBlO8sWvwKzTgy2YdX+AzMf
 11Bw4a2irCyLyJslKsjI7ci5ta14tF4qUMQIBIYy1+JP7NAikPz6iUAB2wykooIptPVLJ+YNzfU
 1qsoNpYtaHRhvB+l/8bX9aaWyXWkeGJTMQj9CtCmPUA==
X-Received: by 2002:a5d:6605:0:b0:2c7:7701:2578 with SMTP id
 n5-20020a5d6605000000b002c777012578mr15657387wru.54.1678437449506; 
 Fri, 10 Mar 2023 00:37:29 -0800 (PST)
X-Google-Smtp-Source: AK7set+y1SLlYCLoZWlLhVUFLLO4mwRgZFYa2PT7ddRAXzE9lqne3QFfWheWewGObdmXBjz49fAnmw==
X-Received: by 2002:a5d:6605:0:b0:2c7:7701:2578 with SMTP id
 n5-20020a5d6605000000b002c777012578mr15657381wru.54.1678437449202; 
 Fri, 10 Mar 2023 00:37:29 -0800 (PST)
Received: from redhat.com ([2.52.9.88]) by smtp.gmail.com with ESMTPSA id
 c14-20020adffb0e000000b002c7107ce17fsm1562448wrr.3.2023.03.10.00.37.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Mar 2023 00:37:28 -0800 (PST)
Date: Fri, 10 Mar 2023 03:37:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Longpeng (Mike,
 Cloud Infrastructure Service Product Dept.)" <longpeng2@huawei.com>
Subject: Re: [PATCH] vhost-vdpa: cleanup memory maps when closing vdpa fds
Message-ID: <20230310033706-mutt-send-email-mst@kernel.org>
References: <20230131145310.2069-1-longpeng2@huawei.com>
 <db99245c-606a-2f24-52fe-836a6972437f@redhat.com>
 <35b94992-0c6b-a190-1fce-5dda9c8dcf4b@huawei.com>
 <CACGkMEt0Rgkcmt9k4dWsp-qqtPvrM40mtgmSERc0A7Ve1wzKHw@mail.gmail.com>
 <ad0ab6b8-1e1e-f686-eb5c-78cc63869c54@huawei.com>
 <CACGkMEsOWmVGA1RYTNZybmzkz53g5cYEkJeMK_9uuQu-ezZcqg@mail.gmail.com>
 <af95c38d-fdca-aef0-55ae-bbb0baee6029@huawei.com>
MIME-Version: 1.0
In-Reply-To: <af95c38d-fdca-aef0-55ae-bbb0baee6029@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, huangzhichao@huawei.com,
 yechuan@huawei.com
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

T24gV2VkLCBGZWIgMTUsIDIwMjMgYXQgMDE6MTU6NTVQTSArMDgwMCwgTG9uZ3BlbmcgKE1pa2Us
IENsb3VkIEluZnJhc3RydWN0dXJlIFNlcnZpY2UgUHJvZHVjdCBEZXB0Likgd3JvdGU6Cj4gCj4g
Cj4g5ZyoIDIwMjMvMi8xNSAxMDo1NiwgSmFzb24gV2FuZyDlhpnpgZM6Cj4gPiBPbiBXZWQsIEZl
YiAxNSwgMjAyMyBhdCAxMDo0OSBBTSBMb25ncGVuZyAoTWlrZSwgQ2xvdWQgSW5mcmFzdHJ1Y3R1
cmUKPiA+IFNlcnZpY2UgUHJvZHVjdCBEZXB0LikgPGxvbmdwZW5nMkBodWF3ZWkuY29tPiB3cm90
ZToKPiA+ID4gCj4gPiA+IAo+ID4gPiAKPiA+ID4g5ZyoIDIwMjMvMi8xNSAxMDowMCwgSmFzb24g
V2FuZyDlhpnpgZM6Cj4gPiA+ID4gT24gVHVlLCBGZWIgMTQsIDIwMjMgYXQgMjoyOCBQTSBMb25n
cGVuZyAoTWlrZSwgQ2xvdWQgSW5mcmFzdHJ1Y3R1cmUKPiA+ID4gPiBTZXJ2aWNlIFByb2R1Y3Qg
RGVwdC4pIDxsb25ncGVuZzJAaHVhd2VpLmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiAKPiA+ID4gPiA+
IAo+ID4gPiA+ID4gCj4gPiA+ID4gPiDlnKggMjAyMy8yLzE0IDE0OjE2LCBKYXNvbiBXYW5nIOWG
memBkzoKPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IOWcqCAyMDIzLzEvMzEgMjI6NTMsIExvbmdw
ZW5nKE1pa2UpIOWGmemBkzoKPiA+ID4gPiA+ID4gPiBGcm9tOiBMb25ncGVuZyA8bG9uZ3Blbmcy
QGh1YXdlaS5jb20+Cj4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gV2UgbXVzdCBjbGVhbnVw
IGFsbCBtZW1vcnkgbWFwcyB3aGVuIGNsb3NpbmcgdGhlIHZkcGEgZmRzLCBvdGhlcndpc2UKPiA+
ID4gPiA+ID4gPiBzb21lIGNyaXRpY2FsIHJlc291cmNlcyAoZS5nLiBtZW1vcnksIGlvbW11IG1h
cCkgd2lsbCBsZWFrZWQgaWYgdGhlCj4gPiA+ID4gPiA+ID4gdXNlcnNwYWNlIGV4aXRzIHVuZXhw
ZWN0ZWRseSAoZS5nLiBraWxsIC05KS4KPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IAo+ID4gPiA+
ID4gPiBTb3VuZHMgbGlrZSBhIGJ1ZyBvZiB0aGUga2VybmVsLCBzaG91bGQgd2UgZml4IHRoZXJl
Pwo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+IAo+ID4gPiA+ID4gRm9yIGV4YW1wbGUsIHRoZSBpb21t
dSBtYXAgaXMgc2V0dXAgd2hlbiBRRU1VIGNhbGxzIFZIT1NUX0lPVExCX1VQREFURQo+ID4gPiA+
ID4gaW9jdGwgYW5kIGl0J2xsIGJlIGZyZWVkIGlmIFFFTVUgY2FsbHMgVkhPU1RfSU9UTEJfSU5W
QUxJREFURSBpb2N0bC4KPiA+ID4gPiA+IAo+ID4gPiA+ID4gU28gbWF5YmUgd2UgcmVsZWFzZSB0
aGVzZSByZXNvdXJjZXMgaW4gdmRwYSBmcmFtZXdvcmsgaW4ga2VybmVsIGlzIGEKPiA+ID4gPiA+
IHN1aXRhYmxlIGNob2ljZT8KPiA+ID4gPiAKPiA+ID4gPiBJIHRoaW5rIEkgbmVlZCB1bmRlcnN0
YW5kIHdoYXQgZG9lcyAicmVzb3VyY2VzIiBtZWFuIGhlcmU6Cj4gPiA+ID4gCj4gPiA+ID4gRm9y
IGlvbW11IG1hcHBpbmcsIGl0IHNob3VsZCBiZSBmcmVlZCBieSB2aG9zdF92ZHBhX2ZyZWVfZG9t
YWluKCkgaW4KPiA+ID4gPiB2aG9zdF92ZHBhX3JlbGVhc2UoKT8KPiA+ID4gPiAKPiA+ID4gCj4g
PiA+IFBsZWFzZSBjb25zaWRlciB0aGUgZm9sbG93aW5nIGxpZmVjeWNsZSBvZiB0aGUgdmRwYSBk
ZXZpY2U6Cj4gPiA+IAo+ID4gPiAxLiB2aG9zdF92ZHBhX29wZW4KPiA+ID4gICAgICAgdmhvc3Rf
dmRwYV9hbGxvY19kb21haW4KPiA+ID4gCj4gPiA+IDIuIHZob3N0X3ZkcGFfcGFfbWFwCj4gPiA+
ICAgICAgIHBpbl91c2VyX3BhZ2VzCj4gPiA+ICAgICAgIHZob3N0X3ZkcGFfbWFwCj4gPiA+ICAg
ICAgICAgaW9tbXVfbWFwCj4gPiA+IAo+ID4gPiAzLiBraWxsIFFFTVUKPiA+ID4gCj4gPiA+IDQu
IHZob3N0X3ZkcGFfcmVsZWFzZQo+ID4gPiAgICAgICB2aG9zdF92ZHBhX2ZyZWVfZG9tYWluCj4g
PiA+IAo+ID4gPiBJbiB0aGlzIGNhc2UsIHdlIGhhdmUgbm8gb3Bwb3J0dW5pdHkgdG8gaW52b2tl
IHVucGluX3VzZXJfcGFnZXMgb3IKPiA+ID4gaW9tbXVfdW5tYXAgdG8gZnJlZSB0aGUgbWVtb3J5
Lgo+ID4gCj4gPiBXZSBkbzoKPiA+IAo+ID4gdmhvc3RfdmRwYV9jbGVhbnVwKCkKPiA+ICAgICAg
dmhvc3RfdmRwYV9yZW1vdmVfYXMoKQo+ID4gICAgICAgICAgdmhvc3RfdmRwYV9pb3RsYl91bm1h
cCgpCj4gPiAgICAgICAgICAgICAgdmhvc3RfdmRwYV9wYV91bm1hcCgpCj4gPiAgICAgICAgICAg
ICAgICAgIHVucGluX3VzZXJfcGFnZXMoKQo+ID4gICAgICAgICAgICAgICAgICB2aG9zdF92ZHBh
X2dlbmVyYWxfdW5tYXAoKQo+ID4gICAgICAgICAgICAgICAgICAgICAgaW9tbXVfdW5tYXAoKQo+
ID4gPwo+ID4gCj4gT2gsIG15IGNvZGViYXNlIGlzIGxpbnV4LTYuMi1yYzIgYW5kIHRoZSBjb21t
aXQgYzA3MGMxOTEyYTggKHZob3N0LXZkcGE6IGZpeAo+IGFuIGlvdGxiIG1lbW9yeSBsZWFrKSBh
bHJlYWR5IGZpeGVkIHRoaXMgYnVnIGluIGxpbnV4LTYuMi1yYzMuCgpPSyBJIGRyb3BwZWQgdGhp
cy4KCj4gPiBCdHcsIGl0IGxvb2tzIGxpa2Ugd2Ugc2hvdWxkIGNhbGwgdmhvc3RfdmRwYV9mcmVl
X2RvbWFpbigpICphZnRlcioKPiA+IHZob3N0X3ZkcGFfY2xlYW51cCgpIG90aGVyd2lzZSBpdCdz
IGEgVUFGPwo+ID4gCj4gSSB0aGluayBzbywgdGhlIHYtPmRvbWFpbiBpcyBzZXQgdG8gTlVMTCBp
biB2aG9zdF92ZHBhX2ZyZWVfZG9tYWluKCksIGl0Cj4gc2VlbXMgd291bGQgdHJpZ2dlciBudWxs
LXBvaW50ZXIgYWNjZXNzIGluIG15IGNhc2UuCj4gCj4gPiBUaGFua3MKPiA+IAo+ID4gPiAKPiA+
ID4gPiBzdGF0aWMgaW50IHZob3N0X3ZkcGFfcmVsZWFzZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBz
dHJ1Y3QgZmlsZSAqZmlsZXApCj4gPiA+ID4gewo+ID4gPiA+ICAgICAgICAgICBzdHJ1Y3Qgdmhv
c3RfdmRwYSAqdiA9IGZpbGVwLT5wcml2YXRlX2RhdGE7Cj4gPiA+ID4gICAgICAgICAgIHN0cnVj
dCB2aG9zdF9kZXYgKmQgPSAmdi0+dmRldjsKPiA+ID4gPiAKPiA+ID4gPiAgICAgICAgICAgbXV0
ZXhfbG9jaygmZC0+bXV0ZXgpOwo+ID4gPiA+ICAgICAgICAgICBmaWxlcC0+cHJpdmF0ZV9kYXRh
ID0gTlVMTDsKPiA+ID4gPiAgICAgICAgICAgdmhvc3RfdmRwYV9jbGVhbl9pcnEodik7Cj4gPiA+
ID4gICAgICAgICAgIHZob3N0X3ZkcGFfcmVzZXQodik7Cj4gPiA+ID4gICAgICAgICAgIHZob3N0
X2Rldl9zdG9wKCZ2LT52ZGV2KTsKPiA+ID4gPiAgICAgICAgICAgdmhvc3RfdmRwYV9mcmVlX2Rv
bWFpbih2KTsKPiA+ID4gPiAgICAgICAgICAgdmhvc3RfdmRwYV9jb25maWdfcHV0KHYpOwo+ID4g
PiA+ICAgICAgICAgICB2aG9zdF92ZHBhX2NsZWFudXAodik7Cj4gPiA+ID4gICAgICAgICAgIG11
dGV4X3VubG9jaygmZC0+bXV0ZXgpOwo+ID4gPiA+IAo+ID4gPiA+ICAgICAgICAgICBhdG9taWNf
ZGVjKCZ2LT5vcGVuZWQpOwo+ID4gPiA+ICAgICAgICAgICBjb21wbGV0ZSgmdi0+Y29tcGxldGlv
bik7Cj4gPiA+ID4gCj4gPiA+ID4gICAgICAgICAgIHJldHVybiAwOwo+ID4gPiA+IH0KPiA+ID4g
PiAKPiA+ID4gPiA+IAo+ID4gPiA+ID4gQnkgdGhlIHdheSwgSmFzb24sIGNhbiB5b3UgcmVwcm9k
dWNlIHRoZSBwcm9ibGVtIGluIHlvdXIgbWFjaGluZT8KPiA+ID4gPiA+IAo+ID4gPiA+IAo+ID4g
PiA+IEhhdmVuJ3QgZ290IHRpbWUgaW4gZG9pbmcgdGhpcyBidXQgaXQgc2hvdWxkIGJlIHRoZSBy
ZXNwb25zaWJpbGl0eSBvZgo+ID4gPiA+IHRoZSBhdXRob3IgdG8gdmFsaWRhdGUgdGhpcyBhbnlo
b3cuCj4gPiA+ID4gCj4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gCj4gPiA+ID4gPiA+IFRoYW5rcwo+
ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gU2ln
bmVkLW9mZi1ieTogTG9uZ3BlbmcgPGxvbmdwZW5nMkBodWF3ZWkuY29tPgo+ID4gPiA+ID4gPiA+
IC0tLQo+ID4gPiA+ID4gPiA+ICAgICBkcml2ZXJzL3Zob3N0L3ZkcGEuYyB8IDEzICsrKysrKysr
KysrKysKPiA+ID4gPiA+ID4gPiAgICAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykK
PiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92
ZHBhLmMgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ID4gPiA+ID4gPiA+IGluZGV4IGE1MjdlZWVh
YzYzNy4uMzc0NzdjZmZhNWFhIDEwMDY0NAo+ID4gPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdmhv
c3QvdmRwYS5jCj4gPiA+ID4gPiA+ID4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiA+ID4g
PiA+ID4gPiBAQCAtODIzLDYgKzgyMywxOCBAQCBzdGF0aWMgdm9pZCB2aG9zdF92ZHBhX3VubWFw
KHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgIHZob3N0X3Zk
cGFfcmVtb3ZlX2FzKHYsIGFzaWQpOwo+ID4gPiA+ID4gPiA+ICAgICB9Cj4gPiA+ID4gPiA+ID4g
K3N0YXRpYyB2b2lkIHZob3N0X3ZkcGFfY2xlYW5fbWFwKHN0cnVjdCB2aG9zdF92ZHBhICp2KQo+
ID4gPiA+ID4gPiA+ICt7Cj4gPiA+ID4gPiA+ID4gKyAgICBzdHJ1Y3Qgdmhvc3RfdmRwYV9hcyAq
YXM7Cj4gPiA+ID4gPiA+ID4gKyAgICB1MzIgYXNpZDsKPiA+ID4gPiA+ID4gPiArCj4gPiA+ID4g
PiA+ID4gKyAgICBmb3IgKGFzaWQgPSAwOyBhc2lkIDwgdi0+dmRwYS0+bmFzOyBhc2lkKyspIHsK
PiA+ID4gPiA+ID4gPiArICAgICAgICBhcyA9IGFzaWRfdG9fYXModiwgYXNpZCk7Cj4gPiA+ID4g
PiA+ID4gKyAgICAgICAgaWYgKGFzKQo+ID4gPiA+ID4gPiA+ICsgICAgICAgICAgICB2aG9zdF92
ZHBhX3VubWFwKHYsICZhcy0+aW90bGIsIDBVTEwsIDBVTEwgLSAxKTsKPiA+ID4gPiA+ID4gPiAr
ICAgIH0KPiA+ID4gPiA+ID4gPiArfQo+ID4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4gPiAgICAg
c3RhdGljIGludCB2aG9zdF92ZHBhX3ZhX21hcChzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPiA+ID4g
PiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgdmhvc3RfaW90bGIgKmlvdGxiLAo+
ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgIHU2NCBpb3ZhLCB1NjQgc2l6ZSwgdTY0
IHVhZGRyLCB1MzIgcGVybSkKPiA+ID4gPiA+ID4gPiBAQCAtMTI0Nyw2ICsxMjU5LDcgQEAgc3Rh
dGljIGludCB2aG9zdF92ZHBhX3JlbGVhc2Uoc3RydWN0IGlub2RlCj4gPiA+ID4gPiA+ID4gKmlu
b2RlLCBzdHJ1Y3QgZmlsZSAqZmlsZXApCj4gPiA+ID4gPiA+ID4gICAgICAgICB2aG9zdF92ZHBh
X2NsZWFuX2lycSh2KTsKPiA+ID4gPiA+ID4gPiAgICAgICAgIHZob3N0X3ZkcGFfcmVzZXQodik7
Cj4gPiA+ID4gPiA+ID4gICAgICAgICB2aG9zdF9kZXZfc3RvcCgmdi0+dmRldik7Cj4gPiA+ID4g
PiA+ID4gKyAgICB2aG9zdF92ZHBhX2NsZWFuX21hcCh2KTsKPiA+ID4gPiA+ID4gPiAgICAgICAg
IHZob3N0X3ZkcGFfZnJlZV9kb21haW4odik7Cj4gPiA+ID4gPiA+ID4gICAgICAgICB2aG9zdF92
ZHBhX2NvbmZpZ19wdXQodik7Cj4gPiA+ID4gPiA+ID4gICAgICAgICB2aG9zdF92ZHBhX2NsZWFu
dXAodik7Cj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiAuCj4gPiA+ID4gPiAKPiA+ID4gPiAKPiA+
ID4gPiAuCj4gPiA+IAo+ID4gCj4gPiAuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
