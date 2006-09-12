From: Rik van Riel <riel@redhat.com>
Subject: Re: [patch 1/9] Guest page hinting: unused / free pages.
Date: Tue, 12 Sep 2006 18:47:29 -0400
Message-ID: <45073901.8020906@redhat.com>
References: <20060901110908.GB15684@skybase>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030234AbWILWrq@vger.kernel.org>
In-Reply-To: <20060901110908.GB15684@skybase>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rhim@cc.gateh.edu
List-Id: virtualization@lists.linuxfoundation.org

Martin Schwidefsky wrote:
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> From: Hubertus Franke <frankeh@watson.ibm.com>
> From: Himanshu Raj <rhim@cc.gatech.edu>
> 
> [patch 1/9] Guest page hinting: unused / free pages.
> 
> A very simple but already quite effective improvement in the handling
> of guest memory vs. host memory is to tell the host when pages are
> free. 

Would it be an idea to place this interface in-between the
per-cpu free page lists and the buddy allocator, so we can
move a batch of pages around at once and do the hinting in
a batched fashion ?

That way the overhead will be acceptable not just on S390
(where things are millicoded), but also on hypervisor based
virtualization like Xen.

Easy enough to pass a vector of pages to the hypervisor.

-- 
What is important?  What you want to be true, or what is true?
