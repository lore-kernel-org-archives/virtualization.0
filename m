From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 07/20] Allow paravirt backend to choose kernel PMD sharing
Date: Wed, 04 Apr 2007 17:43:13 -0700
Message-ID: <46144621.20407@goop.org>
References: <20070404191151.009821039@goop.org> <20070404191205.392155702@goop.org> <Pine.LNX.4.64.0704041729300.22161@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932386AbXDEAnl@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0704041729300.22161@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Lameter <clameter@sgi.com>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, William Lee Irwin III <wli@holomorphy.com>, Zachary Amsden <zach@vmware.com>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Christoph Lameter wrote:
> Acked-by: Christoph Lameter <clameter@sgi.com>
>
> for all thats worth since I am not a i386 specialist.
>
> How much of the issues with page struct sharing between slab and arch code 
> does this address?
>   

I haven't been following that thread as closely as I should be, so I
don't have an answer.  I guess the interesting thing in this patch is
that it only uses the pmd cache for usermode pmds (which are
pre-zeroed), and normal page allocations for kernel pmds.  Also, if the
kernel pmds are unshared, the pgds are page-sized, so its not really
making good use of the pgd cache.

    J
