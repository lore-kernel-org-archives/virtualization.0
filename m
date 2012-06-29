From: Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v2 0/4] make balloon pages movable by compaction
Date: Fri, 29 Jun 2012 00:51:24 -0300
Message-ID: <20120629035123.GA1763__24866.6447274902$1340941937$gmane$org@t510.redhat.com>
References: <cover.1340916058.git.aquini@redhat.com>
	<4FED06C8.1090003@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4FED06C8.1090003@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Minchan Kim <minchan@kernel.org>
Cc: Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 29, 2012 at 10:37:12AM +0900, Minchan Kim wrote:
> Hi Rafael,
> 
> On 06/29/2012 06:49 AM, Rafael Aquini wrote:
> 
> > This patchset follows the main idea discussed at 2012 LSFMMS section:
> > "Ballooning for transparent huge pages" -- http://lwn.net/Articles/490114/
> 
> 
> Could you summarize the problem, solution instead of link URL in cover-letter?
> IIUC, the problem is that it is hard to get contiguous memory in guest-side 
> after ballooning happens because guest-side memory could be very fragmented
> by ballooned page. It makes THP page allocation of guest-side very poor success ratio.
> 
> The solution is that when memory ballooning happens, we allocates ballooned page
> as a movable page in guest-side because they can be migrated easily so compaction of
> guest-side could put together them into either side so that we can get contiguous memory.
> For it, compaction should be aware of ballooned page.
> 
> Right?
>
Yes, you surely got it correct, sir. 

Thanks Minchan, for taking time to provide me such feedback. I'll rework commit
messages to make them more elucidative, yet concise for the next submission.

Please, let me know if you have other concerns I shall be addressing here.

Best regards!
