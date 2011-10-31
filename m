From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 0/8] virtio: console: Fixes, cleanups, stats for bytes
	transferred
Date: Mon, 31 Oct 2011 15:49:40 +0530
Message-ID: <20111031101940.GC3557@amit-x200.redhat.com>
References: <cover.1315985553.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1315985553.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Juan Quintela <quintela@redhat.com>, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On (Wed) 14 Sep 2011 [13:06:38], Amit Shah wrote:
> Hello,
> 
> These patches are mostly cleanups (patches 1, 4, 5, 6, 7).  Patches 2
> and 3 fix cases which will be exposed when S4 support is enabled.
> 
> Patch 8 adds stats for bytes received, sent and discarded for each
> port.  These are added for debugging data loss issues (rather,
> pointing out they don't exist).  Closing a port while data transfer is
> ongoing resulted in discarding of any pending data in the vq, which is
> the expected case.  Adding these stats just helps showing there's no
> data loss, but things are working as they were designed.
> 
> Please apply.

Hey Rusty,

Can you push this series to Linus for 3.2?  Thanks!

		Amit
