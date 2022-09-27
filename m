Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FADC54EE9
	for <virtualization@archiver.kernel.org>; Tue, 27 Sep 2022 19:59:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9ECE980F2C;
	Tue, 27 Sep 2022 19:59:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9ECE980F2C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OZ9/23BT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JrTkbnd4Y_J8; Tue, 27 Sep 2022 19:59:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D761B80C13;
	Tue, 27 Sep 2022 19:59:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D761B80C13
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E8A4C0032;
	Tue, 27 Sep 2022 19:59:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE2D6C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 19:59:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BB08A60888
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 19:59:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BB08A60888
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OZ9/23BT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dhM6jsBgmFZm
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 19:59:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CC862607B0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CC862607B0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 19:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664308752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dx5HDOePnyxgHzqa6DOD5MnqegsYWwrLtgMoZQ1P8dI=;
 b=OZ9/23BTvKP786RkcnXIdeMb7F6oyiy3NTV7Z36oQR7lbXRVizuDXj37K2LIiSx+yP2fjY
 sxPNr4MxwbeuHNPX77a8x8A3555KAdSOSD5WCzpx1ldvuTANIcR5m/vO49GbMd4uGeeQKy
 7HA86eD6PRaxdaXsGL0I5BIsEQHSae4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-146-6l51Okc7Mdu_XBV8a5wWFg-1; Tue, 27 Sep 2022 15:59:09 -0400
X-MC-Unique: 6l51Okc7Mdu_XBV8a5wWFg-1
Received: by mail-wm1-f70.google.com with SMTP id
 l15-20020a05600c4f0f00b003b4bec80edbso6003536wmq.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 12:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date;
 bh=Dx5HDOePnyxgHzqa6DOD5MnqegsYWwrLtgMoZQ1P8dI=;
 b=2WpsqIWBjCdVtr1Rsc3iraoEi5+ykkDg9iCsb5/NBVf5++sVMQAB77n/Mo4P4EAAkG
 xzPE895AHFCB5R/2PnzIBFNvEiJLj0EP++KQPAH3rkc7I8iL+d6FIobAA7hSExwjh95u
 j1Fx0efp05VdXgG5ILZuE8D5qshytEVPBsBRqMRNAFbfLq2KArYWnXMAxgUHYa+3zV7Y
 2+16eKFSYKp88oMg2Uvew/0u7Pa9Xglwm0V1KQ8dhL376Wb5pmkQn05sk2Yv/aH48rvR
 WSJIDIPq1G+N1uh5zDz8KYu1ucSvtGvY3XcqdOhcg7mFV7PTQJvUgcHvPlK8KZw3KA7J
 kS1g==
X-Gm-Message-State: ACrzQf21WkXYjo0OQeO7W7fpSlc5JnVGbvx0Lxd/OTi42xc3g4aNoL8+
 UvkU31Fzoz5sJYE3MxbCAMHpODNGHG2A8t4kyPIVD6V7hbARQjgKp/Fhn6rJkagAjgqdraopX//
 zMVgIWQJUloeHcEMqfTilzfk3eR21TyPUxx0t4HSa5A==
X-Received: by 2002:a05:6000:1a8a:b0:22a:33aa:a907 with SMTP id
 f10-20020a0560001a8a00b0022a33aaa907mr17893672wry.322.1664308748215; 
 Tue, 27 Sep 2022 12:59:08 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7eOWYFV9iprtkvNGfif9TK9/JHNd5re5oxCk70ig0yrmbrjCmGTXstvwdg4i4Hc1mUWp0nvA==
X-Received: by 2002:a05:6000:1a8a:b0:22a:33aa:a907 with SMTP id
 f10-20020a0560001a8a00b0022a33aaa907mr17893654wry.322.1664308747882; 
 Tue, 27 Sep 2022 12:59:07 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-104-40.dyn.eolo.it.
 [146.241.104.40]) by smtp.gmail.com with ESMTPSA id
 f12-20020a05600c4e8c00b003b33943ce5esm17310012wmq.32.2022.09.27.12.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Sep 2022 12:59:07 -0700 (PDT)
Message-ID: <6502e1a45526f97a1e6d7d27bbe07e3bb3623de3.camel@redhat.com>
Subject: Re: [PATCH net-next 0/4] shrink struct ubuf_info
From: Paolo Abeni <pabeni@redhat.com>
To: Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org
Date: Tue, 27 Sep 2022 21:59:06 +0200
In-Reply-To: <c06897d4-4883-2756-87f9-9b10ab495c43@gmail.com>
References: <cover.1663892211.git.asml.silence@gmail.com>
 <7fef56880d40b9d83cc99317df9060c4e7cdf919.camel@redhat.com>
 <021d8ea4-891c-237d-686e-64cecc2cc842@gmail.com>
 <bbb212f6-0165-0747-d99d-b49acbb02a80@gmail.com>
 <85cccb780608e830024fc82a8e4f703031646f4e.camel@redhat.com>
 <c06897d4-4883-2756-87f9-9b10ab495c43@gmail.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Wei Liu <wei.liu@kernel.org>, kvm@vger.kernel.org,
 Paul Durrant <paul@xen.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 xen-devel@lists.xenproject.org, Jakub Kicinski <kuba@kernel.org>,
 "David S . Miller" <davem@davemloft.net>
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

On Tue, 2022-09-27 at 19:48 +0100, Pavel Begunkov wrote:
> On 9/27/22 18:56, Paolo Abeni wrote:
> > On Tue, 2022-09-27 at 18:16 +0100, Pavel Begunkov wrote:
> > > On 9/27/22 15:28, Pavel Begunkov wrote:
> > > > Hello Paolo,
> > > > 
> > > > On 9/27/22 14:49, Paolo Abeni wrote:
> > > > > Hello,
> > > > > 
> > > > > On Fri, 2022-09-23 at 17:39 +0100, Pavel Begunkov wrote:
> > > > > > struct ubuf_info is large but not all fields are needed for all
> > > > > > cases. We have limited space in io_uring for it and large ubuf_info
> > > > > > prevents some struct embedding, even though we use only a subset
> > > > > > of the fields. It's also not very clean trying to use this typeless
> > > > > > extra space.
> > > > > > 
> > > > > > Shrink struct ubuf_info to only necessary fields used in generic paths,
> > > > > > namely ->callback, ->refcnt and ->flags, which take only 16 bytes. And
> > > > > > make MSG_ZEROCOPY and some other users to embed it into a larger struct
> > > > > > ubuf_info_msgzc mimicking the former ubuf_info.
> > > > > > 
> > > > > > Note, xen/vhost may also have some cleaning on top by creating
> > > > > > new structs containing ubuf_info but with proper types.
> > > > > 
> > > > > That sounds a bit scaring to me. If I read correctly, every uarg user
> > > > > should check 'uarg->callback == msg_zerocopy_callback' before accessing
> > > > > any 'extend' fields.
> > > > 
> > > > Providers of ubuf_info access those fields via callbacks and so already
> > > > know the actual structure used. The net core, on the opposite, should
> > > > keep it encapsulated and not touch them at all.
> > > > 
> > > > The series lists all places where we use extended fields just on the
> > > > merit of stripping the structure of those fields and successfully
> > > > building it. The only user in net/ipv{4,6}/* is MSG_ZEROCOPY, which
> > > > again uses callbacks.
> > > > 
> > > > Sounds like the right direction for me. There is a couple of
> > > > places where it might get type safer, i.e. adding types instead
> > > > of void* in for struct tun_msg_ctl and getting rid of one macro
> > > > hiding types in xen. But seems more like TODO for later.
> > > > 
> > > > > AFAICS the current code sometimes don't do the
> > > > > explicit test because the condition is somewhat implied, which in turn
> > > > > is quite hard to track.
> > > > > 
> > > > > clearing uarg->zerocopy for the 'wrong' uarg was armless and undetected
> > > > > before this series, and after will trigger an oops..
> > > > 
> > > > And now we don't have this field at all to access, considering that
> > > > nobody blindly casts it.
> > > > 
> > > > > There is some noise due to uarg -> uarg_zc renaming which make the
> > > > > series harder to review. Have you considered instead keeping the old
> > > > > name and introducing a smaller 'struct ubuf_info_common'? the overall
> > > > > code should be mostly the same, but it will avoid the above mentioned
> > > > > noise.
> > > > 
> > > > I don't think there will be less noise this way, but let me try
> > > > and see if I can get rid of some churn.
> > > 
> > > It doesn't look any better for me
> > > 
> > > TL;DR; This series converts only 3 users: tap, xen and MSG_ZEROCOPY
> > > and doesn't touch core code. If we do ubuf_info_common though I'd need
> > > to convert lots of places in skbuff.c and multiple places across
> > > tcp/udp, which is much worse.
> > 
> > Uhmm... I underlook the fact we must preserve the current accessors for
> > the common fields.
> > 
> > I guess something like the following could do (completely untested,
> > hopefully should illustrate the idea):
> > 
> > struct ubuf_info {
> > 	struct_group_tagged(ubuf_info_common, common,
> > 		void (*callback)(struct sk_buff *, struct ubuf_info *,
> >                           bool zerocopy_success);
> > 		refcount_t refcnt;
> > 	        u8 flags;
> > 	);
> > 
> > 	union {
> >                  struct {
> >                          unsigned long desc;
> >                          void *ctx;
> >                  };
> >                  struct {
> >                          u32 id;
> >                          u16 len;
> >                          u16 zerocopy:1;
> >                          u32 bytelen;
> >                  };
> >          };
> > 
> >          struct mmpin {
> >                  struct user_struct *user;
> >                  unsigned int num_pg;
> >          } mmp;
> > };
> > 
> > Then you should be able to:
> > - access ubuf_info->callback,
> > - access the same field via ubuf_info->common.callback
> > - declare variables as 'struct ubuf_info_commom' with appropriate
> > contents.
> > 
> > WDYT?
> 
> Interesting, I didn't think about struct_group, this would
> let to split patches better and would limit non-core changes.
> But if the plan is to convert the core helpers to
> ubuf_info_common, than I think it's still messier than changing
> ubuf providers only.
> 
> I can do the exercise, but I don't really see what is the goal.
> Let me ask this, if we forget for a second how diffs look,
> do you care about which pair is going to be in the end?

Uhm... I proposed this initially with the goal of remove non fuctional
changes from a patch that was hard to digest for me (4/4). So it's
about diffstat to me ;) 

On the flip side the change suggested would probably not be as
straighforward as I would hope for.

> ubuf_info_common/ubuf_info vs ubuf_info/ubuf_info_msgzc?

The specific names used are not much relevant.

> Are there you concerned about naming or is there more to it?

I feel like this series is potentially dangerous, but I could not spot
bugs into the code. I would have felt more relaxed eariler in the devel
cycle.

Cheers,

Paolo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
