Return-Path: <SRS0=TNKP=DS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADC0C433E7
	for <virtualization@archiver.kernel.org>; Sun, 11 Oct 2020 06:46:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86C94207F7
	for <virtualization@archiver.kernel.org>; Sun, 11 Oct 2020 06:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ga8I5kEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86C94207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3B0D5877FD;
	Sun, 11 Oct 2020 06:46:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iXC-3UDeA9Gr; Sun, 11 Oct 2020 06:46:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B6ACB877DA;
	Sun, 11 Oct 2020 06:46:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A2F5C0052;
	Sun, 11 Oct 2020 06:46:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CAA01C0051
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Oct 2020 06:46:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BE8FD877FD
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Oct 2020 06:46:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PFA1eRGJLDxc
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Oct 2020 06:46:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6B783877DA
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Oct 2020 06:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602398758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dJ3BlgkCnk7q4i6A6rDWI4Y07VULo0UVj4WHUXEfZVc=;
 b=Ga8I5kEcJEo6484q43b0leniQXfKOk3z0T5mOxOefB+QFAJ97OwC/0xCRhNmaicuICTeTy
 96B40jwT4K3ubQ3W/7nNtluchIIU5wQlo4euDhpa4k/u2nDTJgrjOVwoTw2qlK5LgTTVc/
 Q6wAKWkhus28oQXdFM7s+R/F2y1c88g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-t-xFQw1sPda-QfDIVxYKAg-1; Sun, 11 Oct 2020 02:45:57 -0400
X-MC-Unique: t-xFQw1sPda-QfDIVxYKAg-1
Received: by mail-wr1-f70.google.com with SMTP id n14so3949862wrp.1
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 23:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=dJ3BlgkCnk7q4i6A6rDWI4Y07VULo0UVj4WHUXEfZVc=;
 b=NcnXlSVYuIhzvPk9/ardsdZ4lfiePYUu1eel1Tw9R6fssixDTWC08leiDZz0RfKxM4
 QwqhgVH09YA0g1lf1vLTgTD08qPPe0FwgRDSunzErTE3AW/Up8xAmVaKfGxZfO316xdx
 hRkaEJMjKXsCJV7ahXxho3li2Xj15W7XIbJY33176G/gPvuBwYcjavRcros2M+7bwXFZ
 yi3/SQ8eUJyMIkCWhE6xnflwLrw0UbOT3g/Y0m5wVuIyejCttxgQaNgqByqpKCN4oy49
 qMrReFvUCs1oD+H9vvo0kmDemUhmaic9AJe9V1Itgo9EKU8LnQSIEtsuvyxHN8Clc1Ut
 RinQ==
X-Gm-Message-State: AOAM530PUk8u1fLvUtzWgRysx7uF4b3WNrEfuZo4wFnl2HG/tNLz6O3/
 eKOWNguiFmi313eI960t3oc/TYwcQHs2ar3bPEYegAgKdlwzxYFqLQYF9rQIgarckujQ5HOu7sL
 6puPmlAfc55+ITMjIEwiHhE7mnFWPs6cmLcPVSzb6rg==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr5518153wmi.84.1602398755965;
 Sat, 10 Oct 2020 23:45:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymVd3zPBGJk+gsm5hB6NEr0sdsOHn19hXK54y5exKXDFRh+F/ZOFStkaryviOkX38fGRPEVg==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr5518140wmi.84.1602398755755;
 Sat, 10 Oct 2020 23:45:55 -0700 (PDT)
Received: from redhat.com (bzq-79-179-76-41.red.bezeqint.net. [79.179.76.41])
 by smtp.gmail.com with ESMTPSA id
 y66sm1509945wmd.14.2020.10.10.23.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 23:45:55 -0700 (PDT)
Date: Sun, 11 Oct 2020 02:45:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v3 1/2] vhost-vdpa: fix vhost_vdpa_map() on error condition
Message-ID: <20201011024533-mutt-send-email-mst@kernel.org>
References: <1601701330-16837-1-git-send-email-si-wei.liu@oracle.com>
 <1601701330-16837-2-git-send-email-si-wei.liu@oracle.com>
 <a780b2e2-d8ce-4c27-df6b-47523c356d02@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a780b2e2-d8ce-4c27-df6b-47523c356d02@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: boris.ostrovsky@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Si-Wei Liu <si-wei.liu@oracle.com>, lingshan.zhu@intel.com
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

T24gU2F0LCBPY3QgMTAsIDIwMjAgYXQgMDk6NDg6NDJBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIwLzEwLzMg5LiL5Y2IMTowMiwgU2ktV2VpIExpdSB3cm90ZToKPiA+IHZo
b3N0X3ZkcGFfbWFwKCkgc2hvdWxkIHJlbW92ZSB0aGUgaW90bGIgZW50cnkganVzdCBhZGRlZAo+
ID4gaWYgdGhlIGNvcnJlc3BvbmRpbmcgbWFwcGluZyBmYWlscyB0byBzZXQgdXAgcHJvcGVybHku
Cj4gPiAKPiA+IEZpeGVzOiA0YzhjZjMxODg1ZjYgKCJ2aG9zdDogaW50cm9kdWNlIHZEUEEtYmFz
ZWQgYmFja2VuZCIpCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9y
YWNsZS5jb20+Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy92aG9zdC92ZHBhLmMgfCAzICsrKwo+ID4g
ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gPiBpbmRleCA3OTZm
ZTk3Li4wZjI3OTE5IDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKPiA+ICsr
KyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gPiBAQCAtNTY1LDYgKzU2NSw5IEBAIHN0YXRpYyBp
bnQgdmhvc3RfdmRwYV9tYXAoc3RydWN0IHZob3N0X3ZkcGEgKnYsCj4gPiAgIAkJCSAgICAgIHBl
cm1fdG9faW9tbXVfZmxhZ3MocGVybSkpOwo+ID4gICAJfQo+ID4gKwlpZiAocikKPiA+ICsJCXZo
b3N0X2lvdGxiX2RlbF9yYW5nZShkZXYtPmlvdGxiLCBpb3ZhLCBpb3ZhICsgc2l6ZSAtIDEpOwo+
ID4gKwo+ID4gICAJcmV0dXJuIHI7Cj4gPiAgIH0KPiAKPiAKPiBBY2tlZC1ieTogSmFzb24gV2Fu
ZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCkxpbnVzIGFscmVhZHkgbWVyZ2VkIHRoaXMsIEkgY2Fu
J3QgYWRkIHlvdXIgYWNrLCBzb3JyeSEKCi0tIApNU1QKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
