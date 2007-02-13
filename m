From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 7/8] lguest: trivial guest block driver
Date: Tue, 13 Feb 2007 11:25:05 +1100
Message-ID: <1171326305.19842.36.camel@localhost.localdomain>
References: <1171251965.10409.28.camel@localhost.localdomain>
	<1171252113.10409.30.camel@localhost.localdomain>
	<1171252219.10409.33.camel@localhost.localdomain>
	<1171252321.10409.36.camel@localhost.localdomain>
	<1171252405.10409.39.camel@localhost.localdomain>
	<1171252474.10409.42.camel@localhost.localdomain>
	<20070212044339.GJ3685@kernel.dk>
	<1171258034.10409.54.camel@localhost.localdomain>
	<20070212053204.GB3999@kernel.dk>
	<1171264167.10409.62.camel@localhost.localdomain>
	<20070212150125.GM3999@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070212150125.GM3999@kernel.dk>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: virtualization <virtualization@lists.osdl.org>, Andrew Morton <akpm@linux-foundation.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2007-02-12 at 16:01 +0100, Jens Axboe wrote:
> On Mon, Feb 12 2007, Rusty Russell wrote:
> > Thanks Jens!!
> =

> My pleasure, it's not often you get to make that big a performance
> improvement with just a little few lines of change :-)

*cough* I deliberately leave these low hanging fruit in lguest to
encourage people to hack on it.  Really.  *cough*

> I guess you'll take changes to make this driver queuing as well? It's
> pretty important for good guest io performance as well.

The question is whether the guest or host should queue.  If you have
multiple guests sharing a disk in the hose, I would think that the host
is better off queuing.  And this would seem to be the common case.

On my todo list is:
1) Implement write barriers, (-> fsync in the host)
2) Make the host userspace program (lguest) async rather than blocking,
3) Allow multiple outstanding requests.

Then it should be useful for other hypervisors.

Cheers!
Rusty.
