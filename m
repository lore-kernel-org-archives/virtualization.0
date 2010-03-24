From: Amit Shah <amit.shah@redhat.com>
Subject: Problem with multiple hvc consoles via virtio-console
Date: Wed, 24 Mar 2010 21:04:08 +0530
Message-ID: <20100324153408.GB18581__8752.42532133616$1269445150$gmane$org@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hello,

When multiple hvc console ports are initialised and used via the
virtio_console driver, I can interact with only the first console, the
2nd one doesn't respond.

If I call hvc_kick() even if hvc_poll() returns 0, the 2nd console
becomes responsive.

I've checked that hvc_poll() receives data via get_chars() and feeds it
to tty_insert_flip_char().

Any idea what could be going wrong? This is reproducible on Linus' git
kernel as the guest kernel with the qemu.git repo.

Any pointers?

Thanks,
		Amit
