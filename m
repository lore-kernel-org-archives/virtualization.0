From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH] Add a page cache-backed balloon device driver.
Date: Tue, 26 Jun 2012 16:40:14 -0400
Message-ID: <4FEA1E2E.4020806@redhat.com>
References: <1340742778-11282-1-git-send-email-fes@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1340742778-11282-1-git-send-email-fes@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Frank Swiderski <fes@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Rafael Aquini <aquini@redhat.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ying Han <yinghan@google.com>, mikew@google.com
List-Id: virtualization@lists.linuxfoundation.org

On 06/26/2012 04:32 PM, Frank Swiderski wrote:
> This implementation of a virtio balloon driver uses the page cache to
> "store" pages that have been released to the host.  The communication
> (outside of target counts) is one way--the guest notifies the host when
> it adds a page to the page cache, allowing the host to madvise(2) with
> MADV_DONTNEED.  Reclaim in the guest is therefore automatic and implicit
> (via the regular page reclaim).  This means that inflating the balloon
> is similar to the existing balloon mechanism, but the deflate is
> different--it re-uses existing Linux kernel functionality to
> automatically reclaim.
>
> Signed-off-by: Frank Swiderski<fes@google.com>

It is a great idea, but how can this memory balancing
possibly work if someone uses memory cgroups inside a
guest?

Having said that, we currently do not have proper
memory reclaim balancing between cgroups at all, so
requiring that of this balloon driver would be
unreasonable.

The code looks good to me, my only worry is the
code duplication. We now have 5 balloon drivers,
for 4 hypervisors, all implementing everything
from scratch...
