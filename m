From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/3] virtio/vringh: kill off ACCESS_ONCE()
Date: Fri, 25 Nov 2016 18:07:03 +0000
Message-ID: <20161125180649.GC30811__2955.43580218709$1480112187$gmane$org@leverpostej>
References: <32dfca07-59f3-b75a-3154-cf6b6c8538f0@de.ibm.com>
	<20161125122356.GB26611@leverpostej>
	<20161125124044.GN3092@twins.programming.kicks-ass.net>
	<20161125124404.GI3174@twins.programming.kicks-ass.net>
	<20161125145512.GA4014@Boquns-MacBook-Pro.local>
	<CACT4Y+ZpzFhmSqOG+dG7QHSNObWatLOjPjNK2BznnRLeRQpF8A@mail.gmail.com>
	<20161125161004.GA30181@leverpostej>
	<20161125161709.GQ3092@twins.programming.kicks-ass.net>
	<CACT4Y+YJUUjU_FCR1FOcF2DmkkcjiRFpnU7Q4=yzbgvKv0VhyQ@mail.gmail.com>
	<CA+55aFwpUxwdgKdbwfSW59VzPCJojNg7aqBdWio5MM6RJnG5Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFwpUxwdgKdbwfSW59VzPCJojNg7aqBdWio5MM6RJnG5Uw@mail.gmail.com>
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
Cc: Davidlohr Bueso <dave@stgolabs.net>, KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>, netdev <netdev@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Davidlohr Bueso <dbueso@suse.de>, LKML <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Dmitry Vyukov <dvyukov@google.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Nov 25, 2016 at 09:52:50AM -0800, Linus Torvalds wrote:
> READ/WRITE_ONCE() are atomic *WHEN*THAT*IS*POSSIBLE*.

> But sometimes it's not going to be atomic.

That's the problem.

Common code may rely on something being atomic when that's only true on
a subset of platforms. On others, it's silently "fixed" into something
that isn't atomic, and we get no diagnostic. The bug lurks beneath the
surface.

Thanks,
Mark.
