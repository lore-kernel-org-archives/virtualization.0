From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH] virtio-balloon: Disable free page
 hinting/reporting if page poison is disabled
Date: Fri, 17 Apr 2020 06:19:37 -0400
Message-ID: <20200417061815-mutt-send-email-mst@kernel.org>
References: <20200416180845-mutt-send-email-mst@kernel.org>
 <CAKgT0UfWHHyCekU+dReNfhAa6u6FNbm7Ff5wmyN58d1VymmAMA@mail.gmail.com>
 <20200417021335-mutt-send-email-mst@kernel.org>
 <08d2c4e2-8c0f-7d3c-89f1-0e6c6a2756c8@redhat.com>
 <20200417044641-mutt-send-email-mst@kernel.org>
 <0f867029-aef4-72b9-356f-ec25c265db1b@redhat.com>
 <20200417051223-mutt-send-email-mst@kernel.org>
 <3447361c-4d07-1785-c59b-8c98ddaebd92@redhat.com>
 <20200417055217-mutt-send-email-mst@kernel.org>
 <1823d9be-d175-6cb5-0c7d-8a68d959a0d5@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1823d9be-d175-6cb5-0c7d-8a68d959a0d5@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Alexander Duyck <alexander.duyck@gmail.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 17, 2020 at 12:09:38PM +0200, David Hildenbrand wrote:
>  > What do you call "hinting ends" though? The fact we put
> > a page in the VQ is not a guarantee that it's been consumed
> > by the hypervisor.
> > 
> 
> I'd say hinting ends once the hypervisor sets FREE_PAGE_REPORT_S_DONE.

Can't find that one anywhere. what did I miss?



> > 
> > I think a strict definition is this:
> > - hint includes a command ID
> > - hint implies "page was unused at some point after guest reading command ID"
> > 
> > 
> > Hypervisor can use dirty tracking tricks to get from that to
> > "page is unused at the moment".
> > 
> >> Whereby X is
> >> currently assumed to be 0, correct?
> > 
> > 
> > 
> > Now we are talking about what's safe to do with the page.
> > 
> > If POISON flag is set by hypervisor but clear by guest,
> > or poison_val is 0, then it's clear it's safe to blow
> > away the page if we can figure out it's unused.
> > 
> > Otherwise, it's much less clear :)
> 
> Hah! Agreed :D
> 
> > 
> > 
> > 
> > I'll have to come back and re-read the rest next week, this
> > is complex stuff and I'm too rushed with other things today.
> 
> Yeah, I'm also loaded with other stuff. Maybe Alex has time to
> understand the details as well.
> 
> -- 
> Thanks,
> 
> David / dhildenb
