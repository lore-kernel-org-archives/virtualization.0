From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PULL] virtio: fixes, tests
Date: Wed, 27 Jan 2016 22:26:13 -0800
Message-ID: <xmqqd1sm5iey.fsf__42952.4631974802$1453962898$gmane$org@gitster.mtv.corp.google.com>
References: <20160127211216-mutt-send-email-mst@redhat.com>
	<CA+55aFzypP2SDdX7y8MpZGKhmLJot=UT4i328CYBcNQsP2VU+Q@mail.gmail.com>
	<20160128001448-mutt-send-email-mst@redhat.com>
	<CA+55aFzC6mopLkYYvuZNK8W510MpqgSuYwhjAAM-XeuAdEfs3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CA+55aFzC6mopLkYYvuZNK8W510MpqgSuYwhjAAM-XeuAdEfs3A@mail.gmail.com>
	(Linus Torvalds's message of "Wed, 27 Jan 2016 14:57:28 -0800")
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
Cc: jmarchan@redhat.com, KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Network Development <netdev@vger.kernel.org>, Kamal Mostafa <kamal@canonical.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Sasha Levin <sasha.levin@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, Jan 27, 2016 at 2:15 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>
>>> Anyway, pulled. Just curious about how that thing happened.
>>
>> That's because apparently diffstat obeys orderfile rules:
>
> Ugh. I guess that makes sense, but it's still very annoying for
> something like a pull request, where now different people end up
> having different diffstats. And the reason I never noticed it is that
> likely there aren't that many people who use an orderfile.
>
> I guess something like "-O /dev/null" in the pull-request would undo
> it, but it is a bit annoying.
>
> I've never actually met anybody (knowingly) that used that option. I
> thought it was a Junio-only use case (it's been around forever as a
> command line option, but the config file entry seems to be somewhat
> recent and I wasn't even aware of it).
>
> Adding Junio just as background to see what he thinks. Looks like the
> diff.orderfile config option hits not just porcelain, but plumbing
> too.

Note: without enough context, I am guessing that you are annoyed
that diffstat graph in a pull request did not match what you got
locally after pulling.

I've never actually met anybody who uses the orderfile, either.  And
I tend to agree that it probably is a mistake if the configuration
is not limited to diff_ui_config().

Wait.  It _is_ limited to diff_ui_config().  The thing is, "git
request-pull" does use the Porcelain "git diff" to emit the final
diffstat.  So there is nothing to fix in diff.c, at least ;-)

I am of two minds about the configuration affecting the output from
"git request-pull" command as a whole.  In a sense, "request-pull"
command itself _is_ a UI level thing, i.e. Porcelain, and if a
project chooses to standardize on a certain patch/diff presentation
order using the diff.orderfile facility, there should be a way to
tell your project participants to use the same order when they send
in their patches and their pull requests, but with the hardcoded
"git diff --stat" invocation at the end of "git request-pull", such
a per-project customization must happen via _some_ configuration
variable.  We _could_ make up request-pull.difforderfile that is
read by that script and gets turned into "-O $file" arguments to the
"git diff" invocation, but if projects really wants to standardize
on a single patch/diff presentation order, I do not think such a
split configuration buys us anything.  We'd be better off using a
single diff.orderfile and have it consistently honoured by tools
everybody who participates in the project uses.

You obviously can declare "With MY project, the standard order in
which you must present patch/diff is with this empty file", and tell
your project participants to set diff.orderfile to /dev/null in the
repository config when they work on the kernel.  That would be what
any such hypothetical project would do, when it has a specific
preference of the patch/diff presentation order.  After all, you do
have a specific preference, which is "do not futz with the order in
which Git gives the paths by default", so...
