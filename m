Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41551C3DA7A
	for <virtualization@archiver.kernel.org>; Fri,  6 Jan 2023 09:06:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A622541A3B;
	Fri,  6 Jan 2023 09:06:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A622541A3B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=n8vJGgDG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SeleZzhBw0AT; Fri,  6 Jan 2023 09:06:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D2142419C3;
	Fri,  6 Jan 2023 09:06:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D2142419C3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F26DC0035;
	Fri,  6 Jan 2023 09:06:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61ACFC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Jan 2023 09:06:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 259E9419C3
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Jan 2023 09:06:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 259E9419C3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RgahD4gYViIV
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Jan 2023 09:06:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C4AF7419AE
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C4AF7419AE
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Jan 2023 09:06:14 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id co23so699044wrb.4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 06 Jan 2023 01:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kKoaBK8q5W809RS0p+clNzftQXHk/cuqqA0hMS6rYLM=;
 b=n8vJGgDGTwS8p6aCevgRLqT4v9HN9YH3p6o8q1oivYfjkt0TmxEzvWVOM/skRYg4sD
 WQ5+3OPu7Nh6AjqgsnIMf4j8mJOm4sLua4Wad9VIx73YvSpgHz1EDdRDg3yZccq34Mq6
 ixyMkbx1cNgDrJkMXAXcKIWPtr1SFQGrD6TEMxlcvElremJHqc77iMQPHHjGYElP/khL
 s4fdJuZKV5cocAgBQjsSqgeFYAHtJZarJDR49Kp1b0KEb86lH8S1l+f2AGOOPhD1gCuC
 cZ4tYNNMmgAMswsHzTehhux2ZRCgpdCl8L2UOF0pjOSxsm1wTNQX+7XQl2bnvjxNN/Jt
 3Mkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kKoaBK8q5W809RS0p+clNzftQXHk/cuqqA0hMS6rYLM=;
 b=zsvhSpHT9OfonJq/+Fg4oaMGh++SV5X4pSvkqFcbTiOtmlq/OBKqPw++yCc6AwevZM
 cUt5KNs0IzDr4kuBxpCN4EG6JpDF6/uxVvSJUv+EQCHr6SFY0PRCmGsu+V7E/H5gwfBm
 TPMkDuoX8bT6qPTekNXsQcFgi3MUxhkLSoPID2iSfxikO84tOvouYJe32nx758wFnI8V
 12SCdi3wN8iP5knKxhYOFpiQ9wb+tBb0i0bcJFKE6/IAFEjh7LmlKkW9nE2+18B0tDKu
 dIQCMybYZ+o3IJ0GPcMtPZ5Y9XiFw2cNubsknJnDaKmtaALKn4jFQmKycK+2jc6Q9A36
 5ySg==
X-Gm-Message-State: AFqh2kptClwelzxiOQHBjhK3TxFDFErPb1d/Vg1tR48S+cIr6XZz3SYt
 94b6tg1BRp3KbDI3c3LKU7E=
X-Google-Smtp-Source: AMrXdXsFnXnL8N/NpB5p9649686/cvSt6qMANY/q5oaLIUVhTEFqb+CN69FxxCh3rotbyM4FvgyYmQ==
X-Received: by 2002:adf:f20a:0:b0:2ba:bd95:e3af with SMTP id
 p10-20020adff20a000000b002babd95e3afmr738735wro.47.1672995972857; 
 Fri, 06 Jan 2023 01:06:12 -0800 (PST)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 t10-20020a5d534a000000b00272c0767b4asm548470wrv.109.2023.01.06.01.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jan 2023 01:06:12 -0800 (PST)
Date: Fri, 6 Jan 2023 12:06:08 +0300
From: Dan Carpenter <error27@gmail.com>
To: elic@nvidia.com
Subject: [bug report] vdpa/mlx5: Add RX counters to debugfs
Message-ID: <Y7fkgOEYoEWZ1JCc@kili>
MIME-Version: 1.0
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

Hello Eli Cohen,

The patch 7fc5e9ed0777: "vdpa/mlx5: Add RX counters to debugfs" from
Nov 14, 2022, leads to the following Smatch static checker warning:

	drivers/vdpa/mlx5/net/mlx5_vnet.c:1497 mlx5_vdpa_add_mac_vlan_rules()
	error: uninitialized symbol 'rule'.

drivers/vdpa/mlx5/net/mlx5_vnet.c
    1452 static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
    1453                                         struct macvlan_node *node)
    1454 {
    1455         struct mlx5_flow_destination dests[NUM_DESTS] = {};
    1456         struct mlx5_flow_act flow_act = {};
    1457         struct mlx5_flow_handle *rule;
    1458         struct mlx5_flow_spec *spec;
    1459         void *headers_c;
    1460         void *headers_v;
    1461         u8 *dmac_c;
    1462         u8 *dmac_v;
    1463         int err;
    1464         u16 vid;
    1465 
    1466         spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
    1467         if (!spec)
    1468                 return -ENOMEM;
    1469 
    1470         vid = key2vid(node->macvlan);
    1471         spec->match_criteria_enable = MLX5_MATCH_OUTER_HEADERS;
    1472         headers_c = MLX5_ADDR_OF(fte_match_param, spec->match_criteria, outer_headers);
    1473         headers_v = MLX5_ADDR_OF(fte_match_param, spec->match_value, outer_headers);
    1474         dmac_c = MLX5_ADDR_OF(fte_match_param, headers_c, outer_headers.dmac_47_16);
    1475         dmac_v = MLX5_ADDR_OF(fte_match_param, headers_v, outer_headers.dmac_47_16);
    1476         eth_broadcast_addr(dmac_c);
    1477         ether_addr_copy(dmac_v, mac);
    1478         if (ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VLAN)) {
    1479                 MLX5_SET(fte_match_set_lyr_2_4, headers_c, cvlan_tag, 1);
    1480                 MLX5_SET_TO_ONES(fte_match_set_lyr_2_4, headers_c, first_vid);
    1481         }
    1482         if (node->tagged) {
    1483                 MLX5_SET(fte_match_set_lyr_2_4, headers_v, cvlan_tag, 1);
    1484                 MLX5_SET(fte_match_set_lyr_2_4, headers_v, first_vid, vid);
    1485         }
    1486         flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
    1487         dests[0].type = MLX5_FLOW_DESTINATION_TYPE_TIR;
    1488         dests[0].tir_num = ndev->res.tirn;
    1489         err = add_steering_counters(ndev, node, &flow_act, dests);
    1490         if (err)
    1491                 goto out_free;
    1492 
    1493 #if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
    1494         dests[1].counter_id = mlx5_fc_id(node->ucast_counter.counter);
    1495 #endif
    1496         node->ucast_rule = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, dests, NUM_DESTS);
--> 1497         if (IS_ERR(rule)) {

Checking the wrong variable.  It looks like maybe the fix for this
was already posted but only some of the thread made it to lore.kernel.org
so it's impossible to tell for sure.

    1498                 err = PTR_ERR(rule);
    1499                 goto err_ucast;
    1500         }
    1501 
    1502 #if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
    1503         dests[1].counter_id = mlx5_fc_id(node->mcast_counter.counter);
    1504 #endif
    1505 
    1506         memset(dmac_c, 0, ETH_ALEN);
    1507         memset(dmac_v, 0, ETH_ALEN);
    1508         dmac_c[0] = 1;
    1509         dmac_v[0] = 1;
    1510         node->mcast_rule = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, dests, NUM_DESTS);
    1511         if (IS_ERR(rule)) {

Here too.

    1512                 err = PTR_ERR(rule);
    1513                 goto err_mcast;
    1514         }
    1515         kvfree(spec);
    1516         mlx5_vdpa_add_rx_counters(ndev, node);
    1517         return 0;
    1518 
    1519 err_mcast:
    1520         mlx5_del_flow_rules(node->ucast_rule);
    1521 err_ucast:
    1522         remove_steering_counters(ndev, node);
    1523 out_free:
    1524         kvfree(spec);
    1525         return err;
    1526 }

regards,
dan carpenter
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
