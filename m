Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DDCC43334
	for <virtualization@archiver.kernel.org>; Mon, 25 Jul 2022 09:55:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0DE3F40597;
	Mon, 25 Jul 2022 09:55:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0DE3F40597
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4mKwIjCb9m3z; Mon, 25 Jul 2022 09:55:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9FAB940407;
	Mon, 25 Jul 2022 09:55:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9FAB940407
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81213C0033;
	Mon, 25 Jul 2022 09:55:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66D3BC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 09:55:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4179040510
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 09:55:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4179040510
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oEMFvZ7R1pyT
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 09:55:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B52F240407
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B52F240407
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 09:55:50 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id BCA1246B; Mon, 25 Jul 2022 11:55:46 +0200 (CEST)
Date: Mon, 25 Jul 2022 11:55:45 +0200
From: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
To: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-sgx@vger.kernel.org
Subject: [CLOSED] Re: [CFP LPC 2022] Confidential Computing Microconference
Message-ID: <Yt5ooTl8w4CFh4U3@8bytes.org>
References: <Yoe4QZr8dqy1hrU1@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yoe4QZr8dqy1hrU1@8bytes.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Andi Kleen <ak@linux.intel.com>,
 David Kaplan <David.Kaplan@amd.com>, Marc Orr <marcorr@google.com>,
 Sean Christopherson <seanjc@google.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Sathya Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>,
 Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@alien8.de>,
 Mike Rapoport <rppt@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 David Rientjes <rientjes@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Gonda <pgonda@google.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi again,

On Fri, May 20, 2022 at 05:48:18PM +0200, J=F6rg R=F6del wrote:
> Please submit your proposals on the LPC website at:
> =

> 	https://lpc.events/event/16/abstracts/

Thanks a lot for the numerous topic submissions! I am very exicted and I
am looking forward to great discussions at this microconference. As of
now we already have more submissions than we can fit in the 3.5 hour
slot. Therefore the CfP for this MC is now closed and further
submissions will not be considered.

If there are still other topics that need discussion please reach out to
me via email, maybe we can organize a BoF around additional topics.

Thanks a lot,

       Joerg
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
