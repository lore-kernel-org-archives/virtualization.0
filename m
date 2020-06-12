From: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 1/2] docs: mm/gup: pin_user_pages.rst: add a "case 5"
Date: Fri, 12 Jun 2020 13:03:07 -0700
Message-ID: <d717e596-4ac7-9350-8734-379852c151d2@nvidia.com>
References: <20200529234309.484480-1-jhubbard@nvidia.com>
 <20200529234309.484480-2-jhubbard@nvidia.com>
 <20200612192426.GK8681@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200612192426.GK8681@bombadil.infradead.org>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>, Souptick Joarder <jrdr.linux@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
List-Id: virtualization@lists.linuxfoundation.org

On 2020-06-12 12:24, Matthew Wilcox wrote:
> On Fri, May 29, 2020 at 04:43:08PM -0700, John Hubbard wrote:
>> +CASE 5: Pinning in order to write to the data within the page
>> +-------------------------------------------------------------
>> +Even though neither DMA nor Direct IO is involved, just a simple case of "pin,
>> +access page's data, unpin" can cause a problem. Case 5 may be considered a
>> +superset of Case 1, plus Case 2, plus anything that invokes that pattern. In
>> +other words, if the code is neither Case 1 nor Case 2, it may still require
>> +FOLL_PIN, for patterns like this:
>> +
>> +Correct (uses FOLL_PIN calls):
>> +    pin_user_pages()
>> +    access the data within the pages
>> +    set_page_dirty_lock()
>> +    unpin_user_pages()
>> +
>> +INCORRECT (uses FOLL_GET calls):
>> +    get_user_pages()
>> +    access the data within the pages
>> +    set_page_dirty_lock()
>> +    put_page()
> 
> Why does this case need to pin?  Why can't it just do ...
> 
> 	get_user_pages()
> 	lock_page(page);
> 	... modify the data ...
> 	set_page_dirty(page);
> 	unlock_page(page);
> 

Yes, it could do that. And that would also make a good additional "correct"
example. Especially for the case of just dealing with a single page,
lock_page() has the benefit of completely fixing the problem *today*,
without waiting for the pin_user_pages*() handling improvements to get
implemented.

And it's also another (probably better) way to fix the vhost.c problem, than
commit 690623e1b496 ("vhost: convert get_user_pages() --> pin_user_pages()").

I'm inclined to leave vhost.c alone for now, unless someone really prefers
it to be changed, but to update the Case 5 documentation with your point
above. Sound about right?


thanks,
-- 
John Hubbard
NVIDIA
