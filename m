From: Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v2 0/4] make balloon pages movable by compaction
Date: Fri, 29 Jun 2012 10:37:12 +0900
Message-ID: <4FED06C8.1090003__35110.6314607479$1341247004$gmane$org@kernel.org>
References: <cover.1340916058.git.aquini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1340916058.git.aquini@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rafael Aquini <aquini@redhat.com>
Cc: Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Rafael,

On 06/29/2012 06:49 AM, Rafael Aquini wrote:

> This patchset follows the main idea discussed at 2012 LSFMMS section:
> "Ballooning for transparent huge pages" -- http://lwn.net/Articles/490114/


Could you summarize the problem, solution instead of link URL in cover-letter?
IIUC, the problem is that it is hard to get contiguous memory in guest-side 
after ballooning happens because guest-side memory could be very fragmented
by ballooned page. It makes THP page allocation of guest-side very poor success ratio.

The solution is that when memory ballooning happens, we allocates ballooned page
as a movable page in guest-side because they can be migrated easily so compaction of
guest-side could put together them into either side so that we can get contiguous memory.
For it, compaction should be aware of ballooned page.

Right?

-- 
Kind regards,
Minchan Kim
