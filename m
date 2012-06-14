From: Junio C Hamano <gitster@pobox.com>
Subject: Re: drivers/block/cpqarray.c:938:2: error: too many arguments to
	function =?utf-8?Q?=E6=85=B4lk=5Frq=5Fmap=5Fsg=EF=BF=BD?=
Date: Thu, 14 Jun 2012 10:26:20 -0700
Message-ID: <7vpq91erer.fsf__10828.048704616$1339827527$gmane$org@alter.siamese.dyndns.org>
References: <4fd91c3f.KAwMcygw9fFGn9Cx%wfg@linux.intel.com>
	<4FD984F3.3070502@kernel.dk> <20120614090151.GA12013@localhost>
	<4FD9A95D.40903@kernel.dk> <20120614092519.GA12482@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120614092519.GA12482@localhost> (Fengguang Wu's message of
	"Thu, 14 Jun 2012 17:25:19 +0800")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Fengguang Wu <wfg@linux.intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-raid@vger.kernel.org, "git@vger.kernel.org" <git@vger.kernel.org>, linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Fengguang Wu <wfg@linux.intel.com> writes:

> If we can somehow tag the whole branch, it would be most convenient.
> Git can add description to a branch with
>
>         git branch --edit-description [branch name]
>
> However I don't know how to retrieve that description on a remote
> branch..

The branch description is designed to be a place you leave your
temporary note locally outside the history, until you are ready to
set the contents of the branch in more permanent storage (e.g. by
merging it to an integration branch, or sending pull requests for
it) at which time the information is consumed (e.g. inserted in the
merge commit message or pull request message).  The history exchange
via "git push" / "git fetch" is by definition about exchanging the
history, and will not transfer branch descriptions.

For shared and more permanent notes, "git notes" may be more
suitable vehicle.
