From: Rik van Riel <riel@redhat.com>
Subject: Re: [patch 1/9] Guest page hinting: unused / free pages.
Date: Tue, 12 Sep 2006 21:29:45 -0400
Message-ID: <45075F09.5010708@redhat.com>
References: <20060901110908.GB15684@skybase> <45073901.8020906@redhat.com> <45074BD0.3060400@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030477AbWIMB3z@vger.kernel.org>
In-Reply-To: <45074BD0.3060400@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au, rhim@cc.gateh.edu
List-Id: virtualization@lists.linuxfoundation.org

Hubertus Franke wrote:
> Rik van Riel wrote:

>> Easy enough to pass a vector of pages to the hypervisor.
> 
> Rik, I thought that what we did.
> Martin, I see the code actually does it when the page goes into the 
> hot/cold
> list. I can't remember conciously moving to that.
> I thought we had a decent hit on the hot/cold, so that bulking makes sense.
> 
> Then the interface of bulking could be introduced and for s390 it could 
> internally be implemented as a sequence of ESSA instruction.

Note that the transition _to_ volatile can also be batched
and done somewhat lazily.  For frequently mmaped pages that
could end up saving us the transition the other way, too...

That could make page hinting very acceptable performance wise,
even without a millicode implementation.

-- 
What is important?  What you want to be true, or what is true?
