From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v6v3 02/12] mm: migrate: support non-lru movable page
	migration
Date: Tue, 31 May 2016 09:52:48 +0200
Message-ID: <29ae65ef-a4c9-1d45-ce56-70b29d3eacfd__29355.59790717$1464681187$gmane$org@suse.cz>
References: <1463754225-31311-1-git-send-email-minchan@kernel.org>
	<1463754225-31311-3-git-send-email-minchan@kernel.org>
	<20160530013926.GB8683@bbox> <20160531000117.GB18314@bbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160531000117.GB18314@bbox>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Rik van Riel <riel@redhat.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Rafael Aquini <aquini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, John Einar Reitan <john.reitan@foss.arm.com>, linux-mm@kvack.org, Mel Gorman <mgorman@suse.de>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Gioh Kim <gi-oh.kim@profitbricks.com>
List-Id: virtualization@lists.linuxfoundation.org

On 05/31/2016 02:01 AM, Minchan Kim wrote:
> Per Vlastimi's review comment.
>
> Thanks for the detail review, Vlastimi!
> If you have another concern, feel free to say.

I don't for now :)

[...]

> Cc: Rik van Riel <riel@redhat.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Rafael Aquini <aquini@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: John Einar Reitan <john.reitan@foss.arm.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Signed-off-by: Gioh Kim <gi-oh.kim@profitbricks.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
