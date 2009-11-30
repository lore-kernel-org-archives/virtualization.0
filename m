From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 07/28] virtio: console: don't assume a single console port.
Date: Mon, 30 Nov 2009 11:12:39 +0530
Message-ID: <20091130054239.GA25052@amit-x200.redhat.com>
References: <1259391051-7752-1-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-7-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-8-git-send-email-amit.shah@redhat.com>
	<200911301220.02346.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200911301220.02346.rusty@rustcorp.com.au>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Mon) Nov 30 2009 [12:20:02], Rusty Russell wrote:
> On Sat, 28 Nov 2009 05:20:30 pm Amit Shah wrote:
> > Keep a list of all ports being used as a console, and provide a lock
> > and a lookup function.  The hvc callbacks only give us a vterm number,
> > so we need to map this.
> 
> OK, I think we can do better than this.
> 
> How about we introduce a 'struct console_port', like so:
> 
> 	/* A port which is used as a console. */
> 	struct console_port {
> 		struct port port;
> 
> 		u32 vtermno;
> 		struct list_head list;
> 	};
> 
> 	static DEFINE_SPINLOCK(console_lock);
> 	static LIST_HEAD(consoles);

I tried to keep your patches close to the ones you sent -- I make a
change similar to this in patch 14. I can fold the two into one,
obviously.

(I'll wait for comments to the other patches in the series before
sending out a new respin.)

Thanks!
		Amit
