From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v11 1/7] mm: adjust
	address_space_operations.migratepage() return code
Date: Wed, 7 Nov 2012 11:56:10 -0800
Message-ID: <20121107115610.c0cb650c.akpm@linux-foundation.org>
References: <cover.1352256081.git.aquini@redhat.com>
	<74bc30697313206e1225f6fc658bc5952b588dcc.1352256085.git.aquini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <74bc30697313206e1225f6fc658bc5952b588dcc.1352256085.git.aquini@redhat.com>
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
Cc: Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed,  7 Nov 2012 01:05:48 -0200
Rafael Aquini <aquini@redhat.com> wrote:

> This patch introduces MIGRATEPAGE_SUCCESS as the default return code
> for address_space_operations.migratepage() method and documents the
> expected return code for the same method in failure cases.

I hit a large number of rejects applying this against linux-next.  Due
to the increasingly irritating sched/numa code in there.

I attempted to fix it up and also converted some (but not all) of the
implicit tests of `rc' against zero.

Please check the result very carefully - more changes will be needed.

All those

-	if (rc)
+	if (rc != MIGRATEPAGE_SUCCESS)

changes are a pain.  Perhaps we shouldn't bother.
