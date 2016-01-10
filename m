From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/2] virtio_balloon: fix race between migration and
	ballooning
Date: Sun, 10 Jan 2016 23:40:17 +0200
Message-ID: <20160110233310-mutt-send-email-mst__30501.8597319306$1452462037$gmane$org@redhat.com>
References: <1451259313-26353-1-git-send-email-minchan@kernel.org>
	<1451259313-26353-2-git-send-email-minchan@kernel.org>
	<20160101102756-mutt-send-email-mst@redhat.com>
	<20160104002747.GA31090@blaptop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160104002747.GA31090@blaptop.local>
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
Cc: Rafael Aquini <aquini@redhat.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Konstantin Khlebnikov <koct9i@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jan 04, 2016 at 09:27:47AM +0900, Minchan Kim wrote:
> > I think this will cause deadlocks.
> > 
> > pages_lock now nests within page lock, balloon_page_putback
> > nests them in the reverse order.
> 
> In balloon_page_dequeu, we used trylock so I don't think it's
> deadlock.

I went over this again and I don't see the issue anymore.
I think I was mistaken, so I dropped my patch and picked
up yours. Sorry about the noise.


> > 
> > Also, there's another issue there I think: after isolation page could
> > also get freed before we try to lock it.
> 
> If a page was isolated, the page shouldn't stay b_dev_info->pages
> list so balloon_page_dequeue cannot see the page.
> Am I missing something?

I mean without locks, as it is now. With either your or my patch in
place, it's fine.

-- 
MST
