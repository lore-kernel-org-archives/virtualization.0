Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE17C001DE
	for <virtualization@archiver.kernel.org>; Wed, 16 Aug 2023 01:55:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 049476120B;
	Wed, 16 Aug 2023 01:55:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 049476120B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d0rh8DMi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ex3so0L8j03p; Wed, 16 Aug 2023 01:55:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 65ABF61207;
	Wed, 16 Aug 2023 01:55:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 65ABF61207
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 370FBC0071;
	Wed, 16 Aug 2023 01:55:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31A36C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 01:55:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EB3AF61209
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 01:55:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EB3AF61209
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lL31nHvnwqlu
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 01:55:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 23CA361207
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 01:55:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 23CA361207
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692150949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UjCnX6u/94BO9ruB6wVa3OuMbd0IF6Vevmu7R7ayNtA=;
 b=d0rh8DMiQn6eo2z3qpNLzfnlDO2jAwuGY92Ws0YSo/OVgDCTdoMKWuDt1tcHklWXP5ppNk
 /sIcM6BG/PXlTJ7VfyhxFV9LomJZXAZADat16kD71CnCcEL8/0HwRZUnryIJnmsyWEnD4V
 QXgzHi694vIaGcroPanKjf446zhyjyc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-FQ7w2g2yPKeqyBpjqcnbxg-1; Tue, 15 Aug 2023 21:55:45 -0400
X-MC-Unique: FQ7w2g2yPKeqyBpjqcnbxg-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b9bee2d344so61092721fa.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 18:55:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692150944; x=1692755744;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UjCnX6u/94BO9ruB6wVa3OuMbd0IF6Vevmu7R7ayNtA=;
 b=ZD06LuYrz8yPE5I8csSg9wEaAsZu0huYFHhmJzTYYS6kquu71+04YKtEy3jfo6v6md
 YwCpUIjoGe8dBQ7/+EyUSGudetZqE/ubjsDTF7JGNk//C0JJlXfD+8c+9vVYqP6jHWbJ
 7vkHjuK/cQgKtRKYATZRgMVe8AuY6CV+FcXsIuk6PM9k9q8c6J6JGtd7B5WxdCHJ5yEd
 dXwDpKf31WAnaXYvacnZtPnIAYBM7tNDTYJLVWSE7V1014kK2rKKKXQ0UdbTnlNM//EP
 OZPORp58DuQpfsX00+Mq/TIhqOiUEmwaVb4MtfFcogGv9GlEpLzdmJFulHeGVVsSE4EM
 jOGQ==
X-Gm-Message-State: AOJu0YxR9XbkswhMQYYz5tTWbcZyhR4Qip9imtJauTgzVif01mVi4XIj
 joiwS7JlihG9alTlAu5QRR4Yjc6Lt+WrMzMZXGt+O+K5lxGp50NXtyG69Lj0YpwjOvViUQYSgAx
 b91PWiSgTg+OW4DpV+WfFb3tAit1hs9d2PDOZPz0dVPXa0m0uaL4tiz1mew==
X-Received: by 2002:a2e:8893:0:b0:2b6:ecdd:16cf with SMTP id
 k19-20020a2e8893000000b002b6ecdd16cfmr343152lji.40.1692150944455; 
 Tue, 15 Aug 2023 18:55:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoZBozE1L5tA3akyJZBoyIVXtNrtJWNiy9lqfH1Q5JzFdXd6h+mpIYWberUMRzAaIxH8CHfrGhLOuZhH/eXRY=
X-Received: by 2002:a2e:8893:0:b0:2b6:ecdd:16cf with SMTP id
 k19-20020a2e8893000000b002b6ecdd16cfmr343146lji.40.1692150944163; Tue, 15 Aug
 2023 18:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEseKv8MzaF8uxVTjkaAm2xvei578g=rNVzogfPQRQPOhQ@mail.gmail.com>
 <1692063807-5018-1-git-send-email-si-wei.liu@oracle.com>
 <1692063807-5018-2-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEuGeXYo3s6Ytd-Nvp7EXU6td1NY6LrLcVgntprXJwBEhQ@mail.gmail.com>
 <ebc38dc4-ed43-6a1d-5368-ae75269e6b43@oracle.com>
In-Reply-To: <ebc38dc4-ed43-6a1d-5368-ae75269e6b43@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 16 Aug 2023 09:55:33 +0800
Message-ID: <CACGkMEscjR_bTVfwaRcQ8qxpiOEJAT35Y1uoj=kBptYkbijDbw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] vdpa: introduce .reset_map operation callback
To: Si-Wei Liu <si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, gal@nvidia.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com
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

T24gV2VkLCBBdWcgMTYsIDIwMjMgYXQgMzo0OeKAr0FNIFNpLVdlaSBMaXUgPHNpLXdlaS5saXVA
b3JhY2xlLmNvbT4gd3JvdGU6Cj4KPgo+Cj4gT24gOC8xNC8yMDIzIDc6MjEgUE0sIEphc29uIFdh
bmcgd3JvdGU6Cj4gPiBPbiBUdWUsIEF1ZyAxNSwgMjAyMyBhdCA5OjQ24oCvQU0gU2ktV2VpIExp
dSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPiB3cm90ZToKPiA+PiBTaWduZWQtb2ZmLWJ5OiBTaS1X
ZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+Cj4gPj4gLS0tCj4gPj4gICBpbmNsdWRlL2xp
bnV4L3ZkcGEuaCB8IDcgKysrKysrKwo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9u
cygrKQo+ID4+Cj4gPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmRwYS5oIGIvaW5jbHVk
ZS9saW51eC92ZHBhLmgKPiA+PiBpbmRleCBkYjFiMGVhLi4zYTM4NzhkIDEwMDY0NAo+ID4+IC0t
LSBhL2luY2x1ZGUvbGludXgvdmRwYS5oCj4gPj4gKysrIGIvaW5jbHVkZS9saW51eC92ZHBhLmgK
PiA+PiBAQCAtMzE0LDYgKzMxNCwxMiBAQCBzdHJ1Y3QgdmRwYV9tYXBfZmlsZSB7Cj4gPj4gICAg
KiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQGlvdmE6IGlvdmEgdG8gYmUgdW5tYXBwZWQK
PiA+PiAgICAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICBAc2l6ZTogc2l6ZSBvZiB0aGUg
YXJlYQo+ID4+ICAgICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIFJldHVybnMgaW50ZWdl
cjogc3VjY2VzcyAoMCkgb3IgZXJyb3IgKDwgMCkKPiA+PiArICogQHJlc2V0X21hcDogICAgICAg
ICAgICAgICAgIFJlc2V0IGRldmljZSBtZW1vcnkgbWFwcGluZyAob3B0aW9uYWwpCj4gPj4gKyAq
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBOZWVkZWQgZm9yIGRldmljZSB0aGF0IHVzaW5n
IGRldmljZQo+ID4+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3BlY2lmaWMgRE1B
IHRyYW5zbGF0aW9uIChvbi1jaGlwIElPTU1VKQo+ID4gVGhpcyBleHBvc2VzIHRoZSBkZXZpY2Ug
aW50ZXJuYWwgdG8gdGhlIHVwcGVyIGxheWVyIHdoaWNoIGlzIG5vdCBvcHRpbWFsLgo+IE5vdCBz
dXJlIHdoYXQgZG9lcyBpdCBtZWFuIGJ5ICJkZXZpY2UgaW50ZXJuYWwiLCBidXQgdGhpcyBvcCBj
YWxsYmFjawo+IGp1c3QgZm9sbG93cyBleGlzdGluZyBjb252ZW50aW9uIHRvIGRlc2NyaWJlIHdo
YXQgdmRwYSBwYXJlbnQgdGhpcyBBUEkKPiB0YXJnZXRzLgoKSSBtZWFudCB0aGUgYnVzIHRyaWVz
IHRvIGhpZGUgdGhlIGRpZmZlcmVuY2VzIGFtb25nIHZlbmRvcnMuIFNvIGl0Cm5lZWRzIHRvIGhp
ZGUgb24tY2hpcCBJT01NVSBzdHVmZiB0byB0aGUgdXBwZXIgbGF5ZXIuCgpXZSBjYW4gZXhwb3Nl
IHR3byBkaW1lbnNpb25hbCBJTyBtYXBwaW5ncyBtb2RlbHMgYnV0IGl0IGxvb2tzIGxpa2UKb3Zl
ciBlbmdpbmVlcmluZyBmb3IgdGhpcyBpc3N1ZS4gTW9yZSBiZWxvdy4KCj4KPiAgICogQHNldF9t
YXA6ICAgICAgICAgICAgICAgICAgICBTZXQgZGV2aWNlIG1lbW9yeSBtYXBwaW5nIChvcHRpb25h
bCkKPiAgICogICAgICAgICAgICAgICAgICAgICAgICAgICAgICBOZWVkZWQgZm9yIGRldmljZSB0
aGF0IHVzaW5nIGRldmljZQo+ICAgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNwZWNp
ZmljIERNQSB0cmFuc2xhdGlvbiAob24tY2hpcCBJT01NVSkKPiA6Cj4gOgo+ICAgKiBAZG1hX21h
cDogICAgICAgICAgICAgICAgICAgIE1hcCBhbiBhcmVhIG9mIFBBIHRvIElPVkEgKG9wdGlvbmFs
KQo+ICAgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5lZWRlZCBmb3IgZGV2aWNlIHRo
YXQgdXNpbmcgZGV2aWNlCj4gICAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3BlY2lm
aWMgRE1BIHRyYW5zbGF0aW9uIChvbi1jaGlwIElPTU1VKQo+ICAgKiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGFuZCBwcmVmZXJyaW5nIGluY3JlbWVudGFsIG1hcC4KPiA6Cj4gOgo+ICAg
KiBAZG1hX3VubWFwOiAgICAgICAgICAgICAgICAgIFVubWFwIGFuIGFyZWEgb2YgSU9WQSAob3B0
aW9uYWwgYnV0Cj4gICAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXVzdCBiZSBpbXBs
ZW1lbnRlZCB3aXRoIGRtYV9tYXApCj4gICAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
TmVlZGVkIGZvciBkZXZpY2UgdGhhdCB1c2luZyBkZXZpY2UKPiAgICogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBzcGVjaWZpYyBETUEgdHJhbnNsYXRpb24gKG9uLWNoaXAgSU9NTVUpCj4g
ICAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYW5kIHByZWZlcnJpbmcgaW5jcmVtZW50
YWwgdW5tYXAuCj4KPgo+ID4gQnR3LCB3aGF0J3MgdGhlIGRpZmZlcmVuY2UgYmV0d2VlbiB0aGlz
IGFuZCBhIHNpbXBsZQo+ID4KPiA+IHNldF9tYXAoTlVMTCk/Cj4gSSBkb24ndCB0aGluayBwYXJl
bnQgZHJpdmVycyBzdXBwb3J0IHRoaXMgdG9kYXkgLSB0aGV5IGNhbiBhY2NlcHQKPiBub24tTlVM
TCBpb3RsYiBjb250YWluaW5nIGVtcHR5IG1hcCBlbnRyeSwgYnV0IG5vdCBhIE5VTEwgaW90bGIu
IFRoZQo+IGJlaGF2aW9yIGlzIHVuZGVmaW5lZCBvciBpdCBldmVuIGNhdXNlcyBwYW5pYyB3aGVu
IGEgTlVMTCBpb3RsYiBpcwo+IHBhc3NlZCBpbi4KCldlIGNhbiBkbyB0aGlzIHNpbXBsZSBjaGFu
Z2UgaWYgaXQgY2FuIHdvcmsuCgo+ICBGdXJ0aGVyIHRoaXMgZG9lc24ndCB3b3JrIHdpdGggLmRt
YV9tYXAgcGFyZW50IGRyaXZlcnMuCgpQcm9iYWJseSwgYnV0IEknZCByZW1vdmUgZG1hX21hcCBh
cyBpdCBkb2Vzbid0IGhhdmUgYW55IHJlYWwgdXNlcnMKZXhjZXB0IGZvciB0aGUgc2ltdWxhdG9y
LgoKPgo+IFRoZSByZWFzb24gd2h5IGEgbmV3IG9wIGlzIG5lZWRlZCBvciBiZXR0ZXIgaXMgYmVj
YXVzZSBpdCBhbGxvd3MKPiB1c2Vyc3BhY2UgdG8gdGVsbCBhcGFydCBkaWZmZXJlbnQgcmVzZXQg
YmVoYXZpb3IgZnJvbSB0aGUgb2xkZXIga2VybmVsCj4gKHZpYSB0aGUgRl9JT1RMQl9QRVJTSVNU
IGZlYXR1cmUgYml0IGluIHBhdGNoIDQpLCB3aGlsZSB0aGlzIGJlaGF2aW9yCj4gY291bGQgdmFy
eSBiZXR3ZWVuIHBhcmVudCBkcml2ZXJzLgoKSSdtIG9rIHdpdGggYSBuZXcgZmVhdHVyZSBmbGFn
LCBidXQgd2UgbmVlZCB0byBmaXJzdCBzZWVrIGEgd2F5IHRvCnJldXNlIHRoZSBleGlzdGluZyBB
UEkuCgpUaGFua3MKCj4KPiBSZWdhcmRzLAo+IC1TaXdlaQo+Cj4gPgo+ID4gVGhhbmtzCj4gPgo+
ID4+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQHZkZXY6IHZkcGEgZGV2aWNlCj4g
Pj4gKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICBAYXNpZDogYWRkcmVzcyBzcGFjZSBp
ZGVudGlmaWVyCj4gPj4gKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSZXR1cm5zIGlu
dGVnZXI6IHN1Y2Nlc3MgKDApIG9yIGVycm9yICg8IDApCj4gPj4gICAgKiBAZ2V0X3ZxX2RtYV9k
ZXY6ICAgICAgICAgICAgR2V0IHRoZSBkbWEgZGV2aWNlIGZvciBhIHNwZWNpZmljCj4gPj4gICAg
KiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmlydHF1ZXVlIChvcHRpb25hbCkKPiA+PiAg
ICAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICBAdmRldjogdmRwYSBkZXZpY2UKPiA+PiBA
QCAtMzkwLDYgKzM5Niw3IEBAIHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgewo+ID4+ICAgICAgICAg
ICAgICAgICAgICAgICAgIHU2NCBpb3ZhLCB1NjQgc2l6ZSwgdTY0IHBhLCB1MzIgcGVybSwgdm9p
ZCAqb3BhcXVlKTsKPiA+PiAgICAgICAgICBpbnQgKCpkbWFfdW5tYXApKHN0cnVjdCB2ZHBhX2Rl
dmljZSAqdmRldiwgdW5zaWduZWQgaW50IGFzaWQsCj4gPj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICB1NjQgaW92YSwgdTY0IHNpemUpOwo+ID4+ICsgICAgICAgaW50ICgqcmVzZXRfbWFwKShz
dHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHVuc2lnbmVkIGludCBhc2lkKTsKPiA+PiAgICAgICAg
ICBpbnQgKCpzZXRfZ3JvdXBfYXNpZCkoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1bnNpZ25l
ZCBpbnQgZ3JvdXAsCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVk
IGludCBhc2lkKTsKPiA+PiAgICAgICAgICBzdHJ1Y3QgZGV2aWNlICooKmdldF92cV9kbWFfZGV2
KShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHUxNiBpZHgpOwo+ID4+IC0tCj4gPj4gMS44LjMu
MQo+ID4+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
