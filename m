From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 1/4] mm: introduce compaction and migration for virtio
	ballooned pages
Date: Tue, 26 Jun 2012 22:34:00 +0200
Message-ID: <20120626203400.GA11413__12237.101692199$1340742852$gmane$org@one.firstfloor.org>
References: <cover.1340665087.git.aquini@redhat.com>
	<7f83427b3894af7969c67acc0f27ab5aa68b4279.1340665087.git.aquini@redhat.com>
	<20120626101729.GF8103@csn.ul.ie>
	<20120626165258.GY11413@one.firstfloor.org>
	<20120626201513.GJ8103@csn.ul.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120626201513.GJ8103@csn.ul.ie>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mel Gorman <mel@csn.ul.ie>
Cc: Rik van Riel <riel@redhat.com>, Rafael Aquini <aquini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>
List-Id: virtualization@lists.linuxfoundation.org

> How is the compiler meant to optimise away "cond" if it's a function
> call?

Inlines can be optimized away.  These tests are usually inlines.

> What did I miss? If nothing, then I will revert this particular change
> and Rafael will need to be sure his patch is not using VM_BUG_ON to call
> a function with side-effects.

Do you have an example where the code is actually different,
or are you just speculating?

FWIW for my config both generates the same code:

size vmlinux-andi-vmbug vmlinux-vmbug-nothing 
   text    data     bss     dec     hex filename
11809704        1457352 1159168 14426224         dc2070 vmlinux-andi-vmbug
11809704        1457352 1159168 14426224         dc2070 vmlinux-vmbug-nothing

-Andi
