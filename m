From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH 1/4] Prep for paravirt: move pagetable includes.
Date: Fri, 27 Oct 2006 03:30:48 -0700
Message-ID: <4541DFD8.6010106@vmware.com>
References: <1161920325.17807.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1946369AbWJ0Kau@vger.kernel.org>
In-Reply-To: <1161920325.17807.29.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> Move header includes for the nopud / nopmd types to the location of the
> actual pte / pgd type definitions.  This allows generic 4-level page
> type code to be written before the split 2/3 level page table headers are
> included.
>
> Signed-off-by: Zachary Amsden <zach@vmware.com>
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
>   

I sent this one out previously .. I think it is already in a subsystem tree.

Zach
