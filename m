From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PULL] vhost: cleanups and fixes
Date: Fri, 2 Nov 2018 11:46:36 +0000
Message-ID: <20181102114635.hi3q53kzmz4qljsf__28043.7737158083$1541159097$gmane$org@lakrids.cambridge.arm.com>
References: <20181101171938-mutt-send-email-mst@kernel.org>
	<CAGXu5jJ0HgV2qN=wohEgro6ixqXHOHBTsvS5a9Dcpz8gxVo3bA@mail.gmail.com>
	<CAHk-=wicvws38JqzVF6oNEZ0jGzP6RecR6yAGtyzX3AkoJ321g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAHk-=wicvws38JqzVF6oNEZ0jGzP6RecR6yAGtyzX3AkoJ321g@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: lenaic@lhuard.fr, mhocko@suse.com, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, liang.z.li@intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, stefanha@redhat.com, joe@perches.com, Andrew Morton <akpm@linux-foundation.org>, mhocko@kernel.org, bijan.mottahedeh@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 01, 2018 at 04:06:19PM -0700, Linus Torvalds wrote:
> On Thu, Nov 1, 2018 at 4:00 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > +       memset(&rsp, 0, sizeof(rsp));
> > +       rsp.response = VIRTIO_SCSI_S_FUNCTION_REJECTED;
> > +       resp = vq->iov[out].iov_base;
> > +       ret = __copy_to_user(resp, &rsp, sizeof(rsp));
> >
> > Is it actually safe to trust that iov_base has passed an earlier
> > access_ok() check here? Why not just use copy_to_user() instead?
> 
> Good point.
> 
> We really should have removed those double-underscore things ages ago.

FWIW, on arm64 we always check/sanitize the user address as a result of
our sanitization of speculated values. Almost all of our uaccess
routines have an explicit access_ok().

All our uaccess routines mask the user pointer based on addr_limit,
which prevents speculative or architectural uaccess to kernel addresses
when addr_limit it USER_DS:

    4d8efc2d5ee4c9cc ("arm64: Use pointer masking to limit uaccess speculation")

We also inhibit speculative stores to addr_limit being forwarded under
speculation:

    c2f0ad4fc089cff8 ("arm64: uaccess: Prevent speculative use of the current addr_limit")

... and given all that, we folded explicit access_ok() checks into
__{get,put}_user():

    84624087dd7e3b48 ("arm64: uaccess: Don't bother eliding access_ok checks in __{get, put}_user")

IMO we could/should do the same for __copy_{to,from}_user().

Thanks,
Mark.
