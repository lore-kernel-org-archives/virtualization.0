Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA64C7618D
	for <virtualization@archiver.kernel.org>; Mon, 20 Mar 2023 10:42:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F6B960BF8;
	Mon, 20 Mar 2023 10:42:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1F6B960BF8
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=aROtAmz/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aHQkqHOKep1R; Mon, 20 Mar 2023 10:42:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8F5B560AC9;
	Mon, 20 Mar 2023 10:42:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8F5B560AC9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FAEFC0071;
	Mon, 20 Mar 2023 10:42:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E338C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 10:42:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DD2B160B19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 10:42:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DD2B160B19
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CLRXJR3IY3n9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 10:42:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E8C5C60AC9
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E8C5C60AC9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 10:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Date:MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:From:Subject
 :Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
 bh=S6PJWXorYfxubci0Llo4uduSyji2uSjy0wjtwS9/tr8=; b=aROtAmz/Rxblox23+2ut2cqkb6
 sJNg3+qL1gw1ETWn6T8umzSrt1A2B+jolBZ6Q/mbL1Q1JgLvCbnHg3R/0jYt8gyF3k+Q00zD3KRiY
 zDSMxK5AOLVsFA9gJIKqJe6yw+x+CcYUala7PIt9nTnwEFAuj28EuLQy0WANsgGQ6pthweqFFka9Z
 EekcbYXTN6HN9kB+aQ8o0vVqYeikpetPHQL4/sAZ2Rjaa5nTPiOLLmVRbF7aB9mES5p9iC8PPHMeC
 AV1HwEbRa/FXTW4udynlYKX+QZ0CCrKy5ZQOGlJ1IRr9EAQQMEYv/c943lcMusLj9/SMkSXNnvV2M
 t/on2o8A==;
Received: from [54.239.6.186] (helo=edge-cache-203.e-hkg50.amazon.com)
 by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1peCy4-003tXs-0r; Mon, 20 Mar 2023 10:42:20 +0000
Message-ID: <8e05c7e2af238cdbcce1177e8684e192a71421b9.camel@infradead.org>
Subject: Re: [PATCH v2 0/2] [RFC] virtio-rng entropy leak reporting feature
From: Amit Shah <amit@infradead.org>
To: bchalios@amazon.es, "Jason A. Donenfeld" <Jason@zx2c4.com>, Olivia
 Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 linux-crypto@vger.kernel.org,  linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,  sgarzare@redhat.com,
 amit@kernel.org, graf@amazon.de, xmarcalx@amazon.co.uk
In-Reply-To: <5441d09dc213998042a337b7f411bd1662b604bc.camel@infradead.org>
References: <20230131145543.86369-1-bchalios@amazon.es>
 <Y9lBeymca9eFaJ33@zx2c4.com>
 <65d872db2e1be29bb03b43ed606e7cc9e74ec08d.camel@infradead.org>
 <e1c03136-b873-1f1d-8b06-d9186566fc0c@amazon.es>
 <5441d09dc213998042a337b7f411bd1662b604bc.camel@infradead.org>
MIME-Version: 1.0
Date: Mon, 20 Mar 2023 11:42:02 +0100
User-Agent: Evolution 3.44.4-0ubuntu1 
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, 2023-03-13 at 19:05 +0100, Amit Shah wrote:
> Hey Herbert / Jason / crypto maintainers,

[...]

> Let's wait a couple more days for responses, otherwise I suggest you
> resubmit to kickstart a new discussion, with the note that Jason had
> something else in mind - so that it doesn't appear as though we're
> trying to override that.

I reached out to Jason on IRC, and he mentioned he will follow up with
a patch that incorporates ideas from your patch plus hooking into
random.c.  Sounds promising!

		Amit
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
