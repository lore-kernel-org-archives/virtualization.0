From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: How to get a sense of VM pressure
Date: Mon, 28 Jul 2008 01:10:33 -0700
Message-ID: <488D7EF9.2020500@goop.org>
References: <488A1398.7020004@goop.org> <200807261425.26318.nickpiggin@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755218AbYG1IK5@vger.kernel.org>
In-Reply-To: <200807261425.26318.nickpiggin@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Memory Management List <linux-mm@kvack.org>
List-Id: virtualization@lists.linuxfoundation.org

Nick Piggin wrote:
> A good start would be to register a "shrinker" (look at dcache or inode
> cache for examples). Start off by allocating pages, and slow down or
> stop or even release some of the pages back as you start getting feedback
> back through your shrinker callback.
>
> Not perfect, but it should prevent livelocks.
>   

Thanks, that's a good starting place.

    J
