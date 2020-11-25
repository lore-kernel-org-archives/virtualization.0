Return-Path: <SRS0=EQvy=E7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D72C5519F
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 07:09:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BC86206E5
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 07:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZqHcBIyS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BC86206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 742E7228CA;
	Wed, 25 Nov 2020 07:09:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5oYXDQBnwnOY; Wed, 25 Nov 2020 07:09:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6BB4927230;
	Wed, 25 Nov 2020 07:09:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7040C163C;
	Wed, 25 Nov 2020 07:09:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D326C0052
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 07:09:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 311FC84C26
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 07:09:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pyMsFw5Y5P-e
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 07:09:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 105FD84B08
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 07:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606288156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VUSbcPm6ZnSi1CPK9hIkQAxwx3nEzibHi6QrBh+W7dE=;
 b=ZqHcBIySTUrn8hKxRxxApA/3H2Cx/C/pDCgReK3hOnRog4wGYv9/zYC5za/ZJ6iLWsddBP
 eZL0hKjlsvtBFsZ4igfKMIJOLbtY/aYxGdxPDa5yW+7yFoWtGh9/5Xo93nxjz3S16L2+NC
 AMXu6T9HUllgGK+b2X/h7smygRTNWXw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-bycO1I44PYCAiQ5nbkcSJA-1; Wed, 25 Nov 2020 02:09:11 -0500
X-MC-Unique: bycO1I44PYCAiQ5nbkcSJA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEF5A809DD9;
 Wed, 25 Nov 2020 07:09:08 +0000 (UTC)
Received: from [10.72.13.165] (ovpn-13-165.pek2.redhat.com [10.72.13.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 09EF519C46;
 Wed, 25 Nov 2020 07:08:33 +0000 (UTC)
Subject: Re: [RFC PATCH 00/27] vDPA software assisted live migration
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20201120185105.279030-1-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5a4d0b7a-fb62-9e78-9e85-9262dca57f1c@redhat.com>
Date: Wed, 25 Nov 2020 15:08:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201120185105.279030-1-eperezma@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Daly <dandaly0@gmail.com>, virtualization@lists.linux-foundation.org,
 Liran Alon <liralon@gmail.com>, Eli Cohen <eli@mellanox.com>,
 Nitin Shrivastav <nitin.shrivastav@broadcom.com>,
 Alex Barba <alex.barba@broadcom.com>,
 Christophe Fontaine <cfontain@redhat.com>, Lee Ballard <ballle98@gmail.com>,
 Lars Ganrot <lars.ganrot@gmail.com>, Rob Miller <rob.miller@broadcom.com>,
 Howard Cai <howard.cai@gmail.com>, Parav Pandit <parav@mellanox.com>,
 vm <vmireyno@marvell.com>, Salil Mehta <mehta.salil.lnk@gmail.com>,
 Stephen Finucane <stephenfin@redhat.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Sean Mooney <smooney@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jim Harford <jim.harford@broadcom.com>,
 Dmytro Kazantsev <dmytro.kazantsev@gmail.com>, Siwei Liu <loseweigh@gmail.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Michael Lilja <ml@napatech.com>,
 Max Gurtovoy <maxgu14@gmail.com>
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

Ck9uIDIwMjAvMTEvMjEg5LiK5Y2IMjo1MCwgRXVnZW5pbyBQw6lyZXogd3JvdGU6Cj4gVGhpcyBz
ZXJpZXMgZW5hYmxlIHZEUEEgc29mdHdhcmUgYXNzaXN0ZWQgbGl2ZSBtaWdyYXRpb24gZm9yIHZo
b3N0LW5ldAo+IGRldmljZXMuIFRoaXMgaXMgYSBuZXcgbWV0aG9kIG9mIHZob3N0IGRldmljZXMg
bWlncmF0aW9uOiBJbnN0ZWFkIG9mCj4gcmVsYXkgb24gdkRQQSBkZXZpY2UncyBkaXJ0eSBsb2dn
aW5nIGNhcGFiaWxpdHksIFNXIGFzc2lzdGVkIExNCj4gaW50ZXJjZXB0cyBkYXRhcGxhbmUsIGZv
cndhcmRpbmcgdGhlIGRlc2NyaXB0b3JzIGJldHdlZW4gVk0gYW5kIGRldmljZS4KPgo+IEluIHRo
aXMgbWlncmF0aW9uIG1vZGUsIHFlbXUgb2ZmZXJzIGEgbmV3IHZyaW5nIHRvIHRoZSBkZXZpY2Ug
dG8KPiByZWFkIGFuZCB3cml0ZSBpbnRvLCBhbmQgZGlzYWJsZSB2aG9zdCBub3RpZmllcnMsIHBy
b2Nlc3NpbmcgZ3Vlc3QgYW5kCj4gdmhvc3Qgbm90aWZpY2F0aW9ucyBpbiBxZW11LiBPbiB1c2Vk
IGJ1ZmZlciByZWxheSwgcWVtdSB3aWxsIG1hcmsgdGhlCj4gZGlydHkgbWVtb3J5IGFzIHdpdGgg
cGxhaW4gdmlydGlvLW5ldCBkZXZpY2VzLiBUaGlzIHdheSwgZGV2aWNlcyBkb2VzCj4gbm90IG5l
ZWQgdG8gaGF2ZSBkaXJ0eSBwYWdlIGxvZ2dpbmcgY2FwYWJpbGl0eS4KPgo+IFRoaXMgc2VyaWVz
IGlzIGEgUE9DIGRvaW5nIFNXIExNIGZvciB2aG9zdC1uZXQgZGV2aWNlcywgd2hpY2ggYWxyZWFk
eQo+IGhhdmUgZGlydHkgcGFnZSBsb2dnaW5nIGNhcGFiaWxpdGllcy4gTm9uZSBvZiB0aGUgY2hh
bmdlcyBoYXZlIGFjdHVhbAo+IGVmZmVjdCB3aXRoIGN1cnJlbnQgZGV2aWNlcyB1bnRpbCBsYXN0
IHR3byBwYXRjaGVzICgyNiBhbmQgMjcpIGFyZQo+IGFwcGxpZWQsIGJ1dCB0aGV5IGNhbiBiZSBy
ZWJhc2VkIG9uIHRvcCBvZiBhbnkgb3RoZXIuIFRoZXNlIGNoZWNrcyB0aGUKPiBkZXZpY2UgdG8g
bWVldCBhbGwgcmVxdWlyZW1lbnRzLCBhbmQgZGlzYWJsZSB2aG9zdC1uZXQgZGV2aWNlcyBsb2dn
aW5nCj4gc28gbWlncmF0aW9uIGdvZXMgdGhyb3VnaCBTVyBMTS4gVGhpcyBsYXN0IHBhdGNoIGlz
IG5vdCBtZWFudCB0byBiZQo+IGFwcGxpZWQgaW4gdGhlIGZpbmFsIHJldmlzaW9uLCBpdCBpcyBp
biB0aGUgc2VyaWVzIGp1c3QgZm9yIHRlc3RpbmcKPiBwdXJwb3Nlcy4KPgo+IEZvciB1c2UgU1cg
YXNzaXN0ZWQgTE0gdGhlc2Ugdmhvc3QtbmV0IGRldmljZXMgbmVlZCB0byBiZSBpbnN0YW50aWF0
ZWQ6Cj4gKiBXaXRoIElPTU1VIChpb21tdV9wbGF0Zm9ybT1vbixhdHM9b24pCj4gKiBXaXRob3V0
IGV2ZW50X2lkeCAoZXZlbnRfaWR4PW9mZikKCgpTbyBhIHF1ZXN0aW9uIGlzIGF0IHdoYXQgbGV2
ZWwgZG8gd2Ugd2FudCB0byBpbXBsZW1lbnQgcWVtdSBhc3Npc3RlZCAKbGl2ZSBtaWdyYXRpb24u
IFRvIG1lIGl0IGNvdWxkIGJlIGRvbmUgYXQgdHdvIGxldmVsczoKCjEpIGdlbmVyaWMgdmhvc3Qg
bGV2ZWwgd2hpY2ggbWFrZXMgaXQgd29yayBmb3IgYm90aCB2aG9zdC1uZXQvdmhvc3QtdXNlciAK
YW5kIHZob3N0LXZEUEEKMikgYSBzcGVjaWZpYyB0eXBlIG9mIHZob3N0CgpUbyBtZSwgaGF2aW5n
IGEgZ2VuZXJpYyBvbmUgbG9va3MgYmV0dGVyIGJ1dCBpdCB3b3VsZCBiZSBtdWNoIG1vcmUgCmNv
bXBsaWNhdGVkLiBTbyB3aGF0IEkgcmVhZCBmcm9tIHRoaXMgc2VyaWVzIGlzIGl0IHdhcyBhIHZo
b3N0IGtlcm5lbCAKc3BlY2lmaWMgc29mdHdhcmUgYXNzaXN0ZWQgbGl2ZSBtaWdyYXRpb24gd2hp
Y2ggaXMgYSBnb29kIHN0YXJ0LiAKQWN0dWFsbHkgaXQgbWF5IGV2ZW4gaGF2ZSByZWFsIHVzZSBj
YXNlLCBlLmcgaXQgY2FuIHNhdmUgZGlydHkgYml0bWFwcyAKZm9yIGd1ZXN0IHdpdGggbGFyZ2Ug
bWVtb3J5LiBCdXQgd2UgbmVlZCB0byBhZGRyZXNzIHRoZSBhYm92ZSAKbGltaXRhdGlvbnMgZmly
c3QuCgpTbyBJIHdvdWxkIGxpa2UgdG8ga25vdyB3aGF0J3MgdGhlIHJlYXNvbiBmb3IgbWFuZGF0
aW5nIGlvbW11IHBsYXRmb3JtIAphbmQgYXRzPyBBbmQgSSB0aGluayB3ZSBuZWVkIHRvIGZpeCBj
YXNlIG9mIGV2ZW50IGlkeCBzdXBwb3J0LgoKCj4KPiBKdXN0IHRoZSBub3RpZmljYXRpb24gZm9y
d2FyZGluZyAod2l0aCBubyBkZXNjcmlwdG9yIHJlbGF5KSBjYW4gYmUKPiBhY2hpZXZlZCB3aXRo
IHBhdGNoZXMgNyBhbmQgOSwgYW5kIHN0YXJ0aW5nIG1pZ3JhdGlvbi4gUGFydGlhbCBhcHBsaWVz
Cj4gYmV0d2VlbiAxMyBhbmQgMjQgd2lsbCBub3Qgd29yayB3aGlsZSBtaWdyYXRpbmcgb24gc291
cmNlLCBhbmQgcGF0Y2gKPiAyNSBpcyBuZWVkZWQgZm9yIHRoZSBkZXN0aW5hdGlvbiB0byByZXN1
bWUgbmV0d29yayBhY3Rpdml0eS4KPgo+IEl0IGlzIGJhc2VkIG9uIHRoZSBpZGVhcyBvZiBEUERL
IFNXIGFzc2lzdGVkIExNLCBpbiB0aGUgc2VyaWVzIG9mCgoKQWN0dWFsbHkgd2UncmUgYmV0dGVy
IHRoYW4gdGhhdCBzaW5jZSB0aGVyZSdzIG5vIG5lZWQgdGhlIHRyaWNrIGxpa2UgCmhhcmRjb2Rl
ZCBJT1ZBIGZvciBtZWRpYXRlZChzaGFkb3cpIHZpcnRxdWV1ZS4KCgo+IERQREsncyBodHRwczov
L3BhdGNod29yay5kcGRrLm9yZy9jb3Zlci80ODM3MC8gLgoKCkkgbm90aWNlIHRoYXQgeW91IGRv
IEdQQS0+VkEgdHJhbnNsYXRpb25zIGFuZCB0cnkgdG8gZXN0YWJsaXNoIGEgVkEtPlZBIAoodXNl
IFZBIGFzIElPVkEpIG1hcHBpbmcgdmlhIGRldmljZSBJT1RMQi4gVGhpcyBzaG9ydGN1dCBzaG91
bGQgd29yayBmb3IgCnZob3N0LWtlcm5lbC91c2VyIGJ1dCBub3Qgdmhvc3QtdkRQQS4gVGhlIHJl
YXNvbiBpcyB0aGF0IHRoZXJlJ3Mgbm8gCmd1YXJhbnRlZSB0aGF0IHRoZSB3aG9sZSA2NGJpdCBh
ZGRyZXNzIHJhbmdlIGNvdWxkIGJlIHVzZWQgYXMgSU9WQS4gT25lIApleGFtcGxlIGlzIHRoYXQg
Zm9yIGhhcmR3YXJlIElPTU1VIGxpa2UgaW50ZWwsIGl0IHVzdWFsbHkgaGFzIDQ3IG9yIDUyIApi
aXRzIG9mIGFkZHJlc3Mgd2lkdGguCgpTbyB3ZSBwcm9iYWJseSBuZWVkIGFuIElPVkEgYWxsb2Nh
dG9yIHRoYXQgY2FuIG1ha2Ugc3VyZSB0aGUgSU9WQSBpcyBub3QgCm92ZXJsYXBwZWQgYW5kIGZp
dCBmb3IgWzFdLiBXZSBjYW4gcHJvYmFibHkgYnVpbGQgdGhlIElPVkEgZm9yIGd1ZXN0IFZBIAp2
aWEgbWVtb3J5IGxpc3RlbmVycy4gVGhlbiB3ZSBoYXZlCgoxKSBJT1ZBIGZvciBHUEEKMikgSU9W
QSBmb3Igc2hhZG93IFZRCgpBbmQgYWR2ZXJ0aXNlIElPVkEgdG8gVkEgbWFwcGluZyB0byB2aG9z
dC4KClsxXSAKaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQv
dG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9MWI0OGRjMDNlNTc1YTg3MjQwNGYzM2IwNGNk
MjM3OTUzYzVkNzQ5OAoKCj4KPiBDb21tZW50cyBhcmUgd2VsY29tZS4KPgo+IFRoYW5rcyEKPgo+
IEV1Z2VuaW8gUMOpcmV6ICgyNyk6Cj4gICAgdmhvc3Q6IEFkZCB2aG9zdF9kZXZfY2FuX2xvZwo+
ICAgIHZob3N0OiBBZGQgZGV2aWNlIGNhbGxiYWNrIGluIHZob3N0X21pZ3JhdGlvbl9sb2cKPiAg
ICB2aG9zdDogTW92ZSBsb2cgcmVzaXplL3B1dCB0byB2aG9zdF9kZXZfc2V0X2xvZwo+ICAgIHZo
b3N0OiBhZGQgdmhvc3Rfa2VybmVsX3NldF92cmluZ19lbmFibGUKPiAgICB2aG9zdDogQWRkIGhk
ZXYtPmRldi5zd19sbV92cV9oYW5kbGVyCj4gICAgdmlydGlvOiBBZGQgdmlydGlvX3F1ZXVlX2dl
dF91c2VkX25vdGlmeV9zcGxpdAo+ICAgIHZob3N0OiBSb3V0ZSBndWVzdC0+aG9zdCBub3RpZmlj
YXRpb24gdGhyb3VnaCBxZW11Cj4gICAgdmhvc3Q6IEFkZCBhIGZsYWcgZm9yIHNvZnR3YXJlIGFz
c2lzdGVkIExpdmUgTWlncmF0aW9uCj4gICAgdmhvc3Q6IFJvdXRlIGhvc3QtPmd1ZXN0IG5vdGlm
aWNhdGlvbiB0aHJvdWdoIHFlbXUKPiAgICB2aG9zdDogQWxsb2NhdGUgc2hhZG93IHZyaW5nCj4g
ICAgdmlydGlvOiBjb25zdC1pZnkgYWxsIHZpcnRpb190c3dhcCogZnVuY3Rpb25zCj4gICAgdmly
dGlvOiBBZGQgdmlydGlvX3F1ZXVlX2Z1bGwKPiAgICB2aG9zdDogU2VuZCBidWZmZXJzIHRvIGRl
dmljZQo+ICAgIHZpcnRpbzogUmVtb3ZlIHZpcnRpb19xdWV1ZV9nZXRfdXNlZF9ub3RpZnlfc3Bs
aXQKPiAgICB2aG9zdDogRG8gbm90IGludmFsaWRhdGUgc2lnbmFsbGVkIHVzZWQKPiAgICB2aXJ0
aW86IEV4cG9zZSB2aXJ0cXVldWVfYWxsb2NfZWxlbWVudAo+ICAgIHZob3N0OiBhZGQgdmhvc3Rf
dnJpbmdfc2V0X25vdGlmaWNhdGlvbl9yY3UKPiAgICB2aG9zdDogYWRkIHZob3N0X3ZyaW5nX3Bv
bGxfcmN1Cj4gICAgdmhvc3Q6IGFkZCB2aG9zdF92cmluZ19nZXRfYnVmX3JjdQo+ICAgIHZob3N0
OiBSZXR1cm4gdXNlZCBidWZmZXJzCj4gICAgdmhvc3Q6IEFkZCB2aG9zdF92aXJ0cXVldWVfbWVt
b3J5X3VubWFwCj4gICAgdmhvc3Q6IEFkZCB2aG9zdF92aXJ0cXVldWVfbWVtb3J5X21hcAo+ICAg
IHZob3N0OiB1bm1hcCBxZW11J3Mgc2hhZG93IHZpcnRxdWV1ZXMgb24gc3cgbGl2ZSBtaWdyYXRp
b24KPiAgICB2aG9zdDogaW9tbXUgY2hhbmdlcwo+ICAgIHZob3N0OiBEbyBub3QgY29tbWl0IHZo
b3N0IHVzZWQgaWR4IG9uIHZob3N0X3ZpcnRxdWV1ZV9zdG9wCj4gICAgdmhvc3Q6IEFkZCB2aG9z
dF9oZGV2X2Nhbl9zd19sbQo+ICAgIHZob3N0OiBmb3JiaWQgdmhvc3QgZGV2aWNlcyBsb2dnaW5n
Cj4KPiAgIGh3L3ZpcnRpby92aG9zdC1zdy1sbS1yaW5nLmggICAgICB8ICAzOSArKysKPiAgIGlu
Y2x1ZGUvaHcvdmlydGlvL3Zob3N0LmggICAgICAgICB8ICAgNSArCj4gICBpbmNsdWRlL2h3L3Zp
cnRpby92aXJ0aW8tYWNjZXNzLmggfCAgIDggKy0KPiAgIGluY2x1ZGUvaHcvdmlydGlvL3ZpcnRp
by5oICAgICAgICB8ICAgNCArCj4gICBody9uZXQvdmlydGlvLW5ldC5jICAgICAgICAgICAgICAg
fCAgMzkgKystCj4gICBody92aXJ0aW8vdmhvc3QtYmFja2VuZC5jICAgICAgICAgfCAgMjkgKysK
PiAgIGh3L3ZpcnRpby92aG9zdC1zdy1sbS1yaW5nLmMgICAgICB8IDI2OCArKysrKysrKysrKysr
KysrKysrCj4gICBody92aXJ0aW8vdmhvc3QuYyAgICAgICAgICAgICAgICAgfCA0MzEgKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tCj4gICBody92aXJ0aW8vdmlydGlvLmMgICAgICAgICAg
ICAgICAgfCAgMTggKy0KPiAgIGh3L3ZpcnRpby9tZXNvbi5idWlsZCAgICAgICAgICAgICB8ICAg
MiArLQo+ICAgMTAgZmlsZXMgY2hhbmdlZCwgNzU4IGluc2VydGlvbnMoKyksIDg1IGRlbGV0aW9u
cygtKQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L3ZpcnRpby92aG9zdC1zdy1sbS1yaW5nLmgK
PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBody92aXJ0aW8vdmhvc3Qtc3ctbG0tcmluZy5jCgoKU28g
dGhpcyBsb29rcyBsaWtlIGEgcHJldHR5IGh1Z2UgcGF0Y2hzZXQgd2hpY2ggSSdtIHRyeWluZyB0
byB0aGluayBvZiAKd2F5cyB0byBzcGxpdC4gQW4gaWRlYSBpcyB0byBkbyB0aGlzIGlzIHR3byBz
dGVwcwoKMSkgaW1wbGVtZW50IGEgc2hhZG93IHZpcnRxdWV1ZSBtb2RlIGZvciB2aG9zdCBmaXJz
dCAody9vIGxpdmUgCm1pZ3JhdGlvbikuIFRoZW4gd2UgY2FuIHRlc3QgZGVzY3JpcHRvcnMgcmVs
YXksIElPVkEgYWxsb2NhdGluZywgZXRjLgoyKSBhZGQgbGl2ZSBtaWdyYXRpb24gc3VwcG9ydCBv
biB0b3AKCkFuZCBpdCBsb29rcyB0byBtZSBpdCdzIGJldHRlciB0byBzcGxpdCB0aGUgc2hhZG93
IHZpcnRxdWV1ZSAodmlydGlvIApkcml2ZXIgcGFydCkgaW50byBhbiBpbmRlcGVuZGVudCBmaWxl
LiBBbmQgdXNlIGdlbmVyaWMgbmFtZSAody9vIAoic2hhZG93IikgaW4gb3JkZXIgdG8gYmUgcmV1
c2VkIGJ5IG90aGVyIHVzZSBjYXNlcyBhcyB3ZWxsLgoKVGhvdWdodHM/CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
