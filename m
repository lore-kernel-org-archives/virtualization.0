From: Hugh Dickins <hugh@veritas.com>
Subject: Re: [patch 0/6] Guest page hinting version 6.
Date: Thu, 13 Mar 2008 18:55:38 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0803131848080.800@blonde.site>
References: <20080312132132.520833247@de.ibm.com> <Pine.LNX.4.64.0803131627450.17244@blonde.site>
 <47D9754B.1030509@goop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756107AbYCMS7L@vger.kernel.org>
In-Reply-To: <47D9754B.1030509@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.osdl.org, akpm@linux-foundation.org, nickpiggin@yahoo.com.au, zach@vmware.com, frankeh@watson.ibm.com, rusty@rustcorp.com.au, andrea@qumranet.com, clameter@sgi.com, a.p.zijlstra@chello.nl, Keir Fraser <keir@xensource.com>, Ian Pratt <ian.pratt@xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 13 Mar 2008, Jeremy Fitzhardinge wrote:
> 
> My other concern is just correctness over time on the Linux side.  We already
> have enough trouble keeping things like the pte and page structure state in
> sync, with resulting rare data-loss bugs.  Adding another layer which only
> applies in specific environments raises the possibility for new bugs to be
> un-noticed for a long time.  How can we structure the VM changes to make sure
> that its robust in the face of maintenance?

Yes, that's the main concern, as whenever lots of subtlety is added.
I wonder if there's any chance of a CONFIG_DEBUG mode, which could be
run on anybody's x86 machine, without involving any virtualization, but
in which the PAGE_STATEs become essential to the correct working of the mm.

Hugh
