From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PULL] vhost: cleanups and fixes
Date: Fri, 2 Nov 2018 14:12:37 -0400
Message-ID: <20181102141040-mutt-send-email-mst__14547.024414833$1541182251$gmane$org@kernel.org>
References: <20181101171938-mutt-send-email-mst@kernel.org>
	<CAGXu5jJ0HgV2qN=wohEgro6ixqXHOHBTsvS5a9Dcpz8gxVo3bA@mail.gmail.com>
	<CAHk-=wicvws38JqzVF6oNEZ0jGzP6RecR6yAGtyzX3AkoJ321g@mail.gmail.com>
	<20181102114635.hi3q53kzmz4qljsf@lakrids.cambridge.arm.com>
	<20181102083018-mutt-send-email-mst@kernel.org>
	<CAHk-=wh_bQK5zs+CwQ5eyodq4sQT0eOPp60qzvVL2_EtgETP-g@mail.gmail.com>
	<20181102122937-mutt-send-email-mst@kernel.org>
	<CAHk-=wibzqo7C+mS+BgZxRbgdWe2w5F39EhuFUhZUxvotoGLuA@mail.gmail.com>
	<20181102131334-mutt-send-email-mst@kernel.org>
	<CAHk-=wjAvx_rWKct5RtqRrVEgNxrFF=1qQwkz+AegDvd4yXW=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAHk-=wjAvx_rWKct5RtqRrVEgNxrFF=1qQwkz+AegDvd4yXW=g@mail.gmail.com>
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

On Fri, Nov 02, 2018 at 11:02:35AM -0700, Linus Torvalds wrote:
> On Fri, Nov 2, 2018 at 10:21 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > it seems that it depends on current not on the active mm.
> 
> Yes, see my other suggestion to just fix "use_mm()" to update the address range.
> 
> Would you mind testing that?

Sure, I'll test it.

> Because that would seem to be the *much* less error-prone model..
> 
>            Linus

I agree, it's always been bothering me.

-- 
MST
