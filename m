From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 0/8] virtio: console: Fixes, cleanups,
	stats for bytes transferred
Date: Tue, 01 Nov 2011 10:27:44 +1030
Message-ID: <8739e8ww7b.fsf@rustcorp.com.au>
References: <cover.1315985553.git.amit.shah@redhat.com>
	<20111031101940.GC3557@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111031101940.GC3557@amit-x200.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 31 Oct 2011 15:49:40 +0530, Amit Shah <amit.shah@redhat.com> wrote:
> On (Wed) 14 Sep 2011 [13:06:38], Amit Shah wrote:
> > Hello,
> > 
> > These patches are mostly cleanups (patches 1, 4, 5, 6, 7).  Patches 2
> > and 3 fix cases which will be exposed when S4 support is enabled.
> > 
> > Patch 8 adds stats for bytes received, sent and discarded for each
> > port.  These are added for debugging data loss issues (rather,
> > pointing out they don't exist).  Closing a port while data transfer is
> > ongoing resulted in discarding of any pending data in the vq, which is
> > the expected case.  Adding these stats just helps showing there's no
> > data loss, but things are working as they were designed.
> > 
> > Please apply.
> 
> Hey Rusty,
> 
> Can you push this series to Linus for 3.2?  Thanks!

Yep, was going to do it yesterday but spent the day chasing console
breakage in lguest, but it's not caused by these.

Thanks,
Rusty.
