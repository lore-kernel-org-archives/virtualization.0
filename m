From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] vhost-net: defer f->private_data until setup succeeds
Date: Mon, 4 Jan 2010 13:03:12 +1030
Message-ID: <201001041303.12558.rusty__8003.91916786811$1262572465$gmane$org@rustcorp.com.au>
References: <20091222190228.GB2095@sequoia.sous-sol.org>
	<20091224060650.GA26128@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20091224060650.GA26128@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Chris Wright <chrisw@sous-sol.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 24 Dec 2009 04:36:50 pm Michael S. Tsirkin wrote:
> On Tue, Dec 22, 2009 at 11:02:28AM -0800, Chris Wright wrote:
> > Trivial change, just for readability.  The filp is not installed on
> > failure, so the current code is not incorrect (also vhost_dev_init
> > currently has no failure case).  This just treats setting f->private_data
> > as something with global scope (sure, true only after fd_install).
> > 
> > Signed-off-by: Chris Wright <chrisw@redhat.com>
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Thanks, applied.

Rusty.
