From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] Fix preemptible lazy mode bug
Date: Thu, 06 Sep 2007 10:57:46 +0100
Message-ID: <46DFCF1A.8090808@goop.org>
References: <46CE70C8.2030005@vmware.com> <1189024666.10802.197.camel@localhost.localdomain> <1189036175.21516.31.camel@bodhitayantram.eng.vmware.com> <200709060641.36855.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757374AbXIFJ6B@vger.kernel.org>
In-Reply-To: <200709060641.36855.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Linus Torvalds <torvalds@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, stable@kernel.org, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
>> I agree.  The patch is a nop.  I just got overly paranoid.  The whole
>> thing is just very prone to bugs.
>>     
> So do we need a patch for .23 or not?
>   

Forgot this bit.  No, I think the upshot is that it isn't necessary (nor
Rusty's).

    J
