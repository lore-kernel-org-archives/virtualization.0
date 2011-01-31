From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 1/2] virtio: console: Wake up outvq on host notifications
Date: Mon, 31 Jan 2011 15:58:06 +0530
Message-ID: <20110131102806.GA9982__5871.00072666562$1296470574$gmane$org@amit-x200.redhat.com>
References: <eb504880dbb2b70d51c62a63012b69408b80d070.1296459389.git.amit.shah@redhat.com>
	<201101312033.15623.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201101312033.15623.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Hans de Goede <hdegoede@redhat.com>, stable@kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On (Mon) Jan 31 2011 [20:33:15], Rusty Russell wrote:
> On Mon, 31 Jan 2011 06:06:36 pm Amit Shah wrote:
> > The outvq needs to be woken up on host notifications so that buffers
> > consumed by the host can be reclaimed, outvq freed, and application
> > writes may proceed again.
> > 
> > The need for this is now finally noticed when I have qemu patches ready
> > to use nonblocking IO and flow control.
> 
> What about -stable?

Yes, it's needed (I added the CC: stable@kernel.org tag -- that should
be enough, right?)

Thanks,
		Amit
