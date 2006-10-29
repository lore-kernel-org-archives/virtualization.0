From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Re: [PATCH 3/4] Prep for paravirt: desc.h clearer parameter names, some code motion
Date: Sun, 29 Oct 2006 13:06:35 -0800
Message-ID: <200610291306.36148.ak@suse.de>
References: <1161920325.17807.29.camel@localhost.localdomain> <1161920728.17807.39.camel@localhost.localdomain> <1162152071.23311.28.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030269AbWJ2VHM@vger.kernel.org>
In-Reply-To: <1162152071.23311.28.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: virtualization@lists.osdl.org
Cc: Don Mullis <dwm@meer.net>, Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sunday 29 October 2006 12:01, Don Mullis wrote:
> Fix build where CONFIG_CC_OPTIMIZE_FOR_SIZE is not set.
>
> Tested by build and boot.

What error does that fix?

-Andi
