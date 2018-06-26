From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v33 1/4] mm: add a function to get free page blocks
Date: Tue, 26 Jun 2018 04:55:26 +0300
Message-ID: <20180626045118-mutt-send-email-mst@kernel.org>
References: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com>
	<1529037793-35521-2-git-send-email-wei.w.wang@intel.com>
	<CA+55aFzhuGKinEq5udPsk_uYHShkQxJYqcPO=tLCkT-oxpsgPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFzhuGKinEq5udPsk_uYHShkQxJYqcPO=tLCkT-oxpsgPg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: yang.zhang.wz@gmail.com, virtio-dev@lists.oasis-open.org, Rik van Riel <riel@redhat.com>, quan.xu0@gmail.com, KVM list <kvm@vger.kernel.org>, nilal@redhat.com, liliang.opensource@gmail.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, linux-mm <linux-mm@kvack.org>, Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Jun 16, 2018 at 08:08:53AM +0900, Linus Torvalds wrote:
> On Fri, Jun 15, 2018 at 2:08 PM Wei Wang <wei.w.wang@intel.com> wrote:
> >
> > This patch adds a function to get free pages blocks from a free page
> > list. The obtained free page blocks are hints about free pages, because
> > there is no guarantee that they are still on the free page list after
> > the function returns.

...

> > +uint32_t get_from_free_page_list(int order, __le64 buf[], uint32_t size)

...

> 
> Ack. This is the kind of simple interface where I don't need to worry
> about the MM code calling out to random drivers or subsystems.
> 
> I think that "order" should be checked for validity, but from a MM
> standpoint I think this is fine.
> 
>                 Linus

The only issue seems to be getting hold of buf that's large enough -
and we don't really know what the size is, or whether one
buf would be enough.

Linus, do you think it would be ok to have get_from_free_page_list
actually pop entries from the free list and use them as the buffer
to store PAs?

Caller would be responsible for freeing the returned entries.

-- 
MST
