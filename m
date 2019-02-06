From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/6] vmw_balloon: 64-bit limit support, compaction,
	shrinker
Date: Wed, 6 Feb 2019 12:52:00 -0500
Message-ID: <20190206124926-mutt-send-email-mst__16491.5923307248$1549475561$gmane$org@kernel.org>
References: <20190206051336.2425-1-namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190206051336.2425-1-namit@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nadav Amit <namit@vmware.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Julien Freche <jfreche@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 05, 2019 at 09:13:30PM -0800, Nadav Amit wrote:
> Various enhancements for VMware balloon, some of which are remainder
> from a previous patch-set.
> 
> Patch 1: Aumps the version number, following recent changes
> Patch 2: Adds support for 64-bit memory limit
> Patches 3-4: Support for compaction
> Patch 5: Support for memory shrinker - disabled by default
> Patch 6: Split refused pages to improve performance
> 
> Since the 3rd patch requires Michael Tsirkin ack, which has not arrived
> in the last couple of times the patch was sent, please consider applying
> patches 1-2 for 5.1.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: linux-mm@kvack.org
> Cc: virtualization@lists.linux-foundation.org


I don't seem to have got anything except patch 0 either directly
or through virtualization@lists.linux-foundation.org
Could you bounce the relevant patches there?

Thanks!

> Nadav Amit (5):
>   vmw_balloon: bump version number
>   mm/balloon_compaction: list interfaces
>   vmw_balloon: compaction support
>   vmw_balloon: add memory shrinker
>   vmw_balloon: split refused pages
> 
> Xavier Deguillard (1):
>   vmw_balloon: support 64-bit memory limit
> 
>  drivers/misc/Kconfig               |   1 +
>  drivers/misc/vmw_balloon.c         | 511 ++++++++++++++++++++++++++---
>  include/linux/balloon_compaction.h |   4 +
>  mm/balloon_compaction.c            | 139 +++++---
>  4 files changed, 566 insertions(+), 89 deletions(-)
> 
> -- 
> 2.17.1
