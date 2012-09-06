From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-blk: Fix kconfig option
Date: Fri, 07 Sep 2012 09:10:25 +0930
Message-ID: <87zk52hg9i.fsf@rustcorp.com.au>
References: <20120903044133.GA9980@moria.home.lan>
	<87wr0ae26e.fsf@rustcorp.com.au>
	<20120906074113.GA5902@koverstreet-glaptop>
	<20120906084403.GD17656@redhat.com>
	<20120906092512.GB5902@koverstreet-glaptop>
	<20120906094956.GB22816@redhat.com>
	<20120906100247.GA27355@koverstreet-glaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120906100247.GA27355@koverstreet-glaptop>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Kent Overstreet <koverstreet@google.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Kent Overstreet <koverstreet@google.com> writes:

> On Thu, Sep 06, 2012 at 12:49:56PM +0300, Michael S. Tsirkin wrote:
>> On Thu, Sep 06, 2012 at 02:25:12AM -0700, Kent Overstreet wrote:
>> > Do you not understand the difference between depends an selects?
>> > Or did you not read my original mail?

Now you're getting insulting.

It's normal for options to depend on other options.  Sometimes they're
directly nested (eg. E1000 depends on NETDEVICES, and it's nested under
that option), sometimes they're not (eg. E1000 depends on PCI, which is
selected elsewhere).

The fact that you are only just realizing this is not Michael's problem.

>> > Flip off everything in drivers -> virtio
>> > 
>> > Now go to drivers -> block and try to turn on virtio-blk.
>> > 
>> > It's not listed!
>> 
>> Yes. Because you disabled all virtio backends.
>> It does not make sense to have any frontends.
>
> How's a user - or even another kernel developer who isn't familiar with
> virtio - supposed to know that?

I get annoyed that menuconfig doesn't show options whose dependencies
aren't possible, too.  (I got bitten the other way: it doesn't show
dependencies which can't be disabled, and I was trying to turn KALLSYMS
off).

But as I found out just last week, the '/' key allows you to find any
option, and shows what dependencies it has, and their values.

Hope that helps,
Rusty.
