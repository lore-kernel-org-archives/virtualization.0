From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC 1/4] include/linux/compiler*.h: fix OPTIMIZER_HIDE_VAR
Date: Wed, 9 Jan 2019 09:50:11 -0500
Message-ID: <20190109094959-mutt-send-email-mst__6763.09315390444$1547045327$gmane$org@kernel.org>
References: <20190102205715.14054-1-mst@redhat.com>
	<20190102205715.14054-2-mst@redhat.com>
	<CAKwvOdk3b6mnpTEEyY-JFrej8K12w9oTMLqi7q5aNiRMyJo6Ow@mail.gmail.com>
	<CANiq72nEiw8+cZNnBOwF1ehv232ZJe5qzhdbaTEg0rOoV2p4sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CANiq72nEiw8+cZNnBOwF1ehv232ZJe5qzhdbaTEg0rOoV2p4sg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, Peter Zijlstra <peterz@infradead.org>, Akira Yokosawa <akiyks@gmail.com>, Will Deacon <will.deacon@arm.com>, virtualization@lists.linux-foundation.org, David Howells <dhowells@redhat.com>, linux-arch@vger.kernel.org, linux-sparse@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Boqun Feng <boqun.feng@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Nicholas Piggin <npiggin@gmail.com>, Luc Maranget <luc.maranget@inria.fr>, Eli Friedman <efriedma@codeaurora.org>, Jade Alglave <j.alglave@ucl.ac.uk>, Network Development <netdev@vger.kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, LKML <linux-kernel@vger.kernel.org>, Eric Christopher <echristo@google.com>, Joe Perches <joe@perches.com>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.van>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 09, 2019 at 11:35:52AM +0100, Miguel Ojeda wrote:
> On Tue, Jan 8, 2019 at 6:44 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > Also for more context, see:
> > commit 7829fb09a2b4 ("lib: make memzero_explicit more robust against
> > dead store elimination")
> 
> By the way, shouldn't that barrier_data() be directly in compiler.h
> too, since it is for both gcc & clang?
> 
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > + Miguel
> > Miguel, would you mind taking this into your compiler-attributes tree?
> 
> Sure, at least we get quickly some linux-next time.
> 
> Note it would be nice to separate the patch into two (one for the
> comments, another for OPTIMIZER_HIDE_VAR), and also possibly another
> for barrier_data().
> 
> Cheers,
> Miguel

Okay, I will try.

-- 
MST
