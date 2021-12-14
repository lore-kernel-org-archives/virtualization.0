Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CC6C433F5
	for <virtualization@archiver.kernel.org>; Tue, 14 Dec 2021 03:02:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4B3338136D;
	Tue, 14 Dec 2021 03:02:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0_mEL5rQq4qO; Tue, 14 Dec 2021 03:02:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8D80981360;
	Tue, 14 Dec 2021 03:02:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 558ACC002F;
	Tue, 14 Dec 2021 03:02:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 015AEC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 03:02:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C33CA405D0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 03:02:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MfO2-Khhf6If
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 03:02:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0BDF740154
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 03:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639450934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bu9IQ6OFp8WKIafDhLgGALQ8s+ZyeyFhZV7jSjaz0VE=;
 b=TtmT+WXDB/1JqecrRe0OahxFP94M2PE8cLLBkIYPbL1+PkipInvssbPbrvAbhTn1L1GgQ0
 9AWKDQPTR5WnuLZhMW7ROCYZO1aJZ0bpQvA9S8C9nnIzhXoGYP9v1xjOfoPIRbcDbiLf9R
 HyDd54qd/3f8n0oCfmkefqdToDiqqH4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-wojxrEwHMpSpe2xOFpEWWw-1; Mon, 13 Dec 2021 22:02:10 -0500
X-MC-Unique: wojxrEwHMpSpe2xOFpEWWw-1
Received: by mail-lf1-f69.google.com with SMTP id
 u20-20020a056512129400b0040373ffc60bso8318534lfs.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 19:02:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Bu9IQ6OFp8WKIafDhLgGALQ8s+ZyeyFhZV7jSjaz0VE=;
 b=PbGc1u1Lo36JOVv9b7NbgGKGUy71RXgxzwljlHIceDQ/tMUXCjLlhPBgJPrG2n3fYb
 kcCkQoJf4YQz5eCCwabZ7r6JhEGIdv+EQlEDLu4wVavwT6Wkl75LCkBtXixaKLZe9rZ1
 sY+7XYlgF0iNIRVjAce/1zg8iKsvzDJgS7RvX7hwkIeKwvuHsHD0mjCAx7E2yQJTWSs4
 6jHcF7lDhAw2423GA8OjOS0E1fE+iR8Cjmcio9l/zPP6NBb3y0MDB6yvbOMC0/enSR8W
 Is6Z7WHlAkfXnU2g4kjKB7c8RIPhIyWjTVUpO0cQLeSf5WHrmsYyrQmpXFFh0jCLY6Bh
 dsAA==
X-Gm-Message-State: AOAM5316xSv0uT3CeZqY8NhGtlmJXR3eAKjNABt87TeRL5SGWYq7Jxhk
 VIZrdyjclMuzlFGIc2rUoiqeyghZI8k+bKt9nLjptrXz4wh2w773EJRmCnaGgrTz7bDAy+9Uybx
 /7Q13Ie0fhwzXnGgU8sOzA2/BWRyy3tJyZv9xbNdMLesfxylD5jdiWekudw==
X-Received: by 2002:a05:6512:3d09:: with SMTP id
 d9mr2289507lfv.481.1639450928932; 
 Mon, 13 Dec 2021 19:02:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxoBz5QZXCrzq6mFK2FP4oNu6GUwTHLciq3tJxPrbOySxsyH079jZwtqoTEnDqUSVqEBpDKzOE/W/UkNiJhASU=
X-Received: by 2002:a05:6512:3d09:: with SMTP id
 d9mr2289483lfv.481.1639450928676; 
 Mon, 13 Dec 2021 19:02:08 -0800 (PST)
MIME-Version: 1.0
References: <fae0bae7-e4cd-a3aa-57fe-d707df99b634@redhat.com>
 <20210223082536-mutt-send-email-mst@kernel.org>
 <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
 <20210224000057-mutt-send-email-mst@kernel.org>
 <52836a63-4e00-ff58-50fb-9f450ce968d7@oracle.com>
 <20210228163031-mutt-send-email-mst@kernel.org>
 <2cb51a6d-afa0-7cd1-d6f2-6b153186eaca@redhat.com>
 <20210302043419-mutt-send-email-mst@kernel.org>
 <178f8ea7-cebd-0e81-3dc7-10a058d22c07@redhat.com>
 <c9a0932f-a6d7-a9df-38ba-97e50f70c2b2@oracle.com>
 <20211212042311-mutt-send-email-mst@kernel.org>
 <ba9df703-29af-98a9-c554-f303ff045398@oracle.com>
In-Reply-To: <ba9df703-29af-98a9-c554-f303ff045398@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Dec 2021 11:01:57 +0800
Message-ID: <CACGkMEtS3nKAnda8G19hNf=WaeMAgjgeqj3-pi6CjaDsde9jXA@mail.gmail.com>
Subject: Re: vdpa legacy guest support (was Re: [PATCH] vdpa/mlx5:
 set_features should allow reset to zero)
To: Si-Wei Liu <si-wei.liu@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev <netdev@vger.kernel.org>, Eli Cohen <elic@nvidia.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

T24gVHVlLCBEZWMgMTQsIDIwMjEgYXQgMTA6MDAgQU0gU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBv
cmFjbGUuY29tPiB3cm90ZToKPgo+Cj4KPiBPbiAxMi8xMi8yMDIxIDE6MjYgQU0sIE1pY2hhZWwg
Uy4gVHNpcmtpbiB3cm90ZToKPiA+IE9uIEZyaSwgRGVjIDEwLCAyMDIxIGF0IDA1OjQ0OjE1UE0g
LTA4MDAsIFNpLVdlaSBMaXUgd3JvdGU6Cj4gPj4gU29ycnkgZm9yIHJldml2aW5nIHRoaXMgYW5j
aWVudCB0aHJlYWQuIEkgd2FzIGtpbmRhIGxvc3QgZm9yIHRoZSBjb25jbHVzaW9uCj4gPj4gaXQg
ZW5kZWQgdXAgd2l0aC4gSSBoYXZlIHRoZSBmb2xsb3dpbmcgcXVlc3Rpb25zLAo+ID4+Cj4gPj4g
MS4gbGVnYWN5IGd1ZXN0IHN1cHBvcnQ6IGZyb20gdGhlIHBhc3QgY29udmVyc2F0aW9ucyBpdCBk
b2Vzbid0IHNlZW0gdGhlCj4gPj4gc3VwcG9ydCB3aWxsIGJlIGNvbXBsZXRlbHkgZHJvcHBlZCBm
cm9tIHRoZSB0YWJsZSwgaXMgbXkgdW5kZXJzdGFuZGluZwo+ID4+IGNvcnJlY3Q/IEFjdHVhbGx5
IHdlJ3JlIGludGVyZXN0ZWQgaW4gc3VwcG9ydGluZyB2aXJ0aW8gdjAuOTUgZ3Vlc3QgZm9yIHg4
NiwKPiA+PiB3aGljaCBpcyBiYWNrZWQgYnkgdGhlIHNwZWMgYXQKPiA+PiBodHRwczovL3VybGRl
ZmVuc2UuY29tL3YzL19faHR0cHM6Ly9vemxhYnMub3JnLypydXN0eS92aXJ0aW8tc3BlYy92aXJ0
aW8tMC45LjUucGRmX187ZmchIUFDV1Y1TjlNMlJWOTloUSFkVEttekp3d1JzRk03QnRTdVREdTFj
Tmx5NW40WENvdEgwV1ltaWR6R3FIU1h0NDBpN1pVNDNVY05nN0dZeFpnJCAuIFRob3VnaCBJJ20g
bm90IHN1cmUKPiA+PiBpZiB0aGVyZSdzIHJlcXVlc3QvbmVlZCB0byBzdXBwb3J0IHdpbGRlciBs
ZWdhY3kgdmlydGlvIHZlcnNpb25zIGVhcmxpZXIKPiA+PiBiZXlvbmQuCj4gPiBJIHBlcnNvbmFs
bHkgZmVlbCBpdCdzIGxlc3Mgd29yayB0byBhZGQgaW4ga2VybmVsIHRoYW4gdHJ5IHRvCj4gPiB3
b3JrIGFyb3VuZCBpdCBpbiB1c2Vyc3BhY2UuIEphc29uIGZlZWxzIGRpZmZlcmVudGx5Lgo+ID4g
TWF5YmUgcG9zdCB0aGUgcGF0Y2hlcyBhbmQgdGhpcyB3aWxsIHByb3ZlIHRvIEphc29uIGl0J3Mg
bm90Cj4gPiB0b28gdGVycmlibGU/Cj4gSSBzdXBwb3NlIGlmIHRoZSB2ZHBhIHZlbmRvciBkb2Vz
IHN1cHBvcnQgMC45NSBpbiB0aGUgZGF0YXBhdGggYW5kIHJpbmcKPiBsYXlvdXQgbGV2ZWwgYW5k
IGlzIGxpbWl0ZWQgdG8geDg2IG9ubHksIHRoZXJlIHNob3VsZCBiZSBlYXN5IHdheSBvdXQuCgpO
b3RlIHRoYXQgdGhvdWdodCBJIHRyeSB0byBtYW5kYXRlIDEuMCBkZXZpY2Ugd2hlbiB3cml0aW5n
IHRoZSBjb2RlcwpidXQgdGhlIGNvcmUgdmRwYSBkb2Vzbid0IG1hbmRhdGUgaXQsIGFuZCB3ZSd2
ZSBhbHJlYWR5IGhhZCBvbmUgcGFyZW50CndoaWNoIGlzIGJhc2VkIG9uIHRoZSAwLjk1IHNwZWMg
d2hpY2ggaXMgdGhlIGVuaV92ZHBhOgoKMSkgaXQgZGVwZW5kcyBvbiBYODYgKHNvIG5vIGVuZGlh
biBhbmQgb3JkZXJpbmcgaXNzdWVzKQoyKSBpdCBoYXMgdmFyaW91cyBzdWJ0bGUgdGhpbmdzIGxp
a2UgaXQgY2FuJ3Qgd29yayB3ZWxsIHdpdGhvdXQKbXJnX3J4YnVmIGZlYXR1cmVzIG5lZ290aWF0
ZWQgc2luY2UgdGhlIGRldmljZSBhc3N1bWVzIGEgZml4ZWQgdm5ldApoZWFkZXIgbGVuZ3RoLgoz
KSBpdCBjYW4gb25seSBiZSB1c2VkIGJ5IGxlZ2FjeSBkcml2ZXJzIGluIHRoZSBndWVzdCAobm8g
VkVSU0lPTl8xCnNpbmNlIHRoZSBkZXZpY2UgbWFuZGF0ZXMgYSA0MDk2IGFsaWdubWVudCB3aGlj
aCBkb2Vzbid0IGNvbXBseSB3aXRoCjEuMCkKClNvIGl0J3MgYSBwcm9vZiBvZiAwLjk1IHBhcmVu
dCBzdXBwb3J0IGluIHRoZSB2RFBBIGNvcmUuCgpBbmQgd2UgaGFkIGEgbW9kZXJuIG9ubHkgcGFy
ZW50LCB0aGF0IGlzIHRoZSB2cF92ZHBhIHBhcmVudCAodGhvdWdoCml0J3Mgbm90IGhhcmQgdG8g
YWRkIGxlZ2FjeSBzdXBwb3J0KS4KClNvIGZvciBhbGwgdGhlIG90aGVyIHZlbmRvcnMsIGFzc3Vt
aW5nIGl0IGhhcyBmdWxsIHN1cHBvcnQgZm9yCnRyYW5zaXRpb25hbCBkZXZpY2VzIGZvciB4ODYu
IEFzIGRpc2N1c3NlZCwgd2UgbmVlZCB0byBoYW5kbGU6CgoxKSBjb25maWcgYWNjZXNzIGJlZm9y
ZSBmZWF0dXJlcwoyKSBraWNrIGJlZm9yZSBkcml2ZXJfb2sKCkFueXRoaW5nIGVsc2U/IElmIG5v
dCwgaXQgbG9va3MgZWFzaWVyIHRvIGRvIHRoZW0gaW4gdGhlIHVzZXJzcGFjZS4KVGhlIG9ubHkg
YWR2YW50YWdlcyBmb3IgZG9pbmcgaXQgaW4gdGhlIGtlcm5lbCBpcyB0byBtYWtlIGl0IHdvcmsg
Zm9yCnZpcnRpby12ZHBhLiBCdXQgdmlyaXRvLXZkcGEgZG9lc24ndCBuZWVkIHRyYW5zaXRpb25h
bCBkZXZpY2VzLgoKPiBJCj4gY2hlY2tlZCB3aXRoIEVsaSBhbmQgb3RoZXIgTWVsbGFub3gvTlZE
SUEgZm9sa3MgZm9yIGhhcmR3YXJlL2Zpcm13YXJlCj4gbGV2ZWwgMC45NSBzdXBwb3J0LCBpdCBz
ZWVtcyBhbGwgdGhlIGluZ3JlZGllbnQgaGFkIGJlZW4gdGhlcmUgYWxyZWFkeQo+IGRhdGVkIGJh
Y2sgdG8gdGhlIERQREsgZGF5cy4gVGhlIG9ubHkgbWFqb3IgdGhpbmcgbGltaXRpbmcgaXMgaW4g
dGhlCj4gdkRQQSBzb2Z0d2FyZSB0aGF0IHRoZSBjdXJyZW50IHZkcGEgY29yZSBoYXMgdGhlIGFz
c3VtcHRpb24gYXJvdW5kCj4gVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNIGZvciBhIGZldyBETUEg
c2V0dXAgb3BzLCB3aGljaCBpcyB2aXJ0aW8gMS4wIG9ubHkuCgpUaGUgY29kZSBkb2Vzbid0IGhh
dmUgc3VjaCBhbiBhc3N1bXB0aW9uIG9yIGFueXRoaW5nIEkgbWlzc2VkPyBPciB5b3UKbWVhbnQg
dGhlIHZob3N0LXZkcGEgdGhhdCB0cmllcyB0byB0YWxrIHdpdGggdGhlIElPTU1VIGxheWVyIGRp
cmVjdGx5LAppdCBzaG91bGQgYmUgb2sgc2luY2UgaG9zdCBJT01NVSBpcyBoaWRkZW4gZnJvbSBn
dWVzdCBhbnl3YXkuCgo+Cj4gPgo+ID4+IDIuIHN1cHBvc2Ugc29tZSBmb3JtIG9mIGxlZ2FjeSBn
dWVzdCBzdXBwb3J0IG5lZWRzIHRvIGJlIHRoZXJlLCBob3cgZG8gd2UKPiA+PiBkZWFsIHdpdGgg
dGhlIGJvZ3VzIGFzc3VtcHRpb24gYmVsb3cgaW4gdmRwYV9nZXRfY29uZmlnKCkgaW4gdGhlIHNo
b3J0IHRlcm0/Cj4gPj4gSXQgbG9va3Mgb25lIG9mIHRoZSBpbnR1aXRpdmUgZml4IGlzIHRvIG1v
dmUgdGhlIHZkcGFfc2V0X2ZlYXR1cmVzIGNhbGwgb3V0Cj4gPj4gb2YgdmRwYV9nZXRfY29uZmln
KCkgdG8gdmRwYV9zZXRfY29uZmlnKCkuCj4gPj4KPiA+PiAgICAgICAgICAvKgo+ID4+ICAgICAg
ICAgICAqIENvbmZpZyBhY2Nlc3NlcyBhcmVuJ3Qgc3VwcG9zZWQgdG8gdHJpZ2dlciBiZWZvcmUg
ZmVhdHVyZXMgYXJlCj4gPj4gc2V0Lgo+ID4+ICAgICAgICAgICAqIElmIGl0IGRvZXMgaGFwcGVu
IHdlIGFzc3VtZSBhIGxlZ2FjeSBndWVzdC4KPiA+PiAgICAgICAgICAgKi8KPiA+PiAgICAgICAg
ICBpZiAoIXZkZXYtPmZlYXR1cmVzX3ZhbGlkKQo+ID4+ICAgICAgICAgICAgICAgICAgdmRwYV9z
ZXRfZmVhdHVyZXModmRldiwgMCk7Cj4gPj4gICAgICAgICAgb3BzLT5nZXRfY29uZmlnKHZkZXYs
IG9mZnNldCwgYnVmLCBsZW4pOwo+ID4+Cj4gPj4gSSBjYW4gcG9zdCBhIHBhdGNoIHRvIGZpeCAy
KSBpZiB0aGVyZSdzIGNvbnNlbnN1cyBhbHJlYWR5IHJlYWNoZWQuCj4gPj4KPiA+PiBUaGFua3Ms
Cj4gPj4gLVNpd2VpCj4gPiBJJ20gbm90IHN1cmUgaG93IGltcG9ydGFudCBpdCBpcyB0byBjaGFu
Z2UgdGhhdC4KPiA+IEluIGFueSBjYXNlIGl0IG9ubHkgYWZmZWN0cyB0cmFuc2l0aW9uYWwgZGV2
aWNlcywgcmlnaHQ/Cj4gPiBMZWdhY3kgb25seSBzaG91bGQgbm90IGNhcmUgLi4uCj4gWWVzIEkn
ZCBsaWtlIHRvIGRpc3Rpbmd1aXNoIGxlZ2FjeSBkcml2ZXIgKHN1cHBvc2UgaXQgaXMgMC45NSkg
YWdhaW5zdAo+IHRoZSBtb2Rlcm4gb25lIGluIGEgdHJhbnNpdGlvbmFsIGRldmljZSBtb2RlbCBy
YXRoZXIgdGhhbiBiZWluZyBsZWdhY3kKPiBvbmx5LiBUaGF0IHdheSBhIHYwLjk1IGFuZCB2MS4w
IHN1cHBvcnRpbmcgdmRwYSBwYXJlbnQgY2FuIHN1cHBvcnQgYm90aAo+IHR5cGVzIG9mIGd1ZXN0
cyB3aXRob3V0IGhhdmluZyB0byByZWNvbmZpZ3VyZS4KCkkgdGhpbmsgdGhpcyBpcyB3aGF0IGEg
dHJhbnNpdGlvbmFsIGRldmljZSBpcyBleHBlY3RlZCB0byB3b3JrLgoKVGhhbmtzCgo+IE9yIGFy
ZSB5b3Ugc3VnZ2VzdGluZwo+IGxpbWl0IHRvIGxlZ2FjeSBvbmx5IGF0IHRoZSB0aW1lIG9mIHZk
cGEgY3JlYXRpb24gd291bGQgc2ltcGxpZnkgdGhlCj4gaW1wbGVtZW50YXRpb24gYSBsb3Q/Cj4K
PiBUaGFua3MsCj4gLVNpd2VpCj4KPiA+Cj4gPj4gT24gMy8yLzIwMjEgMjo1MyBBTSwgSmFzb24g
V2FuZyB3cm90ZToKPiA+Pj4gT24gMjAyMS8zLzIgNTo0NyDkuIvljYgsIE1pY2hhZWwgUy4gVHNp
cmtpbiB3cm90ZToKPiA+Pj4+IE9uIE1vbiwgTWFyIDAxLCAyMDIxIGF0IDExOjU2OjUwQU0gKzA4
MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPj4+Pj4gT24gMjAyMS8zLzEgNTozNCDkuIrljYgsIE1p
Y2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+Pj4+Pj4gT24gV2VkLCBGZWIgMjQsIDIwMjEgYXQg
MTA6MjQ6NDFBTSAtMDgwMCwgU2ktV2VpIExpdSB3cm90ZToKPiA+Pj4+Pj4+PiBEZXRlY3Rpbmcg
aXQgaXNuJ3QgZW5vdWdoIHRob3VnaCwgd2Ugd2lsbCBuZWVkIGEgbmV3IGlvY3RsIHRvIG5vdGlm
eQo+ID4+Pj4+Pj4+IHRoZSBrZXJuZWwgdGhhdCBpdCdzIGEgbGVnYWN5IGd1ZXN0LiBVZ2ggOigK
PiA+Pj4+Pj4+IFdlbGwsIGFsdGhvdWdoIEkgdGhpbmsgYWRkaW5nIGFuIGlvY3RsIGlzIGRvYWJs
ZSwgbWF5IEkKPiA+Pj4+Pj4+IGtub3cgd2hhdCB0aGUgdXNlCj4gPj4+Pj4+PiBjYXNlIHRoZXJl
IHdpbGwgYmUgZm9yIGtlcm5lbCB0byBsZXZlcmFnZSBzdWNoIGluZm8KPiA+Pj4+Pj4+IGRpcmVj
dGx5PyBJcyB0aGVyZSBhCj4gPj4+Pj4+PiBjYXNlIFFFTVUgY2FuJ3QgZG8gd2l0aCBkZWRpY2F0
ZSBpb2N0bHMgbGF0ZXIgaWYgdGhlcmUncyBpbmRlZWQKPiA+Pj4+Pj4+IGRpZmZlcmVudGlhdGlv
biAobGVnYWN5IHYucy4gbW9kZXJuKSBuZWVkZWQ/Cj4gPj4+Pj4+IEJUVyBhIGdvb2QgQVBJIGNv
dWxkIGJlCj4gPj4+Pj4+Cj4gPj4+Pj4+ICNkZWZpbmUgVkhPU1RfU0VUX0VORElBTiBfSU9XKFZI
T1NUX1ZJUlRJTywgPywgaW50KQo+ID4+Pj4+PiAjZGVmaW5lIFZIT1NUX0dFVF9FTkRJQU4gX0lP
VyhWSE9TVF9WSVJUSU8sID8sIGludCkKPiA+Pj4+Pj4KPiA+Pj4+Pj4gd2UgZGlkIGl0IHBlciB2
cmluZyBidXQgbWF5YmUgdGhhdCB3YXMgYSBtaXN0YWtlIC4uLgo+ID4+Pj4+IEFjdHVhbGx5LCBJ
IHdvbmRlciB3aGV0aGVyIGl0J3MgZ29vZCB0aW1lIHRvIGp1c3Qgbm90IHN1cHBvcnQKPiA+Pj4+
PiBsZWdhY3kgZHJpdmVyCj4gPj4+Pj4gZm9yIHZEUEEuIENvbnNpZGVyOgo+ID4+Pj4+Cj4gPj4+
Pj4gMSkgSXQncyBkZWZpbml0aW9uIGlzIG5vLW5vcm1hdGl2ZQo+ID4+Pj4+IDIpIEEgbG90IG9m
IGJ1ZHJlbiBvZiBjb2Rlcwo+ID4+Pj4+Cj4gPj4+Pj4gU28gcWVtdSBjYW4gc3RpbGwgcHJlc2Vu
dCB0aGUgbGVnYWN5IGRldmljZSBzaW5jZSB0aGUgY29uZmlnCj4gPj4+Pj4gc3BhY2Ugb3Igb3Ro
ZXIKPiA+Pj4+PiBzdHVmZnMgdGhhdCBpcyBwcmVzZW50ZWQgYnkgdmhvc3QtdkRQQSBpcyBub3Qg
ZXhwZWN0ZWQgdG8gYmUKPiA+Pj4+PiBhY2Nlc3NlZCBieQo+ID4+Pj4+IGd1ZXN0IGRpcmVjdGx5
LiBRZW11IGNhbiBkbyB0aGUgZW5kaWFuIGNvbnZlcnNpb24gd2hlbiBuZWNlc3NhcnkKPiA+Pj4+
PiBpbiB0aGlzCj4gPj4+Pj4gY2FzZT8KPiA+Pj4+Pgo+ID4+Pj4+IFRoYW5rcwo+ID4+Pj4+Cj4g
Pj4+PiBPdmVyYWxsIEkgd291bGQgYmUgZmluZSB3aXRoIHRoaXMgYXBwcm9hY2ggYnV0IHdlIG5l
ZWQgdG8gYXZvaWQgYnJlYWtpbmcKPiA+Pj4+IHdvcmtpbmcgdXNlcnNwYWNlLCBxZW11IHJlbGVh
c2VzIHdpdGggdmRwYSBzdXBwb3J0IGFyZSBvdXQgdGhlcmUgYW5kCj4gPj4+PiBzZWVtIHRvIHdv
cmsgZm9yIHBlb3BsZS4gQW55IGNoYW5nZXMgbmVlZCB0byB0YWtlIHRoYXQgaW50byBhY2NvdW50
Cj4gPj4+PiBhbmQgZG9jdW1lbnQgY29tcGF0aWJpbGl0eSBjb25jZXJucy4KPiA+Pj4KPiA+Pj4g
QWdyZWUsIGxldCBtZSBjaGVjay4KPiA+Pj4KPiA+Pj4KPiA+Pj4+ICAgIEkgbm90ZSB0aGF0IGFu
eSBoYXJkd2FyZQo+ID4+Pj4gaW1wbGVtZW50YXRpb24gaXMgYWxyZWFkeSBicm9rZW4gZm9yIGxl
Z2FjeSBleGNlcHQgb24gcGxhdGZvcm1zIHdpdGgKPiA+Pj4+IHN0cm9uZyBvcmRlcmluZyB3aGlj
aCBtaWdodCBiZSBoZWxwZnVsIGluIHJlZHVjaW5nIHRoZSBzY29wZS4KPiA+Pj4KPiA+Pj4gWWVz
Lgo+ID4+Pgo+ID4+PiBUaGFua3MKPiA+Pj4KPiA+Pj4KPiA+Pj4+Cj4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
