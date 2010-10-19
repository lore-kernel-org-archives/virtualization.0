From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH] virtio: console: Don't block entire guest if host
	doesn't read data
Date: Tue, 19 Oct 2010 13:02:16 +0530
Message-ID: <20101019073216.GA8896@amit-laptop.redhat.com>
References: <baecf865292e0cc96914d30fc601e3a96fad9845.1287467155.git.amit.shah@redhat.com>
	<4CBD40D4.9050106@redhat.com>
	<20101019071021.GB2505@amit-laptop.redhat.com>
	<4CBD4754.5030504@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4CBD4754.5030504@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: stable@kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On (Tue) Oct 19 2010 [09:23:00], Hans de Goede wrote:
> >>3) This patch will cause processes filling the virtqueue fast enough to block
> >>    to never wake up again, due to a missing waitqueue wakeup, see:
> >>    https://bugzilla.redhat.com/show_bug.cgi?id=643750
> >
> >Doesn't happen in my testcase, but this patch shouldn't cause that
> >problem if it exists -- it's a problem that exists even now for
> >nonblocking ports.  So if such a bug exists, it needs to be fixed
> >independently.
> 
> First of all lets agree that this is a real problem,

Sure, got a testcase for the test-virtserial or kvm-autotest projects?
;-)

I did try it and POLLOUT gets set for me immediately when I read one
buffer from the host.

> there is simply nothing
> waking the waitqueue were fops_write (or poll) block on when buffers become
> available in out_vq, it may be hard to come up with a test case which fills
> the queue fast enough to hit this scenario, but it is very real.

Not at all.

Connect guest
Connect host

On guest, check for POLLOUT.  As long as it's set, write buffers.
When POLLOUT goes off, read one buffer from host.  See if POLLOUT is set
again.

Also, as I mentioned in a private chat, the fix for that problem is easy
enough.

> I agree it is an independent problem, and should be fixed in a separate
> patch, but that patch should be part of the same set and become *before*
> this one, as this patch now extends the problem to ports opened in blocking
> mode too.

Strongly disagree.  This patch fixes a problem wherein blocking-mode
writes to a port freeze the entire guest.  That's a much uglier problem
to have than poll not indicating a port is writable again.

> BTW, many thanks for working on this, it is appreciated :)

Sure, thanks :-)

		Amit
