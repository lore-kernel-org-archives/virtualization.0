Return-Path: <SRS0=4L+9=IY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B75C433DB
	for <virtualization@archiver.kernel.org>; Fri, 26 Mar 2021 06:16:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FFCE61A0A
	for <virtualization@archiver.kernel.org>; Fri, 26 Mar 2021 06:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FFCE61A0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0C84E4023B;
	Fri, 26 Mar 2021 06:16:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qnaJOXf_tYJg; Fri, 26 Mar 2021 06:16:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8021A40239;
	Fri, 26 Mar 2021 06:16:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58D09C000E;
	Fri, 26 Mar 2021 06:16:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15DFEC000A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Mar 2021 06:16:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EBFD940239
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Mar 2021 06:16:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KUl5fQn_ks-c
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Mar 2021 06:16:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 01D4640237
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Mar 2021 06:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616739387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ffQsViwRS8lsOmvgKdN9Ae0D/qYLHQxwsKKbzi8qrUA=;
 b=YJRxlw41CNQRb1dB+FKWI/O6qy7qBhhBDAwPsTElCPoNCvJbIcU4+u21TtEsDllQ08YJth
 dAsR0SmkWUliiYRvRKSPTVwNZhtuknTzYZnpKwFtnSbsq8ctgz8Jxr0tKUGTa012zrserq
 SsqSzOsxEY6v4v/3RgJRzp2Bg0uqDoQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-8tD4liG2Mxu6ykwHgVwUrg-1; Fri, 26 Mar 2021 02:16:23 -0400
X-MC-Unique: 8tD4liG2Mxu6ykwHgVwUrg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E612107ACCD;
 Fri, 26 Mar 2021 06:16:20 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-10.pek2.redhat.com
 [10.72.13.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 538E31962F;
 Fri, 26 Mar 2021 06:16:07 +0000 (UTC)
Subject: Re: [PATCH v5 08/11] vduse: Implement an MMU-based IOMMU driver
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210315053721.189-1-xieyongji@bytedance.com>
 <20210315053721.189-9-xieyongji@bytedance.com>
 <ec5b4146-9844-11b0-c9b0-c657d3328dd4@redhat.com>
 <CACycT3v_-G6ju-poofXEzYt8QPKWNFHwsS7t=KTLgs-=g+iPQQ@mail.gmail.com>
 <7c90754b-681d-f3bf-514c-756abfcf3d23@redhat.com>
 <CACycT3uS870yy04rw7KBk==sioi+VNunxVz6BQH-Lmxk6m-VSg@mail.gmail.com>
 <2db71996-037e-494d-6ef0-de3ff164d3c3@redhat.com>
 <CACycT3v6Lj61fafztOuzBNFLs2TbKeqrNLXkzv5RK6-h-iTnvA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <75e3b941-dfd2-ebbc-d752-8f25c1f14cab@redhat.com>
Date: Fri, 26 Mar 2021 14:16:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CACycT3v6Lj61fafztOuzBNFLs2TbKeqrNLXkzv5RK6-h-iTnvA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Matthew Wilcox <willy@infradead.org>,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Bob Liu <bob.liu@oracle.com>,
 bcrl@kvack.org, viro@zeniv.linux.org.uk, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
 =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
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
Content-Type: multipart/mixed; boundary="===============1547225132256714277=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is a multi-part message in MIME format.
--===============1547225132256714277==
Content-Type: multipart/alternative;
 boundary="------------13E3C8F206FE43DCBADD1197"

This is a multi-part message in MIME format.
--------------13E3C8F206FE43DCBADD1197
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2021/3/26 下午1:14, Yongji Xie 写道:
>>>>>>> +     }
>>>>>>> +     map->bounce_page = page;
>>>>>>> +
>>>>>>> +     /* paired with vduse_domain_map_page() */
>>>>>>> +     smp_mb();
>>>>>> So this is suspicious. It's better to explain like, we need make sure A
>>>>>> must be done after B.
>>>>> OK. I see. It's used to protect this pattern:
>>>>>
>>>>>       vduse_domain_alloc_bounce_page:          vduse_domain_map_page:
>>>>>       write map->bounce_page                           write map->orig_phys
>>>>>       mb()                                                            mb()
>>>>>       read map->orig_phys                                 read map->bounce_page
>>>>>
>>>>> Make sure there will always be a path to do bouncing.
>>>> Ok.
>>>>
>>>>
>>>>>> And it looks to me the iotlb_lock is sufficnet to do the synchronization
>>>>>> here. E.g any reason that you don't take it in
>>>>>> vduse_domain_map_bounce_page().
>>>>>>
>>>>> Yes, we can. But the performance in multi-queue cases will go down if
>>>>> we use iotlb_lock on this critical path.
>>>>>
>>>>>> And what's more, is there anyway to aovid holding the spinlock during
>>>>>> bouncing?
>>>>>>
>>>>> Looks like we can't. In the case that multiple page faults happen on
>>>>> the same page, we should make sure the bouncing is done before any
>>>>> page fault handler returns.
>>>> So it looks to me all those extra complexitiy comes from the fact that
>>>> the bounce_page and orig_phys are set by different places so we need to
>>>> do the bouncing in two places.
>>>>
>>>> I wonder how much we can gain from the "lazy" boucning in page fault.
>>>> The buffer mapped via dma_ops from virtio driver is expected to be
>>>> accessed by the userspace soon.  It looks to me we can do all those
>>>> stuffs during dma_map() then things would be greatly simplified.
>>>>
>>> If so, we need to allocate lots of pages from the pool reserved for
>>> atomic memory allocation requests.
>> This should be fine, a lot of drivers tries to allocate pages in atomic
>> context. The point is to simplify the codes to make it easy to
>> determince the correctness so we can add optimization on top simply by
>> benchmarking the difference.
>>
> OK. I will use this way in the next version.
>
>> E.g we have serveral places that accesses orig_phys:
>>
>> 1) map_page(), write
>> 2) unmap_page(), write
>> 3) page fault handler, read
>>
>> It's not clear to me how they were synchronized. Or if it was
>> synchronzied implicitly (via iova allocator?), we'd better document it.
> Yes.
>
>> Or simply use spinlock (which is the preferrable way I'd like to go). We
>> probably don't need to worry too much about the cost of spinlock since
>> iova allocater use it heavily.
>>
> Actually iova allocator implements a per-CPU cache to optimize it.
>
> Thanks,
> Yongji


Right, but have a quick glance, I guess what you meant is that usually 
there's no lock contention unless cpu hot-plug. This can work but the 
problem is that such synchornization depends on the internal 
implementation of IOVA allocator which is kind of fragile. I still think 
we should do that on our own.

Thanks



--------------13E3C8F206FE43DCBADD1197
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">在 2021/3/26 下午1:14, Yongji Xie 写道:<br>
    </div>
    <blockquote type="cite"
cite="mid:CACycT3v6Lj61fafztOuzBNFLs2TbKeqrNLXkzv5RK6-h-iTnvA@mail.gmail.com">
      <blockquote type="cite" style="color: #007cff;">
        <blockquote type="cite" style="color: #007cff;">
          <blockquote type="cite" style="color: #007cff;">
            <blockquote type="cite" style="color: #007cff;">
              <blockquote type="cite" style="color: #007cff;">
                <blockquote type="cite" style="color: #007cff;">
                  <pre class="moz-quote-pre" wrap="">+     }
+     map-&gt;bounce_page = page;
+
+     /* paired with vduse_domain_map_page() */
+     smp_mb();
</pre>
                </blockquote>
                <pre class="moz-quote-pre" wrap="">So this is suspicious. It's better to explain like, we need make sure A
must be done after B.
</pre>
              </blockquote>
              <pre class="moz-quote-pre" wrap="">OK. I see. It's used to protect this pattern:

     vduse_domain_alloc_bounce_page:          vduse_domain_map_page:
     write map-&gt;bounce_page                           write map-&gt;orig_phys
     mb()                                                            mb()
     read map-&gt;orig_phys                                 read map-&gt;bounce_page

Make sure there will always be a path to do bouncing.
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">Ok.


</pre>
            <blockquote type="cite" style="color: #007cff;">
              <blockquote type="cite" style="color: #007cff;">
                <pre class="moz-quote-pre" wrap="">And it looks to me the iotlb_lock is sufficnet to do the synchronization
here. E.g any reason that you don't take it in
vduse_domain_map_bounce_page().

</pre>
              </blockquote>
              <pre class="moz-quote-pre" wrap="">Yes, we can. But the performance in multi-queue cases will go down if
we use iotlb_lock on this critical path.

</pre>
              <blockquote type="cite" style="color: #007cff;">
                <pre class="moz-quote-pre" wrap="">And what's more, is there anyway to aovid holding the spinlock during
bouncing?

</pre>
              </blockquote>
              <pre class="moz-quote-pre" wrap="">Looks like we can't. In the case that multiple page faults happen on
the same page, we should make sure the bouncing is done before any
page fault handler returns.
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">So it looks to me all those extra complexitiy comes from the fact that
the bounce_page and orig_phys are set by different places so we need to
do the bouncing in two places.

I wonder how much we can gain from the "lazy" boucning in page fault.
The buffer mapped via dma_ops from virtio driver is expected to be
accessed by the userspace soon.  It looks to me we can do all those
stuffs during dma_map() then things would be greatly simplified.

</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">If so, we need to allocate lots of pages from the pool reserved for
atomic memory allocation requests.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
This should be fine, a lot of drivers tries to allocate pages in atomic
context. The point is to simplify the codes to make it easy to
determince the correctness so we can add optimization on top simply by
benchmarking the difference.

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">OK. I will use this way in the next version.

</pre>
      <blockquote type="cite" style="color: #007cff;">
        <pre class="moz-quote-pre" wrap="">E.g we have serveral places that accesses orig_phys:

1) map_page(), write
2) unmap_page(), write
3) page fault handler, read

It's not clear to me how they were synchronized. Or if it was
synchronzied implicitly (via iova allocator?), we'd better document it.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">Yes.

</pre>
      <blockquote type="cite" style="color: #007cff;">
        <pre class="moz-quote-pre" wrap="">Or simply use spinlock (which is the preferrable way I'd like to go). We
probably don't need to worry too much about the cost of spinlock since
iova allocater use it heavily.

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">Actually iova allocator implements a per-CPU cache to optimize it.

Thanks,
Yongji
</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Right, but have a quick glance, I guess what you meant is that
      usually there's no lock contention unless cpu hot-plug. This can
      work but the problem is that such synchornization depends on the
      internal implementation of IOVA allocator which is kind of
      fragile. I still think we should do that on our own.<br>
    </p>
    <p>Thanks<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:CACycT3v6Lj61fafztOuzBNFLs2TbKeqrNLXkzv5RK6-h-iTnvA@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------13E3C8F206FE43DCBADD1197--


--===============1547225132256714277==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1547225132256714277==--

