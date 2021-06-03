Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5950CC47097
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 19:32:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 132BE613F4
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 19:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 132BE613F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 783F340633;
	Thu,  3 Jun 2021 19:32:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NDS5PJLvOpkI; Thu,  3 Jun 2021 19:32:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id D448C40630;
	Thu,  3 Jun 2021 19:32:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48C9FC0022;
	Thu,  3 Jun 2021 19:32:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9005DC0001;
 Thu,  3 Jun 2021 19:32:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7BE1660B6F;
 Thu,  3 Jun 2021 19:32:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u3XTlXSxIrCF; Thu,  3 Jun 2021 19:32:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DEB02606C6;
 Thu,  3 Jun 2021 19:32:34 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C0FD611CC;
 Thu,  3 Jun 2021 19:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622748754;
 bh=rvC32MA8E3QrSBWjTg6LF33SlYkWLco0I2yCu23n7Ok=;
 h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
 b=jhQeYpzgE6vlWf6TMVMtA+XVEhF3g/+sc+mtqLnWt9Jxq6VW05vCdwGdpHLzufuYS
 UwGtMjrFLjvxTtrXwJuljVurczSzpAyvwhISyhtF9mlHrjE5HfQoaQl5Edk52qoEvO
 fIAR9d5gHQbaop5gruCM9Lb2jdZgO0Vki7OQd9lPddn94/3XqQQhfbFgTNLMzDuhWZ
 qfQDXIjh/bpK09jMqCFV81DG209YazmpQjI81ykvp5KDwDs8VWUNxwQkPY0OgkctQR
 pcqnAZK3Wrh9q7duTaMgSjY9Ojm0reQwUN8R3uZYRnguJ2XWcuU7B5qmCg7FnR504O
 BMQUYhKYK2fxg==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailauth.nyi.internal (Postfix) with ESMTP id 6FF6127C005B;
 Thu,  3 Jun 2021 15:32:32 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute2.internal (MEProxy); Thu, 03 Jun 2021 15:32:32 -0400
X-ME-Sender: <xms:Ti65YARuXTjJ3BHnKxxPhwSkEN4alc6eBsVdVZX7VFM1tHzIOxyOgw>
 <xme:Ti65YNyLRRxKCVBDmIPZpIaCS6oWxEjczPCeT15pkFl57T-PKotNNxIK4jcFo19NO
 s3Vs4kuPInKe7TqDrI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdelledgudefiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdet
 nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
 ggtffrrghtthgvrhhnpedvleehjeejvefhuddtgeegffdtjedtffegveethedvgfejieev
 ieeufeevuedvteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
 hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
 keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
 hugidrlhhuthhordhush
X-ME-Proxy: <xmx:Ti65YN2MdDOPGi9cterhA_MhwaeugS0qPfadYs_WiFpFbzqTVeVAiQ>
 <xmx:Ti65YED0zWXWevXVsCLnReGi2B61zP8LIx-LINBak-ESTbCZ0sdehQ>
 <xmx:Ti65YJhDZklB1wypCK3j_CL1JFPBrH3kprv63MgfcNLqQZuCN3eyiA>
 <xmx:UC65YAOlSD8pvDt4Vuj2PT11Fvc3F8j5ymkDv3XWdRtZblxt_ngBaZaSAMHEjR9C>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 66F9C51C0060; Thu,  3 Jun 2021 15:32:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-519-g27a961944e-fm-20210531.001-g27a96194
Mime-Version: 1.0
Message-Id: <2b2dec75-a0c1-4013-ac49-a49f30d5ac3c@www.fastmail.com>
In-Reply-To: <a0e66b4c-cec5-2a26-9431-d5a21e22c8f2@linux.intel.com>
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-2-ak@linux.intel.com>
 <cc5c8265-83f7-aeb1-bc30-3367fe68bc97@kernel.org>
 <a0e66b4c-cec5-2a26-9431-d5a21e22c8f2@linux.intel.com>
Date: Thu, 03 Jun 2021 12:31:59 -0700
From: "Andy Lutomirski" <luto@kernel.org>
To: "Andi Kleen" <ak@linux.intel.com>, mst@redhat.com
Subject: Re: [PATCH v1 1/8] virtio: Force only split mode with protected guest
Cc: sathyanarayanan.kuppuswamy@linux.intel.com,
 the arch/x86 maintainers <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 Josh Poimboeuf <jpoimboe@redhat.com>, robin.murphy@arm.com, hch@lst.de,
 m.szyprowski@samsung.com
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

CgpPbiBUaHUsIEp1biAzLCAyMDIxLCBhdCAxMTowMCBBTSwgQW5kaSBLbGVlbiB3cm90ZToKPiAK
PiBPbiA2LzMvMjAyMSAxMDozMyBBTSwgQW5keSBMdXRvbWlyc2tpIHdyb3RlOgo+ID4gT24gNi8y
LzIxIDU6NDEgUE0sIEFuZGkgS2xlZW4gd3JvdGU6Cj4gPj4gT25seSBhbGxvdyBzcGxpdCBtb2Rl
IHdoZW4gaW4gYSBwcm90ZWN0ZWQgZ3Vlc3QuIEZvbGxvd29uCj4gPj4gcGF0Y2hlcyBoYXJkZW4g
dGhlIHNwbGl0IG1vZGUgY29kZSBwYXRocywgYW5kIHdlIGRvbid0IHdhbnQKPiA+PiBhbiBtYWxp
Y2lvdXMgaG9zdCB0byBmb3JjZSBhbnl0aGluZyBlbHNlLiBBbHNvIGRpc2FsbG93Cj4gPj4gaW5k
aXJlY3QgbW9kZSBmb3Igc2ltaWxhciByZWFzb25zLgo+ID4gSSByZWFkIHRoaXMgYXMgInRoZSB2
aXJ0aW8gZHJpdmVyIGlzIGJ1Z2d5LiAgTGV0J3MgZGlzYWJsZSBtb3N0IG9mIHRoZQo+ID4gYnVn
Z3kgY29kZSBpbiBvbmUgc3BlY2lhbCBjYXNlIGluIHdoaWNoIHdlIG5lZWQgYSBkcml2ZXIgd2l0
aG91dCBidWdzLgo+ID4gSW4gYWxsIHRoZSBvdGhlciBjYXNlcyAoZS5nLiBoYXJkd2FyZSB2aXJ0
aW8gZGV2aWNlIGNvbm5lY3RlZCBvdmVyCj4gPiBVU0ItQyksIGRyaXZlciBidWdzIGFyZSBzdGls
bCBhbGxvd2VkLiIKPiAKPiBNeSB1bmRlcnN0YW5kaW5nIGlzIG1vc3Qgb2YgdGhlIG90aGVyIG1v
ZGVzIChleGNlcHQgZm9yIHNwbGl0IHdpdGggCj4gc2VwYXJhdGUgZGVzY3JpcHRvcnMpIGFyZSBv
YnNvbGV0ZSBhbmQganVzdCB0aGVyZSBmb3IgY29tcGF0aWJpbGl0eS4gQXMgCj4gbG9uZyBhcyB0
aGV5J3JlIGRlcHJlY2F0ZWQgdGhleSB3b24ndCBoYXJtIGFueW9uZS4KPiAKPgoKVGVsbCB0aGF0
IHRvIGV2ZXJ5IGNyeXB0byBkb3duZ3JhZGUgYXR0YWNrIGV2ZXIuCgpJIHNlZSB0d28gY3JlZGli
bGUgc29sdXRpb25zOgoKMS4gQWN0dWFsbHkgaGFyZGVuIHRoZSB2aXJ0aW8gZHJpdmVyLgoKMi4g
SGF2ZSBhIG5ldyB2aXJ0aW8tbW9kZXJuIGRyaXZlciBhbmQgdXNlIGl0IGZvciBtb2Rlcm4gdXNl
IGNhc2VzLiBNYXliZSByZW5hbWUgdGhlIG9sZCBkcml2ZXIgdmlydGlvLWxlZ2FjeSBvciB2aXJ0
aW8taW5zZWN1cmUuICBUaGV5IGNhbiBzaGFyZSBjb2RlLgoKQW5vdGhlciBzbmFnIHlvdSBtYXkg
aGl0OiB2aXJ0aW/igJlzIGhldXJpc3RpYyBmb3Igd2hldGhlciB0byB1c2UgcHJvcGVyIERNQSBv
cHMgb3IgdG8gYnlwYXNzIHRoZW0gaXMgYSBnaWFudCBrbHVkZ2UuIEnigJltIHZlcnkgc2xpZ2h0
bHkgb3B0aW1pc3RpYyB0aGF0IGdldHRpbmcgdGhlIGhldXJpc3RpYyB3cm9uZyB3aWxsIG1ha2Ug
dGhlIGRyaXZlciBmYWlsIHRvIG9wZXJhdGUgYnV0IHdvbuKAmXQgYWxsb3cgdGhlIGhvc3QgdG8g
dGFrZSBvdmVyIHRoZSBndWVzdCwgYnV0IEnigJltIG5vdCByZWFsbHkgY29udmluY2VkLiBBbmQg
SSB3cm90ZSB0aGF0IGNvZGUhICBBIHZpcnRpby1tb2Rlcm4gbW9kZSBwcm9iYWJseSBzaG91bGQg
bm90IGhhdmUgYSBoZXVyaXN0aWMsIGFuZCB0aGUgdmFyaW91cyBpb21tdS1ieXBhc3NpbmcgbW9k
ZXMgc2hvdWxkIGJlIGZpeGVkIHRvIHdvcmsgYXQgdGhlIGJ1cyBsZXZlbCwgbm90IHRoZSBkZXZp
Y2UgbGV2ZWwuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
