From: Dmitry Vyukov via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH 0/3] virtio/vringh: kill off ACCESS_ONCE()
Date: Fri, 25 Nov 2016 16:21:39 +0100
Message-ID: <CACT4Y+ZpzFhmSqOG+dG7QHSNObWatLOjPjNK2BznnRLeRQpF8A__25502.3170299411$1480112104$gmane$org@mail.gmail.com>
References: <1479983114-17190-1-git-send-email-mark.rutland@arm.com>
	<20161124222357-mutt-send-email-mst@kernel.org>
	<20161125112203.GA26611@leverpostej>
	<32dfca07-59f3-b75a-3154-cf6b6c8538f0@de.ibm.com>
	<20161125122356.GB26611@leverpostej>
	<20161125124044.GN3092@twins.programming.kicks-ass.net>
	<20161125124404.GI3174@twins.programming.kicks-ass.net>
	<20161125145512.GA4014@Boquns-MacBook-Pro.local>
Reply-To: Dmitry Vyukov <dvyukov@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20161125145512.GA4014@Boquns-MacBook-Pro.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Davidlohr Bueso <dave@stgolabs.net>, KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>, netdev <netdev@vger.kernel.org>, dbueso@suse.de, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Paul McKenney <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Nov 25, 2016 at 3:56 PM, Boqun Feng <boqun.feng@gmail.com> wrote:
> On Fri, Nov 25, 2016 at 01:44:04PM +0100, Peter Zijlstra wrote:
>> On Fri, Nov 25, 2016 at 01:40:44PM +0100, Peter Zijlstra wrote:
>> > #define SINGLE_LOAD(x)                                              \
>> > {(                                                          \
>> >     compiletime_assert_atomic_type(typeof(x));              \
>>
>> Should be:
>>
>>       compiletime_assert_atomic_type(x);
>>
>> >     WARN_SINGLE_COPY_ALIGNMENT(&(x));                       \
>
> Do we need to worry about the side effect on x? Maybe
>
> #define SINGLE_LOAD(x)                                  \
> ({                                                      \
>         typeof(x) *_____ptr;                            \
>                                                         \
>         compiletime_assert_atomic_type(typeof(x));      \
>                                                         \
>         _____ptr = &(x);                                \
>                                                         \
>         WARN_SINGLE_COPY_ALIGNMENT(_____ptr);           \
>                                                         \
>         READ_ONCE(*_____ptr);                           \
> })
>
> Ditto for SINGLE_STORE()
>
> Regards,
> Boqun
>
>> >     READ_ONCE(x);                                           \
>> > })
>> >
>> > #define SINGLE_STORE(x, v)                                  \
>> > ({                                                          \
>> >     compiletime_assert_atomic_type(typeof(x));              \
>>
>> idem
>>
>> >     WARN_SINGLE_COPY_ALIGNMENT(&(x));                       \
>> >     WRITE_ONCE(x, v);                                       \
>> > })


READ/WRITE_ONCE imply atomicity. Even if their names don't spell it (a
function name doesn't have to spell all of its guarantees). Most of
the uses of READ/WRITE_ONCE will be broken if they are not atomic.
"Read once but not necessary atomically" is a very subtle primitive
which is very easy to misuse. What are use cases for such primitive
that won't be OK with "read once _and_ atomically"? Copy to/from user
is obviously one such case, but it is already handled specially.
