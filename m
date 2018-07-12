From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v35 1/5] mm: support to get hints of free page blocks
Date: Thu, 12 Jul 2018 10:21:58 +0800
Message-ID: <5B46BB46.2080802__49876.4256168672$1531361749$gmane$org@intel.com>
References: <1531215067-35472-1-git-send-email-wei.w.wang@intel.com>
	<1531215067-35472-2-git-send-email-wei.w.wang@intel.com>
	<CA+55aFz9a=D-kquM=sG5uhV_HrBAw+VAhcJmtPNz+howy4j9ow@mail.gmail.com>
	<5B455D50.90902@intel.com>
	<CA+55aFzqj8wxXnHAdUTiOomipgFONVbqKMjL_tfk7e5ar1FziQ@mail.gmail.com>
	<20180711092152.GE20050@dhcp22.suse.cz>
	<CA+55aFwku2tDH4+rfaC67xc4-cEwSrXgnQaci=e2id5ZCRE9JQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CA+55aFwku2tDH4+rfaC67xc4-cEwSrXgnQaci=e2id5ZCRE9JQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>
Cc: yang.zhang.wz@gmail.com, virtio-dev@lists.oasis-open.org, Rik van Riel <riel@redhat.com>, quan.xu0@gmail.com, KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, liliang.opensource@gmail.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, linux-mm <linux-mm@kvack.org>, Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, nilal@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On 07/12/2018 12:23 AM, Linus Torvalds wrote:
> On Wed, Jul 11, 2018 at 2:21 AM Michal Hocko <mhocko@kernel.org> wrote:
>> We already have an interface for that. alloc_pages(GFP_NOWAIT, MAX_ORDER -1).
>> So why do we need any array based interface?
> That was actually my original argument in the original thread - that
> the only new interface people might want is one that just tells how
> many of those MAX_ORDER-1 pages there are.
>
> See the thread in v33 with the subject
>
>    "[PATCH v33 1/4] mm: add a function to get free page blocks"
>
> and look for me suggesting just using
>
>      #define GFP_MINFLAGS (__GFP_NORETRY | __GFP_NOWARN |
> __GFP_THISNODE | __GFP_NOMEMALLOC)

Would it be better to remove __GFP_THISNODE? We actually want to get all 
the guest free pages (from all the nodes).

Best,
Wei
