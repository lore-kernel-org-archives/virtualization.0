Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E7BC7618E
	for <virtualization@archiver.kernel.org>; Tue, 14 Mar 2023 17:26:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 45131403AC;
	Tue, 14 Mar 2023 17:26:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 45131403AC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VgO2HU30
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wAQI61M27crQ; Tue, 14 Mar 2023 17:26:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2746E4011D;
	Tue, 14 Mar 2023 17:26:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2746E4011D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEDC9C0035;
	Tue, 14 Mar 2023 17:26:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ADFA6C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 17:26:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8EE3E4011D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 17:26:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8EE3E4011D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fSboLhYsyXoa
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 17:26:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5F2E240227
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5F2E240227
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 17:26:37 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id A14DDB81AA0;
 Tue, 14 Mar 2023 17:26:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F12C4339B;
 Tue, 14 Mar 2023 17:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1678814793;
 bh=/AjYsdeKz3/ZT6yxEbbyk1Cv8mFWK+qWnAMphe/pZsA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VgO2HU30/PeyB1p0xRf6TUVkypNHkbxLPi24EJV+zXqlSYmYZu3gGBnmCi7Z2qmP+
 uKNkIarlRm2bP5wa90KpPzCz8gQWGUgAJr5jmkDFVp+VPD8Z2V9gPUYGfSrhfJYPBC
 zXFVXvJZ5kLUkvU0xGiR5QW+31s0VG2vBlbLXliq8iW0WDIjiv507hDGnxbMLRzZQ6
 ewwKSF1YC08tawdWFTv0jPttiYRM+bqy434YTsgOM7e2Tcp4uQwc75BCVWHZ/geZJe
 oUtozSVv1Jo0wX4Wg48U6xRFgqCLVy7y4x5KRr5tzvrk17uWUcSNbTbY0opMQhftBu
 52Vk0fl6+iZNg==
Date: Tue, 14 Mar 2023 13:26:32 -0400
From: Sasha Levin <sashal@kernel.org>
To: Nico Boehr <nrb@linux.ibm.com>
Subject: Re: [PATCH AUTOSEL 6.2 05/16] s390/virtio: sort out physical vs
 virtual pointers usage
Message-ID: <ZBCuSCIRrtdQQTeM@sashalap>
References: <20230305135207.1793266-1-sashal@kernel.org>
 <20230305135207.1793266-5-sashal@kernel.org>
 <167809840006.10483.605220541481258700@t14-nrb.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <167809840006.10483.605220541481258700@t14-nrb.local>
Cc: linux-s390@vger.kernel.org, farman@linux.ibm.com,
 Janosch Frank <frankja@linux.ibm.com>, gor@linux.ibm.com, hca@linux.ibm.com,
 cohuck@redhat.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, pasic@linux.ibm.com,
 kvm@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Mar 06, 2023 at 11:26:40AM +0100, Nico Boehr wrote:
>Hi Sasha, s390 maintainers,
>
>Quoting Sasha Levin (2023-03-05 14:51:56)
>> From: Alexander Gordeev <agordeev@linux.ibm.com>
>>
>> [ Upstream commit 5fc5b94a273655128159186c87662105db8afeb5 ]
>>
>> This does not fix a real bug, since virtual addresses
>> are currently indentical to physical ones.
>
>not sure if it is appropriate to pick for stable, since it does not fix a bug currently.
>
>Alexander, Janosch, your opinion?

I'll drop it, thanks!

-- 
Thanks,
Sasha
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
