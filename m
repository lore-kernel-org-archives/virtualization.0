From: Hubertus Franke <frankeh@watson.ibm.com>
Subject: Re: [patch 1/9] Guest page hinting: unused / free pages.
Date: Wed, 13 Sep 2006 08:06:43 -0400
Message-ID: <4507F453.1040809@watson.ibm.com>
References: <20060901110908.GB15684@skybase> <45073901.8020906@redhat.com>	 <45074BD0.3060400@watson.ibm.com>  <45075F09.5010708@redhat.com> <1158137786.2560.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750704AbWIMMGw@vger.kernel.org>
In-Reply-To: <1158137786.2560.3.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: schwidefsky@de.ibm.com
Cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au, rhim@cc.gateh.edu
List-Id: virtualization@lists.linuxfoundation.org

Martin Schwidefsky wrote:
> On Tue, 2006-09-12 at 21:29 -0400, Rik van Riel wrote:
> 
>>Note that the transition _to_ volatile can also be batched
>>and done somewhat lazily.  For frequently mmaped pages that
>>could end up saving us the transition the other way, too...
> 
> 
> That would be helpful, only how to do it? We need some sort of list or
> array where to store the pages that should be made volatile. The main
> problem that I see is that you have to remove a page that is freed from
> the list/array again, otherwise you would end up with a non page-cache
> page being made volatile. That makes using per-cpu arrays hard since a
> page can be freed on another cpu.
> 


Martin. the point was that pages
which are in the hold/cold lists are technically free.
However we keep them stable.
When the hot/cold list is spilled back to the buddy allocator
we make them volatile in buld (i.e. through the array).
So we only build the array for the duration of the bulk-release
to the buddy allocator (and potentially the other way as well).
Hence there is no "state" to maintain or track for the array.
Pages in the hot/cold lists remain stable.
This would not any of the problems you described as long as we hold
the lock for the hot/cold list during buld-volatile.

I know we did this once. I think we "discarded" the idea
in order to have as many pages volatile as possible.

But this design should be quite easily added and the architecture
can choose whether to be aggressive about this or do it in bulk.

-- Hubertus
