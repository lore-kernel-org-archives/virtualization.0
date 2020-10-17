Return-Path: <SRS0=x5ns=DY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A8DC433E7
	for <virtualization@archiver.kernel.org>; Sat, 17 Oct 2020 05:02:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA1232073A
	for <virtualization@archiver.kernel.org>; Sat, 17 Oct 2020 05:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Mj4ipAZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1232073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 162D6204D0;
	Sat, 17 Oct 2020 05:02:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EFmRS3YOVRz0; Sat, 17 Oct 2020 05:02:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 12AF820394;
	Sat, 17 Oct 2020 05:02:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF3A7C07FF;
	Sat, 17 Oct 2020 05:02:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A9F5C0051
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Oct 2020 05:02:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1CDCD88EB0
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Oct 2020 05:02:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jEQhunjzDnek
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Oct 2020 05:02:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
 [209.85.208.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0A82988EA9
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Oct 2020 05:01:59 +0000 (UTC)
Received: by mail-lj1-f196.google.com with SMTP id a28so168405ljn.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Oct 2020 22:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Hx7Q/ww8SNQlC+Vff55Qg1KHQPfa6zByV8YGUpfQHNk=;
 b=Mj4ipAZT8hm2EFBVYWNa/tPYN08h/c6I9aqqDDNKd/U1Gx8lY/fq6SCOLleNehgJrg
 16iTyZDjW3bOYh1hhqWtA77oKiTI+TPM4N1Keo/JnJzSrlqFLzW7RPlCSwXodHNBHioe
 60sjtbu/3EHa3YEwd0uy5df4RemUuD5LYm5H+8Y1Jz0qZOf6lUVUq/8KwhvUZ8M3r7Gw
 bWF2ycp8+cBNuu5EidPWzLVcRpMEVOSaAgokNP1gQ/Vcr6lzp6alR3rT1I0+BfHSKna1
 MUB9pFRtzc7GBqzTpgUnKrsGKvi+izpGnZj97WNgEpuknnloyOVePKBpgA5B1rIzMjOM
 A/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Hx7Q/ww8SNQlC+Vff55Qg1KHQPfa6zByV8YGUpfQHNk=;
 b=SmmGrnv7Fb971mU2yzjOLMXMGVdySynAMhSnjvfyLKUKK7QT6g8MuEsE7DwAI8JO7m
 AdMy4DiY0sQYCynJAh6PxaIPYyno2ogmEJAu2JAT79CbBcgU2mY7zU2cue3CRW1JK6me
 axGPzKyM+3jlFtac2yr+pqfqom2Mxr4V1OWjKObSMOWD7SUoWL4TAXp0t3BlMgcdbcJY
 kFGx25jJglwG4C/BsE6DkAC7d0Hak0aha8KW9vHUG9R7/oKagDYQR7Y6G3MFinig1cBY
 +d0uoT21PBDUk5W4w9IcWxC6uydLbH3xgLPgk8Z/KACSFlQAzhw4bcL6ngRpsOeeeVak
 K4oQ==
X-Gm-Message-State: AOAM530EB+SQX4bV8LBupjcAIunG8GuUIh5/gOBHMZGyZdjXgLk+M5DG
 0qjf72KbN+6Ghpqvd8I4m804xWNV4KRIP9UKs7ZL2w==
X-Google-Smtp-Source: ABdhPJxCQSIczBapjLlcHFxQX22QzzHRPdqAFoK5FO3ftEN502eaH7vfcq23H3Fg7kt7YZD0VFtLi0VxAAPhKjminMo=
X-Received: by 2002:a2e:b6cf:: with SMTP id m15mr2566942ljo.74.1602910917566; 
 Fri, 16 Oct 2020 22:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <788878CE-2578-4991-A5A6-669DCABAC2F2@amazon.com>
 <CAG48ez0EanBvDyfthe+hAP0OC8iGLNSq2e5wJVz-=ENNGF97_w@mail.gmail.com>
 <20201017033606.GA14014@1wt.eu>
 <CAG48ez0x2S9XuCrANAQbXNi8Jjwm822-fnQSmr-Zr07JgrEs1g@mail.gmail.com>
 <6CC3DB03-27BA-4F5E-8ADA-BE605D83A85C@amazon.com>
In-Reply-To: <6CC3DB03-27BA-4F5E-8ADA-BE605D83A85C@amazon.com>
Date: Sat, 17 Oct 2020 07:01:31 +0200
Message-ID: <CAG48ez1ZtvjOs2CEq8-EMosPCd_o7WQ3Mz_+1mDe7OrH2arxFA@mail.gmail.com>
Subject: Re: [PATCH] drivers/virt: vmgenid: add vm generation id driver
To: Colm MacCarthaigh <colmmacc@amazon.com>
Cc: Jason Donenfeld <Jason@zx2c4.com>, KVM list <kvm@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, ghammer@redhat.com,
 "Weiss, Radu" <raduweis@amazon.com>, Qemu Developers <qemu-devel@nongnu.org>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 Pavel Machek <pavel@ucw.cz>, Jonathan Corbet <corbet@lwn.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Biggers <ebiggers@kernel.org>,
 "Singh, Balbir" <sblbir@amazon.com>, bonzini@gnu.org, "Graf \(AWS\),
 Alexander" <graf@amazon.de>, oridgar@gmail.com, "Catangiu,
 Adrian Costin" <acatan@amazon.com>, Andy Lutomirski <luto@kernel.org>,
 Michal Hocko <mhocko@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 kernel list <linux-kernel@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Willy Tarreau <w@1wt.eu>, "Woodhouse, David" <dwmw@amazon.co.uk>
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
From: Jann Horn via Virtualization <virtualization@lists.linux-foundation.org>
Reply-To: Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gU2F0LCBPY3QgMTcsIDIwMjAgYXQgNjozNCBBTSBDb2xtIE1hY0NhcnRoYWlnaCA8Y29sbW1h
Y2NAYW1hem9uLmNvbT4gd3JvdGU6Cj4gT24gMTYgT2N0IDIwMjAsIGF0IDIxOjAyLCBKYW5uIEhv
cm4gd3JvdGU6Cj4gPiBPbiBTYXQsIE9jdCAxNywgMjAyMCBhdCA1OjM2IEFNIFdpbGx5IFRhcnJl
YXUgPHdAMXd0LmV1PiB3cm90ZToKPiA+IEJ1dCBpbiB1c2Vyc3BhY2UsIHdlIGp1c3QgbmVlZCBh
IHNpbXBsZSBjb3VudGVyLiBUaGVyZSdzIG5vIG5lZWQgZm9yCj4gPiB1cyB0byB3b3JyeSBhYm91
dCBhbnl0aGluZyBlbHNlLCBsaWtlIHRpbWVzdGFtcHMgb3Igd2hhdGV2ZXIuIElmIHdlCj4gPiBy
ZXBlYXRlZGx5IGZvcmsgYSBwYXVzZWQgVk0sIHRoZSBmb3JrZWQgVk1zIHdpbGwgc2VlIHRoZSBz
YW1lIGNvdW50ZXIKPiA+IHZhbHVlLCBidXQgdGhhdCdzIHRvdGFsbHkgZmluZSwgYmVjYXVzZSB0
aGUgb25seSB0aGluZyB0aGF0IG1hdHRlcnMgdG8KPiA+IHVzZXJzcGFjZSBpcyB0aGF0IHRoZSBj
b3VudGVyIGNoYW5nZXMgd2hlbiB0aGUgVk0gaXMgZm9ya2VkLgo+Cj4gRm9yIHVzZXItc3BhY2Us
IGV2ZW4gYSBzaW5nbGUgYml0IHdvdWxkIGRvLiBXZSBhZGRlZCBNQURWSVNFX1dJUEVPTkZPUksK
PiBzbyB0aGF0IHVzZXJzcGFjZSBsaWJyYXJpZXMgY2FuIGRldGVjdCBmb3JrKCkvY2xvbmUoKSBy
b2J1c3RseSwgZm9yIHRoZQo+IHNhbWUgcmVhc29ucy4gSXQganVzdCB3aXBlcyBhIHBhZ2UgYXMg
dGhlIGluZGljYXRvciwgd2hpY2ggaXMKPiBlZmZlY3RpdmVseSBhIHNpbmdsZS1iaXQgc2lnbmFs
LCBhbmQgaXQgd29ya3Mgd2VsbC4gT24gdGhlIHVzZXItc3BhY2UKPiBzaWRlIG9mIHRoaXMsIEni
gJltIGtlZW4gdG8gZmluZCBhIHNvbHV0aW9uIGxpa2UgdGhhdCB0aGF0IHdlIGNhbiB1c2UKPiBm
YWlybHkgZWFzaWx5IGluc2lkZSBvZiBwb3J0YWJsZSBsaWJyYXJpZXMgYW5kIGFwcGxpY2F0aW9u
cy4gVGhlIOKAnGhhdmUKPiBJIGZvcmtlZOKAnSBjaGVja3MgZG8gZW5kIHVwIGluIGhvdCBwYXRo
cywgc28gaXTigJlzIG5pY2UgaWYgdGhleSBjYW4gYmUKPiBDUFUgY2FjaGUgZnJpZW5kbHkuIENv
bXBhcmluZyBhIHdob2xlIDEyOC1iaXQgdmFsdWUgd291bGRu4oCZdCBiZSBteQo+IGZhdm9yaXRl
LgoKSSdtIHByZXR0eSBzdXJlIGEgc2luZ2xlIGJpdCBpcyBub3QgZW5vdWdoIGlmIHlvdSB3YW50
IHRvIGhhdmUgYQpzaW5nbGUgcGFnZSwgc2hhcmVkIGFjcm9zcyB0aGUgZW50aXJlIHN5c3RlbSwg
dGhhdCBzdG9yZXMgdGhlIFZNCmZvcmtpbmcgc3RhdGU7IHlvdSBuZWVkIGEgY291bnRlciBmb3Ig
dGhhdC4KCj4gPiBBbmQgYWN0dWFsbHksIHNpbmNlIHRoZSB2YWx1ZSBpcyBhIGNyeXB0b2dyYXBo
aWNhbGx5IHJhbmRvbSAxMjgtYml0Cj4gPiB2YWx1ZSwgSSB0aGluayB0aGF0IHdlIHNob3VsZCBk
ZWZpbml0ZWx5IHVzZSBpdCB0byBoZWxwIHJlc2VlZCB0aGUKPiA+IGtlcm5lbCdzIFJORywgYW5k
IGtlZXAgaXQgc2VjcmV0IGZyb20gdXNlcnNwYWNlLiBUaGF0IHdheSwgZXZlbiBpZiB0aGUKPiA+
IFZNIGltYWdlIGlzIHB1YmxpYywgd2UgY2FuIGVuc3VyZSB0aGF0IGdvaW5nIGZvcndhcmQsIHRo
ZSBrZXJuZWwgUk5HCj4gPiB3aWxsIHJldHVybiBzZWN1cmVseSByYW5kb20gZGF0YS4KPgo+IElm
IHRoZSBpbWFnZSBpcyBwdWJsaWMsIHlvdSBuZWVkIHNvbWUgZXh0cmEgbmV3IHJhdyBlbnRyb3B5
IGZyb20KPiBzb21ld2hlcmUuIFRoZSBnZW4taWQgY291bGQgYmUgbWl4ZWQgaW4sIHRoYXQgY2Fu
4oCZdCBkbyBhbnkgaGFybSBhcwo+IGxvbmcgYXMgcmlnb3JvdXMgY3J5cHRvZ3JhcGhpYyBtaXhp
bmcgd2l0aCB0aGUgcHJpb3Igc3RhdGUgaXMgdXNlZCwgYnV0Cj4gaWYgdGhhdOKAmXMgYWxsIHlv
dSBkbyB0aGVuIHRoZSBmaW5hbCBzdGF0ZSBpcyBzdGlsbCBkZXRlcm1pbmlzdGljIGFuZAo+IG5v
bi1zZWNyZXQuCgpNaWNyb3NvZnQncyBkb2N1bWVudGF0aW9uCihodHRwOi8vZ28ubWljcm9zb2Z0
LmNvbS9md2xpbmsvP0xpbmtJZD0yNjA3MDkpIHNheXMgdGhhdCB0aGUgVk0KR2VuZXJhdGlvbiBJ
RCB0aGF0IHdlIGdldCBhZnRlciBhIGZvcmsgImlzIGEgMTI4LWJpdCwKY3J5cHRvZ3JhcGhpY2Fs
bHkgcmFuZG9tIGludGVnZXIgdmFsdWUiLiBJZiBtdWx0aXBsZSBwZW9wbGUgdXNlIHRoZQpzYW1l
IGltYWdlLCBpdCBndWFyYW50ZWVzIHRoYXQgZWFjaCB1c2Ugb2YgdGhlIGltYWdlIGdldHMgaXRz
IG93biwKZnJlc2ggSUQ6IFRoZSB0YWJsZSBpbiBzZWN0aW9uICJIb3cgdG8gaW1wbGVtZW50IHZp
cnR1YWwgbWFjaGluZQpnZW5lcmF0aW9uIElEIHN1cHBvcnQgaW4gYSB2aXJ0dWFsaXphdGlvbiBw
bGF0Zm9ybSIgc2F5cyB0aGF0IChhbW9uZwpvdGhlciB0aGluZ3MpICJWaXJ0dWFsIG1hY2hpbmUg
aXMgaW1wb3J0ZWQsIGNvcGllZCwgb3IgY2xvbmVkIgpnZW5lcmF0ZXMgYSBuZXcgZ2VuZXJhdGlv
biBJRC4KClNvIHRoZSBSTkcgc3RhdGUgYWZ0ZXIgbWl4aW5nIGluIHRoZSBuZXcgVk0gR2VuZXJh
dGlvbiBJRCB3b3VsZApjb250YWluIDEyOCBiaXRzIG9mIHNlY3JldCBlbnRyb3B5IG5vdCBrbm93
biB0byBhbnlvbmUgZWxzZSwgaW5jbHVkaW5nCnBlb3BsZSB3aXRoIGFjY2VzcyB0byB0aGUgVk0g
aW1hZ2UuCgpOb3csIDEyOCBiaXRzIG9mIGNyeXB0b2dyYXBoaWNhbGx5IHJhbmRvbSBkYXRhIGFy
ZW4ndCBfb3B0aW1hbF87IEkKdGhpbmsgc29tZXRoaW5nIG9uIHRoZSBvcmRlciBvZiAyNTYgYml0
cyB3b3VsZCBiZSBuaWNlciBmcm9tIGEKdGhlb3JldGljYWwgc3RhbmRwb2ludC4gQnV0IGluIHBy
YWN0aWNlIEkgdGhpbmsgd2UnbGwgYmUgZ29vZCB3aXRoIHRoZQoxMjggYml0cyB3ZSdyZSBnZXR0
aW5nIChzaW5jZSB0aGUgbnVtYmVyIG9mIHVzZXJzIHdobyBmb3JrIGEgVk0gaW1hZ2UKaXMgcHJv
YmFibHkgbm90IGdvaW5nIHRvIGJlIHNvIGxhcmdlIHRoYXQgd29yc3QtY2FzZSBjb2xsaXNpb24K
cHJvYmFiaWxpdGllcyBtYXR0ZXIpLgoKPiBUaGUga2VybmVsIHdvdWxkIG5lZWQgdG8gdXNlIHRo
ZSBjaGFuZ2UgYXMgYSB0cmlnZ2VyIHRvCj4gbWVhc3VyZSBzb21lIGVudHJvcHkgKGUuZy4gaW50
ZXJydXB0cyBhbmQgUkRSQU5ELCBvciB3aGF0ZXZlcikuIE91ciBqdXN0Cj4gZGVmaW5lIHRoZSBt
YWNoaW5lIGNvbnRyYWN0IGFzIOKAnHRoaXMgaGFzIHRvIGJlIHVuaXF1ZSByYW5kb20gZGF0YSBh
bmQKPiBpZiBpdOKAmXMgbm90IHVuaXF1ZSwgb3IgaWYgaXTigJlzIHB1YmljLCB5b3XigJlyZSB0
b2FzdOKAnS4KCkFzIGZhciBhcyBJIGNhbiB0ZWxsIGZyb20gTWljcm9zb2Z0J3Mgc3BlYywgdGhh
dCBpcyBhIGd1YXJhbnRlZSB3ZSdyZQphbHJlYWR5IGdldHRpbmcuCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
