From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v6 03/12] mm: balloon: use general non-lru movable page
	feature
Date: Mon, 30 May 2016 14:16:28 +0200
Message-ID: <94563783-c485-8046-528c-ef0cba747225__17624.3155649447$1464610613$gmane$org@suse.cz>
References: <1463754225-31311-1-git-send-email-minchan@kernel.org>
	<1463754225-31311-4-git-send-email-minchan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1463754225-31311-4-git-send-email-minchan@kernel.org>
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
Cc: Rafael Aquini <aquini@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Konstantin Khlebnikov <koct9i@gmail.com>, Gioh Kim <gi-oh.kim@profitbricks.com>
List-Id: virtualization@lists.linuxfoundation.org

On 05/20/2016 04:23 PM, Minchan Kim wrote:
> Now, VM has a feature to migrate non-lru movable pages so
> balloon doesn't need custom migration hooks in migrate.c
> and compaction.c. Instead, this patch implements
> page->mapping->a_ops->{isolate|migrate|putback} functions.
>
> With that, we could remove hooks for ballooning in general
> migration functions and make balloon compaction simple.
>
> Cc: virtualization@lists.linux-foundation.org
> Cc: Rafael Aquini <aquini@redhat.com>
> Cc: Konstantin Khlebnikov <koct9i@gmail.com>
> Signed-off-by: Gioh Kim <gi-oh.kim@profitbricks.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>

Except for the inode/pseudofs stuff which I'm not familiar with,

Acked-by: Vlastimil Babka <vbabka@suse.cz>
