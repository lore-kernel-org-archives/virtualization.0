From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/6] virtio-console: spec compliance fixes
Date: Sun, 6 May 2018 22:52:03 +0300
Message-ID: <20180506225142-mutt-send-email-mst__10962.7238744453$1525636226$gmane$org@kernel.org>
References: <1524248223-393618-1-git-send-email-mst@redhat.com>
	<20180424214104-mutt-send-email-mst@kernel.org>
	<20180503034529.GA16676@grmbl.mre>
	<20180503222702-mutt-send-email-mst@kernel.org>
	<20180506182430.GB19628@grmbl.mre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180506182430.GB19628@grmbl.mre>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit@amitshah.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, May 06, 2018 at 08:24:30PM +0200, Amit Shah wrote:
> On (Thu) 03 May 2018 [22:28:32], Michael S. Tsirkin wrote:
> > On Thu, May 03, 2018 at 05:45:29AM +0200, Amit Shah wrote:
> > > (apologies if you received a dup)
> > > 
> > > On (Tue) 24 Apr 2018 [21:41:29], Michael S. Tsirkin wrote:
> > > > On Fri, Apr 20, 2018 at 09:17:59PM +0300, Michael S. Tsirkin wrote:
> > > > > Turns out virtio console tries to take a buffer out of an active vq.
> > > > > Works by sheer luck, and is explicitly forbidden by spec.  And while
> > > > > going over it I saw that error handling is also broken -
> > > > > failure is easy to trigger if I force allocations to fail.
> > > > > 
> > > > > Lightly tested.
> > > > 
> > > > Amit - any feedback before I push these patches?
> > > 
> > > The changes look good spec-wise.
> > > 
> > > There are a bunch of tests in avocado-vt that test virtio-console
> > > functionality.  Can you give those a try before pushing?
> > > 
> > > 		Amit
> > 
> > I pushed before I did that test, will try to find the time later.  BTW
> > do you still want to be on the maintainers list?
> 
> Yes, I want to be on the maintainers list; but won't mind
> co-maintainers.  The recent changes seem to be spec-related, and I'd
> expect you to have a good handle on that anyway.
> 
> 		Amit

If you can do extra testing that would be appreciated though.

> -- 
> http://amitshah.net/
