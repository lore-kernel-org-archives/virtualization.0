From: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH 3/4] x86 paravirt_ops: implementation of paravirt_ops
Date: Mon, 7 Aug 2006 07:39:33 +0200
Message-ID: <200608070739.33428.ak@muc.de>
References: <1154925835.21647.29.camel@localhost.localdomain> <1154925943.21647.32.camel@localhost.localdomain> <1154926048.21647.35.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751086AbWHGFkv@vger.kernel.org>
In-Reply-To: <1154926048.21647.35.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: virtualization@lists.osdl.org
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Monday 07 August 2006 06:47, Rusty Russell wrote:
> This patch does the dumbest possible replacement of paravirtualized
> instructions: calls through a "paravirt_ops" structure.  Currently
> these are function implementations of native hardware: hypervisors
> will override the ops structure with their own variants.

You should call it HAL - that would make it clearer what it is.

I think I would prefer to patch always. Is there a particular
reason you can't do that?

-Andi
