From: Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v12 4/7] mm: introduce compaction and migration for
	ballooned pages
Date: Sat, 17 Nov 2012 19:54:35 -0200
Message-ID: <20121117215434.GA23879__49212.8204125494$1353189313$gmane$org@x61.redhat.com>
References: <cover.1352656285.git.aquini@redhat.com>
	<6602296b38c073a5c6faa13ddbc74ceb1eceb2dd.1352656285.git.aquini@redhat.com>
	<50A7D0FA.2080709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <50A7D0FA.2080709@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sasha Levin <levinsasha928@gmail.com>
Cc: Rik van Riel <riel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Nov 17, 2012 at 01:01:30PM -0500, Sasha Levin wrote:
> 
> I'm getting the following while fuzzing using trinity inside a KVM tools guest,
> on latest -next:
> 
> [ 1642.783728] BUG: unable to handle kernel NULL pointer dereference at 0000000000000194
> [ 1642.785083] IP: [<ffffffff8122b354>] isolate_migratepages_range+0x344/0x7b0
> 
> My guess is that we see those because of a race during the check in
> isolate_migratepages_range().
> 
> 
> Thanks,
> Sasha

Sasha, could you share your .config and steps you did used with trinity? So I
can attempt to reproduce this issue you reported.

Thanks, 
Rafael
