Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3046F241665
	for <virtualization@lists.linux-foundation.org>; Mon, 19 Jan 2026 23:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768864465; cv=none; b=gLkCpvS86B9c2BWAEMY7rmYXvk9ucTkTlHC2dzN8Q4shh5uM/WZ7w/1xZXfJYUNpf4qpzyneyPfHGNWzrHpVhLqTTqABUZdCTXzUiim6GlNLxlf361Mt5n4vloG44VTP9Gf+4vJIWGhYcGTDDMYrFTNG0sjPm49/XUg3EmRieuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768864465; c=relaxed/simple;
	bh=FFAkEBsfT6KPO/yYfYslBTpqchcDyedum4PY4PasL6A=;
	h=From:Date:Subject:Message-ID:To:MIME-Version:Content-Type; b=kP5REtMsg6YHay1L6q4HDQwFac7nOQp/wLPgzuqYNKT6+PK6r7RYgFXebIpb57inDolUXWNGZb5658dEJhqhWjbJ7kbs29MLd15anNn5O0GudN+EIf3S2+qEIzduR/j77IbDvOGIpQyWmBYr4zBy3z73JX6Xt3ft6+ezKtpzEYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ol/UK+Ju; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ol/UK+Ju"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CACC080824
	for <virtualization@lists.linux-foundation.org>; Mon, 19 Jan 2026 23:14:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -6.795
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pi8QRJaMjaNd for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jan 2026 23:14:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B8AD080809
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B8AD080809
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ol/UK+Ju
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B8AD080809
	for <virtualization@lists.linux-foundation.org>; Mon, 19 Jan 2026 23:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768864460;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:resent-to:
	 resent-from:resent-message-id:list-id:list-unsubscribe:list-post;
	bh=wOxG4t/w4AmiaNkB6PBT9lalYG56LZ1zINiCatAbx8g=;
	b=Ol/UK+JuTeqk9Km6iAnaKWXNbanH+AlWKRueXfJjFTXut/4/t3FbYZ9nzZxjf+pyrwGovp
	LamEE1WjqahCGT9j4o0mwI99fiHoQXeXrKlMp9I/OIRLKuCrr0SM6k0fkSbm5IqumZtu6V
	XFiKXIjaTYaHpEx2TILY4By9xQswOBQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-aP5b0q8JO6WyB6FO1rOJVA-1; Mon, 19 Jan 2026 18:14:19 -0500
X-MC-Unique: aP5b0q8JO6WyB6FO1rOJVA-1
X-Mimecast-MFC-AGG-ID: aP5b0q8JO6WyB6FO1rOJVA_1768864458
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4358f1c082eso26499f8f.1
        for <virtualization@lists.linux-foundation.org>; Mon, 19 Jan 2026 15:14:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768864458; x=1769469258;
        h=content-transfer-encoding:feedback-id:mime-version:precedence
         :list-unsubscribe:list-post:list-id:to:reply-to:message-id:subject
         :date:dkim-signature:dkim-signature:delivered-to:delivered-to
         :resent-to:resent-message-id:resent-date:resent-from:from:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wOxG4t/w4AmiaNkB6PBT9lalYG56LZ1zINiCatAbx8g=;
        b=BD8Z8oeUNtTXv5qWg3kjek5MClcE0oZ+owVGI4HV/+G2d1XFMg72J6OKwYcFooxtet
         CbK4hWt0blkaahnWBQwz+tzAbohnSsS/KP0qlffYhxslmENR4MdDmm/8coTDSuLDQAoT
         vEQ5lno1i3wK3rP4Ny4m9MZP4JsL+vFMLIM/bZbqPXGlmXBhcmNypJ/WlciflFZz5V7l
         5e92+1sWHAPkD+XSZH/V/PQO7Qfh1gzkXTk52syhXd7LE2hquSeCRyQLU1nRouoJGoy6
         +FUv5Z5Qk46+lhGwJ7GE3UuUYj8OOgfogGfViFl8dhgx//y8pZsacg/R6cRe2F49ekpr
         5RTA==
X-Gm-Message-State: AOJu0Yz0ump1HVi2qJCrfSpXNUKPkPFVrjbRlJAlHKoHWBJ/P79p3Qek
	+3sasXuyloEb5LPKUqL3SXQFixJpmIvJ3MNC84nNtndJ8QnPV64qgV9bzgb7X7gcSsicZC/oow3
	XzK9wuh+U2ChTta1mj+ZghX5cxuNNjyf4iGbxddYfjH34NNVt8CA2MZAGCg/LZR0nNzxFueREU3
	++8wstb3E0v6eGvNp2zHzBGfDkX9xONOiU/pn6oN1xJO0v6+dfyby0iT/QGa3s
X-Gm-Gg: AY/fxX6eouJYTxy/IzLFTJaxu+IjBjKWTka0Qp8LNeHE/NcwVOSUmTmRK6/A4nx/1JY
	zFMxZjqLNWujaSj5h0YtGJaE2uDzWE0M2fnDMHVgkj7ncUcqW5Ckv0Iapd4lz2AGs0ltZa7xRjZ
	dqUWMORSxYJCDF+PQG9ndO0R5MmMb7AK4OHxmIR6nV5AkK3I0/edCVmXfwieDXitgD2D9UJvcRY
	4VhV3P5DSj2jdPaOJZ2NWxpEtUiMlFbuWvBOUSTrUx64SIjbehSekjpGJgex9MZbt45dDrCql5m
	NOCVKhHnmnLpVDNjiHtfhB4cGdrzFolcDPIyj/LY4N1ofqD4Gm+DUeYeMZicPDVsT0lTyTepCdu
	SL+jv6XZcNdf8Kgk8BzolU7OTfmZM6C4=
X-Received: by 2002:a05:600c:6812:b0:47d:403a:277 with SMTP id 5b1f17b1804b1-4801e5301fcmr184375225e9.4.1768864457886;
        Mon, 19 Jan 2026 15:14:17 -0800 (PST)
X-Received: by 2002:a05:600c:6812:b0:47d:403a:277 with SMTP id 5b1f17b1804b1-4801e5301fcmr184374805e9.4.1768864457037;
        Mon, 19 Jan 2026 15:14:17 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435699271dfsm25090717f8f.15.2026.01.19.15.14.16
        for <virtualization@lists.linux-foundation.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 15:14:16 -0800 (PST)
Sender: Michael Tsirkin <mtsirkin@redhat.com>
From: Kelly Cullinane via OASIS <mst@redhat.com>
X-Google-Original-From: Kelly Cullinane via OASIS <Mail@mail.groups.oasis-open.org>
Resent-From: "Michael S. Tsirkin" <mst@redhat.com>
Resent-Date: Mon, 19 Jan 2026 18:14:14 -0500
Resent-Message-ID: <aW66xoA-HpUNFEal@redhat.com>
Resent-To: virtualization@lists.linux-foundation.org
Received: from imap.gmail.com [142.250.110.109]
	by tuck.redhat.com with IMAP (fetchmail-6.5.7 polling redhat account mtsirkin@redhat.com folder INBOX)
	for <mst@localhost> (single-drop); Thu, 15 Jan 2026 01:32:31 -0500 (EST)
Received: by 2002:a05:7108:8e83:b0:50b:8ab7:6e4 with SMTP id qv3csp505688gdb;
 Wed, 14 Jan 2026 12:29:43 -0800 (PST)
X-Forwarded-Encrypted: i=3;
 AJvYcCUPOYz4wuAMdixwIOz5bzLrti4Q+dC/aaPimhHhzQHrJAFViblU1X1BEsPCsZStchOdhBAHBqzB8Q==@gapps.redhat.com
X-Received: by 2002:a05:6214:5186:b0:890:6331:7e7e with SMTP id
 6a1803df08f44-8927445cefamr54450006d6.60.1768422583206; Wed, 14 Jan 2026
 12:29:43 -0800 (PST)
Received: from us-smtp-inbound-delivery-1.mimecast.com
 (us-smtp-inbound-delivery-1.mimecast.com. [170.10.132.61]) by mx.google.com
 with ESMTPS id 6a1803df08f44-89080dbfb42si242793616d6.797.2026.01.14.12.29.43
 for <mtsirkin@gapps.redhat.com> (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384
 bits=256/256); Wed, 14 Jan 2026 12:29:43 -0800 (PST)
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-suea_NRlOjGvwxbhB0UayQ-1; Wed,
 14 Jan 2026 15:29:41 -0500
X-MC-Unique: suea_NRlOjGvwxbhB0UayQ-1
X-Mimecast-MFC-AGG-ID: suea_NRlOjGvwxbhB0UayQ_1768422580
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4]) (using
 TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits) key-exchange X25519
 server-signature RSA-PSS (2048 bits) server-digest SHA256) (No client
 certificate requested) by
 mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id
 AED8119560A1 for <mtsirkin@gapps.redhat.com>; Wed, 14 Jan 2026 20:29:40 +0000
 (UTC)
Received: by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix)
 id A8E0730002E2; Wed, 14 Jan 2026 20:29:40 +0000 (UTC)
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.58]) by
 mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A46D630002DD for <mst@redhat.com>; Wed, 14 Jan 2026 20:29:40 +0000 (UTC)
Received: from us-smtp-inbound-delivery-1.mimecast.com
 (us-smtp-delivery-1.mimecast.com [170.10.132.61]) (using TLSv1.3 with cipher
 TLS_AES_256_GCM_SHA384 (256/256 bits) key-exchange X25519 server-signature
 RSA-PSS (2048 bits) server-digest SHA256) (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 14FFC195606D for <mst@redhat.com>; Wed, 14 Jan 2026 20:29:40 +0000 (UTC)
Received: from a14-221.smtp-out.amazonses.com (a14-221.smtp-out.amazonses.com
 [54.240.14.221]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-f3nKiQzbM52KnKEEhpo_UQ-1; Wed, 14 Jan 2026 15:29:37 -0500
X-MC-Unique: f3nKiQzbM52KnKEEhpo_UQ-1
X-Mimecast-MFC-AGG-ID: f3nKiQzbM52KnKEEhpo_UQ_1768422577
Date: Wed, 14 Jan 2026 20:29:37 +0000
Subject: OASIS Virtual I/O Device (VIRTIO) TC: Invitation to comment on VIRTIO
 v1.4 CSD01
Message-ID: <0100019bbe3313bb-ddb934e7-eba9-43ed-9b59-8681a39b0430-000000@email.amazonses.com>
Reply-To: OASIS-virtio@ConnectedCommunity.org
To: virtualization@lists.linux-foundation.org
List-Post: <mailto:OASIS-virtio@ConnectedCommunity.org>
Precedence: List
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Feedback-ID: ::1.us-east-1.z75T2yZh3ifc8ZNLWkBZyPTlwaSJkUhlzy8i/XAYy2A=:AmazonSES
X-SES-Outgoing: 2026.01.14-54.240.14.221
X-Mimecast-MFC-PROC-ID: J783dJ2zWsKnqATCf1KGiwBVG8agFVVP6RAoNx8xr10_1768422577
X-Mimecast-Impersonation-Protect: Policy=DMARC Check - CHG0118091;Similar
 Internal Domain=false;Similar Monitored External Domain=false;Custom External
 Domain=false;Mimecast External Domain=false;Newly Observed
 Domain=false;Internal User Name=false;Custom Display Name List=false;Reply-to
 Address Mismatch=false;Targeted Threat Dictionary=false;Mimecast Threat
 Dictionary=false;Custom Threat Dictionary=false
X-Mimecast-Impersonation-Protect: Policy=CLT - Impersonation Protection
 Definition;Similar Internal Domain=false;Similar Monitored External
 Domain=false;Custom External Domain=false;Mimecast External
 Domain=false;Newly Observed Domain=false;Internal User Name=false;Custom
 Display Name List=false;Reply-to Address Mismatch=false;Targeted Threat
 Dictionary=false;Mimecast Threat Dictionary=false;Custom Threat
 Dictionary=false
X-Mimecast-Bulk-Signature: yes
X-Mimecast-Spam-Signature: bulk
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Pl-2CYIzFbyzvkS0MN2Xfat-mcaXZACTKIzC6y0QZRA_1768864458
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

OASIS members and other interested parties,=20


OASIS and the VIRTIO TC are pleased to announce that VIRTIO v1.4 CSD01 is n=
ow available for public review and comment.=20


VIRTIO TC aims to enhance the performance of virtual devices by standardizi=
ng key features of the VIRTIO (Virtual I/O) Device Specification.


Virtual I/O Device (VIRTIO) Version 1.4
Committee Specification Draft 01 / Public Review Draft 01
09 December 2025


TEX: https://docs.oasis-open.org/virtio/virtio/v1.4/csprd01/virtio-v1.4-csp=
rd01.html <https://docs.oasis-open.org/virtio/virtio/v1.4/csprd01/virtio-v1=
.4-csprd01.html> (Authoritative)
HTML: https://docs.oasis-open.org/virtio/virtio/v1.4/csprd01/virtio-v1.4-cs=
prd01.html <https://docs.oasis-open.org/virtio/virtio/v1.4/csprd01/virtio-v=
1.4-csprd01.html>
PDF: https://docs.oasis-open.org/virtio/virtio/v1.4/csprd01/virtio-v1.4-csp=
rd01.pdf <https://docs.oasis-open.org/virtio/virtio/v1.4/csprd01/virtio-v1.=
4-csprd01.pdf>


The ZIP containing the complete files of this release is found in the direc=
tory:
https://docs.oasis-open.org/virtio/virtio/v1.4/csprd01/virtio-v1.4-csprd01.=
zip <https://docs.oasis-open.org/virtio/virtio/v1.4/csprd01/virtio-v1.4-csp=
rd01.zip>


How to Provide Feedback


OASIS and the VIRTIO TC value your feedback. We solicit input from develope=
rs, users and=20
others, whether OASIS members or not, for the sake of improving the interop=
erability and quality of its technical work.


The public review is now open and ends Friday, February 13 2026 at 23:59 UT=
C.


Comments may be submitted to the project's comment mailing list at virtio-c=
omment@lists.linux.dev <virtio-comment@lists.linux.dev>. You can subscribe =
to the list by sending an email to
virtio-comment+subscribe@lists.linux.dev <virtio-comment%2Bsubscribe@lists.=
linux.dev>.


All comments submitted to OASIS are subject to the OASIS Feedback License, =
which ensures that the feedback you provide carries the same obligations at=
 least as the obligations of the TC members. In connection with this public=
 review, we call your attention to the OASIS IPR Policy <https://www.oasis-=
open.org/policies-guidelines/ipr/> applicable especially to the work of thi=
s technical committee. All members of the TC should be familiar with this d=
ocument, which may create obligations regarding the disclosure and availabi=
lity of a member's patent, copyright, trademark and license rights that rea=
d on an approved OASIS specification.=20


OASIS invites any persons who know of any such claims to disclose these if =
they may be essential to the implementation of the above specification, so =
that notice of them may be posted to the notice page for this TC's work.


Additional information about the specification and the VIRTIO TC can be fou=
nd at the TC's public home page located here. <https://groups.oasis-open.or=
g/communities/tc-community-home2?CommunityKey=3Db3f5efa5-0e12-4320-873b-018=
dc7d3f25c>





Reply to Sender : https://groups.oasis-open.org/eGroups/PostReply/?GroupId=
=3D2767&MID=3D532030&SenderKey=3D99902440-f52b-43a8-aac3-018dcade3dca

Reply to Discussion : https://groups.oasis-open.org/eGroups/PostReply/?Grou=
pId=3D2767&MID=3D532030



You are subscribed to "OASIS Virtual I/O Device (VIRTIO) TC" as mst@redhat.=
com. To change your subscriptions, go to http://oasis.connectedcommunity.or=
g/preferences?section=3DSubscriptions.  To unsubscribe from this community =
discussion, go to https://oasis.connectedcommunity.org/HigherLogic/eGroups/=
Unsubscribe.aspx?UserKey=3Da2b58e24-6eaa-4c47-a934-018dc916b912&sKey=3Df799=
44d37a6b429084d2&GroupKey=3Dc337f117-a176-45c6-96cb-018dce2b6955.

