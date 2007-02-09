From: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH 2/10] lguest: Export symbols for lguest as a module
Date: Fri, 9 Feb 2007 10:32:44 +0100
Message-ID: <200702091032.44547.ak@muc.de>
References: <1171012296.2718.26.camel@localhost.localdomain> <1171012458.2718.30.camel@localhost.localdomain> <1171012513.2718.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1946266AbXBIKJr@vger.kernel.org>
In-Reply-To: <1171012513.2718.32.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: virtualization@lists.osdl.org
Cc: Rusty Russell <rusty@rustcorp.com.au>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Friday 09 February 2007 10:15, Rusty Russell wrote:

> tsc_khz:
> 	Simplest way of telling the guest how to interpret the TSC
> 	counter.


Are you sure this will work with varying TSC frequencies? 

In general you should get this from cpufreq.

-Andi
