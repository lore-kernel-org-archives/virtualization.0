From: "Richard W.M. Jones" <rjones@redhat.com>
Subject: Re: [Qemu-devel] Re: virtio-serial: An interface for host-guest
	communication
Date: Tue, 28 Jul 2009 15:00:29 +0100
Message-ID: <20090728140029.GA16067__41115.3955189095$1248789808$gmane$org@amd.home.annexia.org>
References: <1248717876-17630-1-git-send-email-amit.shah@redhat.com>
	<4A6E0C9E.10908@codemonkey.ws> <20090727203214.GG15020@redhat.com>
	<20090727204627.GA32432@shareable.org>
	<4A6E3BDC.8050101@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A6E3BDC.8050101@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Amit Shah <amit.shah@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 27, 2009 at 06:44:28PM -0500, Anthony Liguori wrote:
> It really suggests that you need _one_ vmchannel that's exposed to  
> userspace with a single userspace daemon that consumes it.

... or a more flexible API.  I don't like having fixed /dev/vmch*
devices either.

A long time ago (on a mailing list not so far away) there was a much
better userspace API proposed, which had a separate AF_VMCHANNEL
address family.

That API works much more like TCP sockets, except without requiring
network devices:

https://lists.linux-foundation.org/pipermail/virtualization/2008-December/012383.html

Note: even better if it allows multiple channels with the same name to
be created on demand from the guest, which the API would allow,
although not the implementation above.  That would allow the
fast-user-switching / multi-X-server case to work well, and be useful
if we parallelize libguestfs.

Rich.

-- 
Richard Jones, Emerging Technologies, Red Hat  http://et.redhat.com/~rjones
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://et.redhat.com/~rjones/virt-top
