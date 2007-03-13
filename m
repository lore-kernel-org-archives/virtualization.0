From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 2/9] Sched clock paravirt op fix.patch
Date: Tue, 13 Mar 2007 14:05:11 -0700
Message-ID: <45F71207.8050605@goop.org>
References: <200703020254.l222sOaM009656@zach-dev.vmware.com>	<20070313140129.GB92373@muc.de> <45F6C2A3.4040305@goop.org>	<20070313160709.GH10574@sequoia.sous-sol.org>	<20070313161656.GA12128@muc.de> <45F6D361.8080106@redhat.com> <20070313205628.GB46469@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933322AbXCMVFT@vger.kernel.org>
In-Reply-To: <20070313205628.GB46469@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@muc.de>
Cc: Rik van Riel <riel@redhat.com>, Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Daniel Walker <dwalker@mvista.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
> It depends -- under heavy network load you can spend a long time
> just processing interrupts.

Well, in that case you probably don't want to charge them to the process
which happens to be running at the time.

    J
