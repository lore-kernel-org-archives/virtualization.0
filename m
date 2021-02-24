Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F10C433DB
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 08:27:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECCE764EC9
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 08:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECCE764EC9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F91083CC6;
	Wed, 24 Feb 2021 08:27:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tFlAcK_-blGb; Wed, 24 Feb 2021 08:27:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id A4EB083CC4;
	Wed, 24 Feb 2021 08:27:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 883DBC000A;
	Wed, 24 Feb 2021 08:27:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40249C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 08:27:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 21957606DC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 08:27:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NjjcBxrfusts
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 08:26:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D2BC9606CF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 08:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614155217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W5Qg1zyBKM1EtUgRYlwFB4RcmHgzThI/MDNAyPI+orA=;
 b=guWGomX4rn7c0jJTIHMjzNBsemY/8PAwh/2HH/ZWSWBmwCSRWPHcDbPOZuTKuFX54actdf
 Qtlc+uJjirUyr8ujLE9+eX+qqfLsgLf73dHUf/odzfDtU62Eb9gSsnxd2DcO90HQoO3uP7
 SurD7ZcYuv1sW9x9YQMJv7fuYlP194I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-S2OfcC8rNM6-wXQQ_DOodw-1; Wed, 24 Feb 2021 03:26:52 -0500
X-MC-Unique: S2OfcC8rNM6-wXQQ_DOodw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 372461936B66;
 Wed, 24 Feb 2021 08:26:51 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-96.pek2.redhat.com
 [10.72.13.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 157C75D9D0;
 Wed, 24 Feb 2021 08:26:44 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <20210222023040-mutt-send-email-mst@kernel.org>
 <22fe5923-635b-59f0-7643-2fd5876937c2@oracle.com>
 <fae0bae7-e4cd-a3aa-57fe-d707df99b634@redhat.com>
 <20210223082536-mutt-send-email-mst@kernel.org>
 <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
 <20210224000057-mutt-send-email-mst@kernel.org>
 <0559fd8c-ff44-cb7a-8a74-71976dd2ee33@redhat.com>
 <20210224014232-mutt-send-email-mst@kernel.org>
 <ce6b0380-bc4c-bcb8-db82-2605e819702c@redhat.com>
 <20210224021222-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <babc654d-8dcd-d8a2-c3b6-d20cc4fc554c@redhat.com>
Date: Wed, 24 Feb 2021 16:26:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210224021222-mutt-send-email-mst@kernel.org>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, netdev@vger.kernel.org, elic@nvidia.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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
Content-Type: multipart/mixed; boundary="===============1567021158354033211=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is a multi-part message in MIME format.
--===============1567021158354033211==
Content-Type: multipart/alternative;
 boundary="------------7C104AD64C707C26BB84C149"
Content-Language: en-GB

This is a multi-part message in MIME format.
--------------7C104AD64C707C26BB84C149
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2021/2/24 3:17 下午, Michael S. Tsirkin wrote:
> On Wed, Feb 24, 2021 at 02:53:08PM +0800, Jason Wang wrote:
>> On 2021/2/24 2:46 下午, Michael S. Tsirkin wrote:
>>> On Wed, Feb 24, 2021 at 02:04:36PM +0800, Jason Wang wrote:
>>>> On 2021/2/24 1:04 下午, Michael S. Tsirkin wrote:
>>>>> On Tue, Feb 23, 2021 at 11:35:57AM -0800, Si-Wei Liu wrote:
>>>>>> On 2/23/2021 5:26 AM, Michael S. Tsirkin wrote:
>>>>>>> On Tue, Feb 23, 2021 at 10:03:57AM +0800, Jason Wang wrote:
>>>>>>>> On 2021/2/23 9:12 上午, Si-Wei Liu wrote:
>>>>>>>>> On 2/21/2021 11:34 PM, Michael S. Tsirkin wrote:
>>>>>>>>>> On Mon, Feb 22, 2021 at 12:14:17PM +0800, Jason Wang wrote:
>>>>>>>>>>> On 2021/2/19 7:54 下午, Si-Wei Liu wrote:
>>>>>>>>>>>> Commit 452639a64ad8 ("vdpa: make sure set_features is invoked
>>>>>>>>>>>> for legacy") made an exception for legacy guests to reset
>>>>>>>>>>>> features to 0, when config space is accessed before features
>>>>>>>>>>>> are set. We should relieve the verify_min_features() check
>>>>>>>>>>>> and allow features reset to 0 for this case.
>>>>>>>>>>>>
>>>>>>>>>>>> It's worth noting that not just legacy guests could access
>>>>>>>>>>>> config space before features are set. For instance, when
>>>>>>>>>>>> feature VIRTIO_NET_F_MTU is advertised some modern driver
>>>>>>>>>>>> will try to access and validate the MTU present in the config
>>>>>>>>>>>> space before virtio features are set.
>>>>>>>>>>> This looks like a spec violation:
>>>>>>>>>>>
>>>>>>>>>>> "
>>>>>>>>>>>
>>>>>>>>>>> The following driver-read-only field, mtu only exists if
>>>>>>>>>>> VIRTIO_NET_F_MTU is
>>>>>>>>>>> set.
>>>>>>>>>>> This field specifies the maximum MTU for the driver to use.
>>>>>>>>>>> "
>>>>>>>>>>>
>>>>>>>>>>> Do we really want to workaround this?
>>>>>>>>>>>
>>>>>>>>>>> Thanks
>>>>>>>>>> And also:
>>>>>>>>>>
>>>>>>>>>> The driver MUST follow this sequence to initialize a device:
>>>>>>>>>> 1. Reset the device.
>>>>>>>>>> 2. Set the ACKNOWLEDGE status bit: the guest OS has noticed the device.
>>>>>>>>>> 3. Set the DRIVER status bit: the guest OS knows how to drive the
>>>>>>>>>> device.
>>>>>>>>>> 4. Read device feature bits, and write the subset of feature bits
>>>>>>>>>> understood by the OS and driver to the
>>>>>>>>>> device. During this step the driver MAY read (but MUST NOT write)
>>>>>>>>>> the device-specific configuration
>>>>>>>>>> fields to check that it can support the device before accepting it.
>>>>>>>>>> 5. Set the FEATURES_OK status bit. The driver MUST NOT accept new
>>>>>>>>>> feature bits after this step.
>>>>>>>>>> 6. Re-read device status to ensure the FEATURES_OK bit is still set:
>>>>>>>>>> otherwise, the device does not
>>>>>>>>>> support our subset of features and the device is unusable.
>>>>>>>>>> 7. Perform device-specific setup, including discovery of virtqueues
>>>>>>>>>> for the device, optional per-bus setup,
>>>>>>>>>> reading and possibly writing the device’s virtio configuration
>>>>>>>>>> space, and population of virtqueues.
>>>>>>>>>> 8. Set the DRIVER_OK status bit. At this point the device is “live”.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> so accessing config space before FEATURES_OK is a spec violation, right?
>>>>>>>>> It is, but it's not relevant to what this commit tries to address. I
>>>>>>>>> thought the legacy guest still needs to be supported.
>>>>>>>>>
>>>>>>>>> Having said, a separate patch has to be posted to fix the guest driver
>>>>>>>>> issue where this discrepancy is introduced to virtnet_validate() (since
>>>>>>>>> commit fe36cbe067). But it's not technically related to this patch.
>>>>>>>>>
>>>>>>>>> -Siwei
>>>>>>>> I think it's a bug to read config space in validate, we should move it to
>>>>>>>> virtnet_probe().
>>>>>>>>
>>>>>>>> Thanks
>>>>>>> I take it back, reading but not writing seems to be explicitly allowed by spec.
>>>>>>> So our way to detect a legacy guest is bogus, need to think what is
>>>>>>> the best way to handle this.
>>>>>> Then maybe revert commit fe36cbe067 and friends, and have QEMU detect legacy
>>>>>> guest? Supposedly only config space write access needs to be guarded before
>>>>>> setting FEATURES_OK.
>>>>>>
>>>>>> -Siwie
>>>>> Detecting it isn't enough though, we will need a new ioctl to notify
>>>>> the kernel that it's a legacy guest. Ugh:(
>>>> I'm not sure I get this, how can we know if there's a legacy driver before
>>>> set_features()?
>>> qemu knows for sure. It does not communicate this information to the
>>> kernel right now unfortunately.
>> I may miss something, but I still don't get how the new ioctl is supposed to
>> work.
>>
>> Thanks
>
> Basically on first guest access QEMU would tell kernel whether
> guest is using the legacy or the modern interface.
> E.g. virtio_pci_config_read/virtio_pci_config_write will call ioctl(ENABLE_LEGACY, 1)
> while virtio_pci_common_read will call ioctl(ENABLE_LEGACY, 0)


But this trick work only for PCI I think?

Thanks


>
> Or maybe we just add GET_CONFIG_MODERN and GET_CONFIG_LEGACY and
> call the correct ioctl ... there are many ways to build this API.
>

--------------7C104AD64C707C26BB84C149
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021/2/24 3:17 下午, Michael S.
      Tsirkin wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20210224021222-mutt-send-email-mst@kernel.org">
      <pre class="moz-quote-pre" wrap="">On Wed, Feb 24, 2021 at 02:53:08PM +0800, Jason Wang wrote:
</pre>
      <blockquote type="cite" style="color: #007cff;">
        <pre class="moz-quote-pre" wrap="">On 2021/2/24 2:46 下午, Michael S. Tsirkin wrote:
</pre>
        <blockquote type="cite" style="color: #007cff;">
          <pre class="moz-quote-pre" wrap="">On Wed, Feb 24, 2021 at 02:04:36PM +0800, Jason Wang wrote:
</pre>
          <blockquote type="cite" style="color: #007cff;">
            <pre class="moz-quote-pre" wrap="">On 2021/2/24 1:04 下午, Michael S. Tsirkin wrote:
</pre>
            <blockquote type="cite" style="color: #007cff;">
              <pre class="moz-quote-pre" wrap="">On Tue, Feb 23, 2021 at 11:35:57AM -0800, Si-Wei Liu wrote:
</pre>
              <blockquote type="cite" style="color: #007cff;">
                <pre class="moz-quote-pre" wrap="">On 2/23/2021 5:26 AM, Michael S. Tsirkin wrote:
</pre>
                <blockquote type="cite" style="color: #007cff;">
                  <pre class="moz-quote-pre" wrap="">On Tue, Feb 23, 2021 at 10:03:57AM +0800, Jason Wang wrote:
</pre>
                  <blockquote type="cite" style="color: #007cff;">
                    <pre class="moz-quote-pre" wrap="">On 2021/2/23 9:12 上午, Si-Wei Liu wrote:
</pre>
                    <blockquote type="cite" style="color: #007cff;">
                      <pre class="moz-quote-pre" wrap="">On 2/21/2021 11:34 PM, Michael S. Tsirkin wrote:
</pre>
                      <blockquote type="cite" style="color: #007cff;">
                        <pre class="moz-quote-pre" wrap="">On Mon, Feb 22, 2021 at 12:14:17PM +0800, Jason Wang wrote:
</pre>
                        <blockquote type="cite" style="color: #007cff;">
                          <pre class="moz-quote-pre" wrap="">On 2021/2/19 7:54 下午, Si-Wei Liu wrote:
</pre>
                          <blockquote type="cite" style="color:
                            #007cff;">
                            <pre class="moz-quote-pre" wrap="">Commit 452639a64ad8 ("vdpa: make sure set_features is invoked
for legacy") made an exception for legacy guests to reset
features to 0, when config space is accessed before features
are set. We should relieve the verify_min_features() check
and allow features reset to 0 for this case.

It's worth noting that not just legacy guests could access
config space before features are set. For instance, when
feature VIRTIO_NET_F_MTU is advertised some modern driver
will try to access and validate the MTU present in the config
space before virtio features are set.
</pre>
                          </blockquote>
                          <pre class="moz-quote-pre" wrap="">This looks like a spec violation:

"

The following driver-read-only field, mtu only exists if
VIRTIO_NET_F_MTU is
set.
This field specifies the maximum MTU for the driver to use.
"

Do we really want to workaround this?

Thanks
</pre>
                        </blockquote>
                        <pre class="moz-quote-pre" wrap="">And also:

The driver MUST follow this sequence to initialize a device:
1. Reset the device.
2. Set the ACKNOWLEDGE status bit: the guest OS has noticed the device.
3. Set the DRIVER status bit: the guest OS knows how to drive the
device.
4. Read device feature bits, and write the subset of feature bits
understood by the OS and driver to the
device. During this step the driver MAY read (but MUST NOT write)
the device-specific configuration
fields to check that it can support the device before accepting it.
5. Set the FEATURES_OK status bit. The driver MUST NOT accept new
feature bits after this step.
6. Re-read device status to ensure the FEATURES_OK bit is still set:
otherwise, the device does not
support our subset of features and the device is unusable.
7. Perform device-specific setup, including discovery of virtqueues
for the device, optional per-bus setup,
reading and possibly writing the device’s virtio configuration
space, and population of virtqueues.
8. Set the DRIVER_OK status bit. At this point the device is “live”.


so accessing config space before FEATURES_OK is a spec violation, right?
</pre>
                      </blockquote>
                      <pre class="moz-quote-pre" wrap="">It is, but it's not relevant to what this commit tries to address. I
thought the legacy guest still needs to be supported.

Having said, a separate patch has to be posted to fix the guest driver
issue where this discrepancy is introduced to virtnet_validate() (since
commit fe36cbe067). But it's not technically related to this patch.

-Siwei
</pre>
                    </blockquote>
                    <pre class="moz-quote-pre" wrap="">I think it's a bug to read config space in validate, we should move it to
virtnet_probe().

Thanks
</pre>
                  </blockquote>
                  <pre class="moz-quote-pre" wrap="">I take it back, reading but not writing seems to be explicitly allowed by spec.
So our way to detect a legacy guest is bogus, need to think what is
the best way to handle this.
</pre>
                </blockquote>
                <pre class="moz-quote-pre" wrap="">Then maybe revert commit fe36cbe067 and friends, and have QEMU detect legacy
guest? Supposedly only config space write access needs to be guarded before
setting FEATURES_OK.

-Siwie
</pre>
              </blockquote>
              <pre class="moz-quote-pre" wrap="">Detecting it isn't enough though, we will need a new ioctl to notify
the kernel that it's a legacy guest. Ugh <span class="moz-smiley-s2" title=":("><span>:(</span></span>
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">I'm not sure I get this, how can we know if there's a legacy driver before
set_features()?
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">qemu knows for sure. It does not communicate this information to the
kernel right now unfortunately.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
I may miss something, but I still don't get how the new ioctl is supposed to
work.

Thanks
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">

Basically on first guest access QEMU would tell kernel whether
guest is using the legacy or the modern interface.
E.g. virtio_pci_config_read/virtio_pci_config_write will call ioctl(ENABLE_LEGACY, 1)
while virtio_pci_common_read will call ioctl(ENABLE_LEGACY, 0)</pre>
    </blockquote>
    <p><br>
    </p>
    <p>But this trick work only for PCI I think?</p>
    <p>Thanks<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite"
      cite="mid:20210224021222-mutt-send-email-mst@kernel.org">
      <pre class="moz-quote-pre" wrap="">

Or maybe we just add GET_CONFIG_MODERN and GET_CONFIG_LEGACY and
call the correct ioctl ... there are many ways to build this API.

</pre>
    </blockquote>
  </body>
</html>

--------------7C104AD64C707C26BB84C149--


--===============1567021158354033211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1567021158354033211==--

