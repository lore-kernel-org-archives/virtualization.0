From: Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH] virtio: Do not drop __GFP_HIGH in alloc_indirect
Date: Mon, 7 Dec 2015 11:29:09 +0000
Message-ID: <20151207112909.GH2015__25004.1594882079$1449488258$gmane$org@techsingularity.net>
References: <1448980369-27130-1-git-send-email-mhocko@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1448980369-27130-1-git-send-email-mhocko@kernel.org>
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
Cc: Michal Hocko <mhocko@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Huang, Ying" <ying.huang@linux.intel.com>, Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 01, 2015 at 03:32:49PM +0100, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> b92b1b89a33c ("virtio: force vring descriptors to be allocated from
> lowmem") tried to exclude highmem pages for descriptors so it cleared
> __GFP_HIGHMEM from a given gfp mask. The patch also cleared __GFP_HIGH
> which doesn't make much sense for this fix because __GFP_HIGH only
> controls access to memory reserves and it doesn't have any influence
> on the zone selection. Some of the call paths use GFP_ATOMIC and
> dropping __GFP_HIGH will reduce their changes for success because the
> lack of access to memory reserves.
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: Mel Gorman <mgorman@techsingularity.net>

It also has been tested by Ying Huang and found to have fixed a page
allocation failure problem in 4.4-rc3 in the Intel 0-day testing
infrastructure.

-- 
Mel Gorman
SUSE Labs
