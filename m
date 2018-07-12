From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v35 1/5] mm: support to get hints of free page blocks
Date: Thu, 12 Jul 2018 15:12:29 +0200
Message-ID: <20180712131229.GM32648@dhcp22.suse.cz>
References: <1531215067-35472-1-git-send-email-wei.w.wang@intel.com>
	<1531215067-35472-2-git-send-email-wei.w.wang@intel.com>
	<CA+55aFz9a=D-kquM=sG5uhV_HrBAw+VAhcJmtPNz+howy4j9ow@mail.gmail.com>
	<5B455D50.90902@intel.com>
	<CA+55aFzqj8wxXnHAdUTiOomipgFONVbqKMjL_tfk7e5ar1FziQ@mail.gmail.com>
	<20180711092152.GE20050@dhcp22.suse.cz>
	<CA+55aFwku2tDH4+rfaC67xc4-cEwSrXgnQaci=e2id5ZCRE9JQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: yang.zhang.wz@gmail.com, virtio-dev@lists.oasis-open.org, Rik van Riel <riel@redhat.com>, quan.xu0@gmail.com, KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, liliang.opensource@gmail.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, linux-mm <linux-mm@kvack.org>, Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, nilal@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

[Hmm this one somehow got stuck in my outgoing emails]

On Wed 11-07-18 09:23:54, Linus Torvalds wrote:
[...]
> So I'm open to new interfaces. I just want those new interfaces to
> make sense, and be low latency and simple for the VM to do. I'm
> objecting to the incredibly baroque and heavy-weight one that can
> return near-infinite amounts of memory.

Mel was suggesting a bulk page allocator a year ago [1]. I can see only
slab bulk api so I am not sure what happened with that work. Anyway
I think that starting with what we have right now is much more
appropriate than over design this thing from the early beginning.

[1] http://lkml.kernel.org/r/20170109163518.6001-5-mgorman@techsingularity.net
-- 
Michal Hocko
SUSE Labs
