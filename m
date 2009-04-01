From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 3/6] Guest page hinting: mlocked pages.
Date: Wed, 1 Apr 2009 10:13:57 +0200
Message-ID: <20090401101357.7f714f7a@skybase>
References: <20090327150905.819861420@de.ibm.com>
	<20090327151012.095486071@de.ibm.com>
	<49D2D6D4.8000309@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <49D2D6D4.8000309@redhat.com>
Sender: owner-linux-mm@kvack.org
To: Rik van Riel <riel@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, frankeh@watson.ibm.com, akpm@osdl.org, nickpiggin@yahoo.com.au, hugh@veritas.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 31 Mar 2009 22:52:04 -0400
Rik van Riel <riel@redhat.com> wrote:

> Martin Schwidefsky wrote:
> > From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > From: Hubertus Franke <frankeh@watson.ibm.com>
> > From: Himanshu Raj
> > 
> > Add code to get mlock() working with guest page hinting. The problem
> > with mlock is that locked pages may not be removed from page cache.
> > That means they need to be stable. 
> 
> > Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> Acked-by: Rik van Riel <riel@redhat.com>

I'll add this one as well. Thanks again.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
