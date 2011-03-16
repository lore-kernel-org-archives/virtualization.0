From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 0/2] Fix hot-unplug: device removal while port in use
Date: Wed, 16 Mar 2011 14:31:03 +1030
Message-ID: <877hbziuio.fsf@rustcorp.com.au>
References: <cover.1299054025.git.amit.shah@redhat.com>
	<20110311111628.GC8908@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110311111628.GC8908@amit-x200.redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>, Virtualization List <virtualization@lists.linux-foundation.org>
Cc: markmc@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 11 Mar 2011 16:46:28 +0530, Amit Shah <amit.shah@redhat.com> wrote:
> Ideally virtio_pci_release_dev() shouldn't be needed at all; all that
> work can be moved to virtio_pci_remove().  virtio_pci_release_dev()
> was added in 29f9f12e to curb a warning:
> 
>     virtio: add PCI device release() function
>     
>     Add a release() function for virtio_pci devices so as to avoid:
>     
>       Device 'virtio0' does not have a release() function, it is
>       broken and must be fixed
>     
> 
> So we could have an empty release() function that does nothing, and
> all of the current functionality be moved to virtio_pci_remove(), as
> it was earlier.  This should keep everyone happy.
> 
> Is that fine?

Greg K-H needs to be asked this question, I think.

Cheers,
Rusty.
