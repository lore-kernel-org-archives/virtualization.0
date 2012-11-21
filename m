From: Dmitry Torokhov <dtor@vmware.com>
Subject: Re: [Pv-drivers] [PATCH 01/12] VMCI: context implementation.
Date: Wed, 21 Nov 2012 13:29:08 -0800
Message-ID: <20121121212908.GA16131@dtor-ws.eng.vmware.com>
References: <20121121202625.13252.86346.stgit@promb-2n-dhcp175.eng.vmware.com>
	<20121121203109.13252.92744.stgit@promb-2n-dhcp175.eng.vmware.com>
	<1353531886.24807.43.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1353531886.24807.43.camel@joe-AO722>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Joe Perches <joe@perches.com>
Cc: pv-drivers@vmware.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, George Zhang <georgezhang@vmware.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Joe,

On Wed, Nov 21, 2012 at 01:04:46PM -0800, Joe Perches wrote:
> On Wed, 2012-11-21 at 12:31 -0800, George Zhang wrote:
> > +	context = kzalloc(sizeof(*context), GFP_KERNEL);
> > +	if (!context) {
> > +		pr_warn("Failed to allocate memory for VMCI context.\n");
> 
> OOM logging messages aren't necessary as alloc failures
> are already logged with a stack trace.
> 

Are we sure we are going to keep this policy forever? I'd rather keep
the OOM warnings.

Thanks.

-- 
Dmitry
