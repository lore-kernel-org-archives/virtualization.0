From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/6] virtio: console: Fixes, abi update
Date: Sun, 21 Mar 2010 13:44:04 +0200
Message-ID: <20100321114404.GA12348@redhat.com>
References: <1269000408-29962-1-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1269000408-29962-1-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: quintela@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 19, 2010 at 05:36:42PM +0530, Amit Shah wrote:
> Hello,
> 
> These patches fix a couple of small issues: 
>  - generate a kobject change event so that udev is woken up on name
>    changes
>  - fix a crash after hot-unplug of the first console port and a
>    subsequent config update
> 
> But majorly, it reworks how ports are discovered: instead of numbering
> the ports individually in the host and the guest by just incrementing
> a number, we now switch to a bitmap in the config space exposed by the
> host to identify active ports. This lets us maintain the same
> numbering used by the host and also allows for hot-unplug via the
> config space. This is needed for proper migration support after
> several hot-plug/unplug operations.
> 
> I've tested these patches on my testsuite to catch any regression or
> correctness issues. I've also tested all the hotplug-related changes
> here.
> 
> These should go to 2.6.34, so that we don't push out a stable release
> with the older interface.
> 
> Michael, please forward these to Linus if
> everyone is OK with these.

I have some concerns with the new ABI.  I also expect Rusty to be back
in a couple of days, maybe he'll find some time to review the patches.
We'll also have to update the spec ...

Would you like me to queue up the first 2 patches meanwhile?

> I also have a git repo at
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/amit/vs-kernel.git master
> 
> if you prefer to pull the patches.
> Amit Shah (6):
>   virtio: console: Generate a kobject CHANGE event on adding 'name'
>     attribute
>   virtio: console: Check if port is valid in resize_console
>   virtio: console: Switch to using a port bitmap for port discovery
>   virtio: console: Separate out get_config in a separate function
>   virtio: console: Handle hot-plug/unplug config actions
>   virtio: console: Remove hot-unplug control message
> 
>  drivers/char/virtio_console.c  |  238 ++++++++++++++++++++++++----------------
>  include/linux/virtio_console.h |   15 ++-
>  2 files changed, 156 insertions(+), 97 deletions(-)
