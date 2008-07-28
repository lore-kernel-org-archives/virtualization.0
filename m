From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: How to get a sense of VM pressure
Date: Mon, 28 Jul 2008 01:12:41 -0700
Message-ID: <488D7F79.40102@goop.org>
References: <488A1398.7020004@goop.org> <1217230570.6331.6.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754774AbYG1IMx@vger.kernel.org>
In-Reply-To: <1217230570.6331.6.camel@twins>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Memory Management List <linux-mm@kvack.org>
List-Id: virtualization@lists.linuxfoundation.org

Peter Zijlstra wrote:
> Have a peek at this:
>
>   http://people.redhat.com/~riel/riel-OLS2006.pdf
>
> The refault patches have been posted several times, but nobody really
> tried to use them for your problem.
>   

Yep, Rik pointed the paper and patches out to me.  Seems like an 
interesting approach to play with.  The refaulting measure is nice 
because it should give a fairly good idea of how much memory you need to 
add to get the fault rate down below some particular level.  It doesn't 
help with shrinking, other than telling you you've gone too far, and how 
much too far, which is definitely useful to know.

    J
