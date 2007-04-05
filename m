From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [patch 07/20] Allow paravirt backend to choose kernel PMD sharing
Date: Wed, 4 Apr 2007 18:29:56 -0700
Message-ID: <20070405012956.GM19575@sequoia.sous-sol.org>
References: <20070404191151.009821039@goop.org> <20070404191205.392155702@goop.org> <Pine.LNX.4.64.0704041729300.22161@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753014AbXDEBab@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704041729300.22161@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Lameter <clameter@sgi.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, William Lee Irwin III <wli@holomorphy.com>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

* Christoph Lameter (clameter@sgi.com) wrote:
> Acked-by: Christoph Lameter <clameter@sgi.com>
> 
> for all thats worth since I am not a i386 specialist.
> 
> How much of the issues with page struct sharing between slab and arch code 
> does this address?

I think the answer is 'none yet.'  It uses page sized slab and still
needs pgd_list, for example.  But the mm_list chaining should work too,
so it shouldn't make things any worse.

thanks,
-chris
