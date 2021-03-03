Return-Path: <SRS0=2V5C=IB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05584C433E0
	for <virtualization@archiver.kernel.org>; Wed,  3 Mar 2021 04:01:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D08E64E76
	for <virtualization@archiver.kernel.org>; Wed,  3 Mar 2021 04:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D08E64E76
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0B8F843219;
	Wed,  3 Mar 2021 04:01:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rjN6wBEpVPFr; Wed,  3 Mar 2021 04:01:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6DD4E43192;
	Wed,  3 Mar 2021 04:01:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4512BC000B;
	Wed,  3 Mar 2021 04:01:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3003FC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 04:01:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 114C483478
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 04:01:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PUeaMb_DTBhS
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 04:01:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CECB082D49
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 04:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614744074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XKfDC9Z5WJgOxXrNVXAKBbr96Mmb3Os7s67J5ECy14Q=;
 b=FDG+LTf7VXakQrGg8iHuRMrKrpIb0M3jNliBtcwCiGrMqw8IJUlCjvVnD2lD4A5X++bvZu
 d6O+Z0qVCoqANnklYL2VpnEOWilGyBliwZYZp5kSSsGul2Ly1yp0CvoXWOeTqmiUlsLOsI
 sc7RhnF+QyArKkdYLJABVUK2NQa6/xc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388--qSvB34zPxW3DnP_L-GsSQ-1; Tue, 02 Mar 2021 23:01:11 -0500
X-MC-Unique: -qSvB34zPxW3DnP_L-GsSQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30F7D189C448;
 Wed,  3 Mar 2021 04:01:10 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-128.pek2.redhat.com
 [10.72.12.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 75FF15C1BB;
 Wed,  3 Mar 2021 04:01:03 +0000 (UTC)
Subject: Re: [virtio-dev] Re: [PATCH] vdpa/mlx5: set_features should allow
 reset to zero
To: Cornelia Huck <cohuck@redhat.com>
References: <20210223041740-mutt-send-email-mst@kernel.org>
 <788a0880-0a68-20b7-5bdf-f8150b08276a@redhat.com>
 <20210223110430.2f098bc0.cohuck@redhat.com>
 <bbb0a09e-17e1-a397-1b64-6ce9afe18e44@redhat.com>
 <20210223115833.732d809c.cohuck@redhat.com>
 <8355f9b3-4cda-cd2e-98df-fed020193008@redhat.com>
 <20210224121234.0127ae4b.cohuck@redhat.com>
 <be6713d3-ac98-bbbf-1dc1-a003ed06a156@redhat.com>
 <20210225135229-mutt-send-email-mst@kernel.org>
 <0f8eb381-cc98-9e05-0e35-ccdb1cbd6119@redhat.com>
 <20210228162306-mutt-send-email-mst@kernel.org>
 <cdd72199-ac7b-cc8d-2c40-81e43162c532@redhat.com>
 <20210302130812.6227f176.cohuck@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5f6972fe-7246-b622-958d-9cab8dd98e21@redhat.com>
Date: Wed, 3 Mar 2021 12:01:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210302130812.6227f176.cohuck@redhat.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Si-Wei Liu <si-wei.liu@oracle.com>,
 elic@nvidia.com
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
Content-Type: multipart/mixed; boundary="===============2033244550667477001=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is a multi-part message in MIME format.
--===============2033244550667477001==
Content-Type: multipart/alternative;
 boundary="------------B826CAB68AD9EEBB055DC45D"
Content-Language: en-GB

This is a multi-part message in MIME format.
--------------B826CAB68AD9EEBB055DC45D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2021/3/2 8:08 下午, Cornelia Huck wrote:
> On Mon, 1 Mar 2021 11:51:08 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
>> On 2021/3/1 5:25 上午, Michael S. Tsirkin wrote:
>>> On Fri, Feb 26, 2021 at 04:19:16PM +0800, Jason Wang wrote:
>>>> On 2021/2/26 2:53 上午, Michael S. Tsirkin wrote:
>>>>> Confused. What is wrong with the above? It never reads the
>>>>> field unless the feature has been offered by device.
>>>> So the spec said:
>>>>
>>>> "
>>>>
>>>> The following driver-read-only field, max_virtqueue_pairs only exists if
>>>> VIRTIO_NET_F_MQ is set.
>>>>
>>>> "
>>>>
>>>> If I read this correctly, there will be no max_virtqueue_pairs field if the
>>>> VIRTIO_NET_F_MQ is not offered by device? If yes the offsetof() violates
>>>> what spec said.
>>>>
>>>> Thanks
>>> I think that's a misunderstanding. This text was never intended to
>>> imply that field offsets change beased on feature bits.
>>> We had this pain with legacy and we never wanted to go back there.
>>>
>>> This merely implies that without VIRTIO_NET_F_MQ the field
>>> should not be accessed. Exists in the sense "is accessible to driver".
>>>
>>> Let's just clarify that in the spec, job done.
>>
>> Ok, agree. That will make things more eaiser.
> Yes, that makes much more sense.
>
> What about adding the following to the "Basic Facilities of a Virtio
> Device/Device Configuration Space" section of the spec:
>
> "If an optional configuration field does not exist, the corresponding
> space is still present, but reserved."


This became interesting after re-reading some of the qemu codes.

E.g in virtio-net.c we had:

*static VirtIOFeature feature_sizes[] = {
     {.flags = 1ULL << VIRTIO_NET_F_MAC,
      .end = endof(struct virtio_net_config, mac)},
     {.flags = 1ULL << VIRTIO_NET_F_STATUS,
      .end = endof(struct virtio_net_config, status)},
     {.flags = 1ULL << VIRTIO_NET_F_MQ,
      .end = endof(struct virtio_net_config, max_virtqueue_pairs)},
     {.flags = 1ULL << VIRTIO_NET_F_MTU,
      .end = endof(struct virtio_net_config, mtu)},
     {.flags = 1ULL << VIRTIO_NET_F_SPEED_DUPLEX,
      .end = endof(struct virtio_net_config, duplex)},
     {.flags = (1ULL << VIRTIO_NET_F_RSS) | (1ULL << 
VIRTIO_NET_F_HASH_REPORT),
      .end = endof(struct virtio_net_config, supported_hash_types)},
     {}
};*

*It has a implict dependency chain. E.g MTU doesn't presnet if 
DUPLEX/RSS is not offered ...
*


>
> (Do we need to specify what a device needs to do if the driver tries to
> access a non-existing field? We cannot really make assumptions about
> config space accesses; virtio-ccw can just copy a chunk of config space
> that contains non-existing fields...


Right, it looks to me ccw doesn't depends on config len which is kind of 
interesting. I think the answer depends on the implementation of both 
transport and device:

Let's take virtio-net-pci as an example, it fills status unconditionally 
in virtio_net_set_config() even if VIRTIO_NET_F_STATUS is not 
negotiated. So with the above feature_sizes:

1) if one of the MQ, MTU, DUPLEX or RSS is implemented, driver can still 
read status in this case
2) if none of the above four is negotied, driver can only read a 0xFF 
(virtio_config_readb())


> I guess the device could ignore
> writes and return zeroes on read?)


So consider the above, it might be too late to fix/clarify that in the 
spec on the expected behaviour of reading/writing non-exist fields.

Thanks


>
> I've opened https://github.com/oasis-tcs/virtio-spec/issues/98 for the
> spec issues.
>

--------------B826CAB68AD9EEBB055DC45D
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021/3/2 8:08 下午, Cornelia Huck
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20210302130812.6227f176.cohuck@redhat.com">
      <pre class="moz-quote-pre" wrap="">On Mon, 1 Mar 2021 11:51:08 +0800
Jason Wang <a class="moz-txt-link-rfc2396E" href="mailto:jasowang@redhat.com">&lt;jasowang@redhat.com&gt;</a> wrote:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">On 2021/3/1 5:25 上午, Michael S. Tsirkin wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On Fri, Feb 26, 2021 at 04:19:16PM +0800, Jason Wang wrote:  
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">On 2021/2/26 2:53 上午, Michael S. Tsirkin wrote:  
</pre>
          </blockquote>
        </blockquote>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">Confused. What is wrong with the above? It never reads the
field unless the feature has been offered by device.  
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">
So the spec said:

"

The following driver-read-only field, max_virtqueue_pairs only exists if
VIRTIO_NET_F_MQ is set.

"

If I read this correctly, there will be no max_virtqueue_pairs field if the
VIRTIO_NET_F_MQ is not offered by device? If yes the offsetof() violates
what spec said.

Thanks  
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">I think that's a misunderstanding. This text was never intended to
imply that field offsets change beased on feature bits.
We had this pain with legacy and we never wanted to go back there.

This merely implies that without VIRTIO_NET_F_MQ the field
should not be accessed. Exists in the sense "is accessible to driver".

Let's just clarify that in the spec, job done.  
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">

Ok, agree. That will make things more eaiser.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Yes, that makes much more sense.

What about adding the following to the "Basic Facilities of a Virtio
Device/Device Configuration Space" section of the spec:

"If an optional configuration field does not exist, the corresponding
space is still present, but reserved."</pre>
    </blockquote>
    <p><br>
    </p>
    <p>This became interesting after re-reading some of the qemu codes.</p>
    <p>E.g in virtio-net.c we had:</p>
    <p><b style="font-weight:normal;"
        id="docs-internal-guid-6138ff0e-7fff-1df8-93af-8b0b791ded04"><span>static
          VirtIOFeature feature_sizes[] = {<br>
              {.flags = 1ULL &lt;&lt; VIRTIO_NET_F_MAC,<br>
               .end = endof(struct virtio_net_config, mac)},<br>
              {.flags = 1ULL &lt;&lt; VIRTIO_NET_F_STATUS,<br>
               .end = endof(struct virtio_net_config, status)},<br>
              {.flags = 1ULL &lt;&lt; VIRTIO_NET_F_MQ,<br>
               .end = endof(struct virtio_net_config,
          max_virtqueue_pairs)},<br>
              {.flags = 1ULL &lt;&lt; VIRTIO_NET_F_MTU,<br>
               .end = endof(struct virtio_net_config, mtu)},<br>
              {.flags = 1ULL &lt;&lt; VIRTIO_NET_F_SPEED_DUPLEX,<br>
               .end = endof(struct virtio_net_config, duplex)},<br>
              {.flags = (1ULL &lt;&lt; VIRTIO_NET_F_RSS) | (1ULL
          &lt;&lt; VIRTIO_NET_F_HASH_REPORT),<br>
               .end = endof(struct virtio_net_config,
          supported_hash_types)},<br>
              {}<br>
          };</span></b></p>
    <p><b style="font-weight:normal;"
        id="docs-internal-guid-6138ff0e-7fff-1df8-93af-8b0b791ded04"><span>It
          has a implict dependency chain. E.g MTU doesn't presnet if
          DUPLEX/RSS is not offered ...<br>
        </span></b></p>
    <p><br>
    </p>
    <blockquote type="cite"
      cite="mid:20210302130812.6227f176.cohuck@redhat.com">
      <pre class="moz-quote-pre" wrap="">

(Do we need to specify what a device needs to do if the driver tries to
access a non-existing field? We cannot really make assumptions about
config space accesses; virtio-ccw can just copy a chunk of config space
that contains non-existing fields... </pre>
    </blockquote>
    <p><br>
    </p>
    <p>Right, it looks to me ccw doesn't depends on config len which is
      kind of interesting. I think the answer depends on the
      implementation of both transport and device:<br>
    </p>
    <p>Let's take virtio-net-pci as an example, it fills status
      unconditionally in virtio_net_set_config() even if
      VIRTIO_NET_F_STATUS is not negotiated. So with the above
      feature_sizes:</p>
    <p>1) if one of the MQ, MTU, DUPLEX or RSS is implemented, driver
      can still read status in this case<br>
      2) if none of the above four is negotied, driver can only read a
      0xFF (virtio_config_readb())</p>
    <p><br>
    </p>
    <blockquote type="cite"
      cite="mid:20210302130812.6227f176.cohuck@redhat.com">
      <pre class="moz-quote-pre" wrap="">I guess the device could ignore
writes and return zeroes on read?)</pre>
    </blockquote>
    <p><br>
    </p>
    <p>So consider the above, it might be too late to fix/clarify that
      in the spec on the expected behaviour of reading/writing non-exist
      fields.</p>
    <p>Thanks<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite"
      cite="mid:20210302130812.6227f176.cohuck@redhat.com">
      <pre class="moz-quote-pre" wrap="">

I've opened <a class="moz-txt-link-freetext" href="https://github.com/oasis-tcs/virtio-spec/issues/98">https://github.com/oasis-tcs/virtio-spec/issues/98</a> for the
spec issues.

</pre>
    </blockquote>
  </body>
</html>

--------------B826CAB68AD9EEBB055DC45D--


--===============2033244550667477001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2033244550667477001==--

