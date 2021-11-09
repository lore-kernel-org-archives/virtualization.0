Return-Path: <SRS0=KS98=P4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16DCC433F5
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 22:06:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69D7D611AF
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 22:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 69D7D611AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3924E81764;
	Tue,  9 Nov 2021 22:06:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sxZA5gF6wFvV; Tue,  9 Nov 2021 22:06:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F3B93814B4;
	Tue,  9 Nov 2021 22:06:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD046C0019;
	Tue,  9 Nov 2021 22:06:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5FA8C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 22:06:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DD68F403C5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 22:06:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9E5L9FOBtnRw
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 22:06:24 +0000 (UTC)
X-Greylist: delayed 20:02:45 by SQLgrey-1.8.0
Received: from smtprelay.hostedemail.com (smtprelay0058.hostedemail.com
 [216.40.44.58])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 105FB403A3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 22:06:23 +0000 (UTC)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave08.hostedemail.com (Postfix) with ESMTP id 48DB6182D4AC4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 21:57:41 +0000 (UTC)
Received: from omf09.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
 by smtprelay07.hostedemail.com (Postfix) with ESMTP id B72C8184C6E43;
 Tue,  9 Nov 2021 21:57:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf09.hostedemail.com (Postfix) with ESMTPA id CE6C81E04D4; 
 Tue,  9 Nov 2021 21:57:32 +0000 (UTC)
Message-ID: <1875b0458294d23d8e3260d2824894b095d6a62d.camel@perches.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: Mark VMware mailing list entries as
 private
From: Joe Perches <joe@perches.com>
To: Nadav Amit <namit@vmware.com>
Date: Tue, 09 Nov 2021 13:57:31 -0800
In-Reply-To: <5C24FB2A-D2C0-4D95-A0C0-B48C4B8D5AF4@vmware.com>
References: <163640336232.62866.489924062999332446.stgit@srivatsa-dev>
 <163640339370.62866.3435211389009241865.stgit@srivatsa-dev>
 <5179a7c097e0bb88f95642a394f53c53e64b66b1.camel@perches.com>
 <cb03ca42-b777-3d1a-5aba-b01cd19efa9a@csail.mit.edu>
 <dcbd19fcd1625146f4db267f84abd7412513d20e.camel@perches.com>
 <5C24FB2A-D2C0-4D95-A0C0-B48C4B8D5AF4@vmware.com>
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: CE6C81E04D4
X-Stat-Signature: xphw7gem3ckanztarthni3x91po8eitn
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18k+m4zQxO7Jw0A5AU3JcKPJ/10qFxleFI=
X-HE-Tag: 1636495052-266614
Cc: Ronak Doshi <doshir@vmware.com>, Pv-drivers <Pv-drivers@vmware.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Alexey Makhalov <amakhalov@vmware.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Vishal Bhakta <vbhakta@vmware.com>, X86 ML <x86@kernel.org>,
 Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
 Keerthana Kalyanasundaram <keerthanak@vmware.com>,
 Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>,
 Anish Swaminathan <anishs@vmware.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Zack Rusin <zackr@vmware.com>
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

On Tue, 2021-11-09 at 00:58 +0000, Nadav Amit wrote:
> > On Nov 8, 2021, at 4:37 PM, Joe Perches <joe@perches.com> wrote:
> > On Mon, 2021-11-08 at 16:22 -0800, Srivatsa S. Bhat wrote:
> > 
> > So it's an exploder not an actual maintainer and it likely isn't
> > publically archived with any normal list mechanism.
> > 
> > So IMO "private" isn't appropriate.  Neither is "L:"
> > Perhaps just mark it as what it is as an "exploder".
> > 
> > Or maybe these blocks should be similar to:
> > 
> > M:	Name of Lead Developer <somebody@vmware.com>
> > M:	VMware <foo> maintainers <linux-<foo>-maintainers@vmlinux.com>

Maybe adding entries like

M:	Named maintainer <whoever@vmware.com>
R:	VMware <foo> reviewers <linux-<foo>-maintainers@vmware.com>

would be best/simplest.


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
