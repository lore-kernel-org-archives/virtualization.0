Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C348C433F5
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 04:58:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20D676103C
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 04:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 20D676103C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD42E40250;
	Tue, 26 Oct 2021 04:58:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MrzSCG4gy65h; Tue, 26 Oct 2021 04:58:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C816640169;
	Tue, 26 Oct 2021 04:58:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E948C0019;
	Tue, 26 Oct 2021 04:58:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48791C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:58:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2944F404D4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:58:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KPknoSqYEZpb
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:58:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3BBEE40169
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:58:21 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id i5so9453844pla.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 21:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:message-id:in-reply-to:references:subject
 :mime-version:content-transfer-encoding;
 bh=pl3uN+ZrDQb2baLwFpKdvkwD/7Mgn4MUS1nqpdz6ulc=;
 b=J7alWaTqwg5YaD/MMk9gJ/UGG/pMuMoQeizrJZjG0NbD0VsAICx10xJesO40GKXgBC
 tllWlHfeHs0uXYi4af5kxgCO3EHofNnW/Pv4/gsR7jtWG/2Hqm7I1FUin0pgdn8UF4oc
 0zTuJHR1dQN9R/lOkEF73huLUDfht6nRDHjoo2m9RRZGOfUjGggxvJKw6629XUsiwHi1
 +TBP5W+Vh4lJCkt30JHqgIANydHJFx5IOr5r1XvFSXWYxtc2nS/u4q8lXBYZJuxe399m
 sAzWAWCcvCUUm3t9AqbstDyWtU/YAiw7peNwo26Nm6OpRmIzXR0FFiJojj7rk0JFobmq
 VSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
 :references:subject:mime-version:content-transfer-encoding;
 bh=pl3uN+ZrDQb2baLwFpKdvkwD/7Mgn4MUS1nqpdz6ulc=;
 b=nl+1n3NUcduBDubyv6+491edqqzhqjeCuU14RmWzsJBldNYQgL91fNZZ2wv0wF3sKI
 3dPKZ2i30qk2tyinEgSc3gAuBgWK3cr1aDLoUrRMQMJxeN5ngj1AF9qPmLvSM9vjKYrP
 m3F+vBWjuyvMW+6ltz2rWxyi9wbzKs1g8xKLuayK7QUjEWpP5wvIZwqudSag+5iXA6zr
 DIpjKIKD5A9XNqprTLyOTqY4M/gf2OVw2UjSIktHy9HZmIkZ/x4rYfsS6O7WjP4kkOwR
 x6GqMCts+VBKZkfMDgrP582ri1HJ4ZxmOTpwn8KAR7H02LWIylzDCE91HDTeBFnCYwPK
 sy7w==
X-Gm-Message-State: AOAM531vZv6opjW+jOJ+hQ27hhNg33Z1ayLCinfLPIWxvFraTKaR2ioe
 J/zVnOR3iqDKcXy784ItTbo=
X-Google-Smtp-Source: ABdhPJy6WNlQzJWeStaRdvRz9aQeUKiFUTkqGxK43USed77rb6pvi6O2NG0t+fS7Qvtt97ooEZPkQA==
X-Received: by 2002:a17:902:e88a:b0:13e:ed55:296f with SMTP id
 w10-20020a170902e88a00b0013eed55296fmr20362648plg.11.1635224300732; 
 Mon, 25 Oct 2021 21:58:20 -0700 (PDT)
Received: from DESKTOP-RM5ME1E ([221.221.148.17])
 by smtp.gmail.com with ESMTPSA id j8sm20013193pfe.105.2021.10.25.21.58.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Oct 2021 21:58:20 -0700 (PDT)
Date: Tue, 26 Oct 2021 12:58:17 +0800
From: leohou1402 <leohou1402@gmail.com>
To: =?utf-8?Q?parav=40nvidia.com?= <parav@nvidia.com>
Message-ID: <204B3436-0EFB-4722-9EA1-A43C7A2FEDE5@gmail.com>
In-Reply-To: <20211025125316.67664-8-parav@nvidia.com>
References: <20211025125316.67664-1-parav@nvidia.com>
 <20211025125316.67664-8-parav@nvidia.com>
Subject: =?utf-8?Q?Re:_[PATCH_linux-next_v5_7/8]_vdpa/mlx5:_Support_confi?=
 =?utf-8?Q?guration_of_MAC?=
X-Mailer: MailMasterPC/4.15.6.1016 (Windows 10 20H2)
X-CUSTOM-MAIL-MASTER-SENT-ID: 90C3ECE2-ADB7-4820-AC00-A77001AC2915
MIME-Version: 1.0
Cc: "=?utf-8?Q?elic=40nvidia.com?=" <elic@nvidia.com>,
 "=?utf-8?Q?mst=40redhat.com?=" <mst@redhat.com>,
 "=?utf-8?Q?virtualization=40lists.linux-foundation.org?="
 <virtualization@lists.linux-foundation.org>
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
Content-Type: multipart/mixed; boundary="===============6507685712960322692=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============6507685712960322692==
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCiAgICA8bWV0YSBodHRwLWVxdWl2PSdDb250ZW50LVR5cGUnIGNvbnRl
bnQ9J3RleHQvaHRtbDsgY2hhcnNldD1VVEYtOCc+DQo8L2hlYWQ+DQo8Ym9keT4NCjxzdHlsZT4N
CiAgICBmb250ew0KICAgICAgICBsaW5lLWhlaWdodDogMS42Ow0KICAgIH0NCiAgICB1bCxvbHsN
CiAgICAgICAgcGFkZGluZy1sZWZ0OiAyMHB4Ow0KICAgICAgICBsaXN0LXN0eWxlLXBvc2l0aW9u
OiBpbnNpZGU7DQogICAgfQ0KPC9zdHlsZT4NCjxkaXYgc3R5bGUgPSAnZm9udC1mYW1pbHk65b6u
6L2v6ZuF6buRLFZlcmRhbmEsJnF1b3Q7TWljcm9zb2Z0IFlhaGVpJnF1b3Q7LFNpbVN1bixzYW5z
LXNlcmlmO2ZvbnQtc2l6ZToxNHB4OyBsaW5lLWhlaWdodDoxLjY7Jz4NCiAgICA8ZGl2ID48ZGl2
PgogICAgPGRpdj48ZGl2PldoaWNoIGRldmljZSBkb2VzIG1sWDUgcmVmZXIgdG8gPyBDb25uZWN0
eC00IG9yIENvbm5lY3RYLTUgPzwvZGl2PjxkaXY+SSB3YW50IHRvIHRlc3QgaXQgb3V0LjwvZGl2
PjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhhbmtzLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+T24g
MTAvMjUvMjAyMSAyMDo1NO+8jFBhcmF2IFBhbmRpdCB2aWEgVmlydHVhbGl6YXRpb24mbHQ7dmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcmZ3Q7IHdyb3Rl77yaPC9kaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj4mZ3Q7RnJvbTogRWxpIENvaGVuICZsdDtlbGljQG52aWRpYS5j
b20mZ3Q7PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj4mZ3Q7QWRkIGNvZGUgdG8gYWNjZXB0IE1B
QyBjb25maWd1cmF0aW9uIHRocm91Z2ggdmRwYSB0b29sLiBUaGUgTUFDIGlzPC9kaXY+PGRpdj4m
Z3Q7d3JpdHRlbiBpbnRvIHRoZSBjb25maWcgc3RydWN0IGFuZCBsYXRlciBjYW4gYmUgcmV0cmll
dmVkIHRocm91Z2g8L2Rpdj48ZGl2PiZndDtnZXRfY29uZmlnKCkuPC9kaXY+PGRpdj48YnI+PC9k
aXY+PGRpdj4mZ3Q7RXhhbXBsZXM6PC9kaXY+PGRpdj4mZ3Q7MS4gQ29uZmlndXJlIE1BQyB3aGls
ZSBhZGRpbmcgYSBkZXZpY2U6PC9kaXY+PGRpdj4mZ3Q7JCB2ZHBhIGRldiBhZGQgbWdtdGRldiBw
Y2kvMDAwMDowNjowMC4yIG5hbWUgdmRwYTAgbWFjIDAwOjExOjIyOjMzOjQ0OjU1PC9kaXY+PGRp
dj48YnI+PC9kaXY+PGRpdj4mZ3Q7Mi4gU2hvdyBjb25maWd1cmVkIHBhcmFtczo8L2Rpdj48ZGl2
PiZndDskIHZkcGEgZGV2IGNvbmZpZyBzaG93PC9kaXY+PGRpdj4mZ3Q7dmRwYTA6IG1hYyAwMDox
MToyMjozMzo0NDo1NSBsaW5rIGRvd24gbGlua19hbm5vdW5jZSBmYWxzZSBtYXhfdnFfcGFpcnMg
OCBtdHUgMTUwMDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+Jmd0O1NpZ25lZC1vZmYtYnk6IEVs
aSBDb2hlbiAmbHQ7ZWxpY0BudmlkaWEuY29tJmd0OzwvZGl2PjxkaXY+Jmd0O1Jldmlld2VkLWJ5
OiBQYXJhdiBQYW5kaXQgJmx0O3BhcmF2QG52aWRpYS5jb20mZ3Q7PC9kaXY+PGRpdj4mZ3Q7QWNr
ZWQtYnk6IEphc29uIFdhbmcgJmx0O2phc293YW5nQHJlZGhhdC5jb20mZ3Q7PC9kaXY+PGRpdj4m
Z3Q7LS0tPC9kaXY+PGRpdj4mZ3Q7ZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIHwg
MTcgKysrKysrKysrKy0tLS0tLS08L2Rpdj48ZGl2PiZndDsxIGZpbGUgY2hhbmdlZCwgMTAgaW5z
ZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSk8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PiZndDtk
aWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIGIvZHJpdmVycy92
ZHBhL21seDUvbmV0L21seDVfdm5ldC5jPC9kaXY+PGRpdj4mZ3Q7aW5kZXggOGQxNTM5NzI4YTU5
Li44NjBkODBlZmE1ZDEgMTAwNjQ0PC9kaXY+PGRpdj4mZ3Q7LS0tIGEvZHJpdmVycy92ZHBhL21s
eDUvbmV0L21seDVfdm5ldC5jPC9kaXY+PGRpdj4mZ3Q7KysrIGIvZHJpdmVycy92ZHBhL21seDUv
bmV0L21seDVfdm5ldC5jPC9kaXY+PGRpdj4mZ3Q7QEAgLTYsNiArNiw3IEBAPC9kaXY+PGRpdj4m
Z3Q7I2luY2x1ZGUgJmx0O2xpbnV4L3ZyaW5naC5oJmd0OzwvZGl2PjxkaXY+Jmd0OyNpbmNsdWRl
ICZsdDt1YXBpL2xpbnV4L3ZpcnRpb19uZXQuaCZndDs8L2Rpdj48ZGl2PiZndDsjaW5jbHVkZSAm
bHQ7dWFwaS9saW51eC92aXJ0aW9faWRzLmgmZ3Q7PC9kaXY+PGRpdj4mZ3Q7KyNpbmNsdWRlICZs
dDt1YXBpL2xpbnV4L3ZkcGEuaCZndDs8L2Rpdj48ZGl2PiZndDsjaW5jbHVkZSAmbHQ7bGludXgv
dmlydGlvX2NvbmZpZy5oJmd0OzwvZGl2PjxkaXY+Jmd0OyNpbmNsdWRlICZsdDtsaW51eC9hdXhp
bGlhcnlfYnVzLmgmZ3Q7PC9kaXY+PGRpdj4mZ3Q7I2luY2x1ZGUgJmx0O2xpbnV4L21seDUvY3Eu
aCZndDs8L2Rpdj48ZGl2PiZndDtAQCAtMjUyMywxOCArMjUyNCwxOSBAQCBzdGF0aWMgaW50IG1s
eDVfdmRwYV9kZXZfYWRkKHN0cnVjdCB2ZHBhX21nbXRfZGV2ICp2X21kZXYsIGNvbnN0IGNoYXIg
Km5hbWUsPC9kaXY+PGRpdj4mZ3Q7aWYgKGVycik8L2Rpdj48ZGl2PiZndDtnb3RvIGVycl9tdHU7
PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj4mZ3Q7LSAmbmJzcDtuZGV2LSZndDtjb25maWcubXR1
ID0gY3B1X3RvX21seDV2ZHBhMTYobXZkZXYsIG10dSk7PC9kaXY+PGRpdj4mZ3Q7LSAmbmJzcDtu
ZGV2LSZndDtjb25maWcuc3RhdHVzIHw9IGNwdV90b19tbHg1dmRwYTE2KG12ZGV2LCBWSVJUSU9f
TkVUX1NfTElOS19VUCk7PC9kaXY+PGRpdj4mZ3Q7LTwvZGl2PjxkaXY+Jmd0Oy0gJm5ic3A7ZXJy
ID0gbWx4NV9xdWVyeV9uaWNfdnBvcnRfbWFjX2FkZHJlc3MobWRldiwgMCwgMCwgY29uZmlnLSZn
dDttYWMpOzwvZGl2PjxkaXY+Jmd0Oy0gJm5ic3A7aWYgKGVycik8L2Rpdj48ZGl2PiZndDstICZu
YnNwOyAmbmJzcDtnb3RvIGVycl9tdHU7PC9kaXY+PGRpdj4mZ3Q7LTwvZGl2PjxkaXY+Jmd0O2lm
IChnZXRfbGlua19zdGF0ZShtdmRldikpPC9kaXY+PGRpdj4mZ3Q7bmRldi0mZ3Q7Y29uZmlnLnN0
YXR1cyB8PSBjcHVfdG9fbWx4NXZkcGExNihtdmRldiwgVklSVElPX05FVF9TX0xJTktfVVApOzwv
ZGl2PjxkaXY+Jmd0O2Vsc2U8L2Rpdj48ZGl2PiZndDtuZGV2LSZndDtjb25maWcuc3RhdHVzICZh
bXA7PSBjcHVfdG9fbWx4NXZkcGExNihtdmRldiwgflZJUlRJT19ORVRfU19MSU5LX1VQKTs8L2Rp
dj48ZGl2Pjxicj48L2Rpdj48ZGl2PiZndDsrICZuYnNwO2lmIChhZGRfY29uZmlnLSZndDttYXNr
ICZhbXA7ICgxICZsdDsmbHQ7IFZEUEFfQVRUUl9ERVZfTkVUX0NGR19NQUNBRERSKSkgezwvZGl2
PjxkaXY+Jmd0OysgJm5ic3A7ICZuYnNwO21lbWNweShuZGV2LSZndDtjb25maWcubWFjLCBhZGRf
Y29uZmlnLSZndDtuZXQubWFjLCBFVEhfQUxFTik7PC9kaXY+PGRpdj4mZ3Q7KyAmbmJzcDt9IGVs
c2UgezwvZGl2PjxkaXY+Jmd0OysgJm5ic3A7ICZuYnNwO2VyciA9IG1seDVfcXVlcnlfbmljX3Zw
b3J0X21hY19hZGRyZXNzKG1kZXYsIDAsIDAsIGNvbmZpZy0mZ3Q7bWFjKTs8L2Rpdj48ZGl2PiZn
dDsrICZuYnNwOyAmbmJzcDtpZiAoZXJyKTwvZGl2PjxkaXY+Jmd0OysgJm5ic3A7ICZuYnNwOyAm
bmJzcDtnb3RvIGVycl9tdHU7PC9kaXY+PGRpdj4mZ3Q7KyAmbmJzcDt9PC9kaXY+PGRpdj4mZ3Q7
KzwvZGl2PjxkaXY+Jmd0O2lmICghaXNfemVyb19ldGhlcl9hZGRyKGNvbmZpZy0mZ3Q7bWFjKSkg
ezwvZGl2PjxkaXY+Jmd0O3BmbWRldiA9IHBjaV9nZXRfZHJ2ZGF0YShwY2lfcGh5c2ZuKG1kZXYt
Jmd0O3BkZXYpKTs8L2Rpdj48ZGl2PiZndDtlcnIgPSBtbHg1X21wZnNfYWRkX21hYyhwZm1kZXYs
IGNvbmZpZy0mZ3Q7bWFjKTs8L2Rpdj48ZGl2PiZndDtAQCAtMjYzMiw2ICsyNjM0LDcgQEAgc3Rh
dGljIGludCBtbHg1dl9wcm9iZShzdHJ1Y3QgYXV4aWxpYXJ5X2RldmljZSAqYWRldiw8L2Rpdj48
ZGl2PiZndDttZ3RkZXYtJmd0O21ndGRldi5vcHMgPSAmYW1wO21kZXZfb3BzOzwvZGl2PjxkaXY+
Jmd0O21ndGRldi0mZ3Q7bWd0ZGV2LmRldmljZSA9IG1kZXYtJmd0O2RldmljZTs8L2Rpdj48ZGl2
PiZndDttZ3RkZXYtJmd0O21ndGRldi5pZF90YWJsZSA9IGlkX3RhYmxlOzwvZGl2PjxkaXY+Jmd0
OysgJm5ic3A7bWd0ZGV2LSZndDttZ3RkZXYuY29uZmlnX2F0dHJfbWFzayA9ICgxICZsdDsmbHQ7
IFZEUEFfQVRUUl9ERVZfTkVUX0NGR19NQUNBRERSKTs8L2Rpdj48ZGl2PiZndDttZ3RkZXYtJmd0
O21hZGV2ID0gbWFkZXY7PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj4mZ3Q7ZXJyID0gdmRwYV9t
Z210ZGV2X3JlZ2lzdGVyKCZhbXA7bWd0ZGV2LSZndDttZ3RkZXYpOzwvZGl2PjwvZGl2PjwvZGl2
PjxkaXY+PGRpdj4mZ3Q7LS0mbmJzcDs8L2Rpdj48ZGl2PiZndDsyLjI1LjQ8L2Rpdj48L2Rpdj48
L2Rpdj48IS0t8J+YgC0tPg0KPC9kaXY+DQo8L2JvZHk+DQo8L2h0bWw+


--===============6507685712960322692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6507685712960322692==--
