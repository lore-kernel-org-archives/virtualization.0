From: Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v11 5/7] virtio_balloon: introduce migration primitives
	to balloon pages
Date: Wed, 7 Nov 2012 22:34:04 -0200
Message-ID: <20121108003403.GE10444__37528.4076705158$1352334881$gmane$org@optiplex.redhat.com>
References: <cover.1352256081.git.aquini@redhat.com>
	<265aaff9a79f503672f0cdcdff204114b5b5ba5b.1352256088.git.aquini@redhat.com>
	<87625h3tl1.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87625h3tl1.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Rik van Riel <riel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 08, 2012 at 09:32:18AM +1030, Rusty Russell wrote:
> The first one can be delayed, the second one can be delayed if the host
> didn't ask for VIRTIO_BALLOON_F_MUST_TELL_HOST (qemu doesn't).
> 
> We could implement a proper request queue for these, and return -EAGAIN
> if the queue fills.  Though in practice, it's not important (it might
> help performance).

I liked the idea. Give me the directions to accomplish it and I'll give it a try
for sure.
