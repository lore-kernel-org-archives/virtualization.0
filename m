From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v35 1/5] mm: support to get hints of free page blocks
Date: Wed, 11 Jul 2018 22:36:50 +0300
Message-ID: <20180711223040-mutt-send-email-mst__31309.3163575561$1531337695$gmane$org@kernel.org>
References: <1531215067-35472-1-git-send-email-wei.w.wang@intel.com>
	<1531215067-35472-2-git-send-email-wei.w.wang@intel.com>
	<CA+55aFz9a=D-kquM=sG5uhV_HrBAw+VAhcJmtPNz+howy4j9ow@mail.gmail.com>
	<5B455D50.90902@intel.com>
	<CA+55aFzqj8wxXnHAdUTiOomipgFONVbqKMjL_tfk7e5ar1FziQ@mail.gmail.com>
	<20180711092152.GE20050@dhcp22.suse.cz>
	<5B45E17D.2090205@intel.com>
	<20180711110949.GJ20050@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180711110949.GJ20050@dhcp22.suse.cz>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Michal Hocko <mhocko@kernel.org>
Cc: yang.zhang.wz@gmail.com, virtio-dev@lists.oasis-open.org, Rik van Riel <riel@redhat.com>, quan.xu0@gmail.com, KVM list <kvm@vger.kernel.org>, liliang.opensource@gmail.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, linux-mm <linux-mm@kvack.org>, Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, nilal@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 11, 2018 at 01:09:49PM +0200, Michal Hocko wrote:
> But let me note that I am not really convinced how this (or previous)
> approach will really work in most workloads. We tend to cache heavily so
> there is rarely any memory free.

It might be that it's worth flushing the cache when VM is
migrating. Or maybe we should implement virtio-tmem or add
transcendent memory support to the balloon.

-- 
MST
