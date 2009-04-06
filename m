From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 0/6] Guest page hinting version 7.
Date: Mon, 06 Apr 2009 12:23:35 -0700
Message-ID: <49DA56B7.9020905@goop.org>
References: <20090327150905.819861420@de.ibm.com>	<200903281705.29798.rusty@rustcorp.com.au>	<20090329162336.7c0700e9@skybase>	<200904022232.02185.nickpiggin@yahoo.com.au>	<20090402175249.3c4a6d59@skybase>	<49D50CB7.2050705@redhat.com>	<49D518E9.1090001@goop.org>	<49D51CA9.6090601@redhat.com>	<49D5215D.6050503@goop.org>	<20090403104913.29c62082@skybase>	<49D6532C.6010804@goop.org> <20090406092111.3b432edd@skybase>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20090406092111.3b432edd@skybase>
Sender: owner-linux-mm@kvack.org
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Rik van Riel <riel@redhat.com>, akpm@osdl.org, Nick Piggin <nickpiggin@yahoo.com.au>, frankeh@watson.ibm.com, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, hugh@veritas.com, Xen-devel <xen-devel@lists.xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

Martin Schwidefsky wrote:
> Why should the guest want to do preswapping? It is as expensive for
> the host to swap a page and get it back as it is for the guest (= one
> write + one read).

Yes, perhaps for swapping, but in general it makes sense for the guest 
to write the pages to backing store to prevent host swapping.  For swap 
pages there's no big benefit, but for file-backed pages its better for 
the guest to do it.

> The only thing you can gain by
> putting memory pressure on the guest is to free some of the memory that
> is used by the kernel for dentries, inodes, etc. 
>   

Well, that's also significant.  My point is that the guest has multiple 
ways in which it can relieve its own memory pressure in response to 
overall system memory pressure; its just that I happened to pick the 
example where its much of a muchness.

    J

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
