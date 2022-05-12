Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707ECC433F5
	for <virtualization@archiver.kernel.org>; Thu, 12 May 2022 04:14:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E803160C09;
	Thu, 12 May 2022 04:14:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tIe9kCh14Dql; Thu, 12 May 2022 04:14:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6885060C0B;
	Thu, 12 May 2022 04:14:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27BCAC0039;
	Thu, 12 May 2022 04:14:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A48FC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 04:14:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 332F48145D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 04:14:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sY5SwgZfCAue
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 04:14:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 36E79813CA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 04:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652328864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9w/GpJ1N6HGwjmzwJoNwiCf/tw4KuMbHGSJSHCRSnro=;
 b=H2AKj9LG6KpYb+zNgxBTQEqwYIkc36dqyN01MTyLLRX8IHvFCd/iLy56xkCrAXXb88RWMP
 OPHJrNwZXDHTvVKVUAlLr8YwQMuNpa0dzZMZIdXzPuIBVEY/ucdJMaGH5YdlyV62AMnNAJ
 iMIGZdf9036ozX+qgLFDN0K84+h+fPY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-154-sbZhJ74DP-ay0rt_J6fLoA-1; Thu, 12 May 2022 00:14:20 -0400
X-MC-Unique: sbZhJ74DP-ay0rt_J6fLoA-1
Received: by mail-lj1-f200.google.com with SMTP id
 l26-20020a2e99da000000b0024f02d881cdso1199462ljj.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 21:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9w/GpJ1N6HGwjmzwJoNwiCf/tw4KuMbHGSJSHCRSnro=;
 b=tPR+omOTmeChFXFLdw1HkwM5+uMZLyU+8vxovFFiU9xy3oiflAqvYu5ItY4GDAXPHW
 E0LPS2r2UGDz3Yj2JQNiPXjvcLSBYNjBn1OL3z93HwdcR9JmIrw3T3usdHAFTvQjM1rN
 ThbWGK0didt815LdpZshdxgUpUh3+kSsHcN+bgZCf+RtO81HZ7g/TX5zIcbID8GLy2s+
 idP0ub6ywDmYy9QfBLg1frOM/mgMCsv6o6hdf4VULnVkwZ6t9coX/2PYmqAimTUP/tIO
 zAEEBxZjS0/9qzLFj3WV9sBFcQcCBWyUTRd5iMwSVIjt/1s4SBJNWz68UUkn0sZgsxSg
 QDXA==
X-Gm-Message-State: AOAM532U5m2ep/mvWZazvZa4lBbgxw1FqrUpG7gzgslrpcWDgwjcUP4J
 rjvgh6bmv/Ys4ygzh0x47gSG8Xg34BG+YVdQXyg70m5X8nSez/I0YNP5+exLw3hw9nXknyiwgZd
 ZMuOVLOeCPnbaFMbmpR2PB58M+b+K7SVE3AaG/eR+JS4sgcKOiLLV3pXppQ==
X-Received: by 2002:a05:6512:33d0:b0:473:a25e:f9fb with SMTP id
 d16-20020a05651233d000b00473a25ef9fbmr22664782lfg.98.1652328858632; 
 Wed, 11 May 2022 21:14:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMXxPJuzrxrW7rPQgvHxEyCXWglbIUuK3FJKZJOgp1haPDdHY13ozgrgj11nAGFj+mUN+TUiUyhdoWwaiIlSs=
X-Received: by 2002:a05:6512:33d0:b0:473:a25e:f9fb with SMTP id
 d16-20020a05651233d000b00473a25ef9fbmr22664768lfg.98.1652328858375; Wed, 11
 May 2022 21:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220511125845.1332586-1-elic@nvidia.com>
In-Reply-To: <20220511125845.1332586-1-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 May 2022 12:14:07 +0800
Message-ID: <CACGkMEtGvGM7JzP+xHZyxyOFL+wzLPa6-XgfOvM=1ZEf1NqKUg@mail.gmail.com>
Subject: Re: [PATCH] net/vdpa: Use reader/writers semaphore instead of mutex
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Si-Wei Liu <si-wei.liu@oracle.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, mst <mst@redhat.com>
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

On Wed, May 11, 2022 at 8:58 PM Eli Cohen <elic@nvidia.com> wrote:
>
> Use rw_semaphore instead of mutex to control access to vdpa devices.
> This can be especially beneficial in case process poll on statistics
> information.
>
> Suggested-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/vdpa.c | 64 ++++++++++++++++++++++-----------------------
>  1 file changed, 32 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 0fb4a615f267..ced634f94f76 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -18,7 +18,7 @@
>
>  static LIST_HEAD(mdev_head);
>  /* A global mutex that protects vdpa management device and device level operations. */
> -static DEFINE_MUTEX(vdpa_dev_mutex);
> +static DECLARE_RWSEM(vdpa_dev_lock);
>  static DEFINE_IDA(vdpa_index_ida);
>
>  void vdpa_set_status(struct vdpa_device *vdev, u8 status)
> @@ -238,7 +238,7 @@ static int __vdpa_register_device(struct vdpa_device *vdev, u32 nvqs)
>
>         vdev->nvqs = nvqs;
>
> -       lockdep_assert_held(&vdpa_dev_mutex);
> +       lockdep_assert_held(&vdpa_dev_lock);
>         dev = bus_find_device(&vdpa_bus, NULL, dev_name(&vdev->dev), vdpa_name_match);
>         if (dev) {
>                 put_device(dev);
> @@ -278,9 +278,9 @@ int vdpa_register_device(struct vdpa_device *vdev, u32 nvqs)
>  {
>         int err;
>
> -       mutex_lock(&vdpa_dev_mutex);
> +       down_write(&vdpa_dev_lock);
>         err = __vdpa_register_device(vdev, nvqs);
> -       mutex_unlock(&vdpa_dev_mutex);
> +       up_write(&vdpa_dev_lock);
>         return err;
>  }
>  EXPORT_SYMBOL_GPL(vdpa_register_device);
> @@ -293,7 +293,7 @@ EXPORT_SYMBOL_GPL(vdpa_register_device);
>   */
>  void _vdpa_unregister_device(struct vdpa_device *vdev)
>  {
> -       lockdep_assert_held(&vdpa_dev_mutex);
> +       lockdep_assert_held(&vdpa_dev_lock);
>         WARN_ON(!vdev->mdev);
>         device_unregister(&vdev->dev);
>  }
> @@ -305,9 +305,9 @@ EXPORT_SYMBOL_GPL(_vdpa_unregister_device);
>   */
>  void vdpa_unregister_device(struct vdpa_device *vdev)
>  {
> -       mutex_lock(&vdpa_dev_mutex);
> +       down_write(&vdpa_dev_lock);
>         device_unregister(&vdev->dev);
> -       mutex_unlock(&vdpa_dev_mutex);
> +       up_write(&vdpa_dev_lock);
>  }
>  EXPORT_SYMBOL_GPL(vdpa_unregister_device);
>
> @@ -352,9 +352,9 @@ int vdpa_mgmtdev_register(struct vdpa_mgmt_dev *mdev)
>                 return -EINVAL;
>
>         INIT_LIST_HEAD(&mdev->list);
> -       mutex_lock(&vdpa_dev_mutex);
> +       down_write(&vdpa_dev_lock);
>         list_add_tail(&mdev->list, &mdev_head);
> -       mutex_unlock(&vdpa_dev_mutex);
> +       up_write(&vdpa_dev_lock);
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(vdpa_mgmtdev_register);
> @@ -371,14 +371,14 @@ static int vdpa_match_remove(struct device *dev, void *data)
>
>  void vdpa_mgmtdev_unregister(struct vdpa_mgmt_dev *mdev)
>  {
> -       mutex_lock(&vdpa_dev_mutex);
> +       down_write(&vdpa_dev_lock);
>
>         list_del(&mdev->list);
>
>         /* Filter out all the entries belong to this management device and delete it. */
>         bus_for_each_dev(&vdpa_bus, NULL, mdev, vdpa_match_remove);
>
> -       mutex_unlock(&vdpa_dev_mutex);
> +       up_write(&vdpa_dev_lock);
>  }
>  EXPORT_SYMBOL_GPL(vdpa_mgmtdev_unregister);
>
> @@ -532,17 +532,17 @@ static int vdpa_nl_cmd_mgmtdev_get_doit(struct sk_buff *skb, struct genl_info *i
>         if (!msg)
>                 return -ENOMEM;
>
> -       mutex_lock(&vdpa_dev_mutex);
> +       down_read(&vdpa_dev_lock);
>         mdev = vdpa_mgmtdev_get_from_attr(info->attrs);
>         if (IS_ERR(mdev)) {
> -               mutex_unlock(&vdpa_dev_mutex);
> +               up_read(&vdpa_dev_lock);
>                 NL_SET_ERR_MSG_MOD(info->extack, "Fail to find the specified mgmt device");
>                 err = PTR_ERR(mdev);
>                 goto out;
>         }
>
>         err = vdpa_mgmtdev_fill(mdev, msg, info->snd_portid, info->snd_seq, 0);
> -       mutex_unlock(&vdpa_dev_mutex);
> +       up_read(&vdpa_dev_lock);
>         if (err)
>                 goto out;
>         err = genlmsg_reply(msg, info);
> @@ -561,7 +561,7 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
>         int idx = 0;
>         int err;
>
> -       mutex_lock(&vdpa_dev_mutex);
> +       down_read(&vdpa_dev_lock);
>         list_for_each_entry(mdev, &mdev_head, list) {
>                 if (idx < start) {
>                         idx++;
> @@ -574,7 +574,7 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
>                 idx++;
>         }
>  out:
> -       mutex_unlock(&vdpa_dev_mutex);
> +       up_read(&vdpa_dev_lock);
>         cb->args[0] = idx;
>         return msg->len;
>  }
> @@ -630,7 +630,7 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
>             !netlink_capable(skb, CAP_NET_ADMIN))
>                 return -EPERM;
>
> -       mutex_lock(&vdpa_dev_mutex);
> +       down_write(&vdpa_dev_lock);
>         mdev = vdpa_mgmtdev_get_from_attr(info->attrs);
>         if (IS_ERR(mdev)) {
>                 NL_SET_ERR_MSG_MOD(info->extack, "Fail to find the specified management device");
> @@ -650,7 +650,7 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
>
>         err = mdev->ops->dev_add(mdev, name, &config);
>  err:
> -       mutex_unlock(&vdpa_dev_mutex);
> +       up_write(&vdpa_dev_lock);
>         return err;
>  }
>
> @@ -666,7 +666,7 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct genl_info *i
>                 return -EINVAL;
>         name = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
>
> -       mutex_lock(&vdpa_dev_mutex);
> +       down_write(&vdpa_dev_lock);
>         dev = bus_find_device(&vdpa_bus, NULL, name, vdpa_name_match);
>         if (!dev) {
>                 NL_SET_ERR_MSG_MOD(info->extack, "device not found");
> @@ -684,7 +684,7 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct genl_info *i
>  mdev_err:
>         put_device(dev);
>  dev_err:
> -       mutex_unlock(&vdpa_dev_mutex);
> +       up_write(&vdpa_dev_lock);
>         return err;
>  }
>
> @@ -750,7 +750,7 @@ static int vdpa_nl_cmd_dev_get_doit(struct sk_buff *skb, struct genl_info *info)
>         if (!msg)
>                 return -ENOMEM;
>
> -       mutex_lock(&vdpa_dev_mutex);
> +       down_read(&vdpa_dev_lock);
>         dev = bus_find_device(&vdpa_bus, NULL, devname, vdpa_name_match);
>         if (!dev) {
>                 NL_SET_ERR_MSG_MOD(info->extack, "device not found");
> @@ -768,13 +768,13 @@ static int vdpa_nl_cmd_dev_get_doit(struct sk_buff *skb, struct genl_info *info)
>
>         err = genlmsg_reply(msg, info);
>         put_device(dev);
> -       mutex_unlock(&vdpa_dev_mutex);
> +       up_read(&vdpa_dev_lock);
>         return err;
>
>  mdev_err:
>         put_device(dev);
>  err:
> -       mutex_unlock(&vdpa_dev_mutex);
> +       up_read(&vdpa_dev_lock);
>         nlmsg_free(msg);
>         return err;
>  }
> @@ -816,9 +816,9 @@ static int vdpa_nl_cmd_dev_get_dumpit(struct sk_buff *msg, struct netlink_callba
>         info.start_idx = cb->args[0];
>         info.idx = 0;
>
> -       mutex_lock(&vdpa_dev_mutex);
> +       down_read(&vdpa_dev_lock);
>         bus_for_each_dev(&vdpa_bus, NULL, &info, vdpa_dev_dump);
> -       mutex_unlock(&vdpa_dev_mutex);
> +       up_read(&vdpa_dev_lock);
>         cb->args[0] = info.idx;
>         return msg->len;
>  }
> @@ -1016,7 +1016,7 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info
>         if (!msg)
>                 return -ENOMEM;
>
> -       mutex_lock(&vdpa_dev_mutex);
> +       down_read(&vdpa_dev_lock);
>         dev = bus_find_device(&vdpa_bus, NULL, devname, vdpa_name_match);
>         if (!dev) {
>                 NL_SET_ERR_MSG_MOD(info->extack, "device not found");
> @@ -1037,7 +1037,7 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info
>  mdev_err:
>         put_device(dev);
>  dev_err:
> -       mutex_unlock(&vdpa_dev_mutex);
> +       up_read(&vdpa_dev_lock);
>         if (err)
>                 nlmsg_free(msg);
>         return err;
> @@ -1075,9 +1075,9 @@ vdpa_nl_cmd_dev_config_get_dumpit(struct sk_buff *msg, struct netlink_callback *
>         info.start_idx = cb->args[0];
>         info.idx = 0;
>
> -       mutex_lock(&vdpa_dev_mutex);
> +       down_read(&vdpa_dev_lock);
>         bus_for_each_dev(&vdpa_bus, NULL, &info, vdpa_dev_config_dump);
> -       mutex_unlock(&vdpa_dev_mutex);
> +       up_read(&vdpa_dev_lock);
>         cb->args[0] = info.idx;
>         return msg->len;
>  }
> @@ -1104,7 +1104,7 @@ static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
>                 return -ENOMEM;
>
>         index = nla_get_u32(info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX]);
> -       mutex_lock(&vdpa_dev_mutex);
> +       down_read(&vdpa_dev_lock);
>         dev = bus_find_device(&vdpa_bus, NULL, devname, vdpa_name_match);
>         if (!dev) {
>                 NL_SET_ERR_MSG_MOD(info->extack, "device not found");
> @@ -1124,7 +1124,7 @@ static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
>         err = genlmsg_reply(msg, info);
>
>         put_device(dev);
> -       mutex_unlock(&vdpa_dev_mutex);
> +       up_read(&vdpa_dev_lock);
>
>         return err;
>
> @@ -1132,7 +1132,7 @@ static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
>         put_device(dev);
>  dev_err:
>         nlmsg_free(msg);
> -       mutex_unlock(&vdpa_dev_mutex);
> +       up_read(&vdpa_dev_lock);
>         return err;
>  }
>
> --
> 2.35.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
