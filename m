From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 07/28] virtio: console: don't assume a single console port.
Date: Mon, 30 Nov 2009 12:20:02 +1030
Message-ID: <200911301220.02346.rusty@rustcorp.com.au>
References: <1259391051-7752-1-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-7-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-8-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1259391051-7752-8-git-send-email-amit.shah@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 28 Nov 2009 05:20:30 pm Amit Shah wrote:
> Keep a list of all ports being used as a console, and provide a lock
> and a lookup function.  The hvc callbacks only give us a vterm number,
> so we need to map this.

OK, I think we can do better than this.

How about we introduce a 'struct console_port', like so:

	/* A port which is used as a console. */
	struct console_port {
		struct port port;

		u32 vtermno;
		struct list_head list;
	};

	static DEFINE_SPINLOCK(console_lock);
	static LIST_HEAD(consoles);

ie. now we have nicely partitioned off the console-specific parts, and
can use ->port and container_of() to get from this to a generic port and
vice-versa.

It will make allocations a little more complex, since we need to allocate
a 'struct console_port' or a 'struct port' depending on what we want, but the
rest should be significantly cleaner.

Thanks,
Rusty.
