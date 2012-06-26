From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 1/4] mm: introduce compaction and migration for virtio
	ballooned pages
Date: Tue, 26 Jun 2012 18:52:58 +0200
Message-ID: <20120626165258.GY11413__24777.3252115168$1340729596$gmane$org@one.firstfloor.org>
References: <cover.1340665087.git.aquini@redhat.com>
	<7f83427b3894af7969c67acc0f27ab5aa68b4279.1340665087.git.aquini@redhat.com>
	<20120626101729.GF8103@csn.ul.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120626101729.GF8103@csn.ul.ie>
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

> 
> What shocked me actually is that VM_BUG_ON code is executed on
> !CONFIG_DEBUG_VM builds and has been since 2.6.36 due to commit [4e60c86bd:
> gcc-4.6: mm: fix unused but set warnings]. I thought the whole point of
> VM_BUG_ON was to avoid expensive and usually unnecessary checks. Andi,
> was this deliberate?

The idea was that the compiler optimizes it away anyways.

I'm not fully sure what putback_balloon_page does, but if it just tests
a bit (without non variable test_bit) it should be ok.

-Andi
