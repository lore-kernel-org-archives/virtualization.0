Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B761C67871
	for <virtualization@archiver.kernel.org>; Tue, 25 Oct 2022 02:24:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9709A400D6;
	Tue, 25 Oct 2022 02:24:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9709A400D6
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PhLcJbrf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B16eaw5LF2vm; Tue, 25 Oct 2022 02:24:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E21F04000B;
	Tue, 25 Oct 2022 02:24:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E21F04000B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB5F0C0033;
	Tue, 25 Oct 2022 02:24:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 063DEC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Oct 2022 02:24:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C0DFB400D6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Oct 2022 02:24:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C0DFB400D6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Un5QAoBLM7m3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Oct 2022 02:24:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AC2CD4000B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AC2CD4000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Oct 2022 02:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666664660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/U/ac2kD9Eb41W6DVOaULBwmZmjKwBa/RtRrf299IPk=;
 b=PhLcJbrfrf1zauidgEFunOQdgNrghjDhY8MnNV8q7HJ94QTJAji+VMSGXSi3CJ/V77wfHJ
 N7UlYdDM6OKZzxllsbD0JdhiZP/EbjRB79+6Pz1p9Msq4Mb+rDXL7bbYu4uas1SAuviHej
 uHaXR9cMl1sKxCAiNTDgEJkF300SweI=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-48-VBoqEOoGNqaVRiWhymi4mA-1; Mon, 24 Oct 2022 22:24:15 -0400
X-MC-Unique: VBoqEOoGNqaVRiWhymi4mA-1
Received: by mail-oo1-f72.google.com with SMTP id
 i25-20020a4a6f59000000b004758bda2303so5263387oof.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 19:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/U/ac2kD9Eb41W6DVOaULBwmZmjKwBa/RtRrf299IPk=;
 b=IBHw5GTgv33YIe0evLHyIfsaRxQIfrQjr5rkJB9k5atQLOBW/Q3GFeoClWSeVkxm73
 luS2ed0hDd2WlK/M16zQX1j1JpP5ACrGi1eufJVt7fHGo3e/mon/+V9MtDIZMpyVrXD2
 1SdatClZbZ/jf7qmPPyz6iRNieGQFosj5Si8mgiObz8eExJjWdI4j+lZ8lbhgQSE5EQM
 hp81vud/qJnJnOQUQ9jCkvHgGZ1BCqVa7XZXP6CgTxdo3YfaXebAxdMYCABuqlDiIZyh
 j7ujzTEXkXfMj4D+8IbCwlhhOM1q+vh1qnEKaNReIL+HkkzNELf1mEuplGpkaJ/zBprb
 fW+g==
X-Gm-Message-State: ACrzQf0iOcu408HY7LM2WIIZompC/KP9+XMo+k70OXBEEULKABMa2c1B
 bcLuVSzad+wvNkt29qsKvQjNuVKdiV5i/ww8r/i7Ygu2q7zG3JQRM7+C5PyA1TTY7SJVaDzDjBQ
 9o1AZlj+tJoTKbNt0mvf+Gj2/FoxPTSCAze73B+uumt4ld08Nvt6n5HP1Dg==
X-Received: by 2002:a05:6870:eca8:b0:132:df46:5c66 with SMTP id
 eo40-20020a056870eca800b00132df465c66mr22343257oab.280.1666664654269; 
 Mon, 24 Oct 2022 19:24:14 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6cCmauRXGy6HW7Zf5bO2t5LlvJvowxxzC+Sv2zaCixCkE6GW2anEa0gSeXrR9Fm/homFAn4tYos/Q9HA6ij2I=
X-Received: by 2002:a05:6870:eca8:b0:132:df46:5c66 with SMTP id
 eo40-20020a056870eca800b00132df465c66mr22343247oab.280.1666664654045; Mon, 24
 Oct 2022 19:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <1666392237-4042-1-git-send-email-si-wei.liu@oracle.com>
 <1666392237-4042-4-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEti0Z2_sqJbBh_bOVq2ijSUJ96OPS-qd+P4bV490XAA3w@mail.gmail.com>
 <5b9efa3a-8a82-4bd1-a5b4-b9ca5b15b51a@oracle.com>
In-Reply-To: <5b9efa3a-8a82-4bd1-a5b4-b9ca5b15b51a@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 25 Oct 2022 10:24:02 +0800
Message-ID: <CACGkMEsEN+BMJkAk4YRkatTLnW8nmnZM8d_wzSwgPM0nFfh=Kw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] vdpa: show dev config as-is in "vdpa dev show"
 output
To: Si-Wei Liu <si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
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

On Tue, Oct 25, 2022 at 3:14 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
>
>
> On 10/24/2022 1:40 AM, Jason Wang wrote:
> > On Sat, Oct 22, 2022 at 7:49 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
> >> Live migration of vdpa would typically require re-instate vdpa
> >> device with an idential set of configs on the destination node,
> >> same way as how source node created the device in the first
> >> place. In order to save orchestration software from memorizing
> >> and keeping track of vdpa config, it will be helpful if the vdpa
> >> tool provides the aids for exporting the initial configs as-is,
> >> the way how vdpa device was created. The "vdpa dev show" command
> >> seems to be the right vehicle for that. It is unlike the "vdpa dev
> >> config show" command output which usually goes with the live value
> >> in the device config space, and is not quite reliable subject to
> >> the dynamics of feature negotiation or possible change by the
> >> driver to the config space.
> >>
> >> Examples:
> >>
> >> 1) Create vDPA by default without any config attribute
> >>
> >> $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0
> >> $ vdpa dev show vdpa0
> >> vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
> >> $ vdpa dev -jp show vdpa0
> >> {
> >>      "dev": {
> >>          "vdpa0": {
> >>              "type": "network",
> >>              "mgmtdev": "pci/0000:41:04.2",
> >>              "vendor_id": 5555,
> >>              "max_vqs": 9,
> >>              "max_vq_size": 256,
> >>          }
> >>      }
> >> }
> >>
> >> 2) Create vDPA with config attribute(s) specified
> >>
> >> $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0 \
> >>      mac e4:11:c6:d3:45:f0 max_vq_pairs 4
> >> $ vdpa dev show
> >> vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
> >>    initial_config: mac e4:11:c6:d3:45:f0 max_vq_pairs 4
> >> $ vdpa dev -jp show
> >> {
> >>      "dev": {
> >>          "vdpa0": {
> >>              "type": "network",
> >>              "mgmtdev": "pci/0000:41:04.2",
> >>              "vendor_id": 5555,
> >>              "max_vqs": 9,
> >>              "max_vq_size": 256,
> >>              "initial_config": {
> >>                  "mac": "e4:11:c6:d3:45:f0",
> >>                  "max_vq_pairs": 4
> >>              }
> >>          }
> >>      }
> >> }
> >>
> >> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> >> ---
> >>   drivers/vdpa/vdpa.c | 39 +++++++++++++++++++++++++++++++++++++++
> >>   1 file changed, 39 insertions(+)
> >>
> >> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> >> index bebded6..bfb8f54 100644
> >> --- a/drivers/vdpa/vdpa.c
> >> +++ b/drivers/vdpa/vdpa.c
> >> @@ -677,6 +677,41 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct genl_info *i
> >>   }
> >>
> >>   static int
> >> +vdpa_dev_initcfg_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 device_id)
> >> +{
> >> +       struct vdpa_dev_set_config *cfg = &vdev->init_cfg;
> >> +       int err = -EMSGSIZE;
> >> +
> >> +       if (!cfg->mask)
> >> +               return 0;
> >> +
> >> +       switch (device_id) {
> >> +       case VIRTIO_ID_NET:
> >> +               if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR)) != 0 &&
> >> +                   nla_put(msg, VDPA_ATTR_DEV_NET_CFG_MACADDR,
> >> +                           sizeof(cfg->net.mac), cfg->net.mac))
> >> +                       return err;
> >> +               if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) != 0 &&
> >> +                   nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, cfg->net.mtu))
> >> +                       return err;
> >> +               if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) != 0 &&
> >> +                   nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP,
> >> +                               cfg->net.max_vq_pairs))
> >> +                       return err;
> >> +               break;
> >> +       default:
> >> +               break;
> >> +       }
> >> +
> >> +       if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) != 0 &&
> >> +           nla_put_u64_64bit(msg, VDPA_ATTR_DEV_FEATURES,
> >> +                             cfg->device_features, VDPA_ATTR_PAD))
> >> +               return err;
> > A question: If any of those above attributes were not provisioned,
> > should we show the ones that are inherited from the parent?
> A simple answer would be yes, but the long answer is that I am not sure
> if there's any for the moment - there's no  default value for mtu, mac,
> and max_vqp that can be inherited from the parent (max_vqp by default
> being 1 is spec defined, not something inherited from the parent).

Note that it is by default from driver level that if _F_MQ is not
negotiated. But I think we are talking about something different that
is out of the spec here, what if:

vDPA inherit _F_MQ but mqx_vqp is not provisioned via netlink.

Or is it not allowed?  At least some time in the past, mlx5 were
enabled with MQ with 8 queue pairs by default.

> And
> the device_features if inherited is displayed at 'vdpa dev config show'
> output. Can you remind me of a good example for inherited value that we
> may want to show here?

Some other cases:

1) MTU: there should be something that the device needs to report if
_F_MTU is negotiated even if it is not provisioned from netlink.
2) device_features: if device_features is not provisioned, we should
still report it via netlink here or do you mean the mgmt can assume it
should be the same as mgmtdev. Anyhow if we don't show device_features
if it is not provisioned, it will complicate the mgmt software.

Thanks

>
>
> Thanks,
> -Siwei
>
>
> >
> > Thanks
> >
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static int
> >>   vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq,
> >>                int flags, struct netlink_ext_ack *extack)
> >>   {
> >> @@ -715,6 +750,10 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct genl_info *i
> >>          if (nla_put_u16(msg, VDPA_ATTR_DEV_MIN_VQ_SIZE, min_vq_size))
> >>                  goto msg_err;
> >>
> >> +       err = vdpa_dev_initcfg_fill(vdev, msg, device_id);
> >> +       if (err)
> >> +               goto msg_err;
> >> +
> >>          genlmsg_end(msg, hdr);
> >>          return 0;
> >>
> >> --
> >> 1.8.3.1
> >>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
