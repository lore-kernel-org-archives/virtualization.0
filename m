Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A45152DE4
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Apr 2024 22:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714082506; cv=none; b=usIP0zhi6iU+Yxyg2971DoHZFU9G32PEmxqT31F3FpXjBQuLJXnQmd/UQOBdsbzJDi1EgUfb0ipw1StkNG7dVy6OqZHxgQsoCkbRkANWxIbwqz9MN8NYL/eoJYt+jhrRtZyshpBe0jGM9B8cqZ3goAOlAryQc+k4nHT8R/0eR84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714082506; c=relaxed/simple;
	bh=klttxZkZSgZ3DZsghzDVzBR6b+2+d6rMvLnyNr/Ky6A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KOlvy4opxKusahgpaBS0167IyFo0S2JVdBauDwqHYG7/VBbIvG7+a3lpsxiX2/60bqRtfWtmYe/Vnkj41X510opTY2MQReYL7lKrgWiGRSot7d93wLq/AAADXjRDucbX83lxoQldYDcYQ/xyW/3Os9gm3/RGoknDTwkXRNv+lGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WGn893et; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGn893et"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2B1A5401CA
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Apr 2024 22:01:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0DUrDzXwGInR for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Apr 2024 22:01:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0E5C44010C
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0E5C44010C
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WGn893et
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0E5C44010C
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Apr 2024 22:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714082500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=10EB8JD8eFQ62awPO/uclqEC2RU83uJhAuNpjb8D5/0=;
	b=WGn893etB6xWb7ZZC5ooRtFhrjbPLdD87aA/shJRJ6YAubbOCvMJWxZ0M9synkod/LuexW
	jsgxpc6o2UQWQwJPLyfuyxQDj6t9Y7gZxxWkraxGeX8jv8ToLSFReJmEwEWUkGhGazaXqg
	tKJLcuryX0Vb72C/C2zTrlLHn4duXZ8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-9-JXlTbcPt6b7q0XT1y1nA-1; Thu, 25 Apr 2024 18:01:38 -0400
X-MC-Unique: 9-JXlTbcPt6b7q0XT1y1nA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d87ba1f5e0so12673001fa.2
        for <virtualization@lists.linux-foundation.org>; Thu, 25 Apr 2024 15:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714082496; x=1714687296;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=10EB8JD8eFQ62awPO/uclqEC2RU83uJhAuNpjb8D5/0=;
        b=AoEmAzTJ5r17kUGsVfndm7IXpXZzjx3yKNcGz0Qqs8TFbkwmt3TqhoBrtl+I60rvrF
         WniscbGHPnIhDcYeOGvHKsjwb/LwtvYBcDbpvv19QrgFE+0iEiv1xdLJ8uNk9X3MA0yc
         qjBaV7RWJKBvlaWbLKbHYupPC0MauzrGl9Rs1fFnsHKhii+TyVpKf9YCrtJ7qJ3Ir4kK
         R7b0tRxSIceC52DQ4nllZZOV3tZME1o0VDAhBsAI3vlaZNUpVx1lsNIrI6P3YhBHx/ZF
         1W3VxmpU6WD0jlFHd16gvY48a9yzQl3wKF4qs4x4ZNiv5nqnCleDulhgbbVLfCAMMZtH
         3ExQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpnReruhcRrUtf9nojVRXr78zfHIKUAp/FYVttpT6C84CgRqiHjNFVDA5TAYY0rrpLxHpFhBvcajzDyxzVGIl2PW2i2iDJR9u2aCXUcdwnjhXZd/c5vC5RGA==
X-Gm-Message-State: AOJu0YyznHP6a4vmo+g35gCnHY5hlbtEcZdVTn9SiH1YVhaIFmsnU+wi
	kUGV6U0ZoPoQejq3eJ822THqG5gDesbXTQAW+OwP8kBIgidxb/3dobbsPuHkWJAvmnELFeadOzP
	fTp8YkBpfEVhsMvEXyi6Yr1jk4p/vOuFVh1MhP6u1GmTAouYLqJRp5HOs62XzbUfPX/cH3xkQ6+
	0H8tk=
X-Received: by 2002:a2e:740a:0:b0:2de:48ef:c3e1 with SMTP id p10-20020a2e740a000000b002de48efc3e1mr346930ljc.21.1714082495868;
        Thu, 25 Apr 2024 15:01:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGm8NOZAbGoDAO9gTfyNd8pkjMtJVBD9uka+bmH/x6q4ADf9V1x2L+PuxHiHii3JJvSfxbhQw==
X-Received: by 2002:a2e:740a:0:b0:2de:48ef:c3e1 with SMTP id p10-20020a2e740a000000b002de48efc3e1mr346916ljc.21.1714082495199;
        Thu, 25 Apr 2024 15:01:35 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17d:ffa:7b40:24cf:6484:4af6])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c450d00b00417f700eaeasm28993447wmo.22.2024.04.25.15.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 15:01:33 -0700 (PDT)
Date: Thu, 25 Apr 2024 18:01:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lingshan.zhu@intel.com, mst@redhat.com
Subject: [GIT PULL] virtio: bugfix
Message-ID: <20240425180106-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 0bbac3facb5d6cc0171c45c9873a2dc96bea9680:

  Linux 6.9-rc4 (2024-04-14 13:38:39 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 98a821546b3919a10a58faa12ebe5e9a55cd638e:

  vDPA: code clean for vhost_vdpa uapi (2024-04-22 17:07:13 -0400)

----------------------------------------------------------------
virtio: bugfix

enum renames for vdpa uapi - we better do this now before
the names have been in any releases.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Zhu Lingshan (1):
      vDPA: code clean for vhost_vdpa uapi

 drivers/vdpa/vdpa.c       | 6 +++---
 include/uapi/linux/vdpa.h | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

