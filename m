From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 0/6] Guest page hinting version 6.
Date: Wed, 07 May 2008 09:00:14 +0200
Message-ID: <1210143614.14130.3.camel@localhost>
References: <20080312132132.520833247@de.ibm.com>
	 <Pine.LNX.4.64.0803131627450.17244@blonde.site>
	 <1210087982.31803.32.camel@localhost>
	 <20080506154612.58cc3070@cuia.bos.redhat.com>
	 <1210132187.17107.40.camel@bodhitayantram.eng.vmware.com>
Reply-To: schwidefsky@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764158AbYEGHMu@vger.kernel.org>
In-Reply-To: <1210132187.17107.40.camel@bodhitayantram.eng.vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Rik van Riel <riel@redhat.com>, Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.osdl.org, akpm@linux-foundation.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rusty@rustcorp.com.au, jeremy@goop.org, andrea@qumranet.com, clameter@sgi.com, a.p.zijlstra@chello.nl
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2008-05-06 at 20:49 -0700, Zachary Amsden wrote:
> > I suspect one of the problems is that there are too many state transitions
> > to have it implemented with a low overhead on anything but S390, and even
> > there you need milicoded instructions to handle things.
> > 
> > If the number of transitions can be reduced, page hinting could be useful
> > for KVM, too.
> 
> Spot on Rik, if every transition becomes a hypercall (and a synchronous
> one at that), it isn't workable for us.  If, on the other hand, you
> share the state bits between the guest and hypervisor, you need a giant
> (standalone) bit array for per-page state, which is neither convenient
> for Linux nor the hypervisor.  I believe s390 has an 'instruction' to
> migrate the state bits into the hypervisor per-physical-page data
> without requiring a hypercall.

That is why we invented the millicoded ESSA instruction on s390. We had
an emulation of the instruction to test things. It worked but was
awfully slow.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
