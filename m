From: Ryo Tsuruta <ryov@valinux.co.jp>
Subject: Re: [PATCH 1/9] I/O bandwidth controller and BIO tracking
Date: Tue, 15 Sep 2009 00:06:54 +0900 (JST)
Message-ID: <20090915.000654.193698133.ryov__22786.4003777087$1252941787$gmane$org@valinux.co.jp>
References: <20090914.212805.193688121.ryov@valinux.co.jp>
	<1252937480.28368.221.camel@desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1252937480.28368.221.camel@desktop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dwalker@fifo99.com
Cc: xen-devel@lists.xensource.com, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dm-devel@redhat.com, agk@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Hi Daniel,

Daniel Walker <dwalker@fifo99.com> wrote:
> On Mon, 2009-09-14 at 21:28 +0900, Ryo Tsuruta wrote:
> 
> > The list of the patches:
> >   [PATCH 1/9] I/O bandwidth controller and BIO tracking
> >   [PATCH 2/9] dm-ioband-1.13.0: All-in-one patch
> >   [PATCH 3/9] blkio-cgroup-v12: The new page_cgroup framework
> >   [PATCH 4/9] blkio-cgroup-v12: Refactoring io-context initialization
> >   [PATCH 5/9] blkio-cgroup-v12: The body of blkio-cgroup
> >   [PATCH 6/9] blkio-cgroup-v12: Page tracking hooks
> >   [PATCH 7/9] blkio-cgroup-v12: The document of blkio-cgroup
> >   [PATCH 8/9] blkio-cgroup-v12: Add a cgroup support to dm-ioband
> >   [PATCH 9/9] blkio-cgroup-v12: The document of a cgroup support for dm-ioband
> 
> 
> Patches 5, 8, and 9 all have checkpatch errors (2 does also but it
> involves tracing, so Steven may not let you fix them). 
> 
> Could you correct those errors before this get included ?

Thank you for checking the patches, I'll fix them by the next post.

Thanks,
Ryo Tsuruta
