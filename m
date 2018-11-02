From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PULL] vhost: cleanups and fixes
Date: Fri, 2 Nov 2018 09:14:51 -0700
Message-ID: <CAHk-=wh_bQK5zs+CwQ5eyodq4sQT0eOPp60qzvVL2_EtgETP-g__18143.2555233643$1541175192$gmane$org@mail.gmail.com>
References: <20181101171938-mutt-send-email-mst@kernel.org>
	<CAGXu5jJ0HgV2qN=wohEgro6ixqXHOHBTsvS5a9Dcpz8gxVo3bA@mail.gmail.com>
	<CAHk-=wicvws38JqzVF6oNEZ0jGzP6RecR6yAGtyzX3AkoJ321g@mail.gmail.com>
	<20181102114635.hi3q53kzmz4qljsf@lakrids.cambridge.arm.com>
	<20181102083018-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181102083018-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: mark.rutland@arm.com, lenaic@lhuard.fr, mhocko@suse.com, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, netdev@vger.kernel.org, liang.z.li@intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, stefanha@redhat.com, joe@perches.com, Andrew Morton <akpm@linux-foundation.org>, mhocko@kernel.org, bijan.mottahedeh@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Nov 2, 2018 at 6:04 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> I've tried making access_ok mask the parameter it gets.

PLEASE don't do this.

Just use "copy_to/from_user()".

We have had lots of bugs because code bitrots.

And no, the access_ok() checks aren't expensive, not even in a loop.
They *used* to be somewhat expensive compared to the access, but that
simply isn't true any more. The real expense in copy_to_user and
friends are in the user access bit setting (STAC and CLAC on x86),
which easily an order of magnitude more expensive than access_ok().

So just get rid of the double-underscore version. It's basically
always a mis-optimization due to entirely historical reasons. I can
pretty much guarantee that it's not visible in profiles.

                  Linus
