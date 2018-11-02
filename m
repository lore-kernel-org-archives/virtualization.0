From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PULL] vhost: cleanups and fixes
Date: Fri, 2 Nov 2018 10:15:56 -0700
Message-ID: <CAHk-=wj5ZnqmpDuXBCcND8nMNitNyRf_4KQSzSUfQvX2-wOYsg__34621.032459154$1541179301$gmane$org@mail.gmail.com>
References: <20181101171938-mutt-send-email-mst@kernel.org>
	<CAGXu5jJ0HgV2qN=wohEgro6ixqXHOHBTsvS5a9Dcpz8gxVo3bA@mail.gmail.com>
	<CAHk-=wicvws38JqzVF6oNEZ0jGzP6RecR6yAGtyzX3AkoJ321g@mail.gmail.com>
	<20181102114635.hi3q53kzmz4qljsf@lakrids.cambridge.arm.com>
	<20181102083018-mutt-send-email-mst@kernel.org>
	<CAHk-=wh_bQK5zs+CwQ5eyodq4sQT0eOPp60qzvVL2_EtgETP-g@mail.gmail.com>
	<20181102122937-mutt-send-email-mst@kernel.org>
	<CAHk-=wibzqo7C+mS+BgZxRbgdWe2w5F39EhuFUhZUxvotoGLuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAHk-=wibzqo7C+mS+BgZxRbgdWe2w5F39EhuFUhZUxvotoGLuA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, Al Viro <viro@zeniv.linux.org.uk>
Cc: mark.rutland@arm.com, lenaic@lhuard.fr, mhocko@suse.com, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, netdev@vger.kernel.org, liang.z.li@intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, stefanha@redhat.com, joe@perches.com, Andrew Morton <akpm@linux-foundation.org>, mhocko@kernel.org, bijan.mottahedeh@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Nov 2, 2018 at 10:10 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Don't you take over the VM with "use_mm()" when you do the copies? So
> yes, it's a kernel thread, but it has a user VM, and though that
> should have the user limits.

Oooh. *Just* as I sent this, I realized that "use_mm()" doesn't update
the thread addr_limit.

That actually looks like a bug to me - although one that you've
apparently been aware of and worked around.

Wouldn't it be nicer to just make "use_mm()" do

        set_fs(USER_DS);

instead? And undo it on unuse_mm()?

And, in fact, maybe we should default kernel threads to have a zero
address limit, so that they can't do any user accesses at all without
doing this?

Adding Al to the cc, because I think he's been looking at set_fs() in general.

                  Linus
