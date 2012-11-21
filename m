From: Joe Perches <joe@perches.com>
Subject: Re: [Pv-drivers] [PATCH 01/12] VMCI: context implementation.
Date: Wed, 21 Nov 2012 13:35:51 -0800
Message-ID: <1353533751.24807.49.camel@joe-AO722>
References: <20121121202625.13252.86346.stgit@promb-2n-dhcp175.eng.vmware.com>
	<20121121203109.13252.92744.stgit@promb-2n-dhcp175.eng.vmware.com>
	<1353531886.24807.43.camel@joe-AO722>
	<20121121212908.GA16131@dtor-ws.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20121121212908.GA16131@dtor-ws.eng.vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dmitry Torokhov <dtor@vmware.com>
Cc: pv-drivers@vmware.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, George Zhang <georgezhang@vmware.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2012-11-21 at 13:29 -0800, Dmitry Torokhov wrote:
> Hi Joe,

Howdy.

> On Wed, Nov 21, 2012 at 01:04:46PM -0800, Joe Perches wrote:
> > On Wed, 2012-11-21 at 12:31 -0800, George Zhang wrote:
> > > +	context = kzalloc(sizeof(*context), GFP_KERNEL);
> > > +	if (!context) {
> > > +		pr_warn("Failed to allocate memory for VMCI context.\n");
> > 
> > OOM logging messages aren't necessary as alloc failures
> > are already logged with a stack trace.
> > 
> 
> Are we sure we are going to keep this policy forever?

As in geological eras?  Hard to say.  It's been there awhile.
If more OOM logging messages are removed, it's more likely
for the core facility to stay.

There is an __GFP_NOWARN override to avoid the stack trace.

> I'd rather keep the OOM warnings.

Your choice.

cheers, Joe
