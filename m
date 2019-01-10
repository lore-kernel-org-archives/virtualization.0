From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH RFC 1/4] include/linux/compiler*.h: fix OPTIMIZER_HIDE_VAR
Date: Thu, 10 Jan 2019 16:41:39 +0300
Message-ID: <20190110134139.GE1743__18430.3254624412$1547127651$gmane$org@kadam>
References: <20190102205715.14054-1-mst@redhat.com>
	<20190102205715.14054-2-mst@redhat.com>
	<CAKwvOdk3b6mnpTEEyY-JFrej8K12w9oTMLqi7q5aNiRMyJo6Ow@mail.gmail.com>
	<CANiq72nEiw8+cZNnBOwF1ehv232ZJe5qzhdbaTEg0rOoV2p4sg@mail.gmail.com>
	<20190109213543-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190109213543-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, Peter Zijlstra <peterz@infradead.org>, Akira Yokosawa <akiyks@gmail.com>, Will Deacon <will.deacon@arm.com>, virtualization@lists.linux-foundation.org, David Howells <dhowells@redhat.com>, linux-arch@vger.kernel.org, linux-sparse@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Boqun Feng <boqun.feng@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Nicholas Piggin <npiggin@gmail.com>, Luc Maranget <luc.maranget@inria.fr>, Eli Friedman <efriedma@codeaurora.org>, Jade Alglave <j.alglave@ucl.ac.uk>, Network Development <netdev@vger.kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, LKML <linux-kernel@vger.kernel.org>, Eric Christopher <echristo@google.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Joe Perches <joe@perches.com>, Linus Torvalds <torvalds@l>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 09, 2019 at 09:36:41PM -0500, Michael S. Tsirkin wrote:
> On Wed, Jan 09, 2019 at 11:35:52AM +0100, Miguel Ojeda wrote:
> > On Tue, Jan 8, 2019 at 6:44 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> > >
> > > Also for more context, see:
> > > commit 7829fb09a2b4 ("lib: make memzero_explicit more robust against
> > > dead store elimination")
> > 
> > By the way, shouldn't that barrier_data() be directly in compiler.h
> > too, since it is for both gcc & clang?
> > 
> > > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > >
> > > + Miguel
> > > Miguel, would you mind taking this into your compiler-attributes tree?
> > 
> > Sure, at least we get quickly some linux-next time.
> 
> 
> BTW why linux-next? shouldn't this go into 5.0 and stable? It's a bugfix after all.
> 

It doesn't hurt to put things in linux-next for a week and then 5.0 and
-stable.  Not a lot of testing happens on linux-next, but some does.

regards,
dan carpenter
