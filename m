From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PULL] vhost: cleanups and fixes
Date: Fri, 2 Nov 2018 12:59:40 -0400
Message-ID: <20181102122937-mutt-send-email-mst__41493.8629874543$1541177883$gmane$org@kernel.org>
References: <20181101171938-mutt-send-email-mst@kernel.org>
	<CAGXu5jJ0HgV2qN=wohEgro6ixqXHOHBTsvS5a9Dcpz8gxVo3bA@mail.gmail.com>
	<CAHk-=wicvws38JqzVF6oNEZ0jGzP6RecR6yAGtyzX3AkoJ321g@mail.gmail.com>
	<20181102114635.hi3q53kzmz4qljsf@lakrids.cambridge.arm.com>
	<20181102083018-mutt-send-email-mst@kernel.org>
	<CAHk-=wh_bQK5zs+CwQ5eyodq4sQT0eOPp60qzvVL2_EtgETP-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAHk-=wh_bQK5zs+CwQ5eyodq4sQT0eOPp60qzvVL2_EtgETP-g@mail.gmail.com>
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
Cc: mark.rutland@arm.com, lenaic@lhuard.fr, mhocko@suse.com, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, netdev@vger.kernel.org, liang.z.li@intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, stefanha@redhat.com, joe@perches.com, Andrew Morton <akpm@linux-foundation.org>, mhocko@kernel.org, bijan.mottahedeh@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Nov 02, 2018 at 09:14:51AM -0700, Linus Torvalds wrote:
> On Fri, Nov 2, 2018 at 6:04 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > I've tried making access_ok mask the parameter it gets.
> 
> PLEASE don't do this.

Okay.

> Just use "copy_to/from_user()".

Just for completeness I'd like to point out for vhost the copies are
done from the kernel thread.  So yes we can switch to copy_to/from_user
but for e.g. 32-bit userspace running on top of a 64 bit kernel it is
IIUC not sufficient - we must *also* do access_ok checks on control path
when addresses are passed to the kernel and when current points to the
correct task struct.

> We have had lots of bugs because code bitrots.

Yes, I wish we did not need these access_ok checks and could just rely
on copy_to/from_user.

> And no, the access_ok() checks aren't expensive, not even in a loop.
> They *used* to be somewhat expensive compared to the access, but that
> simply isn't true any more. The real expense in copy_to_user and
> friends are in the user access bit setting (STAC and CLAC on x86),
> which easily an order of magnitude more expensive than access_ok().
> 
> So just get rid of the double-underscore version. It's basically
> always a mis-optimization due to entirely historical reasons. I can
> pretty much guarantee that it's not visible in profiles.
> 
>                   Linus

OK. So maybe we should focus on switching to user_access_begin/end +
unsafe_get_user/unsafe_put_user in a loop which does seem to be
measureable.  That moves the barrier out of the loop, which seems to be
consistent with what you would expect.

-- 
MST
