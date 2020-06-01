From: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 1/2] docs: mm/gup: pin_user_pages.rst: add a "case 5"
Date: Sun, 31 May 2020 22:11:49 -0700
Message-ID: <b8de5a5e-b53a-81e8-9165-405d203deb33@nvidia.com>
References: <20200529234309.484480-1-jhubbard@nvidia.com>
 <20200529234309.484480-2-jhubbard@nvidia.com>
 <CAFqt6zaCSngh7-N_qZ6-S3Cj8CHF8DTSPv8anP_oJg5E6UWu9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFqt6zaCSngh7-N_qZ6-S3Cj8CHF8DTSPv8anP_oJg5E6UWu9g@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
List-Id: virtualization@lists.linuxfoundation.org

On 2020-05-31 00:11, Souptick Joarder wrote:
...
>> diff --git a/Documentation/core-api/pin_user_pages.rst b/Documentation/core-api/pin_user_pages.rst
>> index 4675b04e8829..b9f2688a2c67 100644
>> --- a/Documentation/core-api/pin_user_pages.rst
>> +++ b/Documentation/core-api/pin_user_pages.rst
>> @@ -171,6 +171,26 @@ If only struct page data (as opposed to the actual memory contents that a page
>>   is tracking) is affected, then normal GUP calls are sufficient, and neither flag
>>   needs to be set.
>>
>> +CASE 5: Pinning in order to write to the data within the page
>> +-------------------------------------------------------------
>> +Even though neither DMA nor Direct IO is involved, just a simple case of "pin,
>> +access page's data, unpin" can cause a problem.
> 
> Will it be, *"pin, access page's data, set page dirty, unpin" * ?

Well...the problem can show up with just accessing (writing) the data.
But it is true that this statement is a little different from the
patterns below, which is confusing. I'll delete set_page_dirty() from each
of them, in order to avoid confusing things. (Although each is correct.)
And I'll also change the above to "pin, write to a page's data, upin".

set_page_dirty() interactions are really just extra credit here. :) And
fully read-only situations won't cause a problem.

> 
> Case 5 may be considered a
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
>> +

I'll send a v2 shortly.

thanks,
-- 
John Hubbard
NVIDIA
