From: Rik van Riel <riel@redhat.com>
Subject: Re: [patch 3/6] Guest page hinting: mlocked pages.
Date: Tue, 31 Mar 2009 22:52:04 -0400
Message-ID: <49D2D6D4.8000309@redhat.com>
References: <20090327150905.819861420@de.ibm.com> <20090327151012.095486071@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20090327151012.095486071@de.ibm.com>
Sender: owner-linux-mm@kvack.org
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, frankeh@watson.ibm.com, akpm@osdl.org, nickpiggin@yahoo.com.au, hugh@veritas.com
List-Id: virtualization@lists.linuxfoundation.org

Martin Schwidefsky wrote:
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> From: Hubertus Franke <frankeh@watson.ibm.com>
> From: Himanshu Raj
> 
> Add code to get mlock() working with guest page hinting. The problem
> with mlock is that locked pages may not be removed from page cache.
> That means they need to be stable. 

> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

Acked-by: Rik van Riel <riel@redhat.com>

-- 
All rights reversed.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
