From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH] xen-blkfront: use bitmap_set() and bitmap_clear()
Date: Fri, 20 Jan 2012 18:55:08 -0500
Message-ID: <20120120235508.GA17260@phenom.dumpdata.com>
References: <1327072528-8479-1-git-send-email-akinobu.mita@gmail.com>
	<1327072528-8479-4-git-send-email-akinobu.mita@gmail.com>
	<20120120152819.GA3959@phenom.dumpdata.com>
	<CAC5umyi9vuOh9Bx_HoB8ieXcVjZsisKOG6mCEM2ZGL7zXCrVTQ@mail.gmail.com>
	<20120120160938.GC3959@phenom.dumpdata.com>
	<20120120151149.04352aac.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120120151149.04352aac.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jeremy Fitzhardinge Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org, Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jan 20, 2012 at 03:11:49PM -0800, Andrew Morton wrote:
> On Fri, 20 Jan 2012 11:09:38 -0500
> Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> wrote:
> 
> > > 
> > > > Did you test this patch with a large amount of minors?
> > > 
> > > Sorry I didn't do runtime test.
> > 
> > Please do.
> 
> The poor guy probably doesn't know how to test it and surely it would
> be quite a lot of work for him to do so.
> 
> Overall, it would be much more efficient if the tester of this code is
> someone who is set up to easily apply the patch and test it.  ie: the
> code maintainer(s).

<grins>

This patch aside - Andrew how do you deal with a large amount of patches
and make sure they are tested? Is there a weekly Test Tuesday where you 
kick off your automated tests and dilligently look for any variations?

Or is it more of compile the kernel with X features and run it for a week
doing normal (and abnormal!) things to see if it falls over?

Thanks!
