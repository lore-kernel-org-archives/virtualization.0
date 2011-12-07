From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH v4 12/12] virtio: balloon: Add freeze, restore handlers
	to support S4
Date: Wed, 7 Dec 2011 10:20:48 +0530
Message-ID: <20111207045048.GA9371@amit-x200.redhat.com>
References: <cover.1323199985.git.amit.shah@redhat.com>
	<5deccc36afa59032f0e3b10a653773bad511f303.1323199985.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5deccc36afa59032f0e3b10a653773bad511f303.1323199985.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Virtualization List <virtualization@lists.linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, levinsasha928@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On (Wed) 07 Dec 2011 [01:18:50], Amit Shah wrote:

[snip]

> Now to not race with a host issuing ballooning requests while we are in
> the process of freezing, we just exit from the vballoon kthread when the
> processes are asked to freeze.  Upon thaw and restore, we re-start the
> thread.

Actually this isn't necessary.  I over-zealously killed the thread
when it's not really necessary: the thread is frozen before calling
the freeze() callback and is thawed only after the restore() or thaw()
callbacks are done, so we're exactly in the same state with or without
keeping the kthread around (just that the PID of the kthread will
change).  So I'll back out this change for the next revision.


		Amit
