From: Rik van Riel <riel@redhat.com>
Subject: Re: [patch 1/9] Guest page hinting: unused / free pages.
Date: Wed, 13 Sep 2006 10:45:34 -0400
Message-ID: <4508198E.10707@redhat.com>
References: <20060901110908.GB15684@skybase> <45073901.8020906@redhat.com>	 <45074BD0.3060400@watson.ibm.com>  <45075F09.5010708@redhat.com>	 <1158137786.2560.3.camel@localhost>  <4507F453.1040809@watson.ibm.com> <1158151535.2560.20.camel@localhost> <45080262.8050009@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750897AbWIMOps@vger.kernel.org>
In-Reply-To: <45080262.8050009@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au, rhim@cc.gatech.edu
List-Id: virtualization@lists.linuxfoundation.org

Hubertus Franke wrote:

> But another trouble you have not mentioned is what happens to pages
> with pending make-volatile that need to and/or have been made stable
> in the meantime. They too need to be removed from this pending list.

At the time where you walk the set of pages (pagevec?) to make
volatile, you can check whether the page flags are still right.

A page that was set to be marked volatile with the hypervisor,
but later turned stable again would have that indicated in its
page flags, right?

-- 
What is important?  What you want to be true, or what is true?
