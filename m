From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] virtio_console: correct error message on failure of
	debugfs_create_dir
Date: Mon, 24 Dec 2012 10:43:12 -0800
Message-ID: <20121224184312.GA15597@kroah.com>
References: <1356030701-16284-1-git-send-email-sasha.levin@oracle.com>
	<1356030701-16284-13-git-send-email-sasha.levin@oracle.com>
	<20121221075909.GA15739@amit.redhat.com>
	<201212241155.46866.arnd@arndb.de>
	<20121224173937.GB14754@kroah.com>
	<CA+1xoqdd3DN6ApCnQh=8fQBvFh40O2BJPf4mAA_L17cRH8kShQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CA+1xoqdd3DN6ApCnQh=8fQBvFh40O2BJPf4mAA_L17cRH8kShQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sasha Levin <levinsasha928@gmail.com>
Cc: Amit Shah <amit.shah@redhat.com>, Sasha Levin <sasha.levin@oracle.com>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Dec 24, 2012 at 01:24:52PM -0500, Sasha Levin wrote:
> On Mon, Dec 24, 2012 at 12:39 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Mon, Dec 24, 2012 at 11:55:46AM +0000, Arnd Bergmann wrote:
> >> On Friday 21 December 2012, Amit Shah wrote:
> >> > On (Thu) 20 Dec 2012 [14:11:21], Sasha Levin wrote:
> >> > > debugfs_create_dir() returns NULL if it fails, there's little point in
> >> > > calling PTR_ERR on it.
> >> >
> >> > debugfs_create_dir() does return an error value if debugfs is not
> >> > enabled.
> >> >
> >> > This check for !pdrvdata.debugfs_dir should infact use
> >> > IS_ERR_OR_NULL().  Care to submit a patch for that?
> >>
> >> How about we fix the stub instead to return NULL when debugfs is disabled?
> >
> > No, please read debugfs.h for why I decided to not do this (i.e. we try
> > to learn from our mistakes...)
> 
> Why won't we fix it the other way around and return an actual error
> code instead of a NULL on failure?

Again, no, that doesn't make your code simpler/faster.  You really don't
need to check the return value of debugfs, just handle it as if it
always works, and look, the code handles it all properly, no matter if
debugfs is enabled or not.  It's only debugging code, you shouldn't
really care if it is present or not, right?

If you do, perhaps you shouldn't be using debugfs?

greg k-h
