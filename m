From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH] VMI: remove CONFIG_DEBUG_PAGE_TYPE and associated	bitrotted
 code
Date: Fri, 06 Jul 2007 13:34:21 -0700
Message-ID: <468EA74D.7010706@vmware.com>
References: <Pine.LNX.4.64.0707060847470.23786@localhost.localdomain>	<468E890A.1070504@s5r6.in-berlin.de>	<20070706201625.GT4306@sequoia.sous-sol.org> <468EA27C.9060401@vmware.com> <468EA5E0.4070501@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764146AbXGFUny@vger.kernel.org>
In-Reply-To: <468EA5E0.4070501@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.osdl.org, Stefan Richter <stefanr@s5r6.in-berlin.de>, "Robert P. J. Day" <rpjday@mindspring.com>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
>>
>> I never merged the whole bit upstream because it added a field to 
>> struct page. 
>
> Hm, is that a big problem?  It would be OK for a debug config option, 
> wouldn't it?  Also, it doesn't seem particularly vmi-specific.  Could 
> it be made part of the pvops infrastructure?

I though about it, but it gets really ugly.  You need wrappers for all 
the MMU ops in pvops generic code, which means either another layer of 
wrappers or a bunch of CONFIG_DEBUG_PARAVIRT only things that are easy 
to break because they also depend on PAE vs. non-PAE.

It's doable, though, and might even be extensible to s390 for CMM page 
type debugging, as well as descriptor type tracking and enforcement of 
page isolation of GDTs.

Page state tracking could track -

PAGE_ZERO, PAGE_UNUSED, PAGE_STABLE, PAGE_VOLATILE, 
PAGE_POTENTIALLY_VOLATILE, PAGE_L1{2/3/4}, PAGE_LDT, PAGE_GDT,

actually, no this seems silly, since we'd just be duplicating bits for 
the page types, so the only debug benefit is ensuring the intersection 
of volatile and L{1/2/3/4} is nil, which is already trivially verifiable 
by inspection.

Zach
