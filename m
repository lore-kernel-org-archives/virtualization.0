From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/2] virtio: console: Wake up outvq on host notifications
Date: Mon, 31 Jan 2011 20:33:15 +1030
Message-ID: <201101312033.15623.rusty@rustcorp.com.au>
References: <eb504880dbb2b70d51c62a63012b69408b80d070.1296459389.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <eb504880dbb2b70d51c62a63012b69408b80d070.1296459389.git.amit.shah@redhat.com>
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
Cc: Hans de Goede <hdegoede@redhat.com>, stable@kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 31 Jan 2011 06:06:36 pm Amit Shah wrote:
> The outvq needs to be woken up on host notifications so that buffers
> consumed by the host can be reclaimed, outvq freed, and application
> writes may proceed again.
> 
> The need for this is now finally noticed when I have qemu patches ready
> to use nonblocking IO and flow control.

What about -stable?

Thanks,
Rusty.
