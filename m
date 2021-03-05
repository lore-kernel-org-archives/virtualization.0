Return-Path: <SRS0=gmSK=ID=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E6BC433DB
	for <virtualization@archiver.kernel.org>; Fri,  5 Mar 2021 06:52:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C987765016
	for <virtualization@archiver.kernel.org>; Fri,  5 Mar 2021 06:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C987765016
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F45B6F4C8;
	Fri,  5 Mar 2021 06:52:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jyt8H1ZfvVMH; Fri,  5 Mar 2021 06:52:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id EFB516F47C;
	Fri,  5 Mar 2021 06:52:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D31AEC000B;
	Fri,  5 Mar 2021 06:52:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF869C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 06:52:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C5DFC4314A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 06:52:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AJCR-1lPpUlz
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 06:52:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5BE0F43095
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 06:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614927122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hMoNnn3UtTE0eoUCDwOe0zJmsgQzeuz9TyT/WXTFzF4=;
 b=VrkdiqQj4E41J7vCsi1A2+HDLp+tt3LVAA/uMGjQuYTgTQHn4xB2Wp8r4jT+ro8Qfv0lOO
 f3coX2Yl9x00Wj/PC4Sv2DQCuoBL9YVeDfdGgSrvZhM/0jyzx85krsmSUeJVxZteawTKsw
 ZEnSlZ4Beeofp5QC8XeTDzLwfAPNasI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-39KVD8d9PSKq0oPJeYKS2A-1; Fri, 05 Mar 2021 01:51:59 -0500
X-MC-Unique: 39KVD8d9PSKq0oPJeYKS2A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AB2D84BA40;
 Fri,  5 Mar 2021 06:51:57 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-165.pek2.redhat.com
 [10.72.12.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 643966E51D;
 Fri,  5 Mar 2021 06:51:44 +0000 (UTC)
Subject: Re: [RFC v4 06/11] vduse: Implement an MMU-based IOMMU driver
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210223115048.435-1-xieyongji@bytedance.com>
 <20210223115048.435-7-xieyongji@bytedance.com>
 <573ab913-55ce-045a-478f-1200bd78cf7b@redhat.com>
 <CACycT3sVhDKKu4zGbt1Lw-uWfKDAWs=O=C7kXXcuSnePohmBdQ@mail.gmail.com>
 <c173b7ec-8c90-d0e3-7272-a56aa8935e64@redhat.com>
 <CACycT3vb=WyrMpiOOdVDGEh8cEDb-xaj1esQx2UEQpJnOOWhmw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4db35f8c-ee3a-90fb-8d14-5d6014b4f6fa@redhat.com>
Date: Fri, 5 Mar 2021 14:51:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CACycT3vb=WyrMpiOOdVDGEh8cEDb-xaj1esQx2UEQpJnOOWhmw@mail.gmail.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-aio@kvack.org, netdev@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>, Matthew Wilcox <willy@infradead.org>,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Bob Liu <bob.liu@oracle.com>,
 bcrl@kvack.org, viro@zeniv.linux.org.uk, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org
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
Content-Type: multipart/mixed; boundary="===============7763103661306424560=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is a multi-part message in MIME format.
--===============7763103661306424560==
Content-Type: multipart/alternative;
 boundary="------------221DE0FC8498420CEF606DFD"
Content-Language: en-GB

This is a multi-part message in MIME format.
--------------221DE0FC8498420CEF606DFD
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2021/3/5 2:15 下午, Yongji Xie wrote:
>>>> Sorry if I've asked this before.
>>>>
>>>> But what's the reason for maintaing a dedicated IOTLB here? I think we
>>>> could reuse vduse_dev->iommu since the device can not be used by both
>>>> virtio and vhost in the same time or use vduse_iova_domain->iotlb for
>>>> set_map().
>>>>
>>> The main difference between domain->iotlb and dev->iotlb is the way to
>>> deal with bounce buffer. In the domain->iotlb case, bounce buffer
>>> needs to be mapped each DMA transfer because we need to get the bounce
>>> pages by an IOVA during DMA unmapping. In the dev->iotlb case, bounce
>>> buffer only needs to be mapped once during initialization, which will
>>> be used to tell userspace how to do mmap().
>>>
>>>> Also, since vhost IOTLB support per mapping token (opauqe), can we use
>>>> that instead of the bounce_pages *?
>>>>
>>> Sorry, I didn't get you here. Which value do you mean to store in the
>>> opaque pointer？
>> So I would like to have a way to use a single IOTLB for manage all kinds
>> of mappings. Two possible ideas:
>>
>> 1) map bounce page one by one in vduse_dev_map_page(), in
>> VDUSE_IOTLB_GET_FD, try to merge the result if we had the same fd. Then
>> for bounce pages, userspace still only need to map it once and we can
>> maintain the actual mapping by storing the page or pa in the opaque
>> field of IOTLB entry.
> Looks like userspace still needs to unmap the old region and map a new
> region (size is changed) with the fd in each VDUSE_IOTLB_GET_FD ioctl.


I don't get here. Can you give an example?


>
>> 2) map bounce page once in vduse_dev_map_page() and store struct page
>> **bounce_pages in the opaque field of this single IOTLB entry.
>>
> We can get the struct page **bounce_pages from vduse_iova_domain. Why
> do we need to store it in the opaque field?  Should the opaque field
> be used to store vdpa_map_file?


Oh yes, you're right.


>
> And I think it works. One problem is we need to find a place to store
> the original DMA buffer's address and size. I think we can modify the
> array of bounce_pages for this purpose.
>
> Thanks,
> Yongji


Yes.

Thanks


>

--------------221DE0FC8498420CEF606DFD
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021/3/5 2:15 下午, Yongji Xie wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CACycT3vb=WyrMpiOOdVDGEh8cEDb-xaj1esQx2UEQpJnOOWhmw@mail.gmail.com">
      <blockquote type="cite" style="color: #007cff;">
        <blockquote type="cite" style="color: #007cff;">
          <blockquote type="cite" style="color: #007cff;">
            <pre class="moz-quote-pre" wrap="">Sorry if I've asked this before.

But what's the reason for maintaing a dedicated IOTLB here? I think we
could reuse vduse_dev-&gt;iommu since the device can not be used by both
virtio and vhost in the same time or use vduse_iova_domain-&gt;iotlb for
set_map().

</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">The main difference between domain-&gt;iotlb and dev-&gt;iotlb is the way to
deal with bounce buffer. In the domain-&gt;iotlb case, bounce buffer
needs to be mapped each DMA transfer because we need to get the bounce
pages by an IOVA during DMA unmapping. In the dev-&gt;iotlb case, bounce
buffer only needs to be mapped once during initialization, which will
be used to tell userspace how to do mmap().

</pre>
          <blockquote type="cite" style="color: #007cff;">
            <pre class="moz-quote-pre" wrap="">Also, since vhost IOTLB support per mapping token (opauqe), can we use
that instead of the bounce_pages *?

</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Sorry, I didn't get you here. Which value do you mean to store in the
opaque pointer？
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
So I would like to have a way to use a single IOTLB for manage all kinds
of mappings. Two possible ideas:

1) map bounce page one by one in vduse_dev_map_page(), in
VDUSE_IOTLB_GET_FD, try to merge the result if we had the same fd. Then
for bounce pages, userspace still only need to map it once and we can
maintain the actual mapping by storing the page or pa in the opaque
field of IOTLB entry.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">Looks like userspace still needs to unmap the old region and map a new
region (size is changed) with the fd in each VDUSE_IOTLB_GET_FD ioctl.</pre>
    </blockquote>
    <p><br>
    </p>
    <p>I don't get here. Can you give an example?<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:CACycT3vb=WyrMpiOOdVDGEh8cEDb-xaj1esQx2UEQpJnOOWhmw@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite" style="color: #007cff;">
        <pre class="moz-quote-pre" wrap="">2) map bounce page once in vduse_dev_map_page() and store struct page
**bounce_pages in the opaque field of this single IOTLB entry.

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">We can get the struct page **bounce_pages from vduse_iova_domain. Why
do we need to store it in the opaque field?  Should the opaque field
be used to store vdpa_map_file?</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Oh yes, you're right.<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:CACycT3vb=WyrMpiOOdVDGEh8cEDb-xaj1esQx2UEQpJnOOWhmw@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">

And I think it works. One problem is we need to find a place to store
the original DMA buffer's address and size. I think we can modify the
array of bounce_pages for this purpose.

Thanks,
Yongji</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Yes.</p>
    <p>Thanks<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:CACycT3vb=WyrMpiOOdVDGEh8cEDb-xaj1esQx2UEQpJnOOWhmw@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">

</pre>
    </blockquote>
  </body>
</html>

--------------221DE0FC8498420CEF606DFD--


--===============7763103661306424560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7763103661306424560==--

